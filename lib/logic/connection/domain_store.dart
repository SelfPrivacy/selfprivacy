import 'dart:async';

import 'package:selfprivacy/logic/connection/cached_value.dart';

typedef CacheTimerFactory = Timer Function(Duration delay, void Function() run);

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
  Completer<void>? _refresh;
  bool _refreshAgain = false;
  bool _disposed = false;
  int _revision = 0;

  bool get isDue =>
      _value.support == DomainSupport.supported &&
      (_value.data == null ||
          _value.freshness == Freshness.stale ||
          !_now().isBefore(_value.updatedAt!.add(refreshInterval)));

  /// Coalesces concurrent calls, including forced refreshes.
  ///
  /// Fetch failures are recorded in [value] and do not escape this future.
  /// Unknown and unsupported domains are skipped, even with [force].
  Future<void> refresh({final bool force = false}) {
    _ensureOpen();
    if (_value.support != DomainSupport.supported) {
      return Future<void>.value();
    }
    final current = _refresh;
    if (current != null) {
      return current.future;
    }
    if (!force && !isDue) {
      return Future<void>.value();
    }
    final completion = Completer<void>();
    _refresh = completion;
    unawaited(_runRefresh(completion));
    return completion.future;
  }

  Future<void> _runRefresh(final Completer<void> completion) async {
    _emit(_value.copyWith(isRefreshing: true));
    try {
      do {
        _refreshAgain = false;
        final revision = _revision;
        try {
          final data = await _fetch();
          if (!_disposed && revision == _revision) {
            _accept(data);
          }
        } catch (error) {
          if (!_disposed && revision == _revision) {
            _emit(_value.copyWith(lastError: () => error));
          }
        }
      } while (!_disposed &&
          _refreshAgain &&
          _value.support == DomainSupport.supported);
    } finally {
      if (!_disposed) {
        _refresh = null;
        _emit(_value.copyWith(isRefreshing: false));
      }
      if (!completion.isCompleted) {
        completion.complete();
      }
    }
  }

  /// Marks data stale. An active fetch is superseded and followed by one fetch.
  /// Invalidation while idle does not start a request.
  void invalidate() {
    _ensureOpen();
    _revision++;
    _refreshAgain = _refresh != null;
    _expiryTimer?.cancel();
    _emit(_value.copyWith(freshness: Freshness.stale));
  }

  /// Accepts a complete domain update and supersedes pending fetch results.
  /// A push also satisfies any queued invalidation.
  void push(final T data) {
    _ensureOpen();
    if (_value.support != DomainSupport.supported) {
      throw StateError('Cannot push data to an unsupported or unknown domain.');
    }
    _revision++;
    _refreshAgain = false;
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
    _refreshAgain = support == DomainSupport.supported && _refresh != null;
    _expiryTimer?.cancel();
    _emit(
      _value.copyWith(
        support: support,
        freshness: Freshness.stale,
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
        identical(next.lastError, _value.lastError)) {
      return;
    }
    _value = next;
    _changes.add(next);
  }

  /// Stops notifications and completes refresh waiters without awaiting I/O.
  /// Late fetch results are ignored. Further writes and refreshes throw.
  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _expiryTimer?.cancel();
    _refreshAgain = false;
    _value = _value.copyWith(isRefreshing: false);
    _refresh?.complete();
    _refresh = null;
    unawaited(_changes.close());
  }

  void _ensureOpen() {
    if (_disposed) {
      throw StateError('DomainStore $name is disposed.');
    }
  }
}
