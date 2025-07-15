import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/initialize_repository_input.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/providers/backups_providers/backups_provider.dart';
import 'package:selfprivacy/logic/providers/backups_providers/backups_provider_factory.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';

part 'backups_event.dart';
part 'backups_state.dart';

class BackupsBloc extends Bloc<BackupsEvent, BackupsState> {
  BackupsBloc() : super(BackupsInitial()) {
    on<BackupsServerLoaded>(_loadState, transformer: droppable());
    on<BackupsServerReset>(_resetState, transformer: droppable());
    on<BackupsStateChanged>(_updateState, transformer: droppable());
    on<InitializeBackupsRepository>(
      _initializeRepository,
      transformer: droppable(),
    );
    on<ForceSnapshotListUpdate>(
      _forceSnapshotListUpdate,
      transformer: droppable(),
    );
    on<CreateBackups>(_createBackups, transformer: sequential());
    on<RestoreBackup>(_restoreBackup, transformer: sequential());
    on<SetAutobackupPeriod>(_setAutobackupPeriod, transformer: restartable());
    on<SetAutobackupQuotas>(_setAutobackupQuotas, transformer: restartable());
    on<ForgetSnapshot>(_forgetSnapshot, transformer: sequential());

    final connectionRepository = getIt<ApiConnectionRepository>();

    _apiStatusSubscription = connectionRepository.connectionStatusStream.listen(
      (final ConnectionStatus connectionStatus) {
        switch (connectionStatus) {
          case ConnectionStatus.nonexistent:
            add(const BackupsServerReset());
            isLoaded = false;
          case ConnectionStatus.connected:
            if (!isLoaded) {
              add(const BackupsServerLoaded());
              isLoaded = true;
            }
          case ConnectionStatus.reconnecting:
          case ConnectionStatus.offline:
          case ConnectionStatus.unauthorized:
            break;
        }
      },
    );

    _apiDataSubscription = connectionRepository.dataStream.listen((
      final ApiData apiData,
    ) {
      if (apiData.backups.data == null || apiData.backupConfig.data == null) {
        add(const BackupsServerReset());
        isLoaded = false;
      } else {
        add(
          BackupsStateChanged(apiData.backups.data!, apiData.backupConfig.data),
        );
        isLoaded = true;
      }
    });

    if (connectionRepository.connectionStatus == ConnectionStatus.connected) {
      add(const BackupsServerLoaded());
      isLoaded = true;
    }
  }

  Future<void> _loadState(
    final BackupsServerLoaded event,
    final Emitter<BackupsState> emit,
  ) async {
    BackblazeBucket? bucket = getIt<ResourcesModel>().backblazeBucket;
    final backups = getIt<ApiConnectionRepository>().apiData.backups;
    final backupConfig = getIt<ApiConnectionRepository>().apiData.backupConfig;
    if (backupConfig.data == null || backups.data == null) {
      emit(BackupsLoading());
      return;
    }
    if (bucket != null &&
        backupConfig.data!.encryptionKey != bucket.encryptionKey) {
      bucket = bucket.copyWith(encryptionKey: backupConfig.data!.encryptionKey);
      await getIt<ApiConfigModel>().setBackblazeBucket(bucket);
    }
    if (backupConfig.data!.isInitialized) {
      emit(
        BackupsInitialized(
          backblazeBucket: bucket,
          backupConfig: backupConfig.data,
          backups: backups.data ?? [],
        ),
      );
    } else {
      emit(BackupsUnititialized());
    }
  }

  Future<void> _resetState(
    final BackupsServerReset event,
    final Emitter<BackupsState> emit,
  ) async {
    emit(BackupsInitial());
  }

