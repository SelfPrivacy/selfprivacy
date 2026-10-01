import 'dart:async';

Stream<T> managedSubscription<T>({
  required final Stream<void> changes,
  required final Object? Function() identity,
  required final bool Function() available,
  required final bool Function() detached,
  required final Stream<T> Function() open,
}) {
  late final StreamController<T> controller;
  StreamSubscription<void>? observation;
  StreamSubscription<T>? source;
  Object? owner;
  Timer? retry;
  bool disposed = false;

  void disconnect() {
    owner = null;
    final previous = source;
    source = null;
    unawaited(previous?.cancel());
  }

  late final void Function() synchronize;
  void lost() {
    disconnect();
    if (!disposed) {
      retry ??= Timer(const Duration(seconds: 10), () {
        retry = null;
        synchronize();
      });
    }
  }

  synchronize = () {
    if (disposed) {
      return;
    }
    if (detached()) {
      disconnect();
      unawaited(controller.close());
      return;
    }
    final next = identity();
    if (!available() || !identical(owner, next)) {
      disconnect();
    }
    if (source != null || retry != null || !available() || next == null) {
      return;
    }
    owner = next;
    source = open().listen(
      (final event) {
        if (!disposed &&
            identical(owner, next) &&
            identical(identity(), next)) {
          controller.add(event);
        }
      },
      onError: (final Object _) => lost(),
      onDone: lost,
    );
  };

  controller = StreamController<T>(
    onListen: () {
      observation = changes.listen((_) => synchronize());
      synchronize();
    },
    onCancel: () {
      disposed = true;
      retry?.cancel();
      disconnect();
      unawaited(observation?.cancel());
    },
  );
  return controller.stream;
}
