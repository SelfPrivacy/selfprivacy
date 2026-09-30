import 'dart:async';

import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';

class ServerConnectionBinding {
  ServerConnectionBinding(final Server server)
    : serverId = server.uuid,
      domain = server.domain.domainName,
      token = server.hostingDetails.apiToken;

  final String serverId;
  final String domain;
  final String? token;

  bool matches(final Server? server) =>
      server != null &&
      server.uuid == serverId &&
      server.domain.domainName == domain &&
      server.hostingDetails.apiToken == token;
}

typedef BoundServerApiFactory =
    ServerApi Function(
      ServerConnectionBinding binding,
      void Function() onAuthFailure,
    );

/// Replaces the connection when the selected server, domain, or token changes.
class ServerConnectionScope {
  ServerConnectionScope({
    required final Server? Function() selectServer,
    required final Stream<Object?> serverChanges,
    required final BoundServerApiFactory createApi,
    required final void Function() onAuthFailure,
  }) : _selectServer = selectServer,
       _createApi = createApi,
       _onAuthFailure = onAuthFailure {
    _serverSubscription = serverChanges.listen((_) {
      _synchronize();
    });
  }

  final Server? Function() _selectServer;
  final BoundServerApiFactory _createApi;
  final void Function() _onAuthFailure;
  final _changes = StreamController<void>.broadcast();
  late final StreamSubscription<Object?> _serverSubscription;
  StreamSubscription<void>? _connectionSubscription;
  ServerConnection? _current;
  ServerConnectionBinding? _binding;
  bool _cleared = false;
  bool _disposed = false;

  ServerConnection? get current => _synchronize();
  Stream<void> get changes => _changes.stream;

  ServerConnection? _synchronize() {
    if (_disposed || _cleared) {
      return null;
    }
    final server = _selectServer();
    if (_binding?.matches(server) ?? server == null) {
      return _current;
    }
    _detach();
    if (server != null) {
      final binding = ServerConnectionBinding(server);
      final origin = ServerStateOrigin(binding.serverId);
      bool isCurrent() =>
          !_disposed &&
          !_cleared &&
          identical(_binding, binding) &&
          binding.matches(_selectServer());
      final api = _createApi(binding, () {
        if (isCurrent()) {
          _onAuthFailure();
        }
      });
      _binding = binding;
      _current = ServerConnection(
        api: api,
        origin: origin,
        currentOrigin: () => isCurrent() ? origin : null,
      );
      _connectionSubscription = _current!.changes.listen((_) {
        if (isCurrent()) {
          _changes.add(null);
        }
      });
    }
    _changes.add(null);
    return _current;
  }

  void _detach() {
    _binding = null;
    _current?.dispose();
    _current = null;
    unawaited(_connectionSubscription?.cancel());
    _connectionSubscription = null;
  }

  void clear() {
    if (_disposed) {
      return;
    }
    _cleared = true;
    _detach();
    _changes.add(null);
  }

  void resume() {
    if (_disposed) {
      return;
    }
    _cleared = false;
    _synchronize();
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _detach();
    unawaited(_serverSubscription.cancel());
    unawaited(_changes.close());
  }
}
