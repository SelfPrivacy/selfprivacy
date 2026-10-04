import 'dart:async';

import 'package:selfprivacy/logic/operations/operation.dart';
import 'package:selfprivacy/logic/operations/operation_execution.dart';

export 'package:selfprivacy/logic/operations/operation.dart';

class OperationHandle<T> {
  OperationHandle._(this.id, this.result, this.completion, this.cancel);
  final int id;
  final Future<OperationResult<T>> result;
  final Future<OperationStatus> completion;
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
  final _jobReports = <int, OperationStatus>{};
  final _failedJobs = <int>{};
  final _completions = <int, Completer<OperationStatus>>{};
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
  Set<String> get pendingJobIds => {
    for (final jobs in _remainingJobs.values) ...jobs,
  };
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
    final finished = Completer<OperationStatus>();
    if (_disposed) {
      completion.complete(const OperationResult(OperationStatus.notSent));
      finished.complete(OperationStatus.notSent);
      return OperationHandle._(
        id,
        completion.future,
        finished.future,
        () => false,
      );
    }
    _completions[id] = finished;
    _records[id] = OperationSnapshot(
      id: id,
      serverId: serverId,
      kind: kind,
      events: [OperationEvent(_now(), OperationStatus.queued)],
    );
    _pending[id] = _PendingOperation(
      () {
        final execution = OperationExecution(
          onStepsChanged: (final steps) => _updateSteps(id, steps),
        );
        unawaited(
          runZoned(() async {
            try {
              final value = await action();
              if (completion.isCompleted) {
                return;
              }
              final report =
                  describe?.call(value) ??
                  OperationReport(OperationStatus.succeeded);
              _recordReport(id, report);
              completion.complete(OperationResult(report.status, value: value));
            } on OperationNotSent {
              if (completion.isCompleted) {
                return;
              }
              final report = execution.report;
              final status = report.status == OperationStatus.notSent
                  ? OperationStatus.notSent
                  : OperationStatus.unknown;
              _recordReport(
                id,
                OperationReport(status, jobIds: report.jobIds),
                reason: OperationReason.unavailable,
              );
              completion.complete(OperationResult(status));
            } catch (error, stackTrace) {
              if (completion.isCompleted) {
                return;
              }
              _recordReport(
                id,
                OperationReport(
                  OperationStatus.unknown,
                  jobIds: execution.report.jobIds,
                ),
              );
              completion.completeError(error, stackTrace);
            } finally {
              _pending.remove(id);
              _settleIdle();
            }
          }, zoneValues: {OperationExecution.zoneKey: execution}),
        );
      },
      (final status) {
        if (!completion.isCompleted) {
          completion.complete(OperationResult(status));
        }
      },
    );
    _publish();
    _drain();
    return OperationHandle._(
      id,
      completion.future,
      finished.future,
      () => cancel(id),
    );
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

  void observeJob(final String uid, {required final bool succeeded}) =>
      _settleJob(
        uid,
        succeeded ? OperationStatus.succeeded : OperationStatus.failed,
      );

  void observeMissingJob(final String uid) =>
      _settleJob(uid, OperationStatus.unknown);

  void _settleJob(final String uid, final OperationStatus status) {
    if (_disposed) {
      return;
    }
    for (final entry in _remainingJobs.entries.toList()) {
      if (!entry.value.remove(uid)) {
        continue;
      }
      if (status == OperationStatus.failed) {
        _failedJobs.add(entry.key);
      }
      if (status == OperationStatus.unknown) {
        _jobReports[entry.key] = OperationStatus.unknown;
      }
      _updateSteps(
        entry.key,
        _records[entry.key]!.steps.map(
          (final step) => step.jobId == uid ? step.withStatus(status) : step,
        ),
      );
      if (entry.value.isEmpty) {
        _remainingJobs.remove(entry.key);
        final reported = _jobReports.remove(entry.key)!;
        final failed = _failedJobs.remove(entry.key);
        _record(entry.key, switch (reported) {
          OperationStatus.unknown => OperationStatus.unknown,
          _ when failed => OperationStatus.failed,
          OperationStatus.accepted => OperationStatus.succeeded,
          _ => reported,
        });
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
      steps: status.isPending
          ? previous.steps
          : previous.steps.map(
              (final step) => step.status.isPending
                  ? step.withStatus(
                      step.status == OperationStatus.queued
                          ? OperationStatus.notSent
                          : OperationStatus.unknown,
                    )
                  : step,
            ),
    );
    if (!status.isPending) {
      _completions.remove(id)?.complete(status);
    }
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

  void _recordReport(
    final int id,
    final OperationReport report, {
    final OperationReason? reason,
  }) {
    if (report.jobIds.isNotEmpty) {
      _remainingJobs[id] = {...report.jobIds};
      _jobReports[id] = report.status;
    }
    _record(
      id,
      report.jobIds.isEmpty ? report.status : OperationStatus.accepted,
      reason: reason,
      jobIds: report.jobIds,
    );
  }

  void _publish() {
    if (!_disposed) {
      _changes.add(history);
    }
  }

  void _updateSteps(final int id, final Iterable<OperationStep> steps) {
    final previous = _records[id];
    if (_disposed || previous == null || !previous.status.isPending) {
      return;
    }
    _records[id] = OperationSnapshot(
      id: id,
      serverId: serverId,
      kind: previous.kind,
      events: previous.events,
      jobIds: previous.jobIds,
      steps: steps,
    );
    _publish();
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
    _jobReports.clear();
    _failedJobs.clear();
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
