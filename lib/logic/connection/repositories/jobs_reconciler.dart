import 'dart:async';

import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

/// Applies jobs inputs to one store. It does not open a subscription or fetch.
/// Call confirmed-effect methods only from the command's confirmed reducer.
class JobsReconciler {
  JobsReconciler({
    required this.store,
    required final ServerCommandCoordinator commands,
  }) : _commands = commands,
       _readRevision = store.readRevision {
    if (!commands.owns(store)) {
      throw ArgumentError('The coordinator must own the jobs store.');
    }
    _subscriptions
      ..add(commands.changes.listen((_) => _flush()))
      ..add(
        store.stream.listen((_) {
          _syncRead();
        }),
      );
  }

  final DomainStore<List<ServerJob>> store;
  final ServerCommandCoordinator _commands;
  final _subscriptions = <StreamSubscription<Object?>>[];
  final _changes = StreamController<void>.broadcast();
  final _beforeLoad = <String, ServerJob>{};
  final _deleted = <String>{};
  List<ServerJob>? _buffered;
  int _readRevision;
  bool _requiresRead = false;
  bool _disposed = false;

  void restoreFrom(final JobsReconciler previous) {
    previous._syncRead();
    _beforeLoad.addAll(previous._beforeLoad);
    _deleted.addAll(previous._deleted);
    _requiresRead = previous._requiresRead;
    _readRevision = store.readRevision;
  }

  /// Confirmed entities do not imply that the complete jobs list has loaded.
  Map<String, ServerJob> get confirmedBeforeLoad {
    _syncRead();
    return Map.unmodifiable(_beforeLoad);
  }

  Stream<void> get changes => _changes.stream;

  bool get _usable =>
      !_disposed &&
      !store.isDisposed &&
      _commands.isAttached &&
      store.value.support == DomainSupport.supported;

  void upsertConfirmed(final ServerJob job) {
    _ensureUsable();
    _syncRead();
    _requiresRead = true;
    _deleted.remove(job.uid);
    if (store.value.data == null) {
      _beforeLoad[job.uid] = job;
      store.requestReconciliation();
    } else {
      store.patch(
        (final jobs) => List.unmodifiable([
          ...jobs.where((final existing) => existing.uid != job.uid),
          job,
        ]),
      );
    }
    _changes.add(null);
  }

  void removeConfirmed(final String uid) {
    _ensureUsable();
    _syncRead();
    _requiresRead = true;
    _deleted.add(uid);
    _beforeLoad.remove(uid);
    store.patch(
      (final jobs) =>
          List.unmodifiable(jobs.where((final job) => job.uid != uid)),
    );
    _changes.add(null);
  }

  /// During a command, retain only the latest unversioned snapshot.
  /// Ambiguous snapshots cannot prove deletion or collection completeness.
  void receiveSnapshot(final Iterable<ServerJob> jobs) {
    if (!_usable) {
      return;
    }
    _syncRead();
    final snapshot = List<ServerJob>.unmodifiable(jobs);
    if (_commands.isReserved(store)) {
      _requiresRead = true;
      _buffered = snapshot;
      return;
    }
    _applySnapshot(snapshot);
  }

  void _flush() {
    if (!_usable || _commands.isReserved(store)) {
      return;
    }
    _syncRead();
    final snapshot = _buffered;
    _buffered = null;
    if (snapshot != null) {
      _applySnapshot(snapshot);
    }
  }

  void _applySnapshot(final List<ServerJob> snapshot) {
    if (!_requiresRead) {
      store.push(snapshot);
      return;
    }
    final current = store.value.data;
    final merged = current == null
        ? Map<String, ServerJob>.of(_beforeLoad)
        : {for (final job in current) job.uid: job};
    var changed = false;
    for (final incoming in snapshot) {
      final existing = merged[incoming.uid];
      if (!_deleted.contains(incoming.uid) &&
          existing != null &&
          incoming.updatedAt.isAfter(existing.updatedAt)) {
        merged[incoming.uid] = incoming;
        changed = true;
      }
    }
    if (changed) {
      if (current == null) {
        _beforeLoad
          ..clear()
          ..addAll(merged);
      } else {
        store.patch((_) => List.unmodifiable(merged.values));
      }
      _changes.add(null);
    }
    store.requestReconciliation();
  }

  void _syncRead() {
    if (_disposed || _readRevision == store.readRevision) {
      return;
    }
    _readRevision = store.readRevision;
    _requiresRead = false;
    _buffered = null;
    _beforeLoad.clear();
    _deleted.clear();
    _changes.add(null);
  }

  void _ensureUsable() {
    if (!_usable) {
      throw StateError('Jobs reconciliation is detached or unsupported.');
    }
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _buffered = null;
    _beforeLoad.clear();
    _deleted.clear();
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    unawaited(_changes.close());
  }
}
