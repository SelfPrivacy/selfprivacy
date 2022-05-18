import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/backblaze.dart';
import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/json/backup.dart';

part 'backups_state.dart';

class BackupsCubit extends ServerInstallationDependendCubit<BackupsState> {
  BackupsCubit(ServerInstallationCubit serverInstallationCubit)
      : super(serverInstallationCubit, BackupsState(preventActions: true));

  final api = ServerApi();
  final backblaze = BackblazeApi();

  Future<void> load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      final bucket = getIt<ApiConfigModel>().backblazeBucket;
      if (bucket == null) {
        emit(BackupsState(
            isInitialized: false, preventActions: false, refreshing: false));
      } else {
        final status = await api.getBackupStatus();
        switch (status.status) {
          case BackupStatusEnum.noKey:
          case BackupStatusEnum.notInitialized:
            emit(BackupsState(
              backups: [],
              isInitialized: true,
              preventActions: false,
              progress: 0,
              status: status.status,
              refreshing: false,
            ));
            break;
          case BackupStatusEnum.initializing:
            emit(BackupsState(
              backups: [],
              isInitialized: true,
              preventActions: false,
              progress: 0,
              status: status.status,
              refreshTimer: Duration(seconds: 10),
              refreshing: false,
            ));
            break;
          case BackupStatusEnum.initialized:
          case BackupStatusEnum.error:
            final backups = await api.getBackups();
            emit(BackupsState(
              backups: backups,
              isInitialized: true,
              preventActions: false,
              progress: status.progress,
              status: status.status,
              error: status.errorMessage ?? '',
              refreshing: false,
            ));
            break;
          case BackupStatusEnum.backingUp:
          case BackupStatusEnum.restoring:
            final backups = await api.getBackups();
            emit(BackupsState(
              backups: backups,
              isInitialized: true,
              preventActions: true,
              progress: status.progress,
              status: status.status,
              error: status.errorMessage ?? '',
              refreshTimer: Duration(seconds: 5),
              refreshing: false,
            ));
            break;
          default:
            emit(BackupsState());
        }
        Timer(state.refreshTimer, () => updateBackups(useTimer: true));
      }
    }
  }

  Future<void> createBucket() async {
    emit(state.copyWith(preventActions: true));
    final domain = serverInstallationCubit.state.serverDomain!.domainName
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '-');
    final serverId = serverInstallationCubit.state.serverDetails!.id;
    var bucketName = 'selfprivacy-$domain-$serverId';
    // If bucket name is too long, shorten it
    if (bucketName.length > 49) {
      bucketName = bucketName.substring(0, 49);
    }
    final bucketId = await backblaze.createBucket(bucketName);

    final key = await backblaze.createKey(bucketId);
    final bucket = BackblazeBucket(
        bucketId: bucketId,
        bucketName: bucketName,
        applicationKey: key.applicationKey,
        applicationKeyId: key.applicationKeyId);

    await getIt<ApiConfigModel>().storeBackblazeBucket(bucket);
    await api.uploadBackblazeConfig(bucket);
    await updateBackups();

    emit(state.copyWith(isInitialized: true, preventActions: false));
  }

  Future<void> reuploadKey() async {
    emit(state.copyWith(preventActions: true));
    final bucket = getIt<ApiConfigModel>().backblazeBucket;
    if (bucket == null) {
      emit(state.copyWith(isInitialized: false));
    } else {
      await api.uploadBackblazeConfig(bucket);
      emit(state.copyWith(isInitialized: true, preventActions: false));
      getIt<NavigationService>().showSnackBar('providers.backup.reuploadedKey');
    }
  }

  Duration refreshTimeFromState(BackupStatusEnum status) {
    switch (status) {
      case BackupStatusEnum.backingUp:
      case BackupStatusEnum.restoring:
        return Duration(seconds: 5);
      case BackupStatusEnum.initializing:
        return Duration(seconds: 10);
      default:
        return Duration(seconds: 60);
    }
  }

  Future<void> updateBackups({bool useTimer = false}) async {
    emit(state.copyWith(refreshing: true));
    final backups = await api.getBackups();
    final status = await api.getBackupStatus();
    emit(state.copyWith(
      backups: backups,
      progress: status.progress,
      status: status.status,
      error: status.errorMessage,
      refreshTimer: refreshTimeFromState(status.status),
      refreshing: false,
    ));
    if (useTimer)
      Timer(state.refreshTimer, () => updateBackups(useTimer: true));
  }

  Future<void> forceUpdateBackups() async {
    emit(state.copyWith(preventActions: true));
    await api.forceBackupListReload();
    getIt<NavigationService>()
        .showSnackBar('providers.backup.refetchingList'.tr());
    emit(state.copyWith(preventActions: false));
  }

  Future<void> createBackup() async {
    emit(state.copyWith(preventActions: true));
    await api.startBackup();
    await updateBackups();
    emit(state.copyWith(preventActions: false));
  }

  Future<void> restoreBackup(String backupId) async {
    emit(state.copyWith(preventActions: true));
    await api.restoreBackup(backupId);
    emit(state.copyWith(preventActions: false));
  }

  @override
  void clear() async {
    emit(BackupsState());
  }
}
