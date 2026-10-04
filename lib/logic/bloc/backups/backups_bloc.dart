import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/repositories/backups_repository.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/operations/backups/initialize_backups_operation.dart';
import 'package:selfprivacy/logic/operations/backups/remove_backups.dart';
import 'package:selfprivacy/logic/operations/backups/start_backups.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

part 'backups_event.dart';
part 'backups_state.dart';

typedef AdmitBackupOperation =
    Future<OperationResult<void>> Function(
      OperationKind kind,
      Future<void> Function(BackupsRepository) action,
    );

class BackupsBloc extends Bloc<BackupsEvent, BackupsState> {
  BackupsBloc({
    required final Stream<BackupsSnapshot?> backups,
    required final AdmitBackupOperation admitOperation,
    required final BackblazeBucket? Function() currentBucket,
    required final Future<void> Function(BackblazeBucket) saveBucket,
    required final Future<void> Function(BackblazeBucket?) removeBucket,
    required final Future<ServerMutationResult<BackupConfiguration>> Function(
      BackupsRepository,
      BackupsCredential,
    )
    initialize,
    required final void Function(String) showMessage,
  }) : _admitOperation = admitOperation,
       _currentBucket = currentBucket,
       _saveBucket = saveBucket,
       _removeBucket = removeBucket,
       _initialize = initialize,
       _showMessage = showMessage,
       super(const BackupsInitial()) {
    on<_BackupsObserved>(_observe, transformer: restartable());
    _register<InitializeBackupsRepository>(_initializeRepository, droppable());
    _register<ForceSnapshotListUpdate>(_forceSnapshotListUpdate, droppable());
    _register<CreateBackups>(_createBackups, sequential());
    _register<RestoreBackup>(_restoreBackup, sequential());
    _register<SetAutobackupPeriod>(_setAutobackupPeriod, restartable());
    _register<SetAutobackupQuotas>(_setAutobackupQuotas, restartable());
    _register<ForgetSnapshot>(_forgetSnapshot, sequential());
    _register<RemoveBackupsRepository>(_removeRepository, droppable());
    _subscription = backups.listen((final observation) {
      _latest = observation;
      add(_BackupsObserved(observation));
    });
  }

  final AdmitBackupOperation _admitOperation;
  final BackblazeBucket? Function() _currentBucket;
  final Future<void> Function(BackblazeBucket) _saveBucket;
  final Future<void> Function(BackblazeBucket?) _removeBucket;
  final Future<ServerMutationResult<BackupConfiguration>> Function(
    BackupsRepository,
    BackupsCredential,
  )
  _initialize;
  final void Function(String) _showMessage;
  late final StreamSubscription<BackupsSnapshot?> _subscription;
  BackupsSnapshot? _latest;

  bool get _isActive => !isClosed && _latest != null;

  void _register<T extends BackupsEvent>(
    final Future<void> Function(
      T,
      BackupsRepository,
      void Function(BackupsState),
    )
    action,
    final EventTransformer<T> transformer,
  ) {
    on<T>((final event, final emit) async {
      if (!_isActive) {
        return;
      }
      final OperationResult<void> result;
      try {
        result = await _admitOperation(
          switch (event) {
            InitializeBackupsRepository() => OperationKind.initializeBackups,
            RemoveBackupsRepository() => OperationKind.removeBackups,
            CreateBackups() => OperationKind.createBackups,
            RestoreBackup() => OperationKind.restoreBackup,
            _ => OperationKind.manageBackups,
          },
          (final repository) => action(event, repository, (final value) {
            if (!emit.isDone && _isActive) {
              emit(value);
            }
          }),
        );
      } catch (_) {
        if (!_isActive || emit.isDone) {
          return;
        }
        _settleInterrupted(emit);
        _showMessage('server_mutation.outcome_unknown'.tr());
        return;
      }
      if (!_isActive || emit.isDone) {
        return;
      }
      if (state is BackupsBusy || state is BackupsInitializing) {
        _settleInterrupted(emit);
        _showMessage(result.status.translationKey.tr());
      } else if (result.status == OperationStatus.notSent ||
          result.status == OperationStatus.cancelled) {
        _showMessage(result.status.translationKey.tr());
      }
    }, transformer: transformer);
  }

