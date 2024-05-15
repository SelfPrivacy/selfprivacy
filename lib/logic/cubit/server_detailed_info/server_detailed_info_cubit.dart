import 'dart:async';

import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/server_connection_dependent/server_connection_dependent_cubit.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/ssh_settings.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';
import 'package:selfprivacy/logic/models/timezone_settings.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';

part 'server_detailed_info_state.dart';

class ServerDetailsCubit
    extends ServerConnectionDependentCubit<ServerDetailsState> {
  ServerDetailsCubit() : super(const ServerDetailsInitial()) {
    final apiConnectionRepository = getIt<ApiConnectionRepository>();
    _apiDataSubscription = apiConnectionRepository.dataStream.listen(
      (final ApiData apiData) {
        if (apiData.settings.data != null) {
          _handleServerSettings(apiData.settings.data!);
        }
      },
    );
  }

  StreamSubscription? _apiDataSubscription;

  void _handleServerSettings(final SystemSettings settings) {
    emit(
      Loaded(
        metadata: state.metadata,
        serverTimezone: TimeZoneSettings.fromString(settings.timezone),
        autoUpgradeSettings: settings.autoUpgradeSettings,
        sshSettings: settings.sshSettings,
      ),
    );
  }

  Future<List<ServerMetadataEntity>> get _metadata async {
    List<ServerMetadataEntity> data = [];

    final serverProviderApi = ProvidersController.currentServerProvider;
    final dnsProviderApi = ProvidersController.currentDnsProvider;
    if (serverProviderApi != null && dnsProviderApi != null) {
      final serverId = getIt<ResourcesModel>().serverDetails?.id ?? 0;
      final metadataResult = await serverProviderApi.getMetadata(serverId);
      metadataResult.data.add(
        ServerMetadataEntity(
          trId: 'server.dns_provider',
          value: dnsProviderApi.type.displayName,
          type: MetadataType.other,
        ),
      );

      data = metadataResult.data;
    }

    return data;
  }

  void check() async {
    final bool isReadyToCheck = getIt<ResourcesModel>().serverDetails != null;
    try {
      if (isReadyToCheck) {
        emit(const ServerDetailsLoading());
        final List<ServerMetadataEntity> metadata = await _metadata;
        emit(
          state.copyWith(
            metadata: metadata,
          ),
        );
      } else {
        emit(const ServerDetailsNotReady());
      }
    } on StateError {
      print('Tried to emit server info state when cubit is closed');
    }
  }

  @override
  void clear() {
    emit(const ServerDetailsNotReady());
  }

  @override
  void load() async {
    check();
  }

  @override
  Future<void> close() {
    _apiDataSubscription?.cancel();
    return super.close();
  }
}
