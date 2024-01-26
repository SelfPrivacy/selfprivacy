import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/server_connection_dependent/server_connection_dependent_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_repository.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/timezone_settings.dart';

part 'server_detailed_info_state.dart';

class ServerDetailsCubit
    extends ServerConnectionDependentCubit<ServerDetailsState> {
  ServerDetailsCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(ServerDetailsInitial());

  ServerDetailsRepository repository = ServerDetailsRepository();

  void check() async {
    final bool isReadyToCheck = getIt<ApiConfigModel>().serverDetails != null;
    try {
      if (isReadyToCheck) {
        emit(ServerDetailsLoading());
        final ServerDetailsRepositoryDto data = await repository.load();
        emit(
          Loaded(
            metadata: data.metadata,
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

  @override
  void clear() {
    emit(ServerDetailsNotReady());
  }

  @override
  void load() async {
    check();
  }
}
