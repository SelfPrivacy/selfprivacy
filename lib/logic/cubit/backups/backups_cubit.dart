import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/backblaze.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/json/backup.dart';

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
      if (bucket == null) {
        emit(
          const BackupsState(
            isInitialized: false,
            preventActions: false,
            refreshing: false,
          ),
        );
      } else {
        final BackupStatus status = await api.getBackupStatus();
        switch (status.status) {
          case BackupStatusEnum.noKey:
          case BackupStatusEnum.notInitialized:
            emit(
              BackupsState(
                backups: const [],
                isInitialized: true,
                preventActions: false,
                progress: 0,
                status: status.status,
                refreshing: false,
              ),
            );
            break;
          case BackupStatusEnum.initializing:
            emit(
              BackupsState(
                backups: const [],
                isInitialized: true,
                preventActions: false,
                progress: 0,
                status: status.status,
                refreshTimer: const Duration(seconds: 10),
                refreshing: false,
              ),
            );
            break;
          case BackupStatusEnum.initialized:
          case BackupStatusEnum.error:
            final result = await api.getBackups();
            emit(
              BackupsState(
                backups: result.data,
                isInitialized: true,
                preventActions: false,
                progress: status.progress,
                status: status.status,
                error: status.errorMessage ?? '',
                refreshing: false,
              ),
            );
            break;
          case BackupStatusEnum.backingUp:
          case BackupStatusEnum.restoring:
            final result = await api.getBackups();
            emit(
              BackupsState(
                backups: result.data,
                isInitialized: true,
                preventActions: true,
                progress: status.progress,
                status: status.status,
                error: status.errorMessage ?? '',
                refreshTimer: const Duration(seconds: 5),
                refreshing: false,
              ),
            );
            break;
          default:
            emit(const BackupsState());
        }
        Timer(state.refreshTimer, () => updateBackups(useTimer: true));
      }
    }
  }

  Future<void> createBucket() async {
    emit(state.copyWith(preventActions: true));
    final String domain = serverInstallationCubit.state.serverDomain!.domainName
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '-');
    final int serverId = serverInstallationCubit.state.serverDetails!.id;
    String bucketName = 'selfprivacy-$domain-$serverId';
    // If bucket name is too long, shorten it
    if (bucketName.length > 49) {
      bucketName = bucketName.substring(0, 49);
    }
    final String bucketId = await backblaze.createBucket(bucketName);

    final BackblazeApplicationKey key = await backblaze.createKey(bucketId);
    final BackblazeBucket bucket = BackblazeBucket(
      bucketId: bucketId,
      bucketName: bucketName,
      applicationKey: key.applicationKey,
      applicationKeyId: key.applicationKeyId,
    );

    await getIt<ApiConfigModel>().storeBackblazeBucket(bucket);
    //await api.uploadBackblazeConfig(bucket);
    await updateBackups();

    emit(state.copyWith(isInitialized: true, preventActions: false));
  }

  Future<void> reuploadKey() async {
    emit(state.copyWith(preventActions: true));
    final BackblazeBucket? bucket = getIt<ApiConfigModel>().backblazeBucket;
    if (bucket == null) {
      emit(state.copyWith(isInitialized: false));
    } else {
      //await api.uploadBackblazeConfig(bucket);
      emit(state.copyWith(isInitialized: true, preventActions: false));
      getIt<NavigationService>().showSnackBar('backup.reuploaded_key');
    }
  }

  Duration refreshTimeFromState(final BackupStatusEnum status) {
    switch (status) {
      case BackupStatusEnum.backingUp:
      case BackupStatusEnum.restoring:
        return const Duration(seconds: 5);
      case BackupStatusEnum.initializing:
        return const Duration(seconds: 10);
      default:
        return const Duration(seconds: 60);
    }
  }

  Future<void> updateBackups({final bool useTimer = false}) async {
    emit(state.copyWith(refreshing: true));
    final result = await api.getBackups();
    if (!result.success || result.data.isEmpty) {
      return;
    }

    final List<Backup> backups = result.data;
    final BackupStatus status = await api.getBackupStatus();
    emit(
      state.copyWith(
        backups: backups,
        progress: status.progress,
        status: status.status,
        error: status.errorMessage,
        refreshTimer: refreshTimeFromState(status.status),
        refreshing: false,
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

  Future<void> createBackup() async {
    emit(state.copyWith(preventActions: true));
    await api.startBackup();
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
