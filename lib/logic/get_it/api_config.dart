import 'package:hive/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

class ApiConfigModel {
  final Box _box = Hive.box(BNames.serverInstallationBox);

  ServerHostingDetails? get serverDetails => _serverDetails;
  String? get serverProviderKey => _serverProviderKey;
  String? get serverLocation => _serverLocation;
  String? get serverType => _serverType;
  String? get dnsProviderKey => _dnsProviderKey;
  ServerProviderType? get serverProvider => _serverProvider;
  DnsProviderType? get dnsProvider => _dnsProvider;

  BackupsCredential? get backblazeCredential => _backblazeCredential;
  ServerDomain? get serverDomain => _serverDomain;
  BackblazeBucket? get backblazeBucket => _backblazeBucket;

  static const localeCodeFallback = 'en';
  String? _localeCode;
  String get localeCode => _localeCode ?? localeCodeFallback;
  Future<void> setLocaleCode(final String value) async => _localeCode = value;
  Future<void> resetLocaleCode() async => _localeCode = null;

  String? _serverProviderKey;
  String? _serverLocation;
  String? _dnsProviderKey;
  String? _serverType;
  ServerProviderType? _serverProvider;
  DnsProviderType? _dnsProvider;
  ServerHostingDetails? _serverDetails;
  BackupsCredential? _backblazeCredential;
  ServerDomain? _serverDomain;
  BackblazeBucket? _backblazeBucket;

  Future<void> storeServerProviderType(final ServerProviderType value) async {
    await _box.put(BNames.serverProvider, value);
    _serverProvider = value;
  }

  Future<void> setDnsProviderType(final DnsProviderType value) async {
    await _box.put(BNames.dnsProvider, value);
    _dnsProvider = value;
  }

  Future<void> setServerProviderKey(final String value) async {
    await _box.put(BNames.hetznerKey, value);
    _serverProviderKey = value;
  }

  Future<void> setDnsProviderKey(final String value) async {
    await _box.put(BNames.cloudFlareKey, value);
    _dnsProviderKey = value;
  }

  Future<void> setServerTypeIdentifier(final String typeIdentifier) async {
    await _box.put(BNames.serverTypeIdentifier, typeIdentifier);
    _serverType = typeIdentifier;
  }

  Future<void> setServerLocation(final String serverLocation) async {
    await _box.put(BNames.serverLocation, serverLocation);
    _serverLocation = serverLocation;
  }

  Future<void> setBackblazeCredential(final BackupsCredential value) async {
    await _box.put(BNames.backblazeCredential, value);
    _backblazeCredential = value;
  }

  Future<void> setServerDomain(final ServerDomain value) async {
    await _box.put(BNames.serverDomain, value);
    _serverDomain = value;
  }

  Future<void> setServerDetails(final ServerHostingDetails value) async {
    await _box.put(BNames.serverDetails, value);
    _serverDetails = value;
  }

  Future<void> setBackblazeBucket(final BackblazeBucket value) async {
    await _box.put(BNames.backblazeBucket, value);
    _backblazeBucket = value;
  }

  void clear() {
    _serverProviderKey = null;
    _dnsProvider = null;
    _serverLocation = null;
    _dnsProviderKey = null;
    _backblazeCredential = null;
    _serverDomain = null;
    _serverDetails = null;
    _backblazeBucket = null;
    _serverType = null;
    _serverProvider = null;
  }

  Future<void> init() async {
    _serverProviderKey = _box.get(BNames.hetznerKey);
    _serverLocation = _box.get(BNames.serverLocation);
    _dnsProviderKey = _box.get(BNames.cloudFlareKey);
    _backblazeCredential = _box.get(BNames.backblazeCredential);
    _serverDomain = _box.get(BNames.serverDomain);
    _serverDetails = _box.get(BNames.serverDetails);
    _backblazeBucket = _box.get(BNames.backblazeBucket);
    _serverType = _box.get(BNames.serverTypeIdentifier);
    _serverProvider = _box.get(BNames.serverProvider);
    _dnsProvider = _box.get(BNames.dnsProvider);
  }
}
