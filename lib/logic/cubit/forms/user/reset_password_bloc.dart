import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/utils/app_logger.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc({
    required this.user,
  }) : super(
          const ResetPasswordState(),
        ) {
    log('ResetPasswordBloc created for user: ${user.login}');

    on<RequestNewPassword>(
      _mapResetPasswordRequestedToState,
      transformer: droppable(),
    );
  }

  static final log = const AppLogger(name: 'ResetPasswordBloc').log;

  final User user;

  Future<void> _mapResetPasswordRequestedToState(
    final RequestNewPassword event,
    final Emitter<ResetPasswordState> emit,
  ) async {
    log('Reset password requested for user: ${user.login}');
    if (state.isLoading) {
      return;
    }

    emit(
      const ResetPasswordState(
        passwordResetLink: null,
        isLoading: true,
      ),
    );

    log('Load start');
    final (link, message) =
        await getIt<ApiConnectionRepository>().generatePasswordResetLink(user);

    log('Got link: $link, message: $message');

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

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

class RequestNewPassword extends ResetPasswordEvent {
  const RequestNewPassword();
}

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.passwordResetLink,
    this.passwordResetMessage = '',
    this.errorMessage = '',
    this.isLoading = false,
  });

  final Uri? passwordResetLink;
  final bool isLoading;
  final String passwordResetMessage;
  final String errorMessage;

  @override
  List<Object?> get props =>
      [passwordResetMessage, isLoading, passwordResetLink, errorMessage];
}
