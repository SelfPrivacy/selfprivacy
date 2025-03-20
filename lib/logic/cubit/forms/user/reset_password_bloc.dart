import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/utils/app_logger.dart';

final _log = const AppLogger(name: 'ResetPasswordBloc').log;

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc({
    required this.user,
  }) : super(
          const ResetPasswordState(),
        ) {
    _log('ResetPasswordBloc created for user: ${user.login}');

    on<RequestNewPassword>(
      _mapResetPasswordRequestedToState,
      transformer: restartable(),
    );
    on<CancelNewPasswordRequest>(
      _mapCancelResetPasswordRequestedToState,
      transformer: droppable(),
    );
  }

  final User user;

  Future<void> _mapResetPasswordRequestedToState(
    final RequestNewPassword event,
    final Emitter<ResetPasswordState> emit,
  ) async {
    _log('Reset password requested for user: ${user.login}');
    if (state.isLoading) {
      return;
    }

    emit(
      const ResetPasswordState(
        passwordResetLink: null,
        isLoading: true,
      ),
    );

    _log('Load start');
    final (link, message) =
        await getIt<ApiConnectionRepository>().generatePasswordResetLink(user);

    _log('Got link: $link, message: $message');
    if (state.isLoading) {
      emit(
        link != null
            ? ResetPasswordState(
                passwordResetLink: link,
                passwordResetMessage: message,
              )
            : ResetPasswordState(
                errorMessage: message,
              ),
      );
    }
  }

  Future<void> _mapCancelResetPasswordRequestedToState(
    final CancelNewPasswordRequest event,
    final Emitter<ResetPasswordState> emit,
  ) async {
    _log('Reset password request cancelled');
    if (state.isLoading) {
      emit(
        const ResetPasswordState(
          passwordResetLink: null,
          isLoading: false,
        ),
      );
    }
  }
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
  List<Object?> get props =>
      [passwordResetMessage, isLoading, passwordResetLink, errorMessage];
}
