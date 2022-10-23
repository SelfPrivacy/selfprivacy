import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/json/recovery_token_status.dart';

part 'recovery_key_state.dart';

class RecoveryKeyCubit
    extends ServerInstallationDependendCubit<RecoveryKeyState> {
  RecoveryKeyCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(serverInstallationCubit, const RecoveryKeyState.initial());

  final ServerApi api = ServerApi();

  @override
  void load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      final RecoveryKeyStatus? status = await _getRecoveryKeyStatus();
      if (status == null) {
        emit(state.copyWith(loadingStatus: LoadingStatus.error));
      } else {
        emit(
          state.copyWith(
            status: status,
            loadingStatus: LoadingStatus.success,
          ),
        );
      }
    } else {
      emit(state.copyWith(loadingStatus: LoadingStatus.uninitialized));
    }
  }

  Future<RecoveryKeyStatus?> _getRecoveryKeyStatus() async {
    final ApiResponse<RecoveryKeyStatus?> response =
        await api.getRecoveryTokenStatus();
    if (response.isSuccess) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<void> refresh() async {
    emit(state.copyWith(loadingStatus: LoadingStatus.refreshing));
    final RecoveryKeyStatus? status = await _getRecoveryKeyStatus();
    if (status == null) {
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
    } else {
      emit(
        state.copyWith(status: status, loadingStatus: LoadingStatus.success),
      );
    }
  }

  Future<String> generateRecoveryKey({
    final DateTime? expirationDate,
    final int? numberOfUses,
  }) async {
    final ApiResponse<String> response =
        await api.generateRecoveryToken(expirationDate, numberOfUses);
    if (response.isSuccess) {
      refresh();
      return response.data;
    } else {
      throw GenerationError(response.errorMessage ?? 'Unknown error');
    }
  }

  @override
  void clear() {
    emit(state.copyWith(loadingStatus: LoadingStatus.uninitialized));
  }
}

class GenerationError extends Error {
  GenerationError(this.message);
  final String message;
}
