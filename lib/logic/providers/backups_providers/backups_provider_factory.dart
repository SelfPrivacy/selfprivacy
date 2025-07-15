import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/providers/backups_providers/backblaze.dart';
import 'package:selfprivacy/logic/providers/backups_providers/backups_provider.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';

class UnknownProviderException implements Exception {
  UnknownProviderException(this.message);
  final String message;
}

class BackupsProviderFactory {
  static BackupsProvider createBackupsProviderInterface(
    final BackupsProviderSettings settings,
  ) {
    switch (settings.provider) {
      case BackupsProviderType.backblaze:
        return settings.isAuthorized
            ? BackblazeBackupsProvider.load(
              token: settings.token,
              tokenId: settings.tokenId,
            )
            : BackblazeBackupsProvider();
      case BackupsProviderType.none:
      case BackupsProviderType.file:
      case BackupsProviderType.memory:
        throw UnknownProviderException('Unknown server provider');
    }
  }
}
