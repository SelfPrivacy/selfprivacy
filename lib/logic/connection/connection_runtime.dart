import 'dart:async';

import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/connection/lifecycle/app_lifecycle.dart';
import 'package:selfprivacy/logic/connection/lifecycle/network_connectivity.dart';
import 'package:selfprivacy/logic/connection/lifecycle/reachability.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/sync/sync_scheduler.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

class ConnectionRuntime {
  ConnectionRuntime({
    required this.connection,
    required this.lifecycle,
    required final NetworkConnectivitySource connectivity,
    required this.operations,
    required this.onChanged,
  }) {
    reachability = Reachability(
      connectivity: connectivity,
      probe: () async => await connection.api.getApiVersion() != null,
    );
    scheduler = connection.scheduler;
    scheduler.setReadAllowed(allowed: false);
  }

  static const socketGrace = Duration(seconds: 30);
  final ServerConnection connection;
  final AppLifecycle lifecycle;
  final OperationQueue operations;
  final void Function() onChanged;
  late final Reachability reachability;
  late final SyncScheduler scheduler;
  final _subscriptions = <StreamSubscription<Object?>>[];
  StreamSubscription<List<ServerJob>>? _jobs;
  int _jobsRevision = 0;
  InterestHandle? _jobsFallback;
  Timer? _grace;
  Timer? _socketRetry;
  bool _suspended = false;
  bool _disposed = false;
  bool _socketAllowed = true;
  bool _checkingJobs = false;
  final _checkedJobs = <String, List<ServerJob>>{};
  bool get canStream =>
      !_disposed &&
      !_suspended &&
      _socketAllowed &&
      reachability.current == ReachabilityStatus.reachable;

  void start() {
    _subscriptions
      ..add(
        connection.changes.listen((_) {
          _connectJobs();
          _observeJobs();
        }),
      )
      ..add(
        reachability.stream.listen((_) {
          _syncReadEligibility();
          _connectJobs();
          onChanged();
        }),
      )
      ..add(lifecycle.foregroundChanges.listen((_) => _visibilityChanged()))
      ..add(operations.changes.listen((_) => _observeJobs()));
    reachability.start(paused: !lifecycle.isForeground || _suspended);
    scheduler.start();
    _setJobsHealth(false);
    _visibilityChanged();
  }

  void event(final GraphQLTransportEvent event) {
    if (_disposed) {
      return;
    }
    switch (event) {
      case GraphQLTransportEvent.reachable:
        reachability.reportSuccess();
      case GraphQLTransportEvent.protectedSuccess:
        reachability.reportProtectedSuccess();
      case GraphQLTransportEvent.authFailure:
        reachability.reportAuthFailure();
        _closeJobs();
      case GraphQLTransportEvent.networkFailure:
        reachability.reportNetworkFailure();
      case GraphQLTransportEvent.requestStarted:
      case GraphQLTransportEvent.requestFinished:
        break;
    }
  }

  void setSuspended({required final bool suspended}) {
    if (_disposed) {
      return;
    }
    _suspended = suspended;
    _syncReachability();
    _syncReadEligibility();
    if (suspended) {
      _closeJobs();
    } else {
      _connectJobs();
      onChanged();
    }
  }

  void _visibilityChanged() {
    _syncReachability();
    _syncReadEligibility();
    if (lifecycle.isForeground) {
      _grace?.cancel();
      _grace = null;
      _socketAllowed = true;
      _connectJobs();
    } else {
      _grace ??= Timer(socketGrace, () {
        _grace = null;
        _socketAllowed = false;
        _closeJobs();
        onChanged();
      });
    }
    onChanged();
  }

  void _syncReachability() {
    if (!_disposed && !_suspended && lifecycle.isForeground) {
      reachability.resume();
    } else {
      reachability.pause();
    }
  }

  void _syncReadEligibility() {
    scheduler.setReadAllowed(
      allowed:
          !_disposed &&
          !_suspended &&
          lifecycle.isForeground &&
          !reachability.isPaused &&
          reachability.current == ReachabilityStatus.reachable,
    );
  }

