import 'dart:async';

import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/connection/cached_value.dart';
import 'package:selfprivacy/logic/connection/domain_store.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/logic/models/json/recovery_token_status.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';

/// Owns the stores for one server, but does not own its API transport.
///
/// Construction does not fetch data. Refresh [apiVersion] before other stores
/// to establish which domains the server supports.
class ServerStateCache {
  ServerStateCache({
    required final ServerApi api,
    final DateTime Function()? now,
    final CacheTimerFactory? createTimer,
    final Map<String, Duration> staleAfterOverrides = const {},
  }) {
    DomainStore<T> domain<T extends Object>({
      required final String name,
      required final Future<T> Function() fetch,
      final int refreshSeconds = 60,
      final String requiredApiVersion = '>=2.3.0',
    }) {
      final store = DomainStore<T>(
        name: name,
        fetch: fetch,
        refreshInterval: Duration(seconds: refreshSeconds),
        staleAfter: staleAfterOverrides[name],
        now: now,
        createTimer: createTimer,
      );
      _constraints[store] = VersionConstraint.parse(requiredApiVersion);
      return store;
    }

    apiVersion = DomainStore<Version>(
      name: 'apiVersion',
      fetch: () async => Version.parse(await api.fetchApiVersion()),
      refreshInterval: const Duration(seconds: 60),
      staleAfter: staleAfterOverrides['apiVersion'],
      support: DomainSupport.supported,
      now: now,
      createTimer: createTimer,
    );
    serverJobs = domain(
      name: 'serverJobs',
      fetch: api.getServerJobs,
      refreshSeconds: 10,
    );
    backupConfig = domain(
      name: 'backupConfig',
      fetch: api.getBackupsConfiguration,
      refreshSeconds: 120,
      requiredApiVersion: '>=2.4.2',
    );
    backups = domain(
      name: 'backups',
      fetch: api.getBackups,
      refreshSeconds: 120,
      requiredApiVersion: '>=2.4.2',
    );
    services = domain(
      name: 'services',
      fetch: api.getAllServices,
      requiredApiVersion: '>=2.4.3',
    );
    volumes = domain(name: 'volumes', fetch: api.getServerDiskVolumes);
    recoveryKeyStatus = domain(
      name: 'recoveryKeyStatus',
      fetch: api.getRecoveryTokenStatus,
      refreshSeconds: 300,
    );
    devices = domain(name: 'devices', fetch: api.getApiTokens);
    users = domain(name: 'users', fetch: api.getAllUsers);
    groups = domain(
      name: 'groups',
      fetch: api.getAllGroups,
      requiredApiVersion: '>=3.6.0',
    );
    settings = domain(
      name: 'settings',
      fetch: api.getSystemSettings,
      refreshSeconds: 600,
    );
    stores = List.unmodifiable([apiVersion, ..._constraints.keys]);
    final names = stores.map((final store) => store.name).toSet();
    final unknownOverrides = staleAfterOverrides.keys.toSet().difference(names);
    if (unknownOverrides.isNotEmpty) {
      throw ArgumentError.value(unknownOverrides, 'staleAfterOverrides');
    }
    _versionSubscription = apiVersion.stream.listen((_) => _updateSupport());
  }

  late final DomainStore<Version> apiVersion;
  late final DomainStore<List<ServerJob>> serverJobs;
  late final DomainStore<BackupConfiguration> backupConfig;
  late final DomainStore<List<Backup>> backups;
  late final DomainStore<List<Service>> services;
  late final DomainStore<List<ServerDiskVolume>> volumes;
  late final DomainStore<RecoveryKeyStatus> recoveryKeyStatus;
  late final DomainStore<List<ApiToken>> devices;
  late final DomainStore<List<User>> users;
  late final DomainStore<List<String>> groups;
  late final DomainStore<SystemSettings> settings;

  /// Read-only registry for refresh, invalidation and lifecycle operations.
  /// Supply pushed data through the typed domain fields.
  late final List<DomainStore<Object>> stores;

  final _constraints = <DomainStore<Object>, VersionConstraint>{};
  late final StreamSubscription<CachedValue<Version>> _versionSubscription;
  Version? _supportedVersion;
  bool _disposed = false;

  void _updateSupport() {
    if (_disposed) {
      return;
    }
    final version = apiVersion.value.data;
    if (version == null || version == _supportedVersion) {
      return;
    }
    _supportedVersion = version;
    for (final entry in _constraints.entries) {
      entry.key.setSupport(
        entry.value.allows(version)
            ? DomainSupport.supported
            : DomainSupport.unsupported,
      );
    }
  }

  /// Disposes every store without closing the transport or waiting for I/O.
  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    unawaited(_versionSubscription.cancel());
    for (final store in stores) {
      store.dispose();
    }
  }
}
