import 'dart:async';

import 'package:pool/pool.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/connection/lifecycle/app_lifecycle.dart';
import 'package:selfprivacy/logic/connection/lifecycle/network_connectivity.dart';
import 'package:selfprivacy/logic/connection/lifecycle/reachability.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_connection_binding.dart';
import 'package:selfprivacy/logic/connection/lifecycle/token_rotation.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';

class ServerConnectionHub {
  ServerConnectionHub({
    required final ResourcesModel resourcesModel,
    final ConnectionApiFactory? createApi,
    final String? activeServerUuid,
    final Future<void> Function(String?)? persistSelection,
    final bool Function()? automaticRotationEnabled,
    final DateTime Function()? now,
  }) : _resources = resourcesModel,
       _activeServerUuid = activeServerUuid,
       _persistSelection = persistSelection,
       _createApi = createApi ?? _productionApi,
       _now = now ?? DateTime.now,
       _automaticRotationEnabled =
           automaticRotationEnabled ??
           (() =>
               getIt.isRegistered<DeveloperSettingsModel>() &&
               getIt<DeveloperSettingsModel>().automaticGraphqlTokenRefresh) {
    _resourcesSubscription = resourcesModel.statusStream.listen(
      (_) => _synchronize(),
    );
    _synchronize();
  }

  static ServerApi _productionApi(
    final ServerConnectionBinding binding,
    final void Function(GraphQLTransportEvent) onEvent,
    final void Function() beforeRequest,
  ) => ServerApi(
    transport: createGraphQLTransport(
      domainProvider: () => binding.domain,
      tokenProvider: () => binding.token,
      onEvent: onEvent,
      beforeRequest: beforeRequest,
    ),
  );

  final ResourcesModel _resources;
  final Future<void> Function(String?)? _persistSelection;
  final _selectionWrites = Pool(1);
  final ConnectionApiFactory _createApi;
  final DateTime Function() _now;
  final bool Function() _automaticRotationEnabled;
  late final StreamSubscription<Object?> _resourcesSubscription;
  final _rotationHistory = <String, TokenRotationHistory>{};
  final _changes = StreamController<void>.broadcast();
  final _connections = <String, ServerConnection>{};
  final _connectionSubscriptions = <String, StreamSubscription<void>>{};
  String? _activeServerUuid;
  bool _disposed = false;
  bool _cleared = false;
  AppLifecycle? _lifecycle;
  late NetworkConnectivitySource _connectivity;
  bool _ownsLifecycle = false;

  Stream<void> get changes => _changes.stream;
  Map<String, ServerConnection> get connections =>
      Map.unmodifiable(_connections);
  ServerConnection? get active {
    final connection = _connections[_activeServerUuid];
    return (connection?.isAttached ?? false) ? connection : null;
  }

  ReachabilityStatus? get reachability => active?.reachability;
  bool get isForeground => _lifecycle?.isForeground ?? true;

  Future<void> selectServer(final String uuid) async {
    if (_disposed || _cleared) {
      throw StateError('Connections are not available.');
    }
    final connection = _connections[uuid];
    if (connection == null) {
      throw ArgumentError.value(uuid, 'uuid', 'Unknown server');
    }
    bool isCurrent() =>
        !_disposed && !_cleared && identical(_connections[uuid], connection);
    await _selectionWrites.withResource(() async {
      if (!isCurrent()) {
        return;
      }
      final previousUuid = _activeServerUuid;
      await _persistSelection?.call(uuid);
      if (!isCurrent()) {
        String? selected;
        do {
          selected = _disposed ? previousUuid : _activeServerUuid;
          await _persistSelection?.call(selected);
        } while (selected != (_disposed ? previousUuid : _activeServerUuid));
        return;
      }
      _activeServerUuid = uuid;
      _synchronize();
      _notify();
    });
  }

  void start({
    final AppLifecycle? lifecycle,
    final NetworkConnectivitySource? connectivity,
  }) {
    if (_disposed || _lifecycle != null) {
      return;
    }
    _ownsLifecycle = lifecycle == null;
    _lifecycle = lifecycle ?? AppLifecycle();
    _connectivity = connectivity ?? OsNetworkConnectivity();
    _synchronize();
    _startConnections();
  }

  void _startConnections() {
    if (_lifecycle case final lifecycle?) {
      for (final connection in _connections.values) {
        connection.start(lifecycle: lifecycle, connectivity: _connectivity);
      }
    }
  }

  void _synchronize() {
    if (_disposed || _cleared) {
      return;
    }
    final servers = {
      for (final server in _resources.servers) server.uuid: server,
    };
    var changed = false;
    for (final entry in _connections.entries.toList()) {
      if (!entry.value.matches(servers[entry.key])) {
        _detach(entry.key);
        changed = true;
      }
    }
    for (final server in servers.values) {
      if (_connections.containsKey(server.uuid)) {
        continue;
      }
      final connection = ServerConnection.connect(
        server: server,
        resources: _resources,
        createApi: _createApi,
        rotationHistory: _rotationHistory.putIfAbsent(
          server.uuid,
          TokenRotationHistory.new,
        ),
        automaticRotationEnabled: _automaticRotationEnabled,
        now: _now,
      );
      _connections[server.uuid] = connection;
      _connectionSubscriptions[server.uuid] = connection.changes.listen((_) {
        _synchronize();
        _notify();
      });
      changed = true;
    }
    final selected = _connections.containsKey(_activeServerUuid)
        ? _activeServerUuid
        : servers.keys.firstOrNull;
    if (selected != _activeServerUuid) {
      _activeServerUuid = selected;
      changed = true;
    }
    for (final entry in _connections.entries) {
      entry.value.scheduler.setBackground(background: entry.key != selected);
    }
    _startConnections();
    if (changed) {
      _notify();
    }
  }

  void _detach(final String uuid) {
    unawaited(_connectionSubscriptions.remove(uuid)?.cancel());
    _connections.remove(uuid)?.dispose();
  }

  void _detachAll() {
    _connections.keys.toList().forEach(_detach);
    _activeServerUuid = null;
  }

  void clear() {
    _cleared = true;
    _detachAll();
    _notify();
  }

  void resume() {
    _cleared = false;
    _synchronize();
  }

  void _notify() {
    if (!_disposed) {
      _changes.add(null);
    }
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    unawaited(_selectionWrites.close());
    _detachAll();
    if (_ownsLifecycle) {
      _lifecycle?.dispose();
    }
    unawaited(_resourcesSubscription.cancel());
    unawaited(_changes.close());
  }
}
