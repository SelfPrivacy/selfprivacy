import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/repositories/volumes_repository.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/operations/operation_execution.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';

enum VolumeResizeStage { started, providerWaiting, serverWaiting, rebooting }

class ResizeVolumeOperation {
  ResizeVolumeOperation({required this.volumes, required this.provider});

  final VolumesRepository volumes;
  final ServerProvider provider;

  void _requireAttached() {
    if (!volumes.commands.isAttached) {
      throw const OperationNotSent();
    }
  }

  Future<ServerMutationResult<void>?> resize({
    required final String name,
    required final ServerProviderVolume providerVolume,
    required final DiskSize size,
    required final void Function(VolumeResizeStage) onProgress,
  }) async {
    _requireAttached();
    onProgress(VolumeResizeStage.started);
    void step(
      final String id,
      final String titleKey,
      final OperationStatus status,
    ) {
      OperationExecution.current?.recordStep(
        OperationStep(id: id, titleKey: titleKey, status: status, target: name),
      );
    }

    step(
      'provider',
      'storage.extending_volume_started',
      OperationStatus.running,
    );
    final resized = await provider.resizeVolume(providerVolume, size);
    final succeeded = resized.success && resized.data;
    step(
      'provider',
      'storage.extending_volume_started',
      succeeded ? OperationStatus.succeeded : OperationStatus.failed,
    );
    OperationExecution.current?.recordCompletion(succeeded: succeeded);
    _requireAttached();
    if (!resized.success || !resized.data) {
      return null;
    }
    onProgress(VolumeResizeStage.providerWaiting);
    step(
      'providerWait',
      'storage.extending_volume_provider_waiting',
      OperationStatus.running,
    );
    await Future<void>.delayed(const Duration(seconds: 10));
    _requireAttached();
    step(
      'providerWait',
      'storage.extending_volume_provider_waiting',
      OperationStatus.succeeded,
    );
    step(
      'filesystem',
      'storage.extending_volume_title',
      OperationStatus.running,
    );
    final resize = await volumes.resize(name);
    OperationExecution.current?.recordStep(
      OperationStep.fromMutation(
        id: 'filesystem',
        titleKey: 'storage.extending_volume_title',
        target: name,
        result: resize,
      ),
    );
    _requireAttached();
    if (resize.outcome != ServerMutationOutcome.confirmed) {
      return resize;
    }
    onProgress(VolumeResizeStage.serverWaiting);
    step(
      'serverWait',
      'storage.extending_volume_server_waiting',
      OperationStatus.running,
    );
    await Future<void>.delayed(const Duration(seconds: 20));
    _requireAttached();
    step(
      'serverWait',
      'storage.extending_volume_server_waiting',
      OperationStatus.succeeded,
    );
    onProgress(VolumeResizeStage.rebooting);
    step(
      'reboot',
      'storage.extending_volume_rebooting',
      OperationStatus.running,
    );
    final reboot = await volumes.reboot();
    OperationExecution.current?.recordStep(
      OperationStep.fromMutation(
        id: 'reboot',
        titleKey: 'storage.extending_volume_rebooting',
        target: name,
        result: reboot,
      ),
    );
    return reboot;
  }
}
