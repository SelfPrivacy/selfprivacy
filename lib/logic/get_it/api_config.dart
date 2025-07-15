import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';

class ApiConfigModel {
  final Box _box = Hive.box(BNames.serverInstallationBox);

  static const localeCodeFallback = 'en';
  String? _localeCode;

  String get localeCode => _localeCode ?? localeCodeFallback;
  Future<void> setLocaleCode(final String value) async => _localeCode = value;
  Future<void> resetLocaleCode() async => _localeCode = null;

  Future<void> setBackblazeBucket(final BackblazeBucket value) async {
    await _box.put(BNames.backblazeBucket, value);
  }
}
