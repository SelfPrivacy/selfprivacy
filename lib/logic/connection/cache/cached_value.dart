enum Freshness { fresh, stale }

enum DomainSupport { unknown, supported, unsupported }

/// A domain snapshot. Cached data must not be mutated by consumers.
class CachedValue<T extends Object> {
  const CachedValue({
    this.data,
    this.updatedAt,
    this.freshness = Freshness.stale,
    this.isRefreshing = false,
    this.support = DomainSupport.unknown,
    this.lastError,
    this.needsReconciliation = false,
  });

  /// Null until a fetch or a complete subscription update supplies data.
  final T? data;
  final DateTime? updatedAt;
  final Freshness freshness;
  final bool isRefreshing;
  final DomainSupport support;
  final Object? lastError;

  /// Unresolved state changes require a read even before the refresh deadline.
  final bool needsReconciliation;

  CachedValue<T> copyWith({
    final T? data,
    final DateTime? updatedAt,
    final Freshness? freshness,
    final bool? isRefreshing,
    final DomainSupport? support,
    final Object? Function()? lastError,
    final bool? needsReconciliation,
  }) => CachedValue<T>(
    data: data ?? this.data,
    updatedAt: updatedAt ?? this.updatedAt,
    freshness: freshness ?? this.freshness,
    isRefreshing: isRefreshing ?? this.isRefreshing,
    support: support ?? this.support,
    lastError: lastError == null ? this.lastError : lastError(),
    needsReconciliation: needsReconciliation ?? this.needsReconciliation,
  );
}
