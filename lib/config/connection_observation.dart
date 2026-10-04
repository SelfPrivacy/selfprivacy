import 'dart:async';

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

Stream<T?> observeConnection<T extends Object>({
  required final ServerConnection connection,
  required final T Function(ServerConnection) read,
  required final Stream<Object?> Function(ServerConnection) changes,
}) => Stream.multi((final output) {
  StreamSubscription<Object?>? domainSubscription;
  T? previous;
  void publish() {
    if (!connection.isAttached) {
      output.addSync(null);
      return;
    }
    final value = read(connection);
    if (!identical(value, previous)) {
      previous = value;
      output.addSync(value);
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

Stream<bool?> observeReadAccess(final ServerConnection connection) =>
    Stream<bool?>.multi((final output) {
      void publish() {
        output.addSync(connection.isAttached ? connection.canRead : null);
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
    }).distinct();
