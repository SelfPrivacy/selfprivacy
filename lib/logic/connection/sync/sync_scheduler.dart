import 'dart:async';

import 'package:pool/pool.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/cache/server_state_cache.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';

class InterestHandle {
  InterestHandle._(this._release);

  void Function()? _release;

  void dispose() {
    final release = _release;
    _release = null;
    release?.call();
  }
}

class _Interest {
  _Interest(this.interval, {required this.pending});
  final Duration interval;
  bool pending;
}

class _ScheduledDomain {
  _ScheduledDomain(this.store, this.order);
  final DomainStore<Object> store;
  final int order;
  final interests = <_Interest>{};
  DateTime? failedAt;
  bool wasRefreshing = false;
  _RefreshRequest? request;

  Duration get interval => interests.fold(
    store.refreshInterval,
    (final interval, final interest) =>
        interest.interval < interval ? interest.interval : interval,
  );

  bool get forced =>
      request != null || interests.any((final interest) => interest.pending);

  void observe(final DateTime now) {
    final value = store.value;
    if (value.lastError == null) {
      failedAt = null;
    } else if (wasRefreshing && !value.isRefreshing) {
      failedAt = now;
    }
    wasRefreshing = value.isRefreshing;
    if (value.isRefreshing) {
      consumeInterests();
    }
  }

  DateTime deadline(final DateTime now) {
    if (forced) {
      return now;
    }
    if (failedAt case final failure?) {
      return failure.add(interval);
    }
    final value = store.value;
    final deadline = value.updatedAt?.add(interval) ?? now;
    return (value.needsReconciliation || value.freshness == Freshness.stale) &&
            deadline.isAfter(now)
        ? now
        : deadline;
  }

  void consumeInterests() {
    for (final interest in interests) {
      interest.pending = false;
    }
  }
}

class _RefreshRequest {
  _RefreshRequest(this.revision);
  final int revision;
  final completion = Completer<RefreshResult>();
  bool dispatched = false;
}

typedef _Candidate = ({
  _ScheduledDomain domain,
  DateTime deadline,
  int priority,
});

typedef SyncPoolActivity = ({String domain, DateTime startedAt});

class SyncScheduler {
  SyncScheduler({
    required final ServerStateCache cache,
    required final ServerCommandCoordinator commands,
    final DateTime Function()? now,
    final CacheTimerFactory? createTimer,
  }) : _cache = cache,
       _commands = commands,
       _now = now ?? DateTime.now,
       _createTimer = createTimer ?? Timer.new,
       _domains = {
         for (final (index, store) in cache.stores.indexed)
           store.name: _ScheduledDomain(store, index),
       } {
    if (!cache.stores.every(commands.owns)) {
      throw ArgumentError('The coordinator must own every scheduled store.');
    }
    for (final domain in _domains.values) {
      domain.wasRefreshing = domain.store.value.isRefreshing;
      _subscriptions.add(
        domain.store.stream.listen(
          (_) => _observe(domain),
          onDone: () => _observe(domain),
        ),
      );
    }
    _subscriptions.add(_commands.changes.listen((_) => _environmentChanged()));
  }

  static const poolSize = 3;

  final ServerStateCache _cache;
  final ServerCommandCoordinator _commands;
  final DateTime Function() _now;
  final CacheTimerFactory _createTimer;
  final Map<String, _ScheduledDomain> _domains;
  final _subscriptions = <StreamSubscription<Object?>>[];
  final _active = <_ScheduledDomain>{};
  final _pool = Pool(poolSize);
  final _poolStatusChanges =
      StreamController<List<SyncPoolActivity?>>.broadcast();
  List<SyncPoolActivity?> _poolStatus = List.unmodifiable(
    List<SyncPoolActivity?>.filled(poolSize, null),
  );
  Timer? _timer;
  bool _started = false;
  bool _disposed = false;
  bool _queued = false;
  bool _wasAllowed = false;
  bool _waitingForPermit = false;
  bool _readAllowed = true;
  int _forcedStreak = 0;

  List<SyncPoolActivity?> get poolStatus => _poolStatus;

  Stream<List<SyncPoolActivity?>> get poolStatusChanges =>
      _poolStatusChanges.stream;

  bool get _allowed => _readAllowed && _commands.isAttached;

  void setReadAllowed({required final bool allowed}) {
    if (_disposed || _readAllowed == allowed) {
      return;
    }
    _readAllowed = allowed;
    _environmentChanged();
  }

  void start() {
    _ensureOpen();
    if (_started) {
      return;
    }
    _started = true;
    _environmentChanged();
  }

