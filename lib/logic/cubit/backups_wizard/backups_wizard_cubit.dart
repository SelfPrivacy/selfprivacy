import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';

part 'backups_wizard_state.dart';

class BackupsWizardCubit extends Cubit<BackupsWizardState> {
  BackupsWizardCubit() : super(const BackupsWizardState());

  Future<void> load() async {
    final serverBackupConfig = await ServerApi().getBackupsConfiguration();

    /// If config already exists, then user only lacks credentials,
    /// we don't need full re-initialization
    if (serverBackupConfig != null && serverBackupConfig.isInitialized) {
      emit(state.copyWith(currentStep: BackupsWizardStep.hostingRecovery));
    }
  }

  void setBackupsCredential(final BackupsCredential backupsCredential) {
    emit(
      state.copyWith(
        backupsCredential: backupsCredential,
        currentStep: state.currentStep == BackupsWizardStep.hostingRecovery
            ? BackupsWizardStep.confirmRecovery
            : BackupsWizardStep.settingsInitialization,
      ),
    );
  }

  void setAutobackupPeriod(final Duration? autobackupPeriod) {
    emit(
      state.copyWith(
        autobackupPeriod: autobackupPeriod,
      ),
    );
  }

  void setAutobackupQuotas(final AutobackupQuotas autobackupQuotas) {
    emit(
      state.copyWith(
        autobackupQuotas: autobackupQuotas,
      ),
    );
  }

  void confirmSettings() {
    emit(
      state.copyWith(
        currentStep: BackupsWizardStep.confirmInitialization,
      ),
    );
  }
}
