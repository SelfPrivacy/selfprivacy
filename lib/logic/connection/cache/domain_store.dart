import 'dart:async';

import 'package:selfprivacy/logic/connection/cache/cached_value.dart';

typedef CacheTimerFactory = Timer Function(Duration delay, void Function() run);

enum RefreshResult {
  applied,
  failed,
  superseded,
  unsupported,
  disposed,
  current,
  deferred,
}

/// Caches one domain. Only [refresh] performs fetches.
///
/// The clock and timer factory must use the same time source. Consumers must
/// treat fetched and pushed data as immutable after supplying it to the store.
class DomainStore<T extends Object> {
  DomainStore({
    required this.name,
    required final Future<T> Function() fetch,
    required this.refreshInterval,
    final Duration? staleAfter,
    final DomainSupport support = DomainSupport.unknown,
    final DateTime Function()? now,
    final CacheTimerFactory? createTimer,
  }) : staleAfter = staleAfter ?? refreshInterval * 2,
       _fetch = fetch,
       _now = now ?? DateTime.now,
       _createTimer = createTimer ?? Timer.new,
       _value = CachedValue<T>(support: support) {
    if (refreshInterval <= Duration.zero) {
      throw ArgumentError.value(refreshInterval, 'refreshInterval');
    }
    if (this.staleAfter <= refreshInterval) {
      throw ArgumentError.value(this.staleAfter, 'staleAfter');
    }
  }

  final String name;
  final Duration refreshInterval;
  final Duration staleAfter;
  final Future<T> Function() _fetch;
  final DateTime Function() _now;
  final CacheTimerFactory _createTimer;
  final _changes = StreamController<CachedValue<T>>.broadcast();

  CachedValue<T> _value;
  CachedValue<T> get value => _value;

  /// Broadcasts changes without replaying the current [value].
  Stream<CachedValue<T>> get stream => _changes.stream;

  Timer? _expiryTimer;
  Completer<RefreshResult>? _refresh;
  int? _refreshRevision;
  bool _disposed = false;
  int _revision = 0;
  int _readRevision = 0;

  bool get isDisposed => _disposed;
  int get revision => _revision;

  /// Changes only when a fetch result is accepted, not on pushes or patches.
  int get readRevision => _readRevision;

  bool get isDue =>
      _value.support == DomainSupport.supported &&
      (_value.needsReconciliation ||
          _value.data == null ||
          _value.freshness == Freshness.stale ||
          !_now().isBefore(_value.updatedAt!.add(refreshInterval)));

  /// Performs at most one read. Calls for the same revision share its future.
  ///
  /// Fetch failures are recorded in [value] and do not escape this future.
  /// Unknown and unsupported domains are skipped, even with [force].
  /// If [acceptResult] returns false, discards the fetched data or error.
  /// Shared reads use the first caller's [acceptResult].
  Future<RefreshResult> refresh({
    final bool force = false,
    final bool Function()? acceptResult,
  }) {
    if (_disposed) {
      return Future.value(RefreshResult.disposed);
    }
    if (_value.support != DomainSupport.supported) {
      return Future.value(RefreshResult.unsupported);
    }
    final current = _refresh;
    if (current != null) {
      return _refreshRevision == _revision
          ? current.future
          : Future.value(RefreshResult.superseded);
    }
    if (!force && !isDue) {
      return Future.value(RefreshResult.current);
    }
    final completion = Completer<RefreshResult>();
    _refresh = completion;
    _refreshRevision = _revision;
    unawaited(_runRefresh(completion, acceptResult));
    return completion.future;
  }

  Future<void> _runRefresh(
    final Completer<RefreshResult> completion,
    final bool Function()? acceptResult,
  ) async {
    final ticket = _revision;
    var result = RefreshResult.superseded;
    _emit(_value.copyWith(isRefreshing: true));
    try {
      final data = await _fetch();
      if (!_disposed && ticket == _revision && (acceptResult?.call() ?? true)) {
        _readRevision++;
        _accept(data);
        result = RefreshResult.applied;
      }
    } catch (error) {
      if (!_disposed && ticket == _revision && (acceptResult?.call() ?? true)) {
        _emit(_value.copyWith(lastError: () => error));
        result = RefreshResult.failed;
      }
    } finally {
      if (!_disposed) {
        _refresh = null;
        _emit(_value.copyWith(isRefreshing: false));
      }
      if (!completion.isCompleted) {
        completion.complete(result);
      }
    }
  }

