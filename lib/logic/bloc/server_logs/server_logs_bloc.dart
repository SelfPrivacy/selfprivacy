import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/models/server_logs.dart';

part 'server_logs_event.dart';
part 'server_logs_state.dart';

typedef FetchServerLogs =
    Future<(List<ServerLogEntry>, ServerLogsPageMeta)> Function({
      required int limit,
      String? downCursor,
      String? slice,
      String? unit,
    });

class ServerLogsBloc extends Bloc<ServerLogsEvent, ServerLogsState> {
  ServerLogsBloc({
    required final Stream<bool?> access,
    required final FetchServerLogs fetch,
    required final Stream<ServerLogEntry> Function() entries,
  }) : _fetch = fetch,
       _entries = entries,
       super(ServerLogsInitial()) {
    on<_ReadLogs>(_read, transformer: restartable());
    on<_ResetLogs>((final event, final emit) {
      if (identical(event.view, _view)) {
        emit(ServerLogsInitial());
      }
    });
    on<_LogReceived>(_receive);
    _accessSubscription = access.listen((final observation) {
      _access = observation;
      _accessRevision++;
      if (observation == null) {
        _reset();
      }
      if ((observation ?? false) && _deferred != null) {
        final event = _deferred!;
        _deferred = null;
        add(event);
      }
    });
  }

  final FetchServerLogs _fetch;
  final Stream<ServerLogEntry> Function() _entries;
  late final StreamSubscription<bool?> _accessSubscription;
  StreamSubscription<ServerLogEntry>? _entriesSubscription;
  bool? _access;
  int _accessRevision = 0;
  ServerLogsEvent? _deferred;
  _ReadLogs? _reading;
  Object _view = Object();

  @override
  void add(final ServerLogsEvent event) {
    if (event is ServerLogsDisconnect) {
      _reset();
    } else if (event is ServerLogsFetch || event is ServerLogsFetchMore) {
      if (_access == null) {
        _deferred = event;
        return;
      }
      if (event is ServerLogsFetch) {
        _view = Object();
        unawaited(_entriesSubscription?.cancel());
        _entriesSubscription = null;
      } else if (_reading != null) {
        return;
      }
      super.add(_ReadLogs(event, _view));
    } else {
      super.add(event);
    }
  }

  void _reset() {
    _view = Object();
    _deferred = null;
    _reading = null;
    unawaited(_entriesSubscription?.cancel());
    _entriesSubscription = null;
    super.add(_ResetLogs(_view));
  }

  bool _isCurrent(final _ReadLogs request) =>
      !isClosed && identical(request.view, _view) && _access != null;

  Future<void> _read(
    final _ReadLogs request,
    final Emitter<ServerLogsState> emit,
  ) async {
    if (!_isCurrent(request)) {
      return;
    }
    final event = request.event;
    final previous = state;
    final more = event is ServerLogsFetchMore;
    if (more &&
        (previous is! ServerLogsLoaded || previous.meta.upCursor == null)) {
      return;
    }
    _reading = request;
    _deferred = null;
    final revision = _accessRevision;
    final slice = event is ServerLogsFetch
        ? event.serviceId?.replaceAll('-', '_')
        : (previous as ServerLogsLoaded).slice;
    final systemdSlice = event is ServerLogsFetch && slice != null
        ? '$slice.slice'
        : slice;
    final unit = event is ServerLogsFetch
        ? event.unitId
        : (previous as ServerLogsLoaded).unit;
    if (previous is! ServerLogsLoaded) {
      emit(ServerLogsLoading());
    }
    try {
      if (_access != true) {
        throw const GraphQLDispatchDeferred();
      }
      final (values, meta) = await _fetch(
        limit: 50,
        downCursor: more ? (previous as ServerLogsLoaded).meta.upCursor : null,
        slice: systemdSlice,
        unit: unit,
      );
      if (!_isCurrent(request) || emit.isDone) {
        return;
      }
      final current = state;
      emit(
        ServerLogsLoaded(
          oldEntries: _sorted([
            if (more) ...(previous as ServerLogsLoaded).oldEntries,
            ...values,
          ]),
          newEntries: more && current is ServerLogsLoaded
              ? current.newEntries
              : const [],
          meta: meta,
          loadingMore: false,
          slice: systemdSlice,
          unit: unit,
        ),
      );
      if (!more) {
        unawaited(_entriesSubscription?.cancel());
        _entriesSubscription = _entries().listen(
          (final entry) => add(_LogReceived(entry, request.view)),
        );
      }
    } on GraphQLDispatchDeferred {
      if (_isCurrent(request) && !emit.isDone) {
        _deferred = event;
        if ((_access ?? false) && revision != _accessRevision) {
          _deferred = null;
          scheduleMicrotask(() {
            if (_isCurrent(request)) {
              add(event);
            }
          });
        }
      }
    } catch (error) {
      if (_isCurrent(request) && !emit.isDone) {
        emit(ServerLogsError(error.toString()));
      }
    } finally {
      if (identical(_reading, request)) {
        _reading = null;
      }
    }
  }

  List<ServerLogEntry> _sorted(final Iterable<ServerLogEntry> entries) =>
      entries.toSet().toList()
        ..sort((final a, final b) => b.timestamp.compareTo(a.timestamp));

  void _receive(final _LogReceived event, final Emitter<ServerLogsState> emit) {
    final current = state;
    if (!identical(event.view, _view) ||
        current is! ServerLogsLoaded ||
        (current.slice != null && event.entry.systemdSlice != current.slice) ||
        (current.unit != null && event.entry.systemdUnit != current.unit)) {
      return;
    }
    emit(
      ServerLogsLoaded(
        oldEntries: current.oldEntries,
        newEntries: _sorted([...current.newEntries, event.entry]),
        meta: current.meta,
        loadingMore: current.loadingMore,
        slice: current.slice,
        unit: current.unit,
      ),
    );
  }

  @override
  Future<void> close() async {
    _view = Object();
    await _accessSubscription.cancel();
    await _entriesSubscription?.cancel();
    return super.close();
  }
}
