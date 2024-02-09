import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';

part 'connection_status_event.dart';
part 'connection_status_state.dart';

class ConnectionStatusBloc
    extends Bloc<ConnectionStatusEvent, ConnectionStatusState> {
  ConnectionStatusBloc()
      : super(
          const ConnectionStatusState(
            connectionStatus: ConnectionStatus.nonexistent,
          ),
        ) {
    on<ConnectionStatusChanged>((final event, final emit) {
      emit(ConnectionStatusState(connectionStatus: event.connectionStatus));
    });
    final apiConnectionRepository = getIt<ApiConnectionRepository>();
    _apiConnectionStatusSubscription =
        apiConnectionRepository.connectionStatusStream.listen(
      (final ConnectionStatus connectionStatus) {
        add(
          ConnectionStatusChanged(connectionStatus),
        );
      },
    );
  }

  StreamSubscription? _apiConnectionStatusSubscription;

  @override
  Future<void> close() {
    _apiConnectionStatusSubscription?.cancel();
    return super.close();
  }
}
