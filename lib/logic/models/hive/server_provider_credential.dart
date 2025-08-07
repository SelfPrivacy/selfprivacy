import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';

part 'server_provider_credential.g.dart';

// TODO(inex): Make a constant type.
@HiveType(typeId: 7)
class ServerProviderCredential {
  ServerProviderCredential({
    required this.tokenId,
    required this.token,
    required this.provider,
    required this.associatedServerIds,
  });

  @HiveField(0)
  final String? tokenId;

  @HiveField(1)
  final String token;

  @HiveField(2)
  final ServerProviderType provider;

  @HiveField(3)
  final List<int> associatedServerIds;
}
