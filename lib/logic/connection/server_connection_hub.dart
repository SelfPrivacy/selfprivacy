import 'dart:async';

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
import 'package:selfprivacy/logic/models/hive/server.dart';

class ServerConnectionHub {
  ServerConnectionHub({
    required final ResourcesModel resourcesModel,
    final ConnectionApiFactory? createApi,
    final Server? Function()? selectServer,
    final bool Function()? automaticRotationEnabled,
    final DateTime Function()? now,
  }) : _resources = resourcesModel,
       _selectServer =
           selectServer ?? (() => resourcesModel.servers.firstOrNull),
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
  final Server? Function() _selectServer;
  final ConnectionApiFactory _createApi;
  final DateTime Function() _now;
  final bool Function() _automaticRotationEnabled;
  late final StreamSubscription<Object?> _resourcesSubscription;
  final _rotationHistory = <String, TokenRotationHistory>{};
  final _changes = StreamController<void>.broadcast();
  ServerConnection? _connection;
  StreamSubscription<void>? _connectionSubscription;
  bool _disposed = false;
  bool _cleared = false;
  AppLifecycle? _lifecycle;
  late NetworkConnectivitySource _connectivity;
  bool _ownsLifecycle = false;

  Stream<void> get changes => _changes.stream;
  ServerConnection? get active =>
      (_connection?.isAttached ?? false) ? _connection : null;
  ReachabilityStatus? get reachability => active?.reachability;
  bool get isForeground => _lifecycle?.isForeground ?? true;

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
    _startConnection();
  }

  void _startConnection() {
    if (_lifecycle case final lifecycle?) {
      _connection?.start(lifecycle: lifecycle, connectivity: _connectivity);
    }
  }

  void _synchronize() {
    if (_disposed || _cleared) {
      return;
    }
    final server = _selectServer();
    if (_connection?.matches(server) ?? server == null) {
      return;
    }
    _detach();
    if (server != null) {
      _connection = ServerConnection.connect(
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
      _connectionSubscription = _connection!.changes.listen((_) {
        _synchronize();
        _notify();
      });
      _startConnection();
    }
    _notify();
  }

  void _detach() {
    unawaited(_connectionSubscription?.cancel());
    _connectionSubscription = null;
    final previous = _connection;
    _connection = null;
    previous?.dispose();
  }

  void clear() {
    _cleared = true;
    _detach();
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
    _detach();
    if (_ownsLifecycle) {
      _lifecycle?.dispose();
    }
    unawaited(_resourcesSubscription.cancel());
    unawaited(_changes.close());
  }
}
