import 'package:selfprivacy/logic/models/hive/server_details.dart';

enum ProvisioningStage {
  discoverServers,
  createVolume,
  createServer,
  attachVolume,
  awaitIpv4,
  setReverseDns,
}

enum ProvisioningFailureKind {
  unavailable,
  rejected,
  unreadable,
  indeterminate,
  nameConflict,
  actionFailed,
}

enum ProvisionedResourceKind { server, volume }

final class ProvisionedResource {
  ProvisionedResource({
    required this.provider,
    required this.kind,
    required final String? id,
  }) : id = id == null || id.trim().isEmpty ? null : id;

  final ServerProviderType provider;
  final ProvisionedResourceKind kind;
  final String? id;
}

sealed class ProvisioningResult {
  ProvisioningResult({required final List<ProvisionedResource> resources})
    : resources = List.unmodifiable(resources);

  final List<ProvisionedResource> resources;
}

final class ProvisioningCompleted extends ProvisioningResult {
  ProvisioningCompleted({required this.details, required super.resources});

  final ServerHostingDetails details;
}

final class ProvisioningFailed extends ProvisioningResult {
  ProvisioningFailed({
    required this.stage,
    required this.kind,
    required super.resources,
    this.code,
  });

  final ProvisioningStage stage;
  final ProvisioningFailureKind kind;
  final int? code;
}
