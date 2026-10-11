import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(resetOnError: false),
  );
  static String keyName = 'key';

  static Future<Uint8List?> getKey() async {
    final bool hasEncryptionKey = await secureStorage.containsKey(key: keyName);
    if (!hasEncryptionKey) {
      return null;
    }
    final String? string = await secureStorage.read(key: keyName);

    return base64Url.decode(string!);
  }

  static Future<void> setKey(final List<int> key) async {
    final value = base64UrlEncode(key);
    await secureStorage.write(key: keyName, value: value);
  }
}
