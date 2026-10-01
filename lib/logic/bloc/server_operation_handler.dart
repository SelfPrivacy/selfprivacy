import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';

EventHandler<E, S> serverOperation<E, S>(
  final OperationKind kind,
  final Future<void> Function(E, ServerConnection, void Function(S)) action,
) => (final event, final emit) async {
  await getIt<ApiConnectionRepository>().run<void>(
    kind,
    (final owner) => action(event, owner, (final value) {
      if (!emit.isDone) {
        emit(value);
      }
    }),
  );
};
