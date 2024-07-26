import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/server_logs.dart';

part 'server_logs_event.dart';
part 'server_logs_state.dart';

class ServerLogsBloc extends Bloc<ServerLogsEvent, ServerLogsState> {
  ServerLogsBloc() : super(ServerLogsInitial()) {
    on<ServerLogsFetch>((final event, final emit) async {
      emit(ServerLogsLoading());
      try {
        final (logsData, meta) = await _getLogs(limit: 50);
        emit(ServerLogsLoaded(logsData, meta, false));
        if (_apiLogsSubscription != null) {
          await _apiLogsSubscription?.cancel();
        }
        _apiLogsSubscription =
            getIt<ApiConnectionRepository>().api.getServerLogsStream().listen(
          (final ServerLogEntry logEntry) {
            print('Got new log entry');
            print(logEntry);
            add(ServerLogsGotNewEntry(logEntry));
          },
        );
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
          final (logsData, meta) =
              await _getLogs(limit: 50, downCursor: currentState.meta.upCursor);
          final allEntries = currentState.entries
            ..addAll(logsData)
            ..sort((final a, final b) => b.timestamp.compareTo(a.timestamp));
          emit(ServerLogsLoaded(allEntries.toSet().toList(), meta, false));
        } catch (e) {
          emit(ServerLogsError(e.toString()));
        }
      }
    });

    on<ServerLogsGotNewEntry>((final event, final emit) {
      final currentState = state;
      if (currentState is ServerLogsLoaded) {
        final entries = currentState.entries;
        if (!entries.any((final entry) => entry.cursor == event.entry.cursor)) {
          entries.add(event.entry);
          entries
              .sort((final a, final b) => b.timestamp.compareTo(a.timestamp));
          emit(
            ServerLogsLoaded(
              entries,
              currentState.meta,
              currentState.loadingMore,
            ),
          );
        }
      }
    });

    on<ServerLogsDisconnect>((final event, final emit) {
      _apiLogsSubscription?.cancel();
      emit(ServerLogsInitial());
    });
  }

  static const String logsSupportedVersion = '>=3.3.0';

  Future<(List<ServerLogEntry>, ServerLogsPageMeta)> _getLogs({
    // No more than 50
    required final int limit,
    // All entries returned will be lesser than this cursor. Sets upper bound on results.
    final String? upCursor,
    // All entries returned will be greater than this cursor. Sets lower bound on results.
    final String? downCursor,
    // Only one cursor can be set at a time.
  }) {
    final String? apiVersion =
        getIt<ApiConnectionRepository>().apiData.apiVersion.data;
    if (apiVersion == null) {
      throw Exception('basis.network_error'.tr());
    }
    if (!VersionConstraint.parse(logsSupportedVersion)
        .allows(Version.parse(apiVersion))) {
      throw Exception(
        'basis.feature_unsupported_on_api_version'.tr(
          namedArgs: {
            'versionConstraint': logsSupportedVersion,
            'currentVersion': apiVersion,
          },
        ),
      );
    }
    return getIt<ApiConnectionRepository>().api.getServerLogs(
          limit: limit,
          upCursor: upCursor,
          downCursor: downCursor,
        );
  }

  @override
  Future<void> close() {
    _apiLogsSubscription?.cancel();
    return super.close();
  }

  @override
  void onChange(final Change<ServerLogsState> change) {
    super.onChange(change);
  }

  StreamSubscription? _apiLogsSubscription;
}
