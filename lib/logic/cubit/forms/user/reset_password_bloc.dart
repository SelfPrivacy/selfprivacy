import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/utils/app_logger.dart';

final _logger = const AppLogger(name: 'ResetPasswordBloc').log;

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc({required this.user}) : super(const ResetPasswordState()) {
    _logger('ResetPasswordBloc created for user: ${user.login}');

    on<RequestNewPassword>(
      _mapResetPasswordRequestedToState,
      transformer: restartable(),
    );
    on<CancelNewPasswordRequest>(
      _mapCancelResetPasswordRequestedToState,
      transformer: droppable(),
    );
  }

  static const String ssoSupportedVersion = '>=3.6.0';

  final User user;

  Future<void> _mapResetPasswordRequestedToState(
    final RequestNewPassword event,
    final Emitter<ResetPasswordState> emit,
  ) async {
    _logger('Reset password requested for user: ${user.login}');
    if (state.isLoading) {
      return;
    }

    emit(const ResetPasswordState(passwordResetLink: null, isLoading: true));

    final String? apiVersion =
        getIt<ApiConnectionRepository>().apiData.apiVersion.data;
    if (apiVersion == null) {
      throw Exception('basis.network_error'.tr());
    }
    if (!VersionConstraint.parse(
      ssoSupportedVersion,
    ).allows(Version.parse(apiVersion))) {
      emit(
        ResetPasswordUnsupported(
          errorMessage: 'basis.feature_unsupported_on_api_version'.tr(
            namedArgs: {
              'versionConstraint': ssoSupportedVersion,
              'currentVersion': apiVersion,
            },
          ),
        ),
      );
      return;
    }

    _logger('Load start');
    final (link, message) = await getIt<ApiConnectionRepository>()
        .generatePasswordResetLink(user);

    _logger('Got link: $link, message: $message');
    if (state.isLoading) {
      emit(
        link != null
            ? ResetPasswordState(
              passwordResetLink: link,
              passwordResetMessage: message,
            )
            : ResetPasswordState(errorMessage: message),
      );
    }
  }

  Future<void> _mapCancelResetPasswordRequestedToState(
    final CancelNewPasswordRequest event,
    final Emitter<ResetPasswordState> emit,
  ) async {
    _logger('Reset password request cancelled');
    if (state.isLoading) {
      emit(const ResetPasswordState(passwordResetLink: null, isLoading: false));
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
