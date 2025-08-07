import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';

/// basically, a bus for other blocs to listen to server status updates
class ConnectionStatusBloc extends Bloc<ConnectionStatus, ConnectionStatus> {
  ConnectionStatusBloc() : super(ConnectionStatus.nonexistent) {
    on<ConnectionStatus>((final newStatus, final emit) => emit(newStatus));

    final apiConnectionRepository = getIt<ApiConnectionRepository>();
    _apiConnectionStatusSubscription = apiConnectionRepository
        .connectionStatusStream
        .listen(add);
  }

  StreamSubscription? _apiConnectionStatusSubscription;

  @override
  Future<void> close() async {
    await _apiConnectionStatusSubscription?.cancel();
    return super.close();
  }
}
