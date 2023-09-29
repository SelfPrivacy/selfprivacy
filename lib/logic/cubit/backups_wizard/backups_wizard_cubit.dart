import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';

part 'backups_wizard_state.dart';

class BackupsWizardCubit extends Cubit<BackupsWizardState> {
  BackupsWizardCubit() : super(const BackupsWizardState());

  Future<void> load() async {
    final BackupConfiguration? backupConfig =
        await ServerApi().getBackupsConfiguration();

    /// If config already exists, then user only lacks credentials,
    /// we don't need full re-initialization
    if (backupConfig != null) {
      emit(state.copyWith(currentStep: BackupsWizardStep.hostingRecovery));
    }
  }

  void setBackupsCredential(final BackupsCredential backupsCredential) {
    emit(
      state.copyWith(
        backupsCredential: backupsCredential,
        currentStep: state.currentStep == BackupsWizardStep.hostingRecovery
            ? BackupsWizardStep.finished
            : BackupsWizardStep.period,
      ),
    );
  }

  void setAutobackupPeriod(final Duration? autobackupPeriod) {
    emit(
      state.copyWith(
        autobackupPeriod: autobackupPeriod,
        currentStep: BackupsWizardStep.quotas,
      ),
    );
  }

  void setAutobackupQuotas(final AutobackupQuotas autobackupQuotas) {
    emit(
      state.copyWith(
        autobackupQuotas: autobackupQuotas,
        currentStep: BackupsWizardStep.confirmation,
      ),
    );
  }
}
