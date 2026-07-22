import 'dart:io';

import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';

Directory? _hiveTempDir;

Future<void> setUpInMemoryHive() async {
  _hiveTempDir = await Directory.systemTemp.createTemp('sp_hive_test_');
  Hive.init(_hiveTempDir!.path);
  if (!Hive.isAdapterRegistered(7)) {
    HiveConfig.registerAdapters();
  }
}

Future<void> tearDownInMemoryHive() async {
  await Hive.deleteFromDisk();
  final Directory? dir = _hiveTempDir;
  if (dir != null && dir.existsSync()) {
    await dir.delete(recursive: true);
  }
  _hiveTempDir = null;
}
