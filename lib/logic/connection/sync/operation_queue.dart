import 'dart:async';

enum OperationKind {
  manageUsers,
  manageDevices,
  manageServices,
  manageBackups,
  manageVolumes,
  manageSettings,
  manageJobs,
  applyChanges,
  generateDeviceKey,
  generateRecoveryKey,
  generatePasswordResetLink,
  rotateToken;

  String get translationKey => 'operations.kind.$name';
}

enum OperationStatus {
  queued,
  running,
  accepted,
  succeeded,
  rejected,
  failed,
  unknown,
  cancelled,
  notSent;

  bool get isPending => this == queued || this == running || this == accepted;
  String get translationKey => 'operations.status.$name';
}

enum OperationReason {
  rotationFailed,
  connectionReplaced,
  cancelled,
  unavailable;

  String get translationKey => 'operations.reason.$name';
}

class OperationEvent {
  const OperationEvent(this.at, this.status, {this.reason});
  final DateTime at;
  final OperationStatus status;
  final OperationReason? reason;
}

class OperationSnapshot {
  OperationSnapshot({
    required this.id,
    required this.serverId,
    required this.kind,
    required final Iterable<OperationEvent> events,
    final Iterable<String> jobIds = const [],
  }) : events = List.unmodifiable(events),
       jobIds = Set.unmodifiable(jobIds);

  final int id;
  final String serverId;
  final OperationKind kind;
  final List<OperationEvent> events;
  final Set<String> jobIds;
  OperationStatus get status => events.last.status;
  bool get canCancel => status == OperationStatus.queued;
}

class OperationReport {
  OperationReport(this.status, {final Iterable<String> jobIds = const []})
    : jobIds = Set.unmodifiable(jobIds);
  final OperationStatus status;
  final Set<String> jobIds;
}

class OperationResult<T> {
  const OperationResult(this.status, {this.value});
  final OperationStatus status;
  final T? value;
}

class OperationNotSent implements Exception {
  const OperationNotSent();
}

class OperationHandle<T> {
  OperationHandle._(this.id, this.completion, this.cancel);
  final int id;
  final Future<OperationResult<T>> completion;
  final bool Function() cancel;
}

class _PendingOperation {
  _PendingOperation(this.start, this.settle);
  final void Function() start;
  final void Function(OperationStatus) settle;
  bool running = false;
}

class OperationQueue {
  OperationQueue({required this.serverId, final DateTime Function()? now})
    : _now = now ?? DateTime.now;

  static const completedHistoryLimit = 100;
  final String serverId;
  final DateTime Function() _now;
  final _records = <int, OperationSnapshot>{};
  final _pending = <int, _PendingOperation>{};
  final _remainingJobs = <int, Set<String>>{};
  final _changes = StreamController<List<OperationSnapshot>>.broadcast();
  final _idleWaiters = <Completer<void>>[];
  int _nextId = 0;
  bool _paused = false;
  bool _disposed = false;

  List<OperationSnapshot> get history => List.unmodifiable(_records.values);
  List<OperationSnapshot> get pending => List.unmodifiable(
    _records.values.where((final item) => item.status.isPending),
  );
  Stream<List<OperationSnapshot>> get changes => _changes.stream;
  bool get isIdle => !_pending.values.any((final item) => item.running);
  bool get isPaused => _paused;

  Future<void> get whenIdle {
    if (isIdle || _disposed) {
      return Future.value();
    }
    final waiter = Completer<void>();
    _idleWaiters.add(waiter);
    return waiter.future;
  }

  OperationHandle<T> submit<T>(
    final OperationKind kind,
    final Future<T> Function() action, {
    final OperationReport Function(T)? describe,
  }) {
    final id = _nextId++;
    final completion = Completer<OperationResult<T>>();
    if (_disposed) {
      completion.complete(const OperationResult(OperationStatus.notSent));
      return OperationHandle._(id, completion.future, () => false);
    }
    _records[id] = OperationSnapshot(
      id: id,
      serverId: serverId,
      kind: kind,
      events: [OperationEvent(_now(), OperationStatus.queued)],
    );
    _pending[id] = _PendingOperation(
      () {
        unawaited(() async {
          try {
            final value = await action();
            if (completion.isCompleted) {
              return;
            }
            final report =
                describe?.call(value) ??
                OperationReport(OperationStatus.succeeded);
            _record(id, report.status, jobIds: report.jobIds);
            if (report.status == OperationStatus.accepted) {
              _remainingJobs[id] = {...report.jobIds};
            }
            completion.complete(OperationResult(report.status, value: value));
          } on OperationNotSent {
            if (completion.isCompleted) {
              return;
            }
            _record(
              id,
              OperationStatus.notSent,
              reason: OperationReason.unavailable,
            );
            completion.complete(const OperationResult(OperationStatus.notSent));
          } catch (error, stackTrace) {
            if (completion.isCompleted) {
              return;
            }
            _record(id, OperationStatus.unknown);
            completion.completeError(error, stackTrace);
          } finally {
            _pending.remove(id);
            _settleIdle();
          }
        }());
      },
      (final status) {
        if (!completion.isCompleted) {
          completion.complete(OperationResult(status));
        }
      },
    );
    _publish();
    _drain();
    return OperationHandle._(id, completion.future, () => cancel(id));
  }

