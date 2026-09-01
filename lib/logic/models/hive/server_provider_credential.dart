import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:uuid/uuid.dart';

part 'server_provider_credential.g.dart';

// TODO(inex): Make a constant type.
@HiveType(typeId: 7)
class ServerProviderCredential {
  ServerProviderCredential({
    required this.uuid,
    required this.tokenId,
    required this.token,
    required this.provider,
    required this.associatedServerIds,
  });

  factory ServerProviderCredential.create({
    required final String? tokenId,
    required final String token,
    required final ServerProviderType provider,
    required final List<int> associatedServerIds,
  }) => ServerProviderCredential(
    uuid: const Uuid().v4(),
    tokenId: tokenId,
    token: token,
    provider: provider,
    associatedServerIds: associatedServerIds,
  );

  @HiveField(4, defaultValue: '')
  final String uuid;

  @HiveField(0)
  final String? tokenId;

  @HiveField(1)
  final String token;

  @HiveField(2)
  final ServerProviderType provider;

  @HiveField(3)
  final List<int> associatedServerIds;
}
