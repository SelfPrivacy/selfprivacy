import 'package:hive/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';

class ApiConfigModel {
  Box _box = Hive.box(BNames.appConfig);

  ServerHostingDetails? get serverDetails => _serverDetails;
  String? get hetznerKey => _hetznerKey;
  String? get cloudFlareKey => _cloudFlareKey;
  BackblazeCredential? get backblazeCredential => _backblazeCredential;
  ServerDomain? get serverDomain => _serverDomain;
  BackblazeBucket? get backblazeBucket => _backblazeBucket;

  String? _hetznerKey;
  String? _cloudFlareKey;
  ServerHostingDetails? _serverDetails;
  BackblazeCredential? _backblazeCredential;
  ServerDomain? _serverDomain;
  BackblazeBucket? _backblazeBucket;

  Future<void> storeHetznerKey(String value) async {
    await _box.put(BNames.hetznerKey, value);
    _hetznerKey = value;
  }

  Future<void> storeCloudFlareKey(String value) async {
    await _box.put(BNames.cloudFlareKey, value);
    _cloudFlareKey = value;
  }

  Future<void> storeBackblazeCredential(BackblazeCredential value) async {
    await _box.put(BNames.backblazeKey, value);

    _backblazeCredential = value;
  }

  Future<void> storeServerDomain(ServerDomain value) async {
    await _box.put(BNames.serverDomain, value);
    _serverDomain = value;
  }

  Future<void> storeServerDetails(ServerHostingDetails value) async {
    await _box.put(BNames.serverDetails, value);
    _serverDetails = value;
  }

  Future<void> storeBackblazeBucket(BackblazeBucket value) async {
    await _box.put(BNames.backblazeBucket, value);
    _backblazeBucket = value;
  }

  clear() {
    _hetznerKey = null;
    _cloudFlareKey = null;
    _backblazeCredential = null;
    _serverDomain = null;
    _serverDetails = null;
    _backblazeBucket = null;
  }

  void init() {
    _hetznerKey = _box.get(BNames.hetznerKey);

    _cloudFlareKey = _box.get(BNames.cloudFlareKey);
    _backblazeCredential = _box.get(BNames.backblazeKey);
    _serverDomain = _box.get(BNames.serverDomain);
    _serverDetails = _box.get(BNames.serverDetails);
    _backblazeBucket = _box.get(BNames.backblazeBucket);
  }
}
