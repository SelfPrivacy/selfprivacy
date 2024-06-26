import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';

class HiveConfig {
  static Future<void> init() async {
    final String? storagePath = PlatformAdapter.storagePath;
    print('HiveConfig: Custom storage path: $storagePath');
    await Hive.initFlutter(storagePath);
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(ServerHostingDetailsAdapter());
    Hive.registerAdapter(ServerDomainAdapter());
    Hive.registerAdapter(BackupsCredentialAdapter());
    Hive.registerAdapter(BackblazeBucketAdapter());
    Hive.registerAdapter(ServerProviderVolumeAdapter());
    Hive.registerAdapter(UserTypeAdapter());
    Hive.registerAdapter(DnsProviderTypeAdapter());
    Hive.registerAdapter(ServerProviderTypeAdapter());
    Hive.registerAdapter(BackupsProviderTypeAdapter());

    await Hive.openBox(BNames.appSettingsBox);

    try {
      final HiveAesCipher cipher = HiveAesCipher(
        await getEncryptedKey(BNames.serverInstallationEncryptionKey),
      );

      await Hive.openBox<User>(BNames.usersDeprecated);
      await Hive.openBox<User>(BNames.usersBox, encryptionCipher: cipher);

      final Box<User> deprecatedUsers = Hive.box<User>(BNames.usersDeprecated);
      if (deprecatedUsers.isNotEmpty) {
        final Box<User> users = Hive.box<User>(BNames.usersBox);
        await users.addAll(deprecatedUsers.values.toList());
        await deprecatedUsers.clear();
      }

      await Hive.openBox(
        BNames.serverInstallationBox,
        encryptionCipher: cipher,
      );
    } on PlatformException catch (e) {
      print('HiveConfig: Error while opening boxes: $e');
      rethrow;
    }
  }

  static Future<Uint8List> getEncryptedKey(final String encKey) async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    try {
      final bool hasEncryptionKey =
          await secureStorage.containsKey(key: encKey);
      if (!hasEncryptionKey) {
        final List<int> key = Hive.generateSecureKey();
        await secureStorage.write(key: encKey, value: base64UrlEncode(key));
      }

      final String? string = await secureStorage.read(key: encKey);
      return base64Url.decode(string!);
    } on PlatformException catch (e) {
      print('HiveConfig: Error while getting encryption key: $e');
      rethrow;
    }
  }
}

/// Mappings for the different boxes and their keys
class BNames {
  /// App settings box. Contains app settings like [darkThemeModeOn], [shouldShowOnboarding]
  static String appSettingsBox = 'appSettings';

  /// A boolean field of [appSettingsBox] box.
  static String darkThemeModeOn = 'isDarkModeOn';

  /// A boolean field of [appSettingsBox] box.
  static String systemThemeModeOn = 'isAutoDarkModeOn';

  /// A boolean field of [appSettingsBox] box.
  static String shouldShowOnboarding = 'isOnboardingShowing';

  /// A string field
  static String appLocale = 'appLocale';

  /// Encryption key to decrypt [serverInstallationBox] and [usersBox] box.
  static String serverInstallationEncryptionKey = 'key';

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

  /// A String field of [serverTypeIdentifier] box.
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

  /// Deprecated users box as it is unencrypted
  static String usersDeprecated = 'users';

  /// Box with users
  static String usersBox = 'usersEncrypted';
}
