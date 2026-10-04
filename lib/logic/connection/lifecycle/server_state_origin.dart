final class ConnectionContinuity {}

/// Identity of one server's cache and transport generation.
/// Create a new instance when either binding is replaced, even for the same UUID.
class ServerStateOrigin {
  ServerStateOrigin(this.serverId, {final ConnectionContinuity? continuity})
    : continuity = continuity ?? ConnectionContinuity();

  final String serverId;
  final ConnectionContinuity continuity;
}
