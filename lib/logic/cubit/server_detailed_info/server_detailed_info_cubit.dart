import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_repository.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';
import 'package:selfprivacy/logic/models/timezone_settings.dart';

part 'server_detailed_info_state.dart';

class ServerDetailsCubit extends Cubit<ServerDetailsState> {
  ServerDetailsCubit() : super(ServerDetailsInitial());

  ServerDetailsRepository repository = ServerDetailsRepository();

  void check() async {
    final bool isReadyToCheck = getIt<ApiConfigModel>().serverDetails != null;
    try {
      if (isReadyToCheck) {
        emit(ServerDetailsLoading());
        final ServerDetailsRepositoryDto data = await repository.load();
        emit(
          Loaded(
            serverInfo: data.hetznerServerInfo,
            autoUpgradeSettings: data.autoUpgradeSettings,
            serverTimezone: data.serverTimezone,
            checkTime: DateTime.now(),
          ),
        );
      } else {
        emit(ServerDetailsNotReady());
      }
    } on StateError {
      print('Tried to emit server info state when cubit is closed');
    }
  }
}
