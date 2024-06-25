import 'package:hive_flutter/hive_flutter.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/hive/wizards_data/server_installation_wizard_data.dart';
import 'package:selfprivacy/utils/app_logger.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';
import 'package:selfprivacy/utils/secure_storage.dart';

class HiveConfig {
  static final log = const AppLogger(name: 'hive_config').log;

  /// bump on schema changes
  static const version = 2;

  static Future<void> init() async {
    final String? storagePath = PlatformAdapter.storagePath;
    log('set custom storage path to: "$storagePath"');

    await Hive.initFlutter(storagePath);

    registerAdapters();
    await decryptBoxes();
    await performMigrations();
  }

  static void registerAdapters() {
    try {
      Hive.registerAdapter(UserAdapter());
      Hive.registerAdapter(ServerHostingDetailsAdapter());
      Hive.registerAdapter(ServerDomainAdapter());
      Hive.registerAdapter(BackupsCredentialAdapter());
      Hive.registerAdapter(ServerProviderVolumeAdapter());
      Hive.registerAdapter(BackblazeBucketAdapter());
      Hive.registerAdapter(ServerProviderCredentialAdapter());
      Hive.registerAdapter(DnsProviderCredentialAdapter());
      Hive.registerAdapter(ServerAdapter());
      Hive.registerAdapter(DnsProviderTypeAdapter());
      Hive.registerAdapter(ServerProviderTypeAdapter());
      Hive.registerAdapter(UserTypeAdapter());
      Hive.registerAdapter(BackupsProviderTypeAdapter());
      Hive.registerAdapter(ServerInstallationWizardDataAdapter());
      log('successfully registered every adapter');
    } catch (error, stackTrace) {
      log(
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
      key = Hive.generateSecureKey();
      await SecureStorage.setKey(key);
    }
    return HiveAesCipher(key);
  }

  static Future<void> decryptBoxes() async {
    try {
      // load encrypted boxes into memory
      final HiveAesCipher cipher = await getCipher();

      await Hive.openBox(
        BNames.serverInstallationBox,
        encryptionCipher: cipher,
      );
      await Hive.openBox(
        BNames.resourcesBox,
        encryptionCipher: cipher,
      );
      await Hive.openBox(
        BNames.wizardDataBox,
        encryptionCipher: cipher,
      );
      log('successfully decrypted boxes');
    } catch (error, stackTrace) {
      log(
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
      final savedVersion = localSettingsBox.isEmpty
          ? version
          // if box was initialized, but database version was not introduced in
          // it yet, it means that we have initial value
          : await localSettingsBox.get(BNames.databaseVersion, defaultValue: 1);

      /// launch migrations based on version
      if (savedVersion < version) {
        if (savedVersion < 2) {
          await migrateFrom1To2();
        }

        /// add new migrations here, like:
        /// if (version < 3) {...}, etc.

        /// update saved version after successfull migraions
        await localSettingsBox.put(BNames.databaseVersion, version);
      }
    } catch (error, stackTrace) {
      log(
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

      final String? serverProviderKey =
          serverInstallationBox.get(BNames.hetznerKey);
      final String? serverLocation =
          serverInstallationBox.get(BNames.serverLocation);
      final String? dnsProviderKey =
          serverInstallationBox.get(BNames.cloudFlareKey);
      final BackupsCredential? backblazeCredential =
          serverInstallationBox.get(BNames.backblazeCredential);
      final ServerDomain? serverDomain =
          serverInstallationBox.get(BNames.serverDomain);
      final ServerHostingDetails? serverDetails =
          serverInstallationBox.get(BNames.serverDetails);
      final BackblazeBucket? backblazeBucket =
          serverInstallationBox.get(BNames.backblazeBucket);
      final String? serverType =
          serverInstallationBox.get(BNames.serverTypeIdentifier);
      final ServerProviderType? serverProvider =
          serverInstallationBox.get(BNames.serverProvider);
      final DnsProviderType? dnsProvider =
          serverInstallationBox.get(BNames.dnsProvider);

      if (serverProviderKey != null &&
          (serverProvider != null ||
              (serverDetails != null &&
                  serverDetails.provider != ServerProviderType.unknown))) {
        final ServerProviderCredential serverProviderCredential =
            ServerProviderCredential(
          tokenId: null,
          token: serverProviderKey,
          provider: serverProvider ?? serverDetails!.provider,
          associatedServerIds: serverDetails != null ? [serverDetails.id] : [],
        );

        await resourcesBox
            .put(BNames.serverProviderTokens, [serverProviderCredential]);
      }

      if (dnsProviderKey != null &&
          (dnsProvider != null ||
              (serverDomain != null &&
                  serverDomain.provider != DnsProviderType.unknown))) {
        final DnsProviderCredential dnsProviderCredential =
            DnsProviderCredential(
          tokenId: null,
          token: dnsProviderKey,
          provider: dnsProvider ?? serverDomain!.provider,
          associatedDomainNames:
              serverDomain != null ? [serverDomain.domainName] : [],
        );

        await resourcesBox
            .put(BNames.dnsProviderTokens, [dnsProviderCredential]);
      }

      if (backblazeCredential != null) {
        await resourcesBox
            .put(BNames.backupsProviderTokens, [backblazeCredential]);
      }

      if (backblazeBucket != null) {
        await resourcesBox.put(BNames.backblazeBucket, backblazeBucket);
      }

      if (serverDetails != null && serverDomain != null) {
        await resourcesBox.put(BNames.servers, [
          Server(
            domain: serverDomain,
            hostingDetails: serverDetails.copyWith(
              serverLocation: serverLocation,
              serverType: serverType,
            ),
          ),
        ]);
      }
    }
    log('successfully migration of db from 1 to 2 version');
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

  /// Server installation box. Contains server details and provider tokens.
  static String serverInstallationBox = 'appConfig';

  /// A List<String> field of [serverInstallationBox] box.
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
  static String isServerResetedFirstTime = 'isServerResetedFirstTime';

  /// A boolean field of [serverInstallationBox] box.
  static String isServerResetedSecondTime = 'isServerResetedSecondTime';

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
}
