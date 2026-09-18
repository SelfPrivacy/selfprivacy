import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
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
  }) async {
    final response = await getIt<ApiConnectionRepository>().api
        .generateRecoveryToken(expirationDate, numberOfUses);
    final secret = response.confirmedSecret;
    if (secret != null) {
      getIt<ApiConnectionRepository>().apiData.recoveryKeyStatus.invalidate();
      unawaited(getIt<ApiConnectionRepository>().reload(null));
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
    getIt<ApiConnectionRepository>().apiData.recoveryKeyStatus.invalidate();
    await getIt<ApiConnectionRepository>().reload(null);
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
