import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/models/callback_dialogue_branching.dart';
import 'package:selfprivacy/logic/models/launch_installation_data.dart';

typedef ResourceCleanup = Future<GenericResult<void>> Function();

GenericResult<CallbackDialogueBranching?> unreadableCreationResult({
  required final LaunchInstallationData installationData,
  required final String? resourceId,
  required final ResourceCleanup cleanup,
  final String? message,
  final int? code,
}) => GenericResult(
  success: false,
  data: resourceId == null
      ? _manualCleanupDialog(installationData)
      : _cleanupConfirmationDialog(
          installationData: installationData,
          resourceId: resourceId,
          cleanup: cleanup,
        ),
  message: message,
  code: code,
);

CallbackDialogueBranching _cleanupConfirmationDialog({
  required final LaunchInstallationData installationData,
  required final String resourceId,
  required final ResourceCleanup cleanup,
}) => CallbackDialogueBranching(
  title: 'modals.resource_created'.tr(),
  description: 'modals.resource_response_unreadable'.tr(args: [resourceId]),
  choices: [
    CallbackDialogueChoice(
      title: 'modals.leave_resource'.tr(),
      callback: () => _stopInstallation(installationData),
    ),
    CallbackDialogueChoice(
      title: 'modals.delete_and_stop'.tr(),
      callback: () =>
          _runCleanup(installationData: installationData, cleanup: cleanup),
    ),
  ],
);

CallbackDialogueBranching _manualCleanupDialog(
  final LaunchInstallationData installationData,
) => CallbackDialogueBranching(
  title: 'modals.resource_created'.tr(),
  description: 'modals.resource_id_unreadable'.tr(),
  choices: [
    CallbackDialogueChoice(
      title: 'modals.leave_resource'.tr(),
      callback: () => _stopInstallation(installationData),
    ),
    CallbackDialogueChoice(
      title: 'modals.cleanup_done'.tr(),
      callback: () => _stopInstallation(installationData),
    ),
  ],
);

Future<GenericResult<CallbackDialogueBranching?>> _runCleanup({
  required final LaunchInstallationData installationData,
  required final ResourceCleanup cleanup,
}) async {
  final result = await cleanup();
  if (result.success) {
    return _stopInstallation(installationData);
  }

  return GenericResult(
    success: false,
    data: CallbackDialogueBranching(
      title: 'modals.resource_cleanup_failed'.tr(),
      description: 'modals.resource_cleanup_failed_description'.tr(),
      choices: [
        CallbackDialogueChoice(
          title: 'modals.leave_resource'.tr(),
          callback: () => _stopInstallation(installationData),
        ),
        CallbackDialogueChoice(
          title: 'modals.retry_cleanup'.tr(),
          callback: () =>
              _runCleanup(installationData: installationData, cleanup: cleanup),
        ),
      ],
    ),
    message: result.message,
    code: result.code,
  );
}

Future<GenericResult<CallbackDialogueBranching?>> _stopInstallation(
  final LaunchInstallationData installationData,
) async {
  await installationData.errorCallback();
  return GenericResult(success: true, data: null);
}