  bool cancel(final int id) {
    final item = _pending[id];
    if (item == null || item.running) {
      return false;
    }
    _pending.remove(id);
    _record(id, OperationStatus.cancelled, reason: OperationReason.cancelled);
    item.settle(OperationStatus.cancelled);
    return true;
  }

  void pause() => _paused = true;

  int recordExternal(final OperationKind kind, final OperationStatus status) {
    final id = _nextId++;
    _records[id] = OperationSnapshot(
      id: id,
      serverId: serverId,
      kind: kind,
      events: [OperationEvent(_now(), status)],
    );
    _publish();
    return id;
  }

  void updateExternal(final int id, final OperationStatus status) =>
      _record(id, status);

  void resume() {
    _paused = false;
    _drain();
  }

  void rejectWaiting(final OperationReason reason) {
    for (final entry in _pending.entries.toList()) {
      if (entry.value.running) {
        continue;
      }
      _pending.remove(entry.key);
      _record(entry.key, OperationStatus.notSent, reason: reason);
      entry.value.settle(OperationStatus.notSent);
    }
  }

  void observeJob(final String uid, {required final bool succeeded}) {
    if (_disposed) {
      return;
    }
    for (final entry in _remainingJobs.entries.toList()) {
      if (!entry.value.remove(uid)) {
        continue;
      }
      if (!succeeded || entry.value.isEmpty) {
        _remainingJobs.remove(entry.key);
        _record(
          entry.key,
          succeeded ? OperationStatus.succeeded : OperationStatus.failed,
        );
      }
    }
  }

  void _drain() {
    if (_paused || _disposed) {
      return;
    }
    for (final entry in _pending.entries.toList()) {
      if (_paused || _disposed) {
        break;
      }
      if (entry.value.running || !_pending.containsKey(entry.key)) {
        continue;
      }
      entry.value.running = true;
      _record(entry.key, OperationStatus.running);
      entry.value.start();
    }
  }

  void _record(
    final int id,
    final OperationStatus status, {
    final OperationReason? reason,
    final Set<String>? jobIds,
  }) {
    final previous = _records[id];
    if (previous == null || _disposed) {
      return;
    }
    _records[id] = OperationSnapshot(
      id: id,
      serverId: serverId,
      kind: previous.kind,
      events: [
        ...previous.events,
        OperationEvent(_now(), status, reason: reason),
      ],
      jobIds: jobIds ?? previous.jobIds,
    );
    final completed =
        _records.values.where((final item) => !item.status.isPending).toList()
          ..sort(
            (final a, final b) => a.events.last.at.compareTo(b.events.last.at),
          );
    if (completed.length > completedHistoryLimit) {
      for (final record in completed.take(
        completed.length - completedHistoryLimit,
      )) {
        _records.remove(record.id);
      }
    }
    _publish();
  }

  void _publish() {
    if (!_disposed) {
      _changes.add(history);
    }
  }

  void _settleIdle() {
    if (!isIdle) {
      return;
    }
    for (final waiter in _idleWaiters) {
      waiter.complete();
    }
    _idleWaiters.clear();
  }

  void detach() {
    if (_disposed) {
      return;
    }
    rejectWaiting(OperationReason.connectionReplaced);
    for (final entry in _pending.entries) {
      _record(
        entry.key,
        OperationStatus.unknown,
        reason: OperationReason.connectionReplaced,
      );
      entry.value.settle(OperationStatus.unknown);
    }
    for (final id in _remainingJobs.keys) {
      _record(
        id,
        OperationStatus.unknown,
        reason: OperationReason.connectionReplaced,
      );
    }
    _remainingJobs.clear();
    _pending.clear();
    _settleIdle();
    _paused = false;
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    detach();
    _disposed = true;
    unawaited(_changes.close());
  }
}