  Future<RefreshResult> refresh(
    final DomainStore<Object> store, {
    final bool force = true,
  }) {
    final entry = _domains[store.name];
    if (entry == null || !identical(entry.store, store)) {
      throw ArgumentError('Store belongs to another dispatcher.');
    }
    return _prepare(entry, force: force);
  }

  Future<RefreshResult> _prepare(
    final _ScheduledDomain entry, {
    required final bool force,
  }) async {
    if (_disposed || !_commands.isAttached || entry.store.isDisposed) {
      return RefreshResult.disposed;
    }
    if (force) {
      entry.store.requestReconciliation();
    }
    if (!_allowed) {
      return RefreshResult.deferred;
    }
    if (_commands.isReserved(entry.store)) {
      return RefreshResult.deferred;
    }
    if (!identical(entry.store, _cache.apiVersion) &&
        (_cache.apiVersion.value.data == null ||
            _cache.apiVersion.value.lastError != null)) {
      final version = await _prepare(
        _domains[_cache.apiVersion.name]!,
        force: _cache.apiVersion.value.lastError != null,
      );
      if (version != RefreshResult.applied &&
          version != RefreshResult.current) {
        return version;
      }
    }
    final value = entry.store.value;
    if (!force &&
        value.freshness == Freshness.fresh &&
        !value.needsReconciliation &&
        value.lastError == null) {
      return RefreshResult.current;
    }
    return _request(entry);
  }

  Future<RefreshResult> _request(final _ScheduledDomain entry) {
    _settleBlocked(entry);
    if (_blocked(entry) case final result?) {
      if (!entry.store.isDisposed && !_disposed) {
        entry.store.requestReconciliation();
      }
      return Future.value(result);
    }
    if (entry.request case final request?) {
      return request.completion.future;
    }
    entry.store.requestReconciliation();
    final request = _RefreshRequest(entry.store.revision);
    entry.request = request;
    if (entry.store.value.isRefreshing) {
      request.dispatched = true;
      unawaited(
        entry.store
            .refresh(force: true)
            .then((final result) => _finishRequest(entry, request, result)),
      );
    }
    _queue();
    return request.completion.future;
  }

  RefreshResult? _blocked(final _ScheduledDomain domain) {
    if (_disposed || domain.store.isDisposed || !_commands.isAttached) {
      return RefreshResult.disposed;
    }
    if (domain.store.value.support != DomainSupport.supported) {
      return RefreshResult.unsupported;
    }
    if (!_allowed ||
        _commands.isReserved(domain.store) ||
        (_cache.apiVersion.value.data == null &&
            !identical(domain.store, _cache.apiVersion))) {
      return RefreshResult.deferred;
    }
    return null;
  }

  void _finishRequest(
    final _ScheduledDomain domain,
    final _RefreshRequest request,
    final RefreshResult result,
  ) {
    if (!request.completion.isCompleted) {
      request.completion.complete(result);
    }
    if (identical(domain.request, request)) {
      domain.request = null;
    }
  }

  void _settleBlocked(final _ScheduledDomain domain) {
    final request = domain.request;
    if (request == null) {
      return;
    }
    final blocked = _blocked(domain);
    final result = blocked == RefreshResult.disposed
        ? blocked
        : domain.store.revision != request.revision
        ? RefreshResult.superseded
        : blocked;
    if (result != null &&
        (!request.dispatched ||
            result == RefreshResult.disposed ||
            result == RefreshResult.superseded)) {
      if (result == RefreshResult.deferred && !domain.store.isDisposed) {
        domain.store.requestReconciliation();
      }
      _finishRequest(domain, request, result);
    }
  }

  InterestHandle boost(
    final String domain, {
    required final Duration interval,
  }) {
    _ensureOpen();
    if (interval <= Duration.zero) {
      throw ArgumentError.value(interval, 'interval');
    }
    final entry =
        _domains[domain] ?? (throw ArgumentError.value(domain, 'domain'));
    final interest = _Interest(
      interval,
      pending: !entry.store.value.isRefreshing,
    );
    entry.interests.add(interest);
    _queue();
    return InterestHandle._(() {
      entry.interests.remove(interest);
      _queue();
    });
  }

  void _environmentChanged() {
    if (_disposed) {
      return;
    }
    final allowed = _allowed;
    if (allowed && !_wasAllowed) {
      for (final domain in _domains.values) {
        domain.failedAt = null;
      }
    }
    _wasAllowed = allowed;
    _domains.values.forEach(_settleBlocked);
    if (!allowed) {
      _timer?.cancel();
      _timer = null;
    }
    _queue();
  }

