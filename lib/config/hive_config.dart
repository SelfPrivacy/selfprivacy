import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

class HiveConfig {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(ServerHostingDetailsAdapter());
    Hive.registerAdapter(ServerDomainAdapter());
    Hive.registerAdapter(BackblazeCredentialAdapter());
    Hive.registerAdapter(BackblazeBucketAdapter());
    Hive.registerAdapter(ServerVolumeAdapter());

    await Hive.openBox(BNames.appSettingsBox);

    var cipher = HiveAesCipher(
        await getEncryptedKey(BNames.serverInstallationEncryptionKey));

    await Hive.openBox<User>(BNames.usersDeprecated);
    await Hive.openBox<User>(BNames.users, encryptionCipher: cipher);

    Box<User> deprecatedUsers = Hive.box<User>(BNames.usersDeprecated);
    if (deprecatedUsers.isNotEmpty) {
      Box<User> users = Hive.box<User>(BNames.users);
      users.addAll(deprecatedUsers.values.toList());
      deprecatedUsers.clear();
    }

    await Hive.openBox(BNames.serverInstallation, encryptionCipher: cipher);
  }

  static Future<Uint8List> getEncryptedKey(String encKey) async {
    final secureStorage = FlutterSecureStorage();
    var hasEncryptionKey = await secureStorage.containsKey(key: encKey);
    if (!hasEncryptionKey) {
      var key = Hive.generateSecureKey();
      await secureStorage.write(key: encKey, value: base64UrlEncode(key));
    }

    String? string = await secureStorage.read(key: encKey);
    return base64Url.decode(string!);
  }
}

/// Mappings for the different boxes and their keys
class BNames {
  /// App settings box. Contains app settings like [isDarkModeOn], [isOnboardingShowing]
  static String appSettingsBox = 'appSettings';

  /// A boolean field of [appSettingsBox] box.
  static String isDarkModeOn = 'isDarkModeOn';

  /// A boolean field of [appSettingsBox] box.
  static String isOnboardingShowing = 'isOnboardingShowing';

  /// Encryption key to decrypt [serverInstallation] and [users] box.
  static String serverInstallationEncryptionKey = 'key';

  /// Server installation box. Contains server details and provider tokens.
  static String serverInstallation = 'appConfig';

  /// A List<String> field of [serverInstallation] box.
  static String rootKeys = 'rootKeys';

  /// A boolean field of [serverInstallation] box.
  static String hasFinalChecked = 'hasFinalChecked';

  /// A boolean field of [serverInstallation] box.
  static String isServerStarted = 'isServerStarted';

  /// A [ServerDomain] field of [serverInstallation] box.
  static String serverDomain = 'cloudFlareDomain';

  /// A String field of [serverInstallation] box.
  static String hetznerKey = 'hetznerKey';

  /// A String field of [serverInstallation] box.
  static String cloudFlareKey = 'cloudFlareKey';

  /// A [User] field of [serverInstallation] box.
  static String rootUser = 'rootUser';

  /// A [ServerHostingDetails] field of [serverInstallation] box.
  static String serverDetails = 'hetznerServer';

  /// A [BackblazeCredential] field of [serverInstallation] box.
  static String backblazeCredential = 'backblazeKey';

  /// A [BackblazeBucket] field of [serverInstallation] box.
  static String backblazeBucket = 'backblazeBucket';

  /// A boolean field of [serverInstallation] box.
  static String isLoading = 'isLoading';

  /// A boolean field of [serverInstallation] box.
  static String isServerResetedFirstTime = 'isServerResetedFirstTime';

  /// A boolean field of [serverInstallation] box.
  static String isServerResetedSecondTime = 'isServerResetedSecondTime';

  /// Deprecated users box as it is unencrypted
  static String usersDeprecated = 'users';

  /// Box with users
  static String users = 'usersEncrypted';
}
