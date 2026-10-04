import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';

class ConnectionObservation<T extends Object> {
  const ConnectionObservation.absent() : origin = null, value = null;
  const ConnectionObservation.attached(
    ServerStateOrigin this.origin,
    T this.value,
  );

  final ServerStateOrigin? origin;
  final T? value;
}
