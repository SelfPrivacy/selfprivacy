// ignore_for_file: avoid_dynamic_calls

import 'dart:async';

import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/hive/wizards_data/server_installation_wizard_data.dart';

sealed class ResourcesModelEvent {
  const ResourcesModelEvent();
}

class ResourcesModelLoaded extends ResourcesModelEvent {
  const ResourcesModelLoaded();
}

class ChangedServerProviderCredentials extends ResourcesModelEvent {
  const ChangedServerProviderCredentials();
}

class ChangedDnsProviderCredentials extends ResourcesModelEvent {
  const ChangedDnsProviderCredentials();
}

class ChangedBackupsCredentials extends ResourcesModelEvent {
  const ChangedBackupsCredentials();
}

class ChangedServers extends ResourcesModelEvent {
  const ChangedServers();
}

class ClearedModel extends ResourcesModelEvent {
  const ClearedModel();
}

class ResourcesModel {
  final Box _box = Hive.box(BNames.resourcesBox);

  final _statusStreamController =
      StreamController<ResourcesModelEvent>.broadcast();

  Stream<ResourcesModelEvent> get statusStream =>
      _statusStreamController.stream;

  List<ServerProviderCredential> get serverProviderCredentials =>
      _serverProviderTokens;
  List<DnsProviderCredential> get dnsProviderCredentials => _dnsProviderTokens;
  List<BackupsCredential> get backupsCredentials => _backupsCredentials;
  List<Server> get servers => _servers;
  BackblazeBucket? get backblazeBucket => _backblazeBucket;

  List<ServerProviderCredential> _serverProviderTokens = [];
  List<DnsProviderCredential> _dnsProviderTokens = [];
  List<BackupsCredential> _backupsCredentials = [];
  List<Server> _servers = [];
  // TODO(inex): As we will add support for other backup storages, we should
  // refactor this.
  BackblazeBucket? _backblazeBucket;

  @Deprecated('Compatibility getter')
  ServerHostingDetails? get serverDetails =>
      _servers.firstOrNull?.hostingDetails;
  @Deprecated('Compatibility getter')
  String? get serverProviderKey => _serverProviderTokens.firstOrNull?.token;
  @Deprecated('Compatibility getter')
  String? get serverLocation =>
      _servers.firstOrNull?.hostingDetails.serverLocation;
  @Deprecated('Compatibility getter')
  String? get serverType => _servers.firstOrNull?.hostingDetails.serverType;
  @Deprecated('Compatibility getter')
  String? get dnsProviderKey => _dnsProviderTokens.firstOrNull?.token;
  @Deprecated('Compatibility getter')
  ServerProviderType? get serverProvider =>
      _serverProviderTokens.firstOrNull?.provider;
  @Deprecated('Compatibility getter')
  DnsProviderType? get dnsProvider => _dnsProviderTokens.firstOrNull?.provider;
  @Deprecated('Compatibility getter')
  BackupsCredential? get backblazeCredential => _backupsCredentials.firstOrNull;
  @Deprecated('Compatibility getter')
  ServerDomain? get serverDomain => _servers.firstOrNull?.domain;

  Future<void> addServerProviderToken(
    final ServerProviderCredential token,
  ) async {
    _serverProviderTokens.add(token);
    await _box.put(BNames.serverProviderTokens, _serverProviderTokens);
    await _box.flush();
    _statusStreamController.add(const ChangedServerProviderCredentials());
  }

  Future<void> associateServerWithToken(
    final int serverId,
    final String token,
  ) async {
    _serverProviderTokens
        .firstWhere((final credential) => credential.token == token)
        .associatedServerIds
        .add(serverId);
    await _box.put(BNames.serverProviderTokens, _serverProviderTokens);
    await _box.flush();
    _statusStreamController.add(const ChangedServerProviderCredentials());
  }

  Future<void> removeServerProviderToken(
    final ServerProviderCredential token,
  ) async {
    _serverProviderTokens.remove(token);
    await _box.put(BNames.serverProviderTokens, _serverProviderTokens);
    await _box.flush();
    _statusStreamController.add(const ChangedServerProviderCredentials());
  }

  Future<void> addDnsProviderToken(final DnsProviderCredential token) async {
    // Check if this token already exists
    if (_dnsProviderTokens.any(
      (final credential) => credential.token == token.token,
    )) {
      throw Exception('Token already exists');
    }
    _dnsProviderTokens.add(token);
    await _box.put(BNames.dnsProviderTokens, _dnsProviderTokens);
    await _box.flush();
    _statusStreamController.add(const ChangedDnsProviderCredentials());
  }

  Future<void> associateDomainWithToken(
    final String domain,
    final String token,
  ) async {
    _dnsProviderTokens
        .firstWhere((final credential) => credential.token == token)
        .associatedDomainNames
        .add(domain);
    await _box.put(BNames.dnsProviderTokens, _dnsProviderTokens);
    await _box.flush();
    _statusStreamController.add(const ChangedDnsProviderCredentials());
  }

  Future<void> removeDnsProviderToken(final DnsProviderCredential token) async {
    _dnsProviderTokens.remove(token);
    await _box.put(BNames.dnsProviderTokens, _dnsProviderTokens);
    await _box.flush();
    _statusStreamController.add(const ChangedDnsProviderCredentials());
  }

  Future<void> addBackupsCredential(final BackupsCredential credential) async {
    _backupsCredentials.add(credential);
    await _box.put(BNames.backupsProviderTokens, _backupsCredentials);
    await _box.flush();
    _statusStreamController.add(const ChangedBackupsCredentials());
  }

  Future<void> removeBackupsCredential(
    final BackupsCredential credential,
  ) async {
    _backupsCredentials.remove(credential);
    await _box.put(BNames.backupsProviderTokens, _backupsCredentials);
    await _box.flush();
    _statusStreamController.add(const ChangedBackupsCredentials());
  }