  Future<void> _initializeRepository(
    final InitializeBackupsRepository event,
    final Emitter<BackupsState> emit,
  ) async {
    if (state is! BackupsUnititialized) {
      return;
    }
    emit(BackupsInitializing());
    final String? encryptionKey =
        getIt<ApiConnectionRepository>()
            .apiData
            .backupConfig
            .data
            ?.encryptionKey;
    if (encryptionKey == null) {
      emit(BackupsUnititialized());
      getIt<NavigationService>().showSnackBar(
        "Couldn't get encryption key from your server.",
      );
      return;
    }

    final BackblazeBucket bucket;

    if (state.backblazeBucket == null) {
      final settings = BackupsProviderSettings(
        provider: BackupsProviderType.backblaze,
        tokenId: event.credential.keyId,
        token: event.credential.applicationKey,
        isAuthorized: true,
      );
      final provider = BackupsProviderFactory.createBackupsProviderInterface(
        settings,
      );
      final String domain = getIt<ApiConnectionRepository>()
          .serverDomain!
          .domainName
          .replaceAll(RegExp('[^a-zA-Z0-9]'), '-');
      final int serverId = getIt<ApiConnectionRepository>().serverDetails!.id;
      String bucketName =
          '${DateTime.now().millisecondsSinceEpoch}-$serverId-$domain';
      if (bucketName.length > 49) {
        bucketName = bucketName.substring(0, 49);
      }

      final createStorageResult = await provider.createStorage(bucketName);
      if (!createStorageResult.success || createStorageResult.data.isEmpty) {
        getIt<NavigationService>().showSnackBar(
          createStorageResult.message ??
              "Couldn't create storage on your server.",
        );
        emit(BackupsUnititialized());
        return;
      }
      final String bucketId = createStorageResult.data;

      final BackupsApplicationKey? key =
          (await provider.createApplicationKey(bucketId)).data;

      if (key == null) {
        getIt<NavigationService>().showSnackBar(
          "Couldn't create application key on your server.",
        );
        emit(BackupsUnititialized());
        return;
      }

      bucket = BackblazeBucket(
        bucketId: bucketId,
        bucketName: bucketName,
        applicationKey: key.applicationKey,
        applicationKeyId: key.applicationKeyId,
        encryptionKey: encryptionKey,
      );

      await getIt<ApiConfigModel>().setBackblazeBucket(bucket);
      emit(state.copyWith(backblazeBucket: bucket));
    } else {
      bucket = state.backblazeBucket!;
    }

    final GenericResult result = await getIt<ApiConnectionRepository>().api
        .initializeRepository(
          InitializeRepositoryInput(
            provider: BackupsProviderType.backblaze,
            locationId: bucket.bucketId,
            locationName: bucket.bucketName,
            login: bucket.applicationKeyId,
            password: bucket.applicationKey,
          ),
        );
    if (!result.success) {
      getIt<NavigationService>().showSnackBar(
        result.message ?? "Couldn't initialize repository on your server.",
      );
      emit(BackupsUnititialized());
      return;
    }
    getIt<ApiConnectionRepository>().apiData.backupConfig.invalidate();
    getIt<ApiConnectionRepository>().apiData.backups.invalidate();
    await getIt<ApiConnectionRepository>().reload(null);

    getIt<NavigationService>().showSnackBar(
      'Backups repository is now initializing. It may take a while.',
    );
  }

  Future<void> _updateState(
    final BackupsStateChanged event,
    final Emitter<BackupsState> emit,
  ) async {
    if (event.backupConfiguration == null ||
        !event.backupConfiguration!.isInitialized) {
      emit(BackupsUnititialized());
      return;
    }
    final BackblazeBucket? bucket = getIt<ResourcesModel>().backblazeBucket;
    emit(
      BackupsInitialized(
        backblazeBucket: bucket,
        backupConfig: event.backupConfiguration,
        backups: event.backups,
      ),
    );
  }

  Future<void> _forceSnapshotListUpdate(
    final ForceSnapshotListUpdate event,
    final Emitter<BackupsState> emit,
  ) async {
    final currentState = state;
    if (currentState is BackupsInitialized) {
      emit(BackupsBusy.fromState(currentState));
      getIt<NavigationService>().showSnackBar('backup.refetching_list'.tr());
      await getIt<ApiConnectionRepository>().api.forceBackupListReload();
      getIt<ApiConnectionRepository>().apiData.backups.invalidate();
      emit(currentState);
    }
  }

