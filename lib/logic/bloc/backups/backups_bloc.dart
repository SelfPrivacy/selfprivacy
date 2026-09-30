import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/repositories/backups_repository.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/initialize_repository_input.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/providers/backups_providers/backups_provider.dart';
import 'package:selfprivacy/logic/providers/backups_providers/backups_provider_factory.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

part 'backups_event.dart';
part 'backups_state.dart';

class BackupsBloc extends Bloc<BackupsEvent, BackupsState> {
  BackupsBloc() : super(const BackupsInitial()) {
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
      emit(const BackupsLoading());
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
      emit(const BackupsUninitialized());
    }
  }

  Future<void> _resetState(
    final BackupsServerReset event,
    final Emitter<BackupsState> emit,
  ) async {
    emit(const BackupsInitial());
  }

  Future<void> _initializeRepository(
    final InitializeBackupsRepository event,
    final Emitter<BackupsState> emit,
  ) async {
    if (state is! BackupsUninitialized) {
      return;
    }
    final owner = getIt<ApiConnectionRepository>();
    final repository = owner.connection?.backups;
    if (repository == null) {
      return;
    }
    final previous = state;
    emit(
      BackupsInitializing(
        backblazeBucket:
            previous.backblazeBucket ?? getIt<ResourcesModel>().backblazeBucket,
      ),
    );
    final String? encryptionKey = repository.configValue.data?.encryptionKey;
    if (encryptionKey == null) {
      emit(const BackupsUninitialized());
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
      if (!repository.connection.isAttached || emit.isDone) {
        return;
      }
      if (!createStorageResult.success || createStorageResult.data.isEmpty) {
        getIt<NavigationService>().showSnackBar(
          createStorageResult.message ??
              "Couldn't create storage on your server.",
        );
        emit(const BackupsUninitialized());
        return;
      }
      final String bucketId = createStorageResult.data;

      final BackupsApplicationKey? key = (await provider.createApplicationKey(
        bucketId,
      )).data;
      if (!repository.connection.isAttached || emit.isDone) {
        return;
      }

      if (key == null) {
        getIt<NavigationService>().showSnackBar(
          "Couldn't create application key on your server.",
        );
        emit(const BackupsUninitialized());
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
      if (!repository.connection.isAttached || emit.isDone) {
        return;
      }
      emit(state.copyWith(backblazeBucket: bucket));
    } else {
      bucket = state.backblazeBucket!;
    }

    final result = await repository.initializeRepository(
      InitializeRepositoryInput(
        provider: BackupsProviderType.backblaze,
        locationId: bucket.bucketId,
        locationName: bucket.bucketName,
        login: bucket.applicationKeyId,
        password: bucket.applicationKey,
      ),
    );
    if (!repository.connection.isAttached || emit.isDone) {
      return;
    }
    if (!_configurationConfirmed(result)) {
      emit(BackupsUninitialized(backblazeBucket: bucket));
      return;
    }
    emit(
      _configuredState(
        previous.copyWith(backblazeBucket: bucket),
        result.payload.value,
      ),
    );
  }

  Future<void> _updateState(
    final BackupsStateChanged event,
    final Emitter<BackupsState> emit,
  ) async {
    if (event.backupConfiguration == null ||
        !event.backupConfiguration!.isInitialized) {
      emit(const BackupsUninitialized());
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
    final repository = getIt<ApiConnectionRepository>().connection?.backups;
    if (currentState is BackupsInitialized && repository != null) {
      emit(BackupsBusy.fromState(currentState));
      getIt<NavigationService>().showSnackBar('backup.refetching_list'.tr());
      final result = await repository.forceBackupListReload();
      if (!repository.connection.isAttached || emit.isDone) {
        return;
      }
      _isConfirmed(result);
      emit(_currentState(repository, currentState));
    }
  }

  Future<void> _createBackups(
    final CreateBackups event,
    final Emitter<BackupsState> emit,
  ) async {
    final currentState = state;
    final repository = getIt<ApiConnectionRepository>().connection?.backups;
    if (currentState is BackupsInitialized && repository != null) {
      emit(BackupsBusy.fromState(currentState));
      for (final service in event.services) {
        if (!repository.connection.isAttached || emit.isDone) {
          return;
        }
        final result = await repository.startBackup(service.id);
        if (!repository.connection.isAttached || emit.isDone) {
          return;
        }
        if (_isConfirmed(result) && result.payload.value == null) {
          getIt<NavigationService>().showSnackBar(
            serverMutationMessage(result),
          );
        }
      }
      emit(_currentState(repository, currentState));
    }
  }

  Future<void> _restoreBackup(
    final RestoreBackup event,
    final Emitter<BackupsState> emit,
  ) async {
    final currentState = state;
    final repository = getIt<ApiConnectionRepository>().connection?.backups;
    if (currentState is BackupsInitialized && repository != null) {
      emit(BackupsBusy.fromState(currentState));
      final result = await repository.restoreBackup(
        event.backupId,
        event.restoreStrategy,
      );
      if (!repository.connection.isAttached || emit.isDone) {
        return;
      }
      if (_isConfirmed(result) && result.payload.value == null) {
        getIt<NavigationService>().showSnackBar(serverMutationMessage(result));
      }
      emit(_currentState(repository, currentState));
    }
  }

  Future<void> _setAutobackupPeriod(
    final SetAutobackupPeriod event,
    final Emitter<BackupsState> emit,
  ) => _changeConfiguration(
    (final repository) =>
        repository.setAutobackupPeriod(period: event.period?.inMinutes),
    emit,
  );

  Future<void> _setAutobackupQuotas(
    final SetAutobackupQuotas event,
    final Emitter<BackupsState> emit,
  ) => _changeConfiguration(
    (final repository) => repository.setAutobackupQuotas(event.quotas),
    emit,
  );

  Future<void> _changeConfiguration(
    final Future<ServerMutationResult<BackupConfiguration>> Function(
      BackupsRepository,
    )
    change,
    final Emitter<BackupsState> emit,
  ) async {
    final currentState = state;
    final repository = getIt<ApiConnectionRepository>().connection?.backups;
    if (currentState is! BackupsInitialized || repository == null) {
      return;
    }
    emit(BackupsBusy.fromState(currentState));
    final result = await change(repository);
    if (!repository.connection.isAttached || emit.isDone) {
      return;
    }
    _configurationConfirmed(result);
    emit(_currentState(repository, currentState));
  }

  Future<void> _forgetSnapshot(
    final ForgetSnapshot event,
    final Emitter<BackupsState> emit,
  ) async {
    final currentState = state;
    final repository = getIt<ApiConnectionRepository>().connection?.backups;
    if (currentState is BackupsInitialized && repository != null) {
      emit(BackupsBusy.fromState(currentState));
      final result = await repository.forgetSnapshot(event.backupId);
      if (!repository.connection.isAttached || emit.isDone) {
        return;
      }
      _isConfirmed(result);
      emit(_currentState(repository, currentState));
    }
  }

  Future<void> _removeRepository(
    final RemoveBackupsRepository event,
    final Emitter<BackupsState> emit,
  ) async {
    final currentState = state;
    final repository = getIt<ApiConnectionRepository>().connection?.backups;
    if (currentState is! BackupsInitialized || repository == null) {
      return;
    }
    emit(BackupsBusy.fromState(currentState));
    final result = await repository.removeRepository();
    if (!repository.connection.isAttached || emit.isDone) {
      return;
    }
    if (!_configurationConfirmed(result)) {
      emit(currentState);
      return;
    }
    await getIt<ResourcesModel>().removeBackblazeBucket();
    if (!repository.connection.isAttached || emit.isDone) {
      return;
    }
    emit(_configuredState(currentState, result.payload.value));
    if (result.payload.value != null) {
      getIt<NavigationService>().showSnackBar('backup.repository_removed'.tr());
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
      serverMutationMessage(result, sensitive: sensitive),
    );
    return false;
  }

  bool _configurationConfirmed(
    final ServerMutationResult<BackupConfiguration> result,
  ) {
    if (!_isConfirmed(result, sensitive: true)) {
      return false;
    }
    final returned = result.payload.value;
    if (returned == null) {
      getIt<NavigationService>().showSnackBar(
        serverMutationMessage(result, sensitive: true),
      );
    }
    return true;
  }

  BackupsState _configuredState(
    final BackupsState previous,
    final BackupConfiguration? config,
  ) {
    if (config == null) {
      return previous;
    }
    return config.isInitialized
        ? BackupsInitialized(
            backups: previous.backups,
            backupConfig: config,
            backblazeBucket: previous.backblazeBucket,
          )
        : BackupsUninitialized(backblazeBucket: previous.backblazeBucket);
  }

  BackupsState _currentState(
    final BackupsRepository repository,
    final BackupsInitialized previous,
  ) => _configuredState(
    BackupsInitialized(
      backups: repository.value.data ?? previous.backups,
      backupConfig: repository.configValue.data,
      backblazeBucket: previous.backblazeBucket,
    ),
    repository.configValue.data,
  );

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
