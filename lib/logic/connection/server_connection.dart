import 'dart:async';

import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/connection/cached_value.dart';
import 'package:selfprivacy/logic/connection/devices_repository.dart';
import 'package:selfprivacy/logic/connection/domain_store.dart';
import 'package:selfprivacy/logic/connection/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';

/// Owns domain stores and coordinates commands for one server connection.
class ServerConnection {
  ServerConnection({
    required this.api,
    required this.origin,
    required final ServerStateOrigin? Function() currentOrigin,
    final Map<DomainStore<Object>, VersionConstraint> additionalDomains =
        const {},
  }) : _currentOrigin = currentOrigin {
    final deviceStore = DomainStore<List<ApiToken>>(
      name: 'devices',
      refreshInterval: const Duration(seconds: 60),
      fetch: () => DevicesRepository.fetch(api),
    );
    _domains = {
      deviceStore: VersionConstraint.parse('>=2.3.0'),
      ...additionalDomains,
    };
    commands = ServerCommandCoordinator(
      api: api,
      origin: origin,
      currentOrigin: () => isAttached ? origin : null,
      stores: _domains.keys,
    );
    devices = DevicesRepository(connection: this, store: deviceStore);
    for (final store in _domains.keys) {
      _subscriptions.add(
        store.stream.listen((_) {
          if (isAttached) {
            _changes.add(null);
          }
        }),
      );
    }
  }

  final ServerApi api;
  final ServerStateOrigin origin;
  final ServerStateOrigin? Function() _currentOrigin;
  late final Map<DomainStore<Object>, VersionConstraint> _domains;
  late final ServerCommandCoordinator commands;
  late final DevicesRepository devices;
  final _changes = StreamController<void>.broadcast();
  final _subscriptions = <StreamSubscription<Object?>>[];
  final _refreshes = <DomainStore<Object>, Completer<RefreshResult>>{};
  bool _disposed = false;
  Future<bool>? _versionRequest;
  Version? _version;
  Object? _versionError;

  Stream<void> get changes => _changes.stream;
  Iterable<DomainStore<Object>> get stores => List.unmodifiable(_domains.keys);
  bool get isAttached => !_disposed && identical(_currentOrigin(), origin);

  CachedValue<T> snapshot<T extends Object>(final DomainStore<T> store) {
    _checkOwner(store);
    return _versionError == null
        ? store.value
        : store.value.copyWith(lastError: () => _versionError);
  }

  void setVersion(final Version version) {
    if (!isAttached) {
      return;
    }
    _version = version;
    _versionError = null;
    for (final entry in _domains.entries) {
      entry.key.setSupport(
        entry.value.allows(version)
            ? DomainSupport.supported
            : DomainSupport.unsupported,
      );
    }
    _changes.add(null);
  }

  void versionUnavailable() {
    if (!isAttached) {
      return;
    }
    _versionError = StateError('Server API version unavailable.');
    _changes.add(null);
  }

  /// Shares pending reads per store. Returns deferred while a command owns it.
  Future<RefreshResult> refresh<T extends Object>(
    final DomainStore<T> store, {
    final bool force = false,
  }) {
    _checkOwner(store);
    if (!isAttached) {
      return Future.value(RefreshResult.disposed);
    }
    if (force) {
      store.requestReconciliation();
    }
    if (commands.isReserved(store)) {
      return Future.value(RefreshResult.deferred);
    }
    final active = _refreshes[store];
    if (active != null) {
      return active.future;
    }
    final completion = Completer<RefreshResult>();
    _refreshes[store] = completion;
    unawaited(_completeRead(store, force, completion));
    return completion.future;
  }

  Future<void> _completeRead(
    final DomainStore<Object> store,
    final bool force,
    final Completer<RefreshResult> completion,
  ) async {
    var result = RefreshResult.failed;
    try {
      result = await _read(store, force);
    } finally {
      _refreshes.remove(store);
      if (!completion.isCompleted) {
        completion.complete(result);
      }
    }
  }

  Future<RefreshResult> _read(
    final DomainStore<Object> store,
    final bool force,
  ) async {
    if (_version == null || _versionError != null) {
      final supported = await (_versionRequest ??= _discoverVersion()
          .whenComplete(() => _versionRequest = null));
      if (!isAttached) {
        return RefreshResult.disposed;
      }
      if (!supported) {
        return RefreshResult.failed;
      }
    }
    if (!isAttached) {
      return RefreshResult.disposed;
    }
    if (commands.isReserved(store)) {
      store.requestReconciliation();
      return RefreshResult.deferred;
    }
    final result = await store.refresh(
      force: force,
      acceptResult: () => isAttached,
    );
    if (!isAttached) {
      dispose();
      return RefreshResult.disposed;
    }
    return result;
  }

  Future<bool> _discoverVersion() async {
    try {
      final version = await api.getApiVersion();
      if (!isAttached) {
        return false;
      }
      if (version != null) {
        setVersion(Version.parse(version));
        return true;
      }
    } catch (_) {
      // Do not expose raw API errors to consumers.
    }
    versionUnavailable();
    return false;
  }

  void _checkOwner(final DomainStore<Object> store) {
    if (!_domains.containsKey(store)) {
      throw ArgumentError('Store belongs to another connection.');
    }
  }

  /// Disposes all stores. Requests already sent to the server are not cancelled.
  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    for (final completion in _refreshes.values) {
      completion.complete(RefreshResult.disposed);
    }
    _refreshes.clear();
    commands.dispose();
    for (final store in _domains.keys) {
      store.dispose();
    }
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    unawaited(_changes.close());
  }
}
