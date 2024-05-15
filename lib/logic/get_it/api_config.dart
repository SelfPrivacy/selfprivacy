import 'package:hive/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';

class ApiConfigModel {
  final Box _box = Hive.box(BNames.serverInstallationBox);

  String? get localeCode => _localeCode;

  String? _localeCode;

  Future<void> setLocaleCode(final String value) async {
    _localeCode = value;
  }

  Future<void> setBackblazeBucket(final BackblazeBucket value) async {
    await _box.put(BNames.backblazeBucket, value);
  }

  void clear() {
    _localeCode = null;
  }

  void init() {
    _localeCode = 'en';
  }
}
