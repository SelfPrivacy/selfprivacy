import 'package:flutter/services.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/provider_credentials.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/hive/wizards_data/server_installation_wizard_data.dart';
import 'package:selfprivacy/utils/app_logger.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';
import 'package:selfprivacy/utils/secure_storage.dart';
import 'package:uuid/uuid.dart';

class HiveConfig {
  static final logger = const AppLogger(name: 'hive_config').log;

  /// bump on schema changes
  static const version = 3;

  static Future<void> init() async {
    final String? storagePath = PlatformAdapter.storagePath;
    logger('set custom storage path to: "$storagePath"');

    // Use a custom path if available, let Flutter to decide automatically if not
    if (storagePath != null) {
      Hive.init(storagePath);
    } else {
      await Hive.initFlutter();
    }

    registerAdapters();
    await decryptBoxes();
    await performMigrations();
  }

  static void registerAdapters() {
    try {
      Hive
        ..registerAdapter(UserAdapter())
        ..registerAdapter(ServerHostingDetailsAdapter())
        ..registerAdapter(ServerDomainAdapter())
        ..registerAdapter(BackupsCredentialAdapter())
        ..registerAdapter(ServerProviderVolumeAdapter())
        ..registerAdapter(BackblazeBucketAdapter())
        ..registerAdapter(BearerTokenCredentialAdapter())
        ..registerAdapter(ServerProviderCredentialAdapter())
        ..registerAdapter(DnsProviderCredentialAdapter())
        ..registerAdapter(ServerAdapter())
        ..registerAdapter(DnsProviderTypeAdapter())
        ..registerAdapter(ServerProviderTypeAdapter())
        ..registerAdapter(UserTypeAdapter())
        ..registerAdapter(BackupsProviderTypeAdapter())
        ..registerAdapter(ServerInstallationWizardDataAdapter());
      logger('successfully registered every adapter');
    } catch (error, stackTrace) {
      logger(
        'error registering adapters',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  static Future<HiveAesCipher> getCipher() async {
    List<int>? key = await SecureStorage.getKey();
    if (key == null) {
      if (await _encryptedBoxesExist()) {
        throw PlatformException(
          code: 'hive_key_missing_with_data',
          message:
              "The device's secure storage lost the encryption key that "
              'protects this app’s data. The data is still on disk but can '
              'no longer be decrypted.',
        );
      }
      key = Hive.generateSecureKey();
      await SecureStorage.setKey(key);
    }
    return HiveAesCipher(key);
  }

  static Future<bool> _encryptedBoxesExist() async =>
      await Hive.boxExists(BNames.serverInstallationBox) ||
      await Hive.boxExists(BNames.resourcesBox) ||
      await Hive.boxExists(BNames.wizardDataBox) ||
      await Hive.boxExists(BNames.wizardRunsBox);

  static Future<void> decryptBoxes() async {
    try {
      // load encrypted boxes into memory
      final HiveAesCipher cipher = await getCipher();

      await Hive.openBox(
        BNames.serverInstallationBox,
        encryptionCipher: cipher,
      );
      await Hive.openBox(BNames.resourcesBox, encryptionCipher: cipher);
      await Hive.openBox(BNames.wizardDataBox, encryptionCipher: cipher);
      await Hive.openBox(BNames.wizardRunsBox, encryptionCipher: cipher);
      logger('successfully decrypted boxes');
    } catch (error, stackTrace) {
      logger(
        'error initializing encrypted boxes',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  // migrations

  static Future<void> performMigrations() async {
    try {
      // perform migration check
      final localSettingsBox = await Hive.openBox(BNames.appSettingsBox);

      // if it is an initial app launch, we do not need to perform any migrations
      final int savedVersion = localSettingsBox.isEmpty
          ? version
          // if box was initialized, but database version was not introduced in
          // it yet, it means that we have initial value
          : await localSettingsBox.get(BNames.databaseVersion, defaultValue: 1);

      /// launch migrations based on version
      if (savedVersion < version) {
        if (savedVersion < 2) {
          await migrateFrom1To2();
        }
        if (savedVersion < 3) {
          await migrateFrom2To3(localSettingsBox);
        }
      }

      /// update saved version after successfull migrations
      await localSettingsBox.put(BNames.databaseVersion, version);
    } catch (error, stackTrace) {
      logger(
        'error running db migrations',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// introduce and populate resourcesBox
  static Future<void> migrateFrom1To2() async {
    final Box resourcesBox = Hive.box(BNames.resourcesBox);
    if (resourcesBox.isEmpty) {
      final Box serverInstallationBox = Hive.box(BNames.serverInstallationBox);

      final ServerHostingDetails? serverDetails = serverInstallationBox.get(
        BNames.serverDetails,
      );

      // move server provider config

      final ServerProviderType? serverProvider =
          serverInstallationBox.get(BNames.serverProvider) ??
          serverDetails?.provider;
      final String? serverProviderKey = serverInstallationBox.get(
        BNames.hetznerKey,
      );

      if (serverProviderKey != null && serverProvider.isSpecified) {
        final ServerProviderCredential serverProviderCredential =
            ServerProviderCredential.create(
              tokenId: null,
              credentials: BearerTokenCredential(token: serverProviderKey),
              provider: serverProvider!,
              associatedServerUuids: [],
              legacyAssociatedServerIds: [
                if (serverDetails?.legacyProviderId != null)
                  serverDetails!.legacyProviderId!,
              ],
            );

        await resourcesBox.put(BNames.serverProviderTokens, [
          serverProviderCredential,
        ]);
      }

      final String? serverLocation = serverInstallationBox.get(
        BNames.serverLocation,
      );
      final String? serverType = serverInstallationBox.get(
        BNames.serverTypeIdentifier,
      );
      final ServerDomain? serverDomain = serverInstallationBox.get(
        BNames.serverDomain,
      );

      if (serverDetails != null && serverDomain != null) {
        await resourcesBox.put(BNames.servers, [
          Server.create(
            domain: serverDomain,
            hostingDetails: serverDetails.copyWith(
              serverLocation: serverLocation,
              serverType: serverType,
            ),
          ),
        ]);
      }

      // move dns config
      final String? dnsProviderKey = serverInstallationBox.get(
        BNames.cloudFlareKey,
      );
      final DnsProviderType? dnsProvider =
          serverInstallationBox.get(BNames.dnsProvider) ??
          serverDomain?.provider;

      if (dnsProviderKey != null && dnsProvider.isSpecified) {
        final DnsProviderCredential dnsProviderCredential =
            DnsProviderCredential.create(
              token: dnsProviderKey,
              provider: dnsProvider!,
              associatedDomainNames: [
                if (serverDomain != null) serverDomain.domainName,
              ],
            );

        await resourcesBox.put(BNames.dnsProviderTokens, [
          dnsProviderCredential,
        ]);
      }

      // move backblaze (backups) config
      final BackupsCredential? backblazeCredential = serverInstallationBox.get(
        BNames.backblazeCredential,
      );
      final BackblazeBucket? backblazeBucket = serverInstallationBox.get(
        BNames.backblazeBucket,
      );

      if (backblazeCredential != null) {
        await resourcesBox.put(BNames.backupsProviderTokens, [
          backblazeCredential,
        ]);
      }

      if (backblazeBucket != null) {
        await resourcesBox.put(BNames.backblazeBucket, backblazeBucket);
      }
    }
    logger('successfully migrated db from 1 to 2 version');
  }

  static Future<void> migrateFrom2To3(
    final Box<dynamic> localSettingsBox,
  ) async {
    final Box<dynamic> resourcesBox = Hive.box(BNames.resourcesBox);
    final servers = List<Server>.from(
      resourcesBox.get(BNames.servers, defaultValue: <Server>[])
          as List<dynamic>,
    );
    final legacyServerUuids = <int, String>{};
    final migratedServers = servers.map((final server) {
      final serverUuid = server.uuid.isEmpty ? const Uuid().v4() : server.uuid;
      final hostingDetails = server.hostingDetails;
      final legacyProviderId =
          hostingDetails.legacyProviderId ??
          int.tryParse(hostingDetails.providerId ?? '');
      if (legacyProviderId != null) {
        legacyServerUuids[legacyProviderId] = serverUuid;
      }
      final volume = hostingDetails.volume;
      return Server(
        uuid: serverUuid,
        domain: server.domain,
        hostingDetails: ServerHostingDetails(
          ip4: hostingDetails.ip4,
          providerId: hostingDetails.providerId ?? legacyProviderId?.toString(),
          createTime: hostingDetails.createTime,
          volume: ServerProviderVolume(
            id: volume.id,
            name: volume.name,
            sizeByte: volume.sizeByte,
            serverId: volume.serverId ?? volume.legacyServerId?.toString(),
            linuxDevice: volume.linuxDevice,
            uuid: volume.uuid,
            location: volume.location,
          ),
          apiToken: hostingDetails.apiToken,
          provider: hostingDetails.provider,
          serverLocation: hostingDetails.serverLocation,
          serverType: hostingDetails.serverType,
          startTime: hostingDetails.startTime,
          apiTokenRotatedAt: hostingDetails.apiTokenRotatedAt,
        ),
      );
    }).toList();
    await resourcesBox.put(BNames.servers, migratedServers);

    final serverCredentials = List<ServerProviderCredential>.from(
      resourcesBox.get(
            BNames.serverProviderTokens,
            defaultValue: <ServerProviderCredential>[],
          )
          as List<dynamic>,
    );
    final migratedServerCredentials = serverCredentials.map((final credential) {
      final associatedServerUuids = <String>{
        ...credential.associatedServerUuids,
        for (final legacyId in credential.legacyAssociatedServerIds)
          ?legacyServerUuids[legacyId],
      }.toList();
      return ServerProviderCredential(
        uuid: credential.uuid.isEmpty ? const Uuid().v4() : credential.uuid,
        tokenId: credential.tokenId,
        credentials:
            credential.credentials ??
            switch (credential.legacyToken) {
              final token? => BearerTokenCredential(token: token),
              null => null,
            },
        provider: credential.provider,
        associatedServerUuids: associatedServerUuids,
      );
    }).toList();
    await resourcesBox.put(
      BNames.serverProviderTokens,
      migratedServerCredentials,
    );

    final dnsCredentials = List<DnsProviderCredential>.from(
      resourcesBox.get(
            BNames.dnsProviderTokens,
            defaultValue: <DnsProviderCredential>[],
          )
          as List<dynamic>,
    );
    await resourcesBox.put(
      BNames.dnsProviderTokens,
      dnsCredentials.map((final credential) {
        if (credential.uuid.isNotEmpty) {
          return credential;
        }
        return DnsProviderCredential(
          uuid: const Uuid().v4(),
          token: credential.token,
          provider: credential.provider,
          associatedDomainNames: credential.associatedDomainNames,
          tokenId: credential.tokenId,
          url: credential.url,
          tenant: credential.tenant,
          secondaryToken: credential.secondaryToken,
        );
      }).toList(),
    );

    final backupsCredentials = List<BackupsCredential>.from(
      resourcesBox.get(
            BNames.backupsProviderTokens,
            defaultValue: <BackupsCredential>[],
          )
          as List<dynamic>,
    );
    await resourcesBox.put(
      BNames.backupsProviderTokens,
      backupsCredentials.map((final credential) {
        if (credential.uuid.isNotEmpty) {
          return credential;
        }
        return BackupsCredential(
          uuid: const Uuid().v4(),
          keyId: credential.keyId,
          applicationKey: credential.applicationKey,
          provider: credential.provider,
        );
      }).toList(),
    );

    if (localSettingsBox.get(BNames.activeServerUuid) == null &&
        migratedServers.isNotEmpty) {
      await localSettingsBox.put(
        BNames.activeServerUuid,
        migratedServers.first.uuid,
      );
    }
    logger('successfully migrated db from 2 to 3 version');
  }
}

/// Mappings for the different boxes and their keys
class BNames {
  /// App settings box. Contains app settings like [darkThemeModeOn], [shouldShowOnboarding]
  static String appSettingsBox = 'appSettings';

  /// An integer with last saved version of the database
  static String databaseVersion = 'databaseVersion';

  /// A boolean field of [appSettingsBox] box.
  static String darkThemeModeOn = 'isDarkModeOn';

  /// A boolean field of [appSettingsBox] box.
  static String systemThemeModeOn = 'isAutoDarkModeOn';

  /// A boolean field of [appSettingsBox] box.
  static String shouldShowOnboarding = 'isOnboardingShowing';

  /// A string field
  static String appLocale = 'appLocale';

  /// A boolean field of [appSettingsBox] box.
  static String stagingAcme = 'stagingAcme';

  /// A boolean field of [appSettingsBox] box.
  static String automaticGraphqlTokenRefresh = 'automaticGraphqlTokenRefresh';

  /// A server UUID field of [appSettingsBox] box.
  static String activeServerUuid = 'activeServerUuid';

  /// Server installation box. Contains server details and provider tokens.
  static String serverInstallationBox = 'appConfig';

  /// A `List<String>` field of [serverInstallationBox] box.
  static String rootKeys = 'rootKeys';

  /// A boolean field of [serverInstallationBox] box.
  static String hasFinalChecked = 'hasFinalChecked';

  /// A boolean field of [serverInstallationBox] box.
  static String isServerStarted = 'isServerStarted';

  /// A [ServerDomain] field of [serverInstallationBox] box.
  static String serverDomain = 'cloudFlareDomain';

  /// A String field of [serverInstallationBox] box.
  static String hetznerKey = 'hetznerKey';

  /// A String field of [serverInstallationBox] box.
  static String serverProvider = 'serverProvider';

  /// A String field of [serverInstallationBox] box.
  static String dnsProvider = 'dnsProvider';

  /// A String field of [serverLocation] box.
  static String serverLocation = 'serverLocation';

  /// A String field of [serverInstallationBox] box.
  static String cloudFlareKey = 'cloudFlareKey';

  /// A String field of [serverInstallationBox] box.
  static String serverTypeIdentifier = 'serverTypeIdentifier';

  /// A [User] field of [serverInstallationBox] box.
  static String rootUser = 'rootUser';

  /// A [ServerHostingDetails] field of [serverInstallationBox] box.
  static String serverDetails = 'hetznerServer';

  /// A [BackupsCredential] field of [serverInstallationBox] box.
  static String backblazeCredential = 'backblazeKey';

  /// A [BackblazeBucket] field of [serverInstallationBox] box.
  static String backblazeBucket = 'backblazeBucket';

  /// A boolean field of [serverInstallationBox] box.
  static String isLoading = 'isLoading';

  /// A boolean field of [serverInstallationBox] box.
  static String isRecoveringServer = 'isRecoveringServer';

  /// Resources and provider tokens box,
  static String resourcesBox = 'resourcesBox';

  /// Server Provider Tokens of [resourcesBox] box.
  static String serverProviderTokens = 'serverProviderTokens';

  /// DNS Provider Tokens of [resourcesBox] box.
  static String dnsProviderTokens = 'dnsProviderTokens';

  /// Backups Provider Tokens of [resourcesBox] box.
  static String backupsProviderTokens = 'backupsProviderTokens';

  /// Servers of [resourcesBox] box.
  static String servers = 'servers';

  /// Wizard data box
  static String wizardDataBox = 'wizardDataBox';

  /// Server installation wizard data of [wizardDataBox] box.
  static String serverInstallationWizardData = 'serverInstallationWizardData';

  /// Wizard run scratch data, keyed by run UUID.
  static String wizardRunsBox = 'wizardRunsBox';
}