  Future<void> addServer(final Server server) async {
    _servers.add(server);
    await _box.put(BNames.servers, _servers);
    await _box.flush();
    _statusStreamController.add(const ChangedServers());
  }

  Future<void> removeServer(final Server server) async {
    _servers.remove(server);
    await _box.put(BNames.servers, _servers);
    await _box.flush();
    _statusStreamController.add(const ChangedServers());
  }

  Future<void> updateServerByDomain(final Server server) async {
    final index = _servers.indexWhere(
      (final s) => s.domain.domainName == server.domain.domainName,
    );
    if (index != -1) {
      _servers[index] = server;
      await _box.put(BNames.servers, _servers);
      await _box.flush();
      _statusStreamController.add(const ChangedServers());
    }
  }

  Future<void> setBackblazeBucket(final BackblazeBucket bucket) async {
    _backblazeBucket = bucket;
    await _box.put(BNames.backblazeBucket, _backblazeBucket);
    await _box.flush();
  }

  Future<void> removeBackblazeBucket() async {
    _backblazeBucket = null;
    await _box.delete(BNames.backblazeBucket);
    await _box.flush();
  }

  Future<void> clear() async {
    _servers.clear();
    _serverProviderTokens.clear();
    _dnsProviderTokens.clear();
    _backupsCredentials.clear();
    _backblazeBucket = null;

    await _box.clear();
    await _box.compact();

    _statusStreamController.add(const ClearedModel());
  }

  Future<void> dispose() async {
    await _statusStreamController.close();
  }

  void init() {
    _serverProviderTokens =
        _box
            .get(
              BNames.serverProviderTokens,
              defaultValue: <ServerProviderCredential>[],
            )
            .map<ServerProviderCredential>(
              (final e) => e as ServerProviderCredential,
            )
            .toList();
    _dnsProviderTokens =
        _box
            .get(
              BNames.dnsProviderTokens,
              defaultValue: <DnsProviderCredential>[],
            )
            .map<DnsProviderCredential>((final e) => e as DnsProviderCredential)
            .toList();
    _backupsCredentials =
        _box
            .get(
              BNames.backupsProviderTokens,
              defaultValue: <BackupsCredential>[],
            )
            .map<BackupsCredential>((final e) => e as BackupsCredential)
            .toList();
    _servers =
        _box
            .get(BNames.servers, defaultValue: <Server>[])
            .map<Server>((final e) => e as Server)
            .toList();
    _backblazeBucket = _box.get(BNames.backblazeBucket);

    _statusStreamController.add(const ResourcesModelLoaded());
  }
}

class WizardDataModel {
  final Box _box = Hive.box(BNames.wizardDataBox);

  ServerInstallationWizardData? get serverInstallation => _serverInstallation;

  ServerInstallationWizardData? _serverInstallation;

  Future<void> setServerProviderType(final ServerProviderType provider) async {
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(serverProviderType: provider);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> setServerProviderKey(final String key) async {
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(serverProviderKey: key);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> setDnsProviderType(final DnsProviderType provider) async {
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(dnsProviderType: provider);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> setDnsProviderKey(final String key) async {
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(dnsProviderKey: key);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> setServerTypeIdentifier(final String identifier) async {
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(serverTypeIdentifier: identifier);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> setServerLocation(final String location) async {
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(serverLocation: location);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> moveServerTypeToServerDetails() async {
    final details = _serverInstallation?.serverDetails;
    if (details != null) {
      if (_serverInstallation?.serverTypeIdentifier != null &&
          _serverInstallation?.serverLocation != null) {
        _serverInstallation = _serverInstallation?.copyWith(
          serverDetails:
              () => details.copyWith(
                serverType: _serverInstallation?.serverTypeIdentifier,
                serverLocation: _serverInstallation?.serverLocation,
              ),
        );
        await _box.put(
          BNames.serverInstallationWizardData,
          _serverInstallation,
        );
      }
    }
  }

  Future<void> setServerDetails(final ServerHostingDetails details) async {
    final detailsWithServerType = details.copyWith(
      serverLocation: _serverInstallation?.serverLocation,
      serverType: _serverInstallation?.serverTypeIdentifier,
    );
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(serverDetails: () => detailsWithServerType);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> deleteServerDetails() async {
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(serverDetails: () => null);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> setBackupsCredential(final BackupsCredential credential) async {
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(backupsCredential: credential);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> setServerDomain(final ServerDomain domain) async {
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(serverDomain: () => domain);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> deleteServerDomain() async {
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(serverDomain: () => null);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> setIsServerStarted({required final bool isStarted}) async {
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(isServerStarted: isStarted);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> setIsServerRebootedFirstTime({
    required final bool isRebooted,
  }) async {
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(isServerResetedFirstTime: isRebooted);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> setIsServerRebootedSecondTime({
    required final bool isRebooted,
  }) async {
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(isServerResetedSecondTime: isRebooted);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> setRootUser(final User user) async {
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(rootUser: user);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> setIsRecoveringServer({required final bool isRecovering}) async {
    _serverInstallation = (_serverInstallation ??
            ServerInstallationWizardData.empty())
        .copyWith(isRecoveringServer: isRecovering);
    await _box.put(BNames.serverInstallationWizardData, _serverInstallation);
  }

  Future<void> clearServerInstallation() async {
    _serverInstallation = null;
    await _box.delete(BNames.serverInstallationWizardData);
  }

  Future<void> clear() async {
    await _box.clear();
    await _box.compact();
  }

  void init() {
    _serverInstallation = _box.get(
      BNames.serverInstallationWizardData,
      defaultValue: null,
    );
  }
}
