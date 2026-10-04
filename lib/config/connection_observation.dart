import 'dart:async';

import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/lifecycle/reachability.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';

Stream<ReachabilityStatus?> observeReachability(
  final ServerConnectionHub hub,
) => Stream<ReachabilityStatus?>.multi((final output) {
  output.addSync(hub.reachability);
  final subscription = hub.changes.listen(
    (_) => output.addSync(hub.reachability),
    onDone: output.close,
  );
  output.onCancel = subscription.cancel;
}).distinct();

Stream<ConnectionObservation<T>> observeConnection<T extends Object>({
  required final ServerConnection connection,
  required final T Function(ServerConnection) read,
  required final Stream<Object?> Function(ServerConnection) changes,
}) => Stream.multi((final output) {
  StreamSubscription<Object?>? domainSubscription;
  T? previous;
  void publish() {
    if (!connection.isAttached) {
      output.addSync(const ConnectionObservation.absent());
      return;
    }
    final value = read(connection);
    if (!identical(value, previous)) {
      previous = value;
      output.addSync(ConnectionObservation.attached(connection.origin, value));
    }
  }

  domainSubscription = changes(connection).listen((_) => publish());
  final bindingSubscription = connection.changes.listen(
    (_) => publish(),
    onDone: () {
      publish();
      unawaited(domainSubscription?.cancel());
      unawaited(output.close());
    },
  );
  output.onCancel = () async {
    await bindingSubscription.cancel();
    await domainSubscription?.cancel();
  };
  publish();
});

Stream<ConnectionObservation<bool>> observeReadAccess(
  final ServerConnection connection,
) =>
    Stream<ConnectionObservation<bool>>.multi((final output) {
      void publish() {
        final origin = connection.isAttached ? connection.origin : null;
        output.addSync(
          origin == null
              ? const ConnectionObservation.absent()
              : ConnectionObservation.attached(origin, connection.canRead),
        );
      }

      final subscription = connection.changes.listen(
        (_) => publish(),
        onDone: () {
          publish();
          unawaited(output.close());
        },
      );
      output.onCancel = subscription.cancel;
      publish();
    }).distinct(
      (final previous, final next) =>
          identical(previous.origin, next.origin) &&
          previous.value == next.value,
    );
