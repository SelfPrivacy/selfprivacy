import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:selfprivacy/logic/models/backblaze_credential.dart';
import 'package:selfprivacy/logic/models/cloudflare_domain.dart';
import 'package:selfprivacy/logic/models/server_details.dart';
import 'package:selfprivacy/logic/models/user.dart';

class HiveConfig {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(HetznerServerDetailsAdapter());
    Hive.registerAdapter(CloudFlareDomainAdapter());
    Hive.registerAdapter(BackblazeCredentialAdapter());

    await Hive.openBox(BNames.appSettings);
    var cipher = HiveAesCipher(await getEncriptedKey());

    await Hive.openBox(BNames.appConfig, encryptionCipher: cipher);
  }

  static Future<Uint8List> getEncriptedKey() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    var containsEncryptionKey =
        await secureStorage.containsKey(key: BNames.key);
    if (!containsEncryptionKey) {
      var key = Hive.generateSecureKey();
      await secureStorage.write(key: BNames.key, value: base64UrlEncode(key));
    }

    String? string = await secureStorage.read(key: BNames.key);
    return base64Url.decode(string!);
  }
}

class BNames {
  static String appConfig = 'appConfig';
  static String isDarkModeOn = 'isDarkModeOn';
  static String isOnbordingShowing = 'isOnbordingShowing';

  static String appSettings = 'appSettings';

  static String key = 'key';

  static String cloudFlareDomain = 'cloudFlareDomain';
  static String hetznerKey = 'hetznerKey';
  static String cloudFlareKey = 'cloudFlareKey';
  static String rootUser = 'rootUser';
  static String hetznerServer = 'hetznerServer';
  static String hasFinalChecked = 'hasFinalChecked';
  static String isServerStarted = 'isServerStarted';
  static String backblazeKey = 'backblazeKey';
  static String isLoading = 'isLoading';
  static String isServerReseted = 'isServerReseted';
}
