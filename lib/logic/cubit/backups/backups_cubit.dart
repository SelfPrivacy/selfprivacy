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
    if (serverInstallationCubit.state is! ServerInstallationFinished) {
      return;
    }

    final BackblazeBucket? bucket = getIt<ApiConfigModel>().backblazeBucket;
    final BackupConfiguration? backupConfig =
        await api.getBackupsConfiguration();
    final BackupsCredential? backupsCredential =
        getIt<ApiConfigModel>().backblazeCredential;
    final List<Backup> backups = await api.getBackups();
    backups.sort((final a, final b) => b.time.compareTo(a.time));
    final bool? initialized = backupConfig?.isInitialized;
    final nextState = state.copyWith(
      backblazeBucket: bucket,
      isInitialized: initialized,
      autobackupPeriod: backupConfig?.autobackupPeriod ?? Duration.zero,
      autobackupQuotas: backupConfig?.autobackupQuotas,
      backupsCredential: backupsCredential,
      backups: backups,
      preventActions: false,
      refreshing: false,
    );
    emit(
      (initialized == null || initialized == false)
          ? BackupsNotFinishedState.fromBackupsState(nextState)
          : nextState,
    );
  }

  Future<void> setBackupsKey(
    final String keyId,
    final String applicationKey,
  ) async {
    final BackupsCredential backupsCredential = BackupsCredential(
      keyId: keyId,
      applicationKey: applicationKey,
      provider: BackupsProviderType.backblaze,
    );
    await getIt<ApiConfigModel>().storeBackblazeCredential(backupsCredential);
    if (state is BackupsNotFinishedState) {
      emit(
        (state as BackupsNotFinishedState).copyNotFinishedWith(
          backupsCredential: backupsCredential,
          step: BackupsInitializingStep.period,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        backupsCredential: backupsCredential,
      ),
    );
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
    BackblazeBucket? bucket = getIt<ApiConfigModel>().backblazeBucket;
    if (bucket == null) {
      emit(state.copyWith(isInitialized: false));
    } else {
      String login = bucket.applicationKeyId;
      String password = bucket.applicationKey;
      if (login.isEmpty || password.isEmpty) {
        final BackblazeApplicationKey key =
            await backblaze.createKey(bucket.bucketId);
        login = key.applicationKeyId;
        password = key.applicationKey;
        bucket = BackblazeBucket(
          bucketId: bucket.bucketId,
          bucketName: bucket.bucketName,
          encryptionKey: bucket.encryptionKey,
          applicationKey: password,
          applicationKeyId: login,
        );
        await getIt<ApiConfigModel>().storeBackblazeBucket(bucket);
        emit(state.copyWith(backblazeBucket: bucket));
      }
      final GenericResult result = await api.initializeRepository(
        InitializeRepositoryInput(
          provider: BackupsProviderType.backblaze,
          locationId: bucket.bucketId,
          locationName: bucket.bucketName,
          login: login,
          password: password,
        ),
      );
      if (result.success == false) {
        getIt<NavigationService>()
            .showSnackBar(result.message ?? 'Unknown error');
        emit(state.copyWith(preventActions: false));
        return;
      } else {
        emit(state.copyWith(preventActions: false));
        getIt<NavigationService>().showSnackBar('backup.reuploaded_key'.tr());
        await updateBackups();
      }
    }
  }

  @Deprecated("we don't have states")
  Duration refreshTimeFromState() => const Duration(seconds: 60);

  Future<void> updateBackups({final bool useTimer = false}) async {
    emit(state.copyWith(refreshing: true));
    final backups = await api.getBackups();
    backups.sort((final a, final b) => b.time.compareTo(a.time));
    final backupConfig = await api.getBackupsConfiguration();

    emit(
      state.copyWith(
        backups: backups,
        refreshTimer: refreshTimeFromState(),
        refreshing: false,
        isInitialized: backupConfig?.isInitialized ?? false,
        autobackupPeriod: backupConfig?.autobackupPeriod,
        autobackupQuotas: backupConfig?.autobackupQuotas,
      ),
    );
    if (useTimer) {
      Timer(state.refreshTimer, () => updateBackups(useTimer: true));
    }
  }

  Future<void> forceUpdateBackups() async {
    emit(state.copyWith(preventActions: true));
    getIt<NavigationService>().showSnackBar('backup.refetching_list'.tr());
    await api.forceBackupListReload();
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

  Future<void> restoreBackup(
    final String backupId,
    final BackupRestoreStrategy strategy,
  ) async {
    emit(state.copyWith(preventActions: true));
    await api.restoreBackup(backupId, strategy);
    emit(state.copyWith(preventActions: false));
  }

  Future<void> setAutobackupPeriod(final Duration? period) async {
    emit(state.copyWith(preventActions: true));
    final result = await api.setAutobackupPeriod(period: period?.inMinutes);
    if (result.success == false) {
      getIt<NavigationService>()
          .showSnackBar(result.message ?? 'Unknown error');
      emit(state.copyWith(preventActions: false));
    } else {
      getIt<NavigationService>()
          .showSnackBar('backup.autobackup_period_set'.tr());
      emit(
        state.copyWith(
          preventActions: false,
          autobackupPeriod: period ?? Duration.zero,
        ),
      );
    }
    await updateBackups();
  }

  Future<void> setAutobackupQuotas(final AutobackupQuotas quotas) async {
    emit(state.copyWith(preventActions: true));
    final result = await api.setAutobackupQuotas(quotas);
    if (result.success == false) {
      getIt<NavigationService>()
          .showSnackBar(result.message ?? 'Unknown error');
      emit(state.copyWith(preventActions: false));
    } else {
      getIt<NavigationService>().showSnackBar('backup.quotas_set'.tr());
      emit(
        state.copyWith(
          preventActions: false,
          autobackupQuotas: quotas,
        ),
      );
    }
    await updateBackups();
  }

  Future<void> forgetSnapshot(final String snapshotId) async {
    final result = await api.forgetSnapshot(snapshotId);
    if (!result.success) {
      getIt<NavigationService>().showSnackBar('jobs.generic_error'.tr());
      return;
    }

    if (result.data == false) {
      getIt<NavigationService>()
          .showSnackBar('backup.forget_snapshot_error'.tr());
    }

    // Optimistic update
    final backups = state.backups;
    final index =
        backups.indexWhere((final snapshot) => snapshot.id == snapshotId);
    if (index != -1) {
      backups.removeAt(index);
      emit(state.copyWith(backups: backups));
    }

    await updateBackups();
  }

  @override
  void clear() async {
    emit(BackupsNotFinishedState.fromBackupsState(const BackupsState()));
  }
}
