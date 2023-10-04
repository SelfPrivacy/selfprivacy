import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/backblaze.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';

part 'backups_wizard_state.dart';

class BackupsWizardCubit extends Cubit<BackupsWizardState> {
  BackupsWizardCubit() : super(const BackupsWizardState());

  BackupConfiguration? serverBackupConfig;

  Future<void> load() async {
    serverBackupConfig = await ServerApi().getBackupsConfiguration();

    /// If config already exists, then user only lacks credentials,
    /// we don't need full re-initialization
    if (serverBackupConfig != null) {
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

  void recoverBackupsInformation() async {
    try {
      await getIt<ApiConfigModel>()
          .storeBackblazeCredential(state.backupsCredential!);
      final bucket = await BackblazeApi()
          .fetchBucket(state.backupsCredential!, serverBackupConfig!);
      await getIt<ApiConfigModel>().storeBackblazeBucket(bucket!);
    } catch (e) {
      print(e);
      getIt<NavigationService>().showSnackBar('jobs.generic_error'.tr());
      return;
    }

    emit(
      state.copyWith(
        currentStep: BackupsWizardStep.finished,
      ),
    );
  }
}