  void _settleInterrupted(final Emitter<BackupsState> emit) {
    final snapshot = _latest!;
    final configuration = snapshot.configuration.data;
    final bucket = _currentBucket();
    emit(
      (configuration?.isInitialized ?? false)
          ? BackupsInitialized(
              backupConfig: configuration,
              backups: snapshot.backups.data ?? const [],
              backblazeBucket: bucket,
            )
          : BackupsUninitialized(backblazeBucket: bucket),
    );
  }

  Future<void> _observe(
    final _BackupsObserved event,
    final Emitter<BackupsState> emit,
  ) async {
    if (event.observation == null) {
      emit(const BackupsInitial());
      return;
    }
    final snapshot = event.observation!;
    final configuration = snapshot.configuration.data;
    var bucket = _currentBucket();
    if (configuration != null &&
        configuration.encryptionKey.isNotEmpty &&
        bucket != null &&
        configuration.encryptionKey != bucket.encryptionKey) {
      bucket = bucket.copyWith(encryptionKey: configuration.encryptionKey);
      try {
        await _saveBucket(bucket);
      } catch (_) {
        if (!emit.isDone && _isActive) {
          _showMessage('backup.save_storage_failed'.tr());
        }
      }
      if (!_isActive || emit.isDone) {
        return;
      }
    }
    if (configuration == null || snapshot.backups.data == null) {
      final unsupported =
          snapshot.configuration.support == DomainSupport.unsupported ||
          snapshot.backups.support == DomainSupport.unsupported;
      final failed =
          snapshot.configuration.lastError != null ||
          snapshot.backups.lastError != null;
      emit(
        unsupported || failed
            ? BackupsUnavailable(
                isUnsupported: unsupported,
                backblazeBucket: bucket,
              )
            : BackupsLoading(backblazeBucket: bucket),
      );
    } else if (!configuration.isInitialized) {
      if (state is BackupsInitializing) {
        return;
      }
      emit(BackupsUninitialized(backblazeBucket: bucket));
    } else {
      final loaded = BackupsInitialized(
        backups: snapshot.backups.data!,
        backupConfig: configuration,
        backblazeBucket: bucket,
      );
      emit(state is BackupsBusy ? BackupsBusy.fromState(loaded) : loaded);
    }
  }

  Future<void> _initializeRepository(
    final InitializeBackupsRepository event,
    final BackupsRepository repository,
    final void Function(BackupsState) emit,
  ) async {
    if (state is! BackupsUninitialized) {
      return;
    }
    final previous = state;
    emit(
      BackupsInitializing(
        backblazeBucket: previous.backblazeBucket ?? _currentBucket(),
      ),
    );
    final ServerMutationResult<BackupConfiguration> result;
    try {
      result = await _initialize(repository, event.credential);
    } on BackupStorageFailure catch (failure) {
      if (!repository.commands.isAttached || !_isActive) {
        return;
      }
      emit(BackupsUninitialized(backblazeBucket: previous.backblazeBucket));
      _showMessage(switch (failure) {
        BackupStorageFailure.missingEncryptionKey =>
          'backup.backups_encryption_key_not_found'.tr(),
        BackupStorageFailure.createStorage =>
          'backup.create_storage_failed'.tr(),
        BackupStorageFailure.createApplicationKey =>
          'backup.create_application_key_failed'.tr(),
      });
      return;
    }
    if (!repository.commands.isAttached || !_isActive) {
      return;
    }
    final bucket = _currentBucket();
    if (!_configurationConfirmed(result)) {
      emit(BackupsUninitialized(backblazeBucket: bucket));
      return;
    }
    emit(
      _configuredState(
        bucket == null ? previous : previous.copyWith(backblazeBucket: bucket),
        result.payload.value,
      ),
    );
  }

  Future<void> _forceSnapshotListUpdate(
    final ForceSnapshotListUpdate event,
    final BackupsRepository repository,
    final void Function(BackupsState) emit,
  ) async {
    final currentState = state;
    if (currentState is BackupsInitialized) {
      emit(BackupsBusy.fromState(currentState));
      _showMessage('backup.refetching_list'.tr());
      final result = await repository.forceBackupListReload();
      if (!repository.commands.isAttached || !_isActive) {
        return;
      }
      _isConfirmed(result);
      emit(_currentState(repository, currentState));
    }
  }

