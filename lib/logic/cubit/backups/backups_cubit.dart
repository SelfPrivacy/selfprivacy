import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/backblaze.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/initialize_repository_input.dart';
import 'package:selfprivacy/logic/models/service.dart';

part 'backups_state.dart';

class BackupsCubit extends ServerInstallationDependendCubit<BackupsState> {
  BackupsCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(
          serverInstallationCubit,
          const BackupsState(preventActions: true),
        );

  final ServerApi api = ServerApi();
  final BackblazeApi backblaze = BackblazeApi();

  @override
  Future<void> load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      final BackblazeBucket? bucket = getIt<ApiConfigModel>().backblazeBucket;
      final BackupConfiguration? backupConfig =
          await api.getBackupsConfiguration();
      final List<Backup> backups = await api.getBackups();
      emit(
        state.copyWith(
          backblazeBucket: bucket,
          isInitialized: backupConfig?.isInitialized,
          autobackupPeriod: backupConfig?.autobackupPeriod,
          backups: backups,
          preventActions: false,
          refreshing: false,
        ),
      );
      print(state);
    }
  }

  Future<void> initializeBackups() async {
    emit(state.copyWith(preventActions: true));
    final String? encryptionKey =
        (await api.getBackupsConfiguration())?.encryptionKey;
    if (encryptionKey == null) {
      getIt<NavigationService>()
          .showSnackBar("Couldn't get encryption key from your server.");
      emit(state.copyWith(preventActions: false));
      return;
    }

    final BackblazeBucket bucket;

    if (state.backblazeBucket == null) {
      final String domain = serverInstallationCubit
          .state.serverDomain!.domainName
          .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '-');
      final int serverId = serverInstallationCubit.state.serverDetails!.id;
      String bucketName = 'selfprivacy-$domain-$serverId';
      // If bucket name is too long, shorten it
      if (bucketName.length > 49) {
        bucketName = bucketName.substring(0, 49);
      }
      final String bucketId = await backblaze.createBucket(bucketName);

      final BackblazeApplicationKey key = await backblaze.createKey(bucketId);
      bucket = BackblazeBucket(
        bucketId: bucketId,
        bucketName: bucketName,
        applicationKey: key.applicationKey,
        applicationKeyId: key.applicationKeyId,
        encryptionKey: encryptionKey,
      );

      await getIt<ApiConfigModel>().storeBackblazeBucket(bucket);
      emit(state.copyWith(backblazeBucket: bucket));
    } else {
      bucket = state.backblazeBucket!;
    }

    final GenericResult result = await api.initializeRepository(
      InitializeRepositoryInput(
        provider: BackupsProviderType.backblaze,
        locationId: bucket.bucketId,
        locationName: bucket.bucketName,
        login: bucket.applicationKeyId,
        password: bucket.applicationKey,
      ),
    );
    if (result.success == false) {
      getIt<NavigationService>()
          .showSnackBar(result.message ?? 'Unknown error');
      emit(state.copyWith(preventActions: false));
      return;
    }
    await updateBackups();
    getIt<NavigationService>().showSnackBar(
      'Backups repository is now initializing. It may take a while.',
    );

    emit(state.copyWith(preventActions: false));
  }

  Future<void> reuploadKey() async {
    emit(state.copyWith(preventActions: true));
    final BackblazeBucket? bucket = getIt<ApiConfigModel>().backblazeBucket;
    if (bucket == null) {
      emit(state.copyWith(isInitialized: false));
      print('bucket is null');
    } else {
      print('bucket is not null');
      final GenericResult result = await api.initializeRepository(
        InitializeRepositoryInput(
          provider: BackupsProviderType.backblaze,
          locationId: bucket.bucketId,
          locationName: bucket.bucketName,
          login: bucket.applicationKeyId,
          password: bucket.applicationKey,
        ),
      );
      print('result is $result');
      if (result.success == false) {
        getIt<NavigationService>()
            .showSnackBar(result.message ?? 'Unknown error');
        emit(state.copyWith(preventActions: false));
        return;
      } else {
        emit(state.copyWith(preventActions: false));
        getIt<NavigationService>().showSnackBar('backup.reuploaded_key');
        await updateBackups();
      }
    }
  }

  @Deprecated("we don't have states")
  Duration refreshTimeFromState() => const Duration(seconds: 60);

  Future<void> updateBackups({final bool useTimer = false}) async {
    emit(state.copyWith(refreshing: true));
    final backups = await api.getBackups();
    final backupConfig = await api.getBackupsConfiguration();

    emit(
      state.copyWith(
        backups: backups,
        refreshTimer: refreshTimeFromState(),
        refreshing: false,
        isInitialized: backupConfig?.isInitialized ?? false,
        autobackupPeriod: backupConfig?.autobackupPeriod,
      ),
    );
    if (useTimer) {
      Timer(state.refreshTimer, () => updateBackups(useTimer: true));
    }
  }

  Future<void> forceUpdateBackups() async {
    emit(state.copyWith(preventActions: true));
    await api.forceBackupListReload();
    getIt<NavigationService>().showSnackBar('backup.refetching_list'.tr());
    emit(state.copyWith(preventActions: false));
  }

  Future<void> createMultipleBackups(final List<Service> services) async {
    emit(state.copyWith(preventActions: true));
    for (final service in services) {
      await api.startBackup(service.id);
    }
    await updateBackups();
    emit(state.copyWith(preventActions: false));
  }

  Future<void> createBackup(final String serviceId) async {
    emit(state.copyWith(preventActions: true));
    await api.startBackup(serviceId);
    await updateBackups();
    emit(state.copyWith(preventActions: false));
  }

  Future<void> restoreBackup(final String backupId) async {
    emit(state.copyWith(preventActions: true));

    /// TOOD: ???
    //await api.restoreBackup(backupId);
    emit(state.copyWith(preventActions: false));
  }

  @override
  void clear() async {
    emit(const BackupsState());
  }
}