  void _setJobsHealth(final bool healthy) {
    if (_disposed) {
      return;
    }
    if (healthy) {
      _jobsFallback?.dispose();
      _jobsFallback = null;
    } else {
      _jobsFallback ??= scheduler.boost(
        'serverJobs',
        interval: const Duration(seconds: 10),
      );
    }
  }

  void _connectJobs() {
    final version = connection.cache.apiVersion.value.data;
    if (_disposed ||
        _suspended ||
        !_socketAllowed ||
        _jobs != null ||
        _socketRetry != null ||
        version == null ||
        version < Version(3, 3, 0) ||
        reachability.current != ReachabilityStatus.reachable ||
        !lifecycle.isForeground) {
      return;
    }
    final revision = _jobsRevision;
    bool isCurrent() =>
        !_disposed &&
        !_suspended &&
        revision == _jobsRevision &&
        connection.isAttached;
    void lost() {
      if (isCurrent()) {
        _jobsLost();
      }
    }

    _jobs = connection.api
        .getServerJobsStream(
          onConnectionState: ({required final bool connected}) {
            if (isCurrent()) {
              _setJobsHealth(connected);
            }
          },
        )
        .listen(
          (final jobs) {
            if (isCurrent()) {
              connection.jobs.receiveSnapshot(jobs);
            }
          },
          onError: (final Object _) => lost(),
          onDone: lost,
        );
  }

  void _jobsLost() {
    if (_disposed) {
      return;
    }
    _closeJobs();
    _socketRetry ??= Timer(const Duration(seconds: 10), () {
      _socketRetry = null;
      _connectJobs();
    });
  }

  void _observeJobs() {
    for (final job in [
      ...?connection.jobs.value.data,
      ...connection.jobs.confirmedBeforeLoad.values,
    ]) {
      if (job.status == JobStatusEnum.finished ||
          job.status == JobStatusEnum.error) {
        operations.observeJob(
          job.uid,
          succeeded: job.status == JobStatusEnum.finished,
        );
      }
    }
    _checkedJobs.removeWhere(
      (final uid, _) => !operations.pendingJobIds.contains(uid),
    );
    if (!_checkingJobs && !_disposed && !_suspended && connection.canRead) {
      unawaited(_verifyMissingJobs());
    }
  }

  Future<void> _verifyMissingJobs() async {
    final snapshot = connection.jobs.value.data;
    if (snapshot == null) {
      return;
    }
    final known = {
      ...snapshot.map((final job) => job.uid),
      ...connection.jobs.confirmedBeforeLoad.keys,
    };
    final missing = operations.pendingJobIds
        .where(
          (final uid) =>
              !known.contains(uid) && !identical(_checkedJobs[uid], snapshot),
        )
        .toList();
    if (missing.isEmpty) {
      return;
    }
    _checkingJobs = true;
    try {
      for (final uid in missing) {
        if (_disposed || _suspended || !connection.canRead) {
          break;
        }
        if (!operations.pendingJobIds.contains(uid)) {
          continue;
        }
        _checkedJobs[uid] = snapshot;
        try {
          final job = await connection.read(
            (final owner) => owner.api.getServerJob(uid),
          );
          if (_disposed ||
              !operations.pendingJobIds.contains(uid) ||
              connection.jobs.snapshot.jobs.any(
                (final job) => job.uid == uid,
              )) {
            continue;
          }
          if (job == null) {
            operations.observeMissingJob(uid);
          } else {
            connection.jobs.receiveVerifiedJob(job);
          }
        } catch (_) {
          // Retry observation after the next jobs snapshot, never the command.
        }
      }
    } finally {
      _checkingJobs = false;
      if (!_disposed) {
        _observeJobs();
      }
    }
  }

  void _closeJobs() {
    _jobsRevision++;
    final subscription = _jobs;
    _jobs = null;
    unawaited(subscription?.cancel());
    _setJobsHealth(false);
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _grace?.cancel();
    _socketRetry?.cancel();
    _closeJobs();
    _jobsFallback?.dispose();
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    scheduler.setReadAllowed(allowed: false);
    reachability.dispose();
  }
}
