import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/logic/models/hive/provider_credentials.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:uuid/uuid.dart';

part 'server_provider_credential.g.dart';

// TODO(inex): Make a constant type.
@HiveType(typeId: 7)
class ServerProviderCredential {
  ServerProviderCredential({
    required this.uuid,
    required this.tokenId,
    required this.credentials,
    required this.provider,
    required this.associatedServerUuids,
    this.legacyToken,
    this.legacyAssociatedServerIds = const [],
  });

  factory ServerProviderCredential.create({
    required final String? tokenId,
    required final ProviderCredentials credentials,
    required final ServerProviderType provider,
    required final List<String> associatedServerUuids,
    final List<int> legacyAssociatedServerIds = const [],
  }) => ServerProviderCredential(
    uuid: const Uuid().v4(),
    tokenId: tokenId,
    credentials: credentials,
    provider: provider,
    associatedServerUuids: associatedServerUuids,
    legacyAssociatedServerIds: legacyAssociatedServerIds,
  );

  @HiveField(4, defaultValue: '')
  final String uuid;

  @HiveField(0)
  final String? tokenId;

  @HiveField(1)
  final String? legacyToken;

  @HiveField(2)
  final ServerProviderType provider;

  @HiveField(3)
  final List<int> legacyAssociatedServerIds;

  @HiveField(5, defaultValue: <String>[])
  final List<String> associatedServerUuids;

  @HiveField(6, defaultValue: null)
  final ProviderCredentials? credentials;

  String? get bearerToken => switch (credentials) {
    BearerTokenCredential(:final token) => token,
    null => legacyToken,
  };
}
