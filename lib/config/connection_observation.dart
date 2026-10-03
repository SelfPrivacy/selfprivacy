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
  required final ServerConnectionHub hub,
  required final T Function(ServerConnection) read,
  required final Stream<Object?> Function(ServerConnection) changes,
}) => Stream.multi((final output) {
  ServerConnection? observed;
  StreamSubscription<Object?>? domainSubscription;
  var initialized = false;

  void rebind() {
    final connection = hub.active;
    if (initialized && identical(connection, observed)) {
      return;
    }
    initialized = true;
    observed = connection;
    unawaited(domainSubscription?.cancel());
    domainSubscription = null;
    if (connection == null) {
      output.addSync(const ConnectionObservation.absent());
      return;
    }
    T? previous;
    void publish() {
      if (!identical(observed, connection) || !connection.isAttached) {
        return;
      }
      final value = read(connection);
      if (!identical(value, previous)) {
        previous = value;
        output.addSync(
          ConnectionObservation.attached(connection.origin, value),
        );
      }
    }

    domainSubscription = changes(connection).listen((_) => publish());
    publish();
  }

  final bindingSubscription = hub.changes.listen(
    (_) => rebind(),
    onDone: () {
      rebind();
      unawaited(domainSubscription?.cancel());
      unawaited(output.close());
    },
  );
  output.onCancel = () async {
    observed = null;
    await bindingSubscription.cancel();
    await domainSubscription?.cancel();
  };
  rebind();
});

Stream<ConnectionObservation<bool>> observeReadAccess(
  final ServerConnectionHub hub,
) =>
    Stream<ConnectionObservation<bool>>.multi((final output) {
      void publish() {
        final origin = hub.active?.origin;
        output.addSync(
          origin == null
              ? const ConnectionObservation.absent()
              : ConnectionObservation.attached(origin, hub.canRead),
        );
      }

      final subscription = hub.changes.listen(
        (_) => publish(),
        onDone: output.close,
      );
      output.onCancel = subscription.cancel;
      publish();
    }).distinct(
      (final previous, final next) =>
          identical(previous.origin, next.origin) &&
          previous.value == next.value,
    );
