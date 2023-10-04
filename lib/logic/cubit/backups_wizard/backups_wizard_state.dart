part of 'backups_wizard_cubit.dart';

/// Temporary attributes of backups configuration.
///
/// After backups wizard is finished, this data is to be converted
/// to actual backups state and set to the app config and its server permanently.
class BackupsWizardState {
  const BackupsWizardState({
    this.autobackupPeriod,
    this.autobackupQuotas,
    this.backupsCredential,
    this.currentStep = BackupsWizardStep.hostingInitialization,
  });

  final BackupsWizardStep currentStep;
  final Duration? autobackupPeriod;
  final AutobackupQuotas? autobackupQuotas;
  final BackupsCredential? backupsCredential;

  BackupsWizardState copyWith({
    final Duration? autobackupPeriod,
    final AutobackupQuotas? autobackupQuotas,
    final BackupsCredential? backupsCredential,
    final BackupsWizardStep? currentStep,
  }) =>
      BackupsWizardState(
        backupsCredential: backupsCredential ?? this.backupsCredential,
        autobackupQuotas: autobackupQuotas ?? this.autobackupQuotas,
        autobackupPeriod: autobackupPeriod ?? this.autobackupPeriod,
        currentStep: currentStep ?? this.currentStep,
      );
}

/// The state machine is expected to follow:
///
/// (Initialize backups) -> hostingInitialization -> period -> rotation -> confirmation
///
/// or
///
/// (Recovery access) -> hostingRecovery
enum BackupsWizardStep {
  hostingRecovery,
  hostingInitialization,
  settingsInitialization,
  confirmInitialization,
  confirmRecovery,
  finished,
}
