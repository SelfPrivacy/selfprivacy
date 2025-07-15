import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:selfprivacy/utils/app_logger.dart';

class SecureStorage {
  static final logger = const AppLogger(name: 'secure_storage').log;

  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  static String keyName = 'key';

  static Future<Uint8List?> getKey() async {
    try {
      final bool hasEncryptionKey = await secureStorage.containsKey(
        key: keyName,
      );
      if (!hasEncryptionKey) {
        return null;
      }
      final String? string = await secureStorage.read(key: keyName);
      logger('successfully got encryption key: $string');

      return base64Url.decode(string!);
    } catch (error, stackTrace) {
      logger(
        'error reading encryption key',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  static Future<void> setKey(final List<int> key) async {
    try {
      final value = base64UrlEncode(key);
      await secureStorage.write(key: keyName, value: value);
      logger('successfully saved encryption key: $value');
    } catch (error, stackTrace) {
      logger(
        'error saving new encryption key',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
