import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/models/server_logs.dart';

part 'server_logs_event.dart';
part 'server_logs_state.dart';

class ServerLogsBloc extends Bloc<ServerLogsEvent, ServerLogsState> {
  ServerLogsBloc() : super(ServerLogsInitial()) {
    final hub = getIt<ApiConnectionRepository>().hub;
    _connectionSubscription = hub.changes.listen((_) {
      if (!isClosed && hub.canRead && _deferredRead != null) {
        final event = _deferredRead!;
        _deferredRead = null;
        add(event);
      }
    });
    on<ServerLogsFetch>((final event, final emit) async {
      _deferredRead = null;
      final previous = state;
      emit(ServerLogsLoading());
      final String? slice = event.serviceId != null
          ? '${event.serviceId?.replaceAll('-', '_')}.slice'
          : null;
      final String? unit = event.unitId;
      try {
        final (logsData, meta) = await _getLogs(
          limit: 50,
          slice: slice,
          unit: unit,
        );
        emit(
          ServerLogsLoaded(
            oldEntries: logsData.sorted(
              (final a, final b) => b.timestamp.compareTo(a.timestamp),
            ),
            newEntries: List<ServerLogEntry>.empty(growable: true),
            meta: meta,
            loadingMore: false,
            slice: slice,
            unit: unit,
          ),
        );
        if (_apiLogsSubscription != null) {
          await _apiLogsSubscription?.cancel();
        }
        _apiLogsSubscription = getIt<ApiConnectionRepository>().hub
            .logs()
            .listen((final ServerLogEntry logEntry) {
              add(ServerLogsGotNewEntry(logEntry));
            });
      } on GraphQLDispatchDeferred {
        _deferredRead = event;
        if (previous is ServerLogsLoaded) {
          emit(previous);
        }
      } catch (e) {
        emit(ServerLogsError(e.toString()));
      }
    });

    on<ServerLogsFetchMore>((final event, final emit) async {
      final currentState = state;
      if (currentState is ServerLogsLoaded &&
          !currentState.loadingMore &&
          currentState.meta.upCursor != null) {
        try {
          final (logsData, meta) = await _getLogs(
            limit: 50,
            downCursor: currentState.meta.upCursor,
            slice: currentState.slice,
            unit: currentState.unit,
          );
          final allEntries = currentState.oldEntries
            ..addAll(logsData)
            ..sort((final a, final b) => b.timestamp.compareTo(a.timestamp));
          emit(
            ServerLogsLoaded(
              oldEntries: allEntries.toSet().toList(),
              newEntries: currentState.newEntries,
              meta: meta,
              loadingMore: false,
              slice: currentState.slice,
              unit: currentState.unit,
            ),
          );
        } on GraphQLDispatchDeferred {
          _deferredRead = event;
        } catch (e) {
          emit(ServerLogsError(e.toString()));
        }
      }
    });

    on<ServerLogsGotNewEntry>((final event, final emit) {
      final currentState = state;
      if (currentState is ServerLogsLoaded) {
        if (currentState.slice != null &&
            event.entry.systemdSlice != currentState.slice) {
          return;
        }
        if (currentState.unit != null &&
            event.entry.systemdUnit != currentState.unit) {
          return;
        }
        final allEntries = currentState.newEntries
          ..add(event.entry)
          ..sort((final a, final b) => b.timestamp.compareTo(a.timestamp));
        emit(
          ServerLogsLoaded(
            oldEntries: currentState.oldEntries,
            newEntries: allEntries.toSet().toList(),
            meta: currentState.meta,
            loadingMore: currentState.loadingMore,
            slice: currentState.slice,
            unit: currentState.unit,
          ),
        );
      }
    });

    on<ServerLogsDisconnect>((final event, final emit) async {
      _deferredRead = null;
      await _apiLogsSubscription?.cancel();
      emit(ServerLogsInitial());
    });
  }

  static const String logsSupportedVersion = '>=3.3.0';
  ServerLogsEvent? _deferredRead;
  late final StreamSubscription<void> _connectionSubscription;

  Future<(List<ServerLogEntry>, ServerLogsPageMeta)> _getLogs({
    // No more than 50
    required final int limit,
    // All entries returned will be lesser than this cursor. Sets upper bound on results.
    final String? upCursor,
    // All entries returned will be greater than this cursor. Sets lower bound on results.
    final String? downCursor,
    // Only one cursor can be set at a time.
    final String? slice,
    final String? unit,
  }) {
    final String? apiVersion =
        getIt<ApiConnectionRepository>().apiData.apiVersion.data;
    if (apiVersion == null) {
      throw Exception('basis.network_error'.tr());
    }
    if (!VersionConstraint.parse(
      logsSupportedVersion,
    ).allows(Version.parse(apiVersion))) {
      throw Exception(
        'basis.feature_unsupported_on_api_version'.tr(
          namedArgs: {
            'versionConstraint': logsSupportedVersion,
            'currentVersion': apiVersion,
          },
        ),
      );
    }
    return getIt<ApiConnectionRepository>().hub.read(
      (final connection) => connection.api.getServerLogs(
        limit: limit,
        upCursor: upCursor,
        downCursor: downCursor,
        slice: slice,
        unit: unit,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _connectionSubscription.cancel();
    await _apiLogsSubscription?.cancel();
    return super.close();
  }

  @override
  void onChange(final Change<ServerLogsState> change) {
    super.onChange(change);
  }

  StreamSubscription? _apiLogsSubscription;
}
