import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
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
    on<RemoveBackupsRepository>(_removeRepository, transformer: droppable());

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
    final previous = state;
    emit(
      BackupsInitializing(
        backblazeBucket:
            previous.backblazeBucket ?? getIt<ResourcesModel>().backblazeBucket,
      ),
    );
    final String? encryptionKey = getIt<ApiConnectionRepository>()
        .apiData
        .backupConfig
        .data
        ?.encryptionKey;
    if (encryptionKey == null) {
      emit(BackupsUnititialized());
      getIt<NavigationService>().showSnackBar(
        'backup.backups_encryption_key_not_found'.tr(),
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
      final String serverId =
          getIt<ApiConnectionRepository>().serverDetails!.providerId ??
          'manual';
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

      final BackupsApplicationKey? key = (await provider.createApplicationKey(
        bucketId,
      )).data;

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

    final result = await getIt<ApiConnectionRepository>().api
        .initializeRepository(
          InitializeRepositoryInput(
            provider: BackupsProviderType.backblaze,
            locationId: bucket.bucketId,
            locationName: bucket.bucketName,
            login: bucket.applicationKeyId,
            password: bucket.applicationKey,
          ),
        );
    if (!_applyConfiguration(result)) {
      emit(BackupsUnititialized(backblazeBucket: bucket));
      return;
    }
    final repository = getIt<ApiConnectionRepository>();
    repository.apiData.backups.invalidate();
    emit(
      _configuredState(
        previous.copyWith(backblazeBucket: bucket),
        result.payload.value,
      ),
    );
    repository.emitData();
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
      final result = await getIt<ApiConnectionRepository>().api
          .forceBackupListReload();
      if (_isConfirmed(result)) {
        getIt<ApiConnectionRepository>().apiData.backups.invalidate();
      }
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
      var hasConfirmedResult = false;
      for (final service in event.services) {
        final result = await getIt<ApiConnectionRepository>().api.startBackup(
          service.id,
        );
        if (_applyJob(result)) {
          hasConfirmedResult = true;
        }
      }
      emit(currentState);
      if (hasConfirmedResult) {
        getIt<ApiConnectionRepository>().emitData();
      }
    }
  }

  Future<void> _restoreBackup(
    final RestoreBackup event,
    final Emitter<BackupsState> emit,
  ) async {
    final currentState = state;
    if (currentState is BackupsInitialized) {
      emit(BackupsBusy.fromState(currentState));
      final result = await getIt<ApiConnectionRepository>().api.restoreBackup(
        event.backupId,
        event.restoreStrategy,
      );
      final confirmed = _applyJob(result);
      emit(currentState);
      if (confirmed) {
        getIt<ApiConnectionRepository>().emitData();
      }
    }
  }

  Future<void> _setAutobackupPeriod(
    final SetAutobackupPeriod event,
    final Emitter<BackupsState> emit,
  ) => _changeConfiguration(
    () => getIt<ApiConnectionRepository>().api.setAutobackupPeriod(
      period: event.period?.inMinutes,
    ),
    emit,
  );

  Future<void> _setAutobackupQuotas(
    final SetAutobackupQuotas event,
    final Emitter<BackupsState> emit,
  ) => _changeConfiguration(
    () =>
        getIt<ApiConnectionRepository>().api.setAutobackupQuotas(event.quotas),
    emit,
  );

  Future<void> _changeConfiguration(
    final Future<ServerMutationResult<BackupConfiguration>> Function() change,
    final Emitter<BackupsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! BackupsInitialized) {
      return;
    }
    emit(BackupsBusy.fromState(currentState));
    final result = await change();
    if (_applyConfiguration(result)) {
      emit(_configuredState(currentState, result.payload.value));
      getIt<ApiConnectionRepository>().emitData();
    } else {
      emit(currentState);
    }
  }

  Future<void> _forgetSnapshot(
    final ForgetSnapshot event,
    final Emitter<BackupsState> emit,
  ) async {
    final currentState = state;
    if (currentState is BackupsInitialized) {
      emit(BackupsBusy.fromState(currentState));
      final repository = getIt<ApiConnectionRepository>();
      final result = await repository.api.forgetSnapshot(event.backupId);
      final confirmed = _isConfirmed(result);
      if (confirmed) {
        repository.apiData.backups.data = repository.apiData.backups.data
            ?.where((final backup) => backup.id != event.backupId)
            .toList();
      }
      emit(currentState);
      if (confirmed) {
        repository.emitData();
      }
    }
  }

  Future<void> _removeRepository(
    final RemoveBackupsRepository event,
    final Emitter<BackupsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! BackupsInitialized) {
      return;
    }
    emit(BackupsBusy.fromState(currentState));
    final repository = getIt<ApiConnectionRepository>();
    final result = await repository.api.removeRepository();
    if (!_applyConfiguration(result)) {
      emit(currentState);
      return;
    }
    await getIt<ResourcesModel>().removeBackblazeBucket();
    repository.apiData.backups.invalidate();
    emit(BackupsUnititialized());
    if (result.payload.value != null) {
      getIt<NavigationService>().showSnackBar('backup.repository_removed'.tr());
      repository.emitData();
    }
  }

  bool _isConfirmed<T>(
    final ServerMutationResult<T> result, {
    final bool sensitive = false,
  }) {
    if (result.outcome == ServerMutationOutcome.confirmed) {
      return true;
    }
    getIt<NavigationService>().showSnackBar(
      result.outcome == ServerMutationOutcome.indeterminate
          ? 'server_mutation.outcome_unknown'.tr()
          : sensitive
          ? 'server_mutation.rejected'.tr()
          : result.message ?? 'server_mutation.rejected'.tr(),
    );
    return false;
  }

  bool _applyConfiguration(
    final ServerMutationResult<BackupConfiguration> result,
  ) {
    if (!_isConfirmed(result, sensitive: true)) {
      return false;
    }
    final config = getIt<ApiConnectionRepository>().apiData.backupConfig;
    final returned = result.payload.value;
    if (returned == null) {
      config.invalidate();
      getIt<NavigationService>().showSnackBar(
        'server_mutation.payload_unavailable'.tr(),
      );
    } else {
      config.data = returned;
    }
    return true;
  }

  BackupsState _configuredState(
    final BackupsState previous,
    final BackupConfiguration? config,
  ) {
    final data = getIt<ApiConnectionRepository>().apiData;
    if (config == null) {
      return previous;
    }
    return config.isInitialized
        ? BackupsInitialized(
            backups: data.backups.data ?? [],
            backupConfig: config,
            backblazeBucket: previous.backblazeBucket,
          )
        : BackupsUnititialized(backblazeBucket: previous.backblazeBucket);
  }

  bool _applyJob(final ServerMutationResult<ServerJob> result) {
    if (!_isConfirmed(result)) {
      return false;
    }
    final jobs = getIt<ApiConnectionRepository>().apiData.serverJobs;
    final job = result.payload.value;
    if (job == null) {
      jobs.invalidate();
      getIt<NavigationService>().showSnackBar(
        'server_mutation.payload_unavailable'.tr(),
      );
    } else {
      final existing = jobs.data;
      if (existing == null) {
        jobs
          ..data = [job]
          ..invalidate();
      } else {
        final index = existing.indexWhere((final item) => item.uid == job.uid);
        if (index < 0) {
          existing.add(job);
        } else {
          existing[index] = job;
        }
      }
    }
    return true;
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
