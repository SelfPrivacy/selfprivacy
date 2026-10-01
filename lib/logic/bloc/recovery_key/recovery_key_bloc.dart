import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/sync/operation_execution.dart';
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';
import 'package:selfprivacy/logic/connection/sync/secret_recipient.dart';
import 'package:selfprivacy/logic/models/json/recovery_token_status.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

part 'recovery_key_event.dart';
part 'recovery_key_state.dart';

class RecoveryKeyBloc extends Bloc<RecoveryKeyEvent, RecoveryKeyState> {
  RecoveryKeyBloc() : super(RecoveryKeyInitial()) {
    on<RecoveryKeyStatusChanged>(
      _mapRecoveryKeyStatusChangedToState,
      transformer: sequential(),
    );
    on<RecoveryKeyStatusRefresh>(
      _mapRecoveryKeyStatusRefreshToState,
      transformer: droppable(),
    );

    final apiConnectionRepository = getIt<ApiConnectionRepository>();
    _apiDataSubscription = apiConnectionRepository.dataStream.listen((
      final ApiData apiData,
    ) {
      add(RecoveryKeyStatusChanged(apiData.recoveryKeyStatus.data));
    });
  }

  StreamSubscription? _apiDataSubscription;

  Future<void> _mapRecoveryKeyStatusChangedToState(
    final RecoveryKeyStatusChanged event,
    final Emitter<RecoveryKeyState> emit,
  ) async {
    if (event.recoveryKeyStatus == null) {
      emit(RecoveryKeyError());
      return;
    }
    emit(RecoveryKeyLoaded(keyStatus: event.recoveryKeyStatus));
  }

  Future<String> generateRecoveryKey({
    final DateTime? expirationDate,
    final int? numberOfUses,
    final SecretRecipient? recipient,
  }) async {
    final target = recipient ?? SecretRecipient();
    final response = await target.receive(
      getIt<ApiConnectionRepository>().hub.submit(
        OperationKind.generateRecoveryKey,
        (final owner) => target.protect(() async {
          final response = await owner.api.generateRecoveryToken(
            expirationDate,
            numberOfUses,
          );
          OperationExecution.current?.record(response);
          if (response.outcome == ServerMutationOutcome.confirmed) {
            owner.cache.recoveryKeyStatus.invalidate();
          }
          return response;
        }),
      ),
    );
    if (response == null) {
      throw GenerationError('server_mutation.not_sent');
    }
    final secret = response.confirmedSecret;
    if (secret != null) {
      unawaited(getIt<ApiConnectionRepository>().refreshRecoveryKeyStatus());
      return secret;
    } else {
      throw GenerationError(serverMutationMessage(response, sensitive: true));
    }
  }

  Future<void> _mapRecoveryKeyStatusRefreshToState(
    final RecoveryKeyEvent event,
    final Emitter<RecoveryKeyState> emit,
  ) async {
    emit(RecoveryKeyRefreshing(keyStatus: state._status));
    await getIt<ApiConnectionRepository>().refreshRecoveryKeyStatus();
  }

  @override
  void onChange(final Change<RecoveryKeyState> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() async {
    await _apiDataSubscription?.cancel();
    return super.close();
  }
}

class GenerationError extends Error {
  GenerationError(this.message);
  final String message;
}
