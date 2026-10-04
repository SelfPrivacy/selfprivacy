import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

class SecretRecipient {
  final _cancellations = <bool Function()>{};
  bool _disposed = false;

  Future<T> protect<T>(final Future<T> Function() action) async {
    var cancelledBeforeDispatch = false;
    void check() {
      if (_disposed) {
        cancelledBeforeDispatch = true;
        throw const OperationNotSent();
      }
    }

    check();
    final result = await GraphQLDispatchGuard(check).run(action);
    if (cancelledBeforeDispatch) {
      throw const OperationNotSent();
    }
    return result;
  }

  Future<T?> receive<T>(final OperationHandle<T> handle) async {
    if (_disposed) {
      handle.cancel();
    }
    _cancellations.add(handle.cancel);
    try {
      final result = await handle.result;
      return _disposed ? null : result.value;
    } finally {
      _cancellations.remove(handle.cancel);
    }
  }

  void dispose() {
    _disposed = true;
    for (final cancel in _cancellations) {
      cancel();
    }
    _cancellations.clear();
  }
}