  /// Supersedes active reads and records reconciliation without starting I/O.
  void invalidate() {
    _ensureOpen();
    _revision++;
    _expiryTimer?.cancel();
    _emit(
      _value.copyWith(freshness: Freshness.stale, needsReconciliation: true),
    );
  }

  /// Records deferred work without superseding an active read.
  void requestReconciliation() {
    _ensureOpen();
    _emit(_value.copyWith(needsReconciliation: true));
  }

  /// Fences reads before a command without aging the retained snapshot.
  /// A discarded active read leaves reconciliation due.
  void fenceReads() {
    _ensureOpen();
    final supersedesRead = _refresh != null && _refreshRevision == _revision;
    _revision++;
    _emit(
      _value.copyWith(
        needsReconciliation: _value.needsReconciliation || supersedesRead,
      ),
    );
  }

  /// Applies a reducer without renewing the complete snapshot's age.
  /// Reducers must return immutable values without mutating their input.
  /// Returns false before first load. The repository must retain that effect
  /// in its entity projection until a complete snapshot is available.
  bool patch(final T Function(T data) reduce) {
    _ensureOpen();
    _ensureSupported();
    final data = _value.data;
    final next = data == null ? null : reduce(data);
    final supersedesRead = _refresh != null && _refreshRevision == _revision;
    _revision++;
    _emit(
      _value.copyWith(
        data: next,
        needsReconciliation:
            _value.needsReconciliation || data == null || supersedesRead,
      ),
    );
    return data != null;
  }

  /// Accepts a complete domain update and supersedes pending fetch results.
  /// A push also satisfies any queued invalidation.
  void push(final T data) {
    _ensureOpen();
    _ensureSupported();
    _revision++;
    _accept(data);
  }

  /// Changes query eligibility and supersedes work from the previous state.
  /// Retained data is stale until refreshed under supported API capabilities.
  void setSupport(final DomainSupport support) {
    _ensureOpen();
    if (support == _value.support) {
      return;
    }
    _revision++;
    _expiryTimer?.cancel();
    _emit(
      _value.copyWith(
        support: support,
        freshness: Freshness.stale,
        needsReconciliation: true,
        isRefreshing: support == DomainSupport.supported && _refresh != null,
        lastError: () => null,
      ),
    );
  }

  void _accept(final T data) {
    _expiryTimer?.cancel();
    _emit(
      _value.copyWith(
        data: data,
        updatedAt: _now(),
        freshness: Freshness.fresh,
        needsReconciliation: false,
        lastError: () => null,
      ),
    );
    _expiryTimer = _createTimer(staleAfter, () {
      if (!_disposed) {
        _emit(_value.copyWith(freshness: Freshness.stale));
      }
    });
  }

  void _emit(final CachedValue<T> next) {
    if (identical(next.data, _value.data) &&
        next.updatedAt == _value.updatedAt &&
        next.freshness == _value.freshness &&
        next.isRefreshing == _value.isRefreshing &&
        next.support == _value.support &&
        next.needsReconciliation == _value.needsReconciliation &&
        identical(next.lastError, _value.lastError)) {
      return;
    }
    _value = next;
    _changes.add(next);
  }

  /// Stops notifications and completes refresh waiters without awaiting I/O.
  /// Late fetch results are ignored. Further writes throw.
  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _expiryTimer?.cancel();
    _value = _value.copyWith(isRefreshing: false);
    _refresh?.complete(RefreshResult.disposed);
    _refresh = null;
    unawaited(_changes.close());
  }

  void _ensureOpen() {
    if (_disposed) {
      throw StateError('DomainStore $name is disposed.');
    }
  }

  void _ensureSupported() {
    if (_value.support != DomainSupport.supported) {
      throw StateError(
        'Cannot write data to an unsupported or unknown domain.',
      );
    }
  }
}