  Future<void> _createBackups(
    final CreateBackups event,
    final Emitter<BackupsState> emit,
  ) async {
    final currentState = state;
    if (currentState is BackupsInitialized) {
      emit(BackupsBusy.fromState(currentState));
      for (final service in event.services) {
        final GenericResult<ServerJob?> result =
            await getIt<ApiConnectionRepository>().api.startBackup(service.id);
        if (!result.success) {
          getIt<NavigationService>().showSnackBar(
            result.message ?? 'Unknown error',
          );
        }
        if (result.data != null) {
          getIt<ApiConnectionRepository>().apiData.serverJobs.data?.add(
            result.data!,
          );
        }
      }
      emit(currentState);
      getIt<ApiConnectionRepository>().emitData();
    }
  }

  Future<void> _restoreBackup(
    final RestoreBackup event,
    final Emitter<BackupsState> emit,
  ) async {
    final currentState = state;
    if (currentState is BackupsInitialized) {
      emit(BackupsBusy.fromState(currentState));
      final GenericResult result = await getIt<ApiConnectionRepository>().api
          .restoreBackup(event.backupId, event.restoreStrategy);
      if (!result.success) {
        getIt<NavigationService>().showSnackBar(
          result.message ?? 'Unknown error',
        );
      }
      emit(currentState);
    }
  }

  Future<void> _setAutobackupPeriod(
    final SetAutobackupPeriod event,
    final Emitter<BackupsState> emit,
  ) async {
    final currentState = state;
    if (currentState is BackupsInitialized) {
      emit(BackupsBusy.fromState(currentState));
      final GenericResult result = await getIt<ApiConnectionRepository>().api
          .setAutobackupPeriod(period: event.period?.inMinutes);
      if (!result.success) {
        getIt<NavigationService>().showSnackBar(
          result.message ?? 'Unknown error',
        );
      }
      if (result.success) {
        getIt<ApiConnectionRepository>()
            .apiData
            .backupConfig
            .data = getIt<ApiConnectionRepository>().apiData.backupConfig.data
            ?.copyWith(autobackupPeriod: event.period);
      }
      emit(currentState);
      getIt<ApiConnectionRepository>().emitData();
    }
  }

  Future<void> _setAutobackupQuotas(
    final SetAutobackupQuotas event,
    final Emitter<BackupsState> emit,
  ) async {
    final currentState = state;
    if (currentState is BackupsInitialized) {
      emit(BackupsBusy.fromState(currentState));
      final GenericResult result = await getIt<ApiConnectionRepository>().api
          .setAutobackupQuotas(event.quotas);
      if (!result.success) {
        getIt<NavigationService>().showSnackBar(
          result.message ?? 'Unknown error',
        );
      }
      if (result.success) {
        getIt<ApiConnectionRepository>()
            .apiData
            .backupConfig
            .data = getIt<ApiConnectionRepository>().apiData.backupConfig.data
            ?.copyWith(autobackupQuotas: event.quotas);
      }
      emit(currentState);
      getIt<ApiConnectionRepository>().emitData();
    }
  }

  Future<void> _forgetSnapshot(
    final ForgetSnapshot event,
    final Emitter<BackupsState> emit,
  ) async {
    final currentState = state;
    if (currentState is BackupsInitialized) {
      // Optimistically remove the snapshot from the list
      getIt<ApiConnectionRepository>().apiData.backups.data =
          getIt<ApiConnectionRepository>().apiData.backups.data
              ?.where((final Backup backup) => backup.id != event.backupId)
              .toList();
      emit(BackupsBusy.fromState(currentState));
      final GenericResult result = await getIt<ApiConnectionRepository>().api
          .forgetSnapshot(event.backupId);
      if (!result.success) {
        getIt<NavigationService>().showSnackBar(
          result.message ?? 'jobs.generic_error'.tr(),
        );
      } else if (result.data == false) {
        getIt<NavigationService>().showSnackBar(
          'backup.forget_snapshot_error'.tr(),
        );
      }
      emit(currentState);
    }
  }

  @override
  Future<void> close() async {
    await _apiStatusSubscription.cancel();
    await _apiDataSubscription.cancel();
    return super.close();
  }

  @override
  void onChange(final Change<BackupsState> change) {
    super.onChange(change);
  }

  late StreamSubscription _apiStatusSubscription;
  late StreamSubscription _apiDataSubscription;
  bool isLoaded = false;
}