  Future<void> _createBackups(
    final CreateBackups event,
    final BackupsRepository repository,
    final void Function(BackupsState) emit,
  ) async {
    final currentState = state;
    if (currentState is BackupsInitialized) {
      emit(BackupsBusy.fromState(currentState));
      final results = await startBackups(
        repository,
        event.services.map((final service) => service.id),
      );
      if (!repository.commands.isAttached || !_isActive) {
        return;
      }
      for (final result in results) {
        if (_isConfirmed(result) && result.payload.value == null) {
          _showMessage(serverMutationMessage(result));
        }
      }
      emit(_currentState(repository, currentState));
    }
  }

  Future<void> _restoreBackup(
    final RestoreBackup event,
    final BackupsRepository repository,
    final void Function(BackupsState) emit,
  ) async {
    final currentState = state;
    if (currentState is BackupsInitialized) {
      emit(BackupsBusy.fromState(currentState));
      final result = await repository.restoreBackup(
        event.backupId,
        event.restoreStrategy,
      );
      if (!repository.commands.isAttached || !_isActive) {
        return;
      }
      if (_isConfirmed(result) && result.payload.value == null) {
        _showMessage(serverMutationMessage(result));
      }
      emit(_currentState(repository, currentState));
    }
  }

  Future<void> _setAutobackupPeriod(
    final SetAutobackupPeriod event,
    final BackupsRepository repository,
    final void Function(BackupsState) emit,
  ) => _changeConfiguration(
    repository,
    (final repository) =>
        repository.setAutobackupPeriod(period: event.period?.inMinutes),
    emit,
  );

  Future<void> _setAutobackupQuotas(
    final SetAutobackupQuotas event,
    final BackupsRepository repository,
    final void Function(BackupsState) emit,
  ) => _changeConfiguration(
    repository,
    (final repository) => repository.setAutobackupQuotas(event.quotas),
    emit,
  );

  Future<void> _changeConfiguration(
    final BackupsRepository repository,
    final Future<ServerMutationResult<BackupConfiguration>> Function(
      BackupsRepository,
    )
    change,
    final void Function(BackupsState) emit,
  ) async {
    final currentState = state;
    if (currentState is! BackupsInitialized) {
      return;
    }
    emit(BackupsBusy.fromState(currentState));
    final result = await change(repository);
    if (!repository.commands.isAttached || !_isActive) {
      return;
    }
    _configurationConfirmed(result);
    emit(_currentState(repository, currentState));
  }

  Future<void> _forgetSnapshot(
    final ForgetSnapshot event,
    final BackupsRepository repository,
    final void Function(BackupsState) emit,
  ) async {
    final currentState = state;
    if (currentState is BackupsInitialized) {
      emit(BackupsBusy.fromState(currentState));
      final result = await repository.forgetSnapshot(event.backupId);
      if (!repository.commands.isAttached || !_isActive) {
        return;
      }
      _isConfirmed(result);
      emit(_currentState(repository, currentState));
    }
  }

  Future<void> _removeRepository(
    final RemoveBackupsRepository event,
    final BackupsRepository repository,
    final void Function(BackupsState) emit,
  ) async {
    final currentState = state;
    if (currentState is! BackupsInitialized) {
      return;
    }
    emit(BackupsBusy.fromState(currentState));
    final result = await removeBackups(
      repository,
      removeBucket: () => _removeBucket(currentState.backblazeBucket),
    );
    if (!repository.commands.isAttached || !_isActive) {
      return;
    }
    if (!_configurationConfirmed(result)) {
      emit(currentState);
      return;
    }
    emit(_configuredState(currentState, result.payload.value));
    if (result.payload.value != null) {
      _showMessage('backup.repository_removed'.tr());
    }
  }

  bool _isConfirmed<T>(
    final ServerMutationResult<T> result, {
    final bool sensitive = false,
  }) {
    if (result.outcome == ServerMutationOutcome.confirmed) {
      return true;
    }
    _showMessage(serverMutationMessage(result, sensitive: sensitive));
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
      _showMessage(serverMutationMessage(result, sensitive: true));
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
    _latest = null;
    await _subscription.cancel();
    return super.close();
  }
}