  void _observe(final _ScheduledDomain domain) {
    if (_disposed) {
      return;
    }
    domain.observe(_now());
    _settleBlocked(domain);
    _queue();
  }

  bool _eligible(final _ScheduledDomain domain) {
    final value = domain.store.value;
    return (_started || domain.request != null) &&
        !_active.contains(domain) &&
        !domain.store.isDisposed &&
        !_commands.isReserved(domain.store) &&
        !value.isRefreshing &&
        value.support == DomainSupport.supported &&
        (_cache.apiVersion.value.data != null ||
            identical(domain.store, _cache.apiVersion));
  }

  List<_Candidate> _candidates(final DateTime now) =>
      [
        for (final domain in _domains.values.where(_eligible))
          (
            domain: domain,
            deadline: domain.deadline(now),
            priority: identical(domain.store, _cache.apiVersion)
                ? 0
                : (_forcedStreak >= poolSize
                      ? (domain.forced ? 2 : 1)
                      : (domain.forced ? 1 : 2)),
          ),
      ]..sort((final a, final b) {
        final priority = a.priority.compareTo(b.priority);
        if (priority != 0) {
          return priority;
        }
        final deadline = a.deadline.compareTo(b.deadline);
        return deadline != 0
            ? deadline
            : a.domain.order.compareTo(b.domain.order);
      });

  void _queue() {
    if (_disposed || _queued) {
      return;
    }
    _queued = true;
    scheduleMicrotask(() {
      _queued = false;
      if (!_disposed) {
        _drain();
      }
    });
  }

  void _drain() {
    _timer?.cancel();
    _timer = null;
    if (!_allowed || _waitingForPermit) {
      return;
    }
    final now = _now();
    final candidates = _candidates(now);
    if (!candidates.any(
      (final candidate) => !candidate.deadline.isAfter(now),
    )) {
      _scheduleNext(candidates);
      return;
    }
    _waitingForPermit = true;
    unawaited(_pool.withResource(_dispatch));
  }

  Future<void> _dispatch() async {
    _waitingForPermit = false;
    if (_disposed || !_allowed) {
      return;
    }
    final now = _now();
    final candidates = _candidates(now);
    for (final candidate in candidates) {
      if (candidate.deadline.isAfter(now)) {
        continue;
      }
      final domain = candidate.domain;
      _forcedStreak = domain.forced ? _forcedStreak + 1 : 0;
      domain
        ..consumeInterests()
        ..wasRefreshing = true;
      _active.add(domain);
      final slot = _poolStatus.indexOf(null);
      _setSlot(slot, (domain: domain.store.name, startedAt: now));
      _queue();
      await _refresh(domain, slot);
      return;
    }
    _scheduleNext(candidates);
  }

  void _scheduleNext(final List<_Candidate> candidates) {
    if (!_allowed) {
      return;
    }
    DateTime? next;
    for (final (:domain, :deadline, priority: _) in candidates) {
      if (!_eligible(domain)) {
        continue;
      }
      if (next == null || deadline.isBefore(next)) {
        next = deadline;
      }
    }
    if (next != null) {
      final delay = next.difference(_now());
      _timer = _createTimer(delay.isNegative ? Duration.zero : delay, _queue);
    }
  }

  void _setSlot(final int slot, final SyncPoolActivity? activity) {
    if (_disposed) {
      return;
    }
    _poolStatus = List.unmodifiable([..._poolStatus]..[slot] = activity);
    _poolStatusChanges.add(_poolStatus);
  }

  Future<void> _refresh(final _ScheduledDomain domain, final int slot) async {
    final request = domain.request;
    if (request != null) {
      request.dispatched = true;
    }
    try {
      final result = await domain.store.refresh(
        force: true,
        acceptResult: () => _commands.isAttached,
      );
      if (request != null) {
        _finishRequest(
          domain,
          request,
          _commands.isAttached ? result : RefreshResult.disposed,
        );
      }
    } finally {
      _setSlot(slot, null);
      _active.remove(domain);
      _observe(domain);
    }
  }

  void _ensureOpen() {
    if (_disposed) {
      throw StateError('SyncScheduler is disposed');
    }
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _timer?.cancel();
    unawaited(_poolStatusChanges.close());
    unawaited(_pool.close());
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    for (final domain in _domains.values) {
      if (domain.request case final request?) {
        _finishRequest(domain, request, RefreshResult.disposed);
      }
      domain.interests.clear();
    }
  }
}
