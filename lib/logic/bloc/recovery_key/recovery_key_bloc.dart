import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/models/json/recovery_token_status.dart';
import 'package:selfprivacy/logic/operations/secret_recipient.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

part 'recovery_key_event.dart';
part 'recovery_key_state.dart';

class RecoveryKeyBloc extends Bloc<RecoveryKeyEvent, RecoveryKeyState> {
  RecoveryKeyBloc({
    required final Stream<CachedValue<RecoveryKeyStatus>?> status,
    required final Future<void> Function() refresh,
    required final Future<ServerMutationResult<String>?> Function(
      SecretRecipient,
      DateTime?,
      int?,
    )
    generate,
  }) : _refresh = refresh,
       _generate = generate,
       super(const RecoveryKeyInitial()) {
    on<_RecoveryKeyObserved>(_observe, transformer: sequential());
    on<RecoveryKeyStatusRefresh>((final event, _) async {
      if (_isActive) {
        await _refresh();
      }
    }, transformer: droppable());
    _subscription = status.listen((final observation) {
      _latest = observation;
      add(_RecoveryKeyObserved(observation));
    });
  }

  final Future<void> Function() _refresh;
  final Future<ServerMutationResult<String>?> Function(
    SecretRecipient,
    DateTime?,
    int?,
  )
  _generate;
  late final StreamSubscription<CachedValue<RecoveryKeyStatus>?> _subscription;
  CachedValue<RecoveryKeyStatus>? _latest;
  final _recipients = <SecretRecipient>{};

  void _observe(
    final _RecoveryKeyObserved event,
    final Emitter<RecoveryKeyState> emit,
  ) {
    final snapshot = event.observation;
    if (snapshot == null) {
      emit(const RecoveryKeyInitial());
    } else if (snapshot.isRefreshing) {
      emit(RecoveryKeyRefreshing(keyStatus: snapshot.data));
    } else if (snapshot.lastError != null ||
        snapshot.support == DomainSupport.unsupported) {
      emit(RecoveryKeyError(keyStatus: snapshot.data));
    } else if (snapshot.data != null) {
      emit(RecoveryKeyLoaded(keyStatus: snapshot.data));
    } else {
      emit(const RecoveryKeyInitial());
    }
  }

  bool get _isActive => !isClosed && _latest != null;

  Future<String> generateRecoveryKey({
    final DateTime? expirationDate,
    final int? numberOfUses,
    final SecretRecipient? recipient,
  }) async {
    if (!_isActive) {
      throw GenerationError('server_mutation.not_sent');
    }
    final target = recipient ?? SecretRecipient();
    if (recipient == null) {
      _recipients.add(target);
    }
    try {
      final response = await _generate(target, expirationDate, numberOfUses);
      if (response == null || !_isActive) {
        throw GenerationError('server_mutation.not_sent');
      }
      final secret = response.confirmedSecret;
      if (secret == null) {
        throw GenerationError(serverMutationMessage(response, sensitive: true));
      }
      return secret;
    } finally {
      if (_recipients.remove(target)) {
        target.dispose();
      }
    }
  }

  @override
  Future<void> close() async {
    _latest = null;
    for (final recipient in _recipients) {
      recipient.dispose();
    }
    _recipients.clear();
    await _subscription.cancel();
    return super.close();
  }
}

class GenerationError extends Error {
  GenerationError(this.message);
  final String message;
}
