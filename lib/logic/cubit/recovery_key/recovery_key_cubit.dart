import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/json/recovery_token_status.dart';

part 'recovery_key_state.dart';

class RecoveryKeyCubit
    extends ServerInstallationDependendCubit<RecoveryKeyState> {
  RecoveryKeyCubit(ServerInstallationCubit serverInstallationCubit)
      : super(serverInstallationCubit, const RecoveryKeyState.initial());

  final api = ServerApi();

  @override
  void load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      final status = await _getRecoveryKeyStatus();
      if (status == null) {
        emit(state.copyWith(loadingStatus: LoadingStatus.error));
      } else {
        emit(state.copyWith(status: status, loadingStatus: LoadingStatus.good));
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
    final status = await _getRecoveryKeyStatus();
    if (status == null) {
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
    } else {
      emit(state.copyWith(status: status, loadingStatus: LoadingStatus.good));
    }
  }

  Future<String> generateRecoveryKey({
    DateTime? expirationDate,
    int? numberOfUses,
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
  final String message;

  GenerationError(this.message);
}
