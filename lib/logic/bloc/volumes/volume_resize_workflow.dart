import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/repositories/volumes_repository.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/operations/operation_execution.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';

enum VolumeResizeStage { started, providerWaiting, serverWaiting, rebooting }

class VolumeResizeWorkflow {
  VolumeResizeWorkflow({required this.volumes, required this.provider});

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
    final resized = await provider.resizeVolume(providerVolume, size);
    OperationExecution.current?.recordCompletion(
      succeeded: resized.success && resized.data,
    );
    _requireAttached();
    if (!resized.success || !resized.data) {
      return null;
    }
    onProgress(VolumeResizeStage.providerWaiting);
    await Future<void>.delayed(const Duration(seconds: 10));
    _requireAttached();
    final resize = await volumes.resize(name);
    _requireAttached();
    if (resize.outcome != ServerMutationOutcome.confirmed) {
      return resize;
    }
    onProgress(VolumeResizeStage.serverWaiting);
    await Future<void>.delayed(const Duration(seconds: 20));
    _requireAttached();
    onProgress(VolumeResizeStage.rebooting);
    return volumes.reboot();
  }
}
