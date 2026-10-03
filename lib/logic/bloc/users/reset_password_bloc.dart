import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/sync/secret_recipient.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc({
    required final ServerStateOrigin? origin,
    required final Stream<ConnectionObservation<CachedValue<Version>>> versions,
    required final Future<ServerMutationResult<String>?> Function(
      SecretRecipient,
    )
    generate,
  }) : _generate = generate,
       super(const ResetPasswordState()) {
    on<RequestNewPassword>(_request, transformer: droppable());
    on<CancelNewPasswordRequest>((_, final emit) {
      _recipient.dispose();
      _recipient = SecretRecipient();
      emit(const ResetPasswordState());
    });
    on<_BindingLost>((_, final emit) {
      emit(ResetPasswordState(errorMessage: 'server_mutation.not_sent'.tr()));
    });
    _subscription = versions.listen((final observation) {
      _valid =
          origin != null &&
          identical(origin.continuity, observation.origin?.continuity);
      _version = _valid ? observation.value?.data : null;
      if (!_valid) {
        _recipient.dispose();
        add(const _BindingLost());
      }
    });
  }

  static const String ssoSupportedVersion = '>=3.6.0';
  final Future<ServerMutationResult<String>?> Function(SecretRecipient)
  _generate;
  late final StreamSubscription<ConnectionObservation<CachedValue<Version>>>
  _subscription;
  SecretRecipient _recipient = SecretRecipient();
  Version? _version;
  bool _valid = false;

  Future<void> _request(
    final RequestNewPassword event,
    final Emitter<ResetPasswordState> emit,
  ) async {
    if (!_valid) {
      emit(ResetPasswordState(errorMessage: 'server_mutation.not_sent'.tr()));
      return;
    }
    final version = _version;
    if (version == null) {
      emit(ResetPasswordState(errorMessage: 'basis.network_error'.tr()));
      return;
    }
    if (!VersionConstraint.parse(ssoSupportedVersion).allows(version)) {
      emit(
        ResetPasswordUnsupported(
          errorMessage: 'basis.feature_unsupported_on_api_version'.tr(
            namedArgs: {
              'versionConstraint': ssoSupportedVersion,
              'currentVersion': version.toString(),
            },
          ),
        ),
      );
      return;
    }
    final recipient = _recipient;
    emit(const ResetPasswordState(isLoading: true));
    final result = await _generate(recipient);
    if (emit.isDone || !_valid || !identical(recipient, _recipient)) {
      return;
    }
    if (result == null) {
      emit(ResetPasswordState(errorMessage: 'server_mutation.not_sent'.tr()));
      return;
    }
    final secret = result.confirmedSecret;
    if (secret == null) {
      emit(
        ResetPasswordState(
          errorMessage: serverMutationMessage(result, sensitive: true),
        ),
      );
      return;
    }
    final uri = Uri.tryParse(secret);
    emit(
      uri == null || uri.scheme.isEmpty
          ? ResetPasswordState(
              errorMessage: 'users.could_not_generate_password_link'.tr(),
            )
          : ResetPasswordState(
              passwordResetLink: uri,
              passwordResetMessage: 'basis.done'.tr(),
            ),
    );
  }

  @override
  Future<void> close() async {
    _recipient.dispose();
    await _subscription.cancel();
    return super.close();
  }
}

class _BindingLost extends ResetPasswordEvent {
  const _BindingLost();
}

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

class RequestNewPassword extends ResetPasswordEvent {
  const RequestNewPassword();
}

class CancelNewPasswordRequest extends ResetPasswordEvent {
  const CancelNewPasswordRequest();
}

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.passwordResetLink,
    this.passwordResetMessage = '',
    this.errorMessage = '',
    this.isLoading = false,
  });

  final Uri? passwordResetLink;
  bool get isLinkValid => passwordResetLink != null;
  final bool isLoading;
  final String passwordResetMessage;
  final String errorMessage;

  @override
  List<Object?> get props => [
    passwordResetMessage,
    isLoading,
    passwordResetLink,
    errorMessage,
  ];
}

class ResetPasswordUnsupported extends ResetPasswordState {
  const ResetPasswordUnsupported({super.errorMessage}) : super();
}
