import 'package:hive_ce/hive.dart';

part 'provider_credentials.g.dart';

sealed class ProviderCredentials {
  const ProviderCredentials();
}

@HiveType(typeId: 11)
final class BearerTokenCredential extends ProviderCredentials {
  const BearerTokenCredential({required this.token});

  @HiveField(0)
  final String token;
}
