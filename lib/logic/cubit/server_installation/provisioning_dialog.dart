import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/models/callback_dialogue_branching.dart';
import 'package:selfprivacy/logic/models/provisioning_result.dart';

CallbackDialogueBranching provisioningFailureDialog({
  required final ProvisioningFailed failure,
  required final Future<void> Function() onStop,
  required final Future<GenericResult<CallbackDialogueBranching?>> Function()
  onRetry,
  required final Future<GenericResult<void>> Function(ProvisionedResource)
  deleteResource,
}) {
  Future<GenericResult<CallbackDialogueBranching?>>? pending;

  Future<GenericResult<CallbackDialogueBranching?>> run(
    final Future<GenericResult<CallbackDialogueBranching?>> Function() action,
  ) => pending ??= Future.sync(action).whenComplete(() => pending = null);

  Future<GenericResult<CallbackDialogueBranching?>> stop() async {
    await onStop();
    return GenericResult(success: true, data: null);
  }

  CallbackDialogueChoice choice(
    final String key,
    final Future<GenericResult<CallbackDialogueBranching?>> Function() action,
  ) => CallbackDialogueChoice(title: key.tr(), callback: () => run(action));

  final resources = [
    ...failure.resources.where(
      (final r) => r.kind == ProvisionedResourceKind.server,
    ),
    ...failure.resources.where(
      (final r) => r.kind == ProvisionedResourceKind.volume,
    ),
  ];

  Future<GenericResult<CallbackDialogueBranching?>> cleanup({
    required final bool retry,
  }) async {
    for (final resource in resources) {
      final result = await deleteResource(resource);
      if (!result.success) {
        return GenericResult(
          success: false,
          code: result.code,
          data: CallbackDialogueBranching(
            title: 'modals.resource_cleanup_failed'.tr(),
            description: 'modals.resource_cleanup_failed_description'.tr(),
            choices: [
              choice('modals.leave_resource', stop),
              choice('modals.retry_cleanup', () => cleanup(retry: retry)),
            ],
          ),
        );
      }
    }
    return retry ? onRetry() : stop();
  }

  if (failure.kind == ProvisioningFailureKind.indeterminate) {
    return CallbackDialogueBranching(
      title: 'modals.resource_creation_unknown'.tr(),
      description: 'modals.resource_creation_unknown_description'.tr(),
      choices: [choice('basis.cancel', stop)],
    );
  }
  if (failure.kind == ProvisioningFailureKind.nameConflict) {
    return CallbackDialogueBranching(
      title: 'modals.already_exists'.tr(),
      description: 'modals.server_name_conflict_manual_cleanup'.tr(),
      choices: [choice('basis.cancel', stop)],
    );
  }
  if (resources.any((final resource) => resource.id == null)) {
    return CallbackDialogueBranching(
      title: 'modals.resource_created'.tr(),
      description: 'modals.resource_id_unreadable'.tr(),
      choices: [
        choice('modals.leave_resource', stop),
        choice('modals.cleanup_done', stop),
      ],
    );
  }
  if (failure.kind == ProvisioningFailureKind.unreadable) {
    return CallbackDialogueBranching(
      title: 'modals.resource_created'.tr(),
      description: 'modals.resource_response_unreadable'.tr(
        args: [resources.map((final r) => r.id).join(', ')],
      ),
      choices: [
        choice('modals.leave_resource', stop),
        choice('modals.delete_and_stop', () => cleanup(retry: false)),
      ],
    );
  }
  return CallbackDialogueBranching(
    title: 'modals.unexpected_error'.tr(),
    description: switch (failure.stage) {
      ProvisioningStage.discoverServers => 'modals.server_validators_error',
      ProvisioningStage.createVolume => 'modals.volume_creation_error',
      _ => 'recovering.generic_error',
    }.tr(),
    choices: [
      choice(
        resources.isEmpty ? 'basis.cancel' : 'modals.delete_and_stop',
        () => cleanup(retry: false),
      ),
      choice('modals.try_again', () => cleanup(retry: true)),
    ],
  );
}
