import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';

class ConnectionObservation<T extends Object> {
  const ConnectionObservation.absent() : origin = null, value = null;
  const ConnectionObservation.attached(
    ServerStateOrigin this.origin,
    T this.value,
  );

  final ServerStateOrigin? origin;
  final T? value;
}
