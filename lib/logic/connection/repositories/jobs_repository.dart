import 'dart:async';

import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_reconciler.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

class JobsRepository {
  JobsRepository({required this.connection, required this.store})
    : _reconciler = JobsReconciler(
        store: store,
        commands: connection.commands,
      ) {
    _subscriptions
      ..add(store.stream.listen((_) => _trackCompletions()))
      ..add(_reconciler.changes.listen((_) => _trackCompletions()));
  }

  final ServerConnection connection;
  final DomainStore<List<ServerJob>> store;
  final JobsReconciler _reconciler;
  final _subscriptions = <StreamSubscription<Object?>>[];
  final _observed = <String, ServerJob>{};
  final _effects = <String, Set<DomainStore<Object>>>{};
  CachedValue<List<ServerJob>> get value => connection.snapshot(store);
  Map<String, ServerJob> get confirmedBeforeLoad =>
      _reconciler.confirmedBeforeLoad;
  Future<RefreshResult> refresh({final bool force = false}) =>
      connection.refresh(store, force: force);

  void applyConfirmed(
    final ServerJob job, {
    final Iterable<DomainStore<Object>> affectedDomains = const [],
  }) {
    _reconciler.upsertConfirmed(job);
    _observed[job.uid] = job;
    _effects[job.uid] = affectedDomains
        .where((final domain) => domain != store)
        .toSet();
  }

  void receiveSnapshot(final Iterable<ServerJob> jobs) {
    _trackCompletions();
    _reconciler.receiveSnapshot(jobs);
    _trackCompletions();
  }

  void _trackCompletions() {
    if (!connection.isAttached) {
      return;
    }
    final after = [...?store.value.data, ...confirmedBeforeLoad.values];
    final completed = after
        .where(
          (final job) =>
              _finished(job) &&
              _observed[job.uid] != null &&
              !_finished(_observed[job.uid]!),
        )
        .toList();
    _observed.addEntries(after.map((final job) => MapEntry(job.uid, job)));
    final domains = <DomainStore<Object>>{};
    for (final job in completed) {
      final effects = _effects.remove(job.uid);
      domains.addAll(
        (effects?.isNotEmpty ?? false) ? effects! : _externalEffects(job),
      );
    }
    for (final domain in domains) {
      domain.invalidate();
    }
  }

  Iterable<DomainStore<Object>> _externalEffects(final ServerJob job) {
    final type = job.typeId;
    if (type.contains('restore')) {
      return [connection.backups.store, connection.services.store];
    }
    if (type.contains('backup')) {
      return [connection.backups.store];
    }
    if (type.contains('move') || type.contains('migrate_to_binds')) {
      return [connection.services.store, connection.volumesStore];
    }
    if (type.contains('collect_garbage')) {
      return [connection.volumesStore];
    }
    return connection.stores.where((final domain) => domain != store);
  }

  bool _finished(final ServerJob job) =>
      job.status == JobStatusEnum.finished || job.status == JobStatusEnum.error;

  Future<ServerMutationResult<void>> removeJob(final String uid) =>
      connection.mutate(
        domains: [store],
        send: (final api) => api.removeApiJob(uid),
        applyConfirmed: (_) {
          _reconciler.removeConfirmed(uid);
          _effects.remove(uid);
          _observed.remove(uid);
          return [store];
        },
      );

  Future<Map<String, ServerMutationResult<void>>> removeAllFinished() async {
    final ids = {
      ...?store.value.data?.where(_finished).map((final job) => job.uid),
      ...confirmedBeforeLoad.values
          .where(_finished)
          .map((final job) => job.uid),
    };
    final results = <String, ServerMutationResult<void>>{};
    for (final uid in ids) {
      results[uid] = await removeJob(uid);
    }
    return Map.unmodifiable(results);
  }

  Future<ServerMutationResult<ServerJob>> _start(
    final Future<ServerMutationResult<ServerJob>> Function(ServerApi) send,
    final Iterable<DomainStore<Object>> domains,
  ) => connection.mutate(
    domains: domains,
    send: send,
    applyConfirmed: (final result) {
      final job = result.payload.value;
      if (job == null) {
        return [];
      }
      applyConfirmed(job, affectedDomains: domains);
      return [store];
    },
  );

  Future<ServerMutationResult<ServerJob>> upgrade() =>
      _start((final api) => api.upgrade(), _systemDomains);
  Future<ServerMutationResult<ServerJob>> apply() =>
      _start((final api) => api.apply(), _systemDomains);
  Iterable<DomainStore<Object>> get _systemDomains => [
    store,
    ...connection.stores.where(
      (final domain) =>
          domain != store && domain.value.support == DomainSupport.supported,
    ),
  ];
  Future<ServerMutationResult<ServerJob>> collectNixGarbage() => _start(
    (final api) => api.collectNixGarbage(),
    [store, connection.volumesStore],
  );
  Future<ServerMutationResult<ServerJob>> migrateToBinds(
    final Map<String, String> serviceToDisk,
    final String fallbackDrive,
  ) {
    final submitted = Map<String, String>.unmodifiable(serviceToDisk);
    return _start((final api) => api.migrateToBinds(submitted, fallbackDrive), [
      store,
      connection.services.store,
      connection.volumesStore,
    ]);
  }

  void dispose() {
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    _reconciler.dispose();
  }
}
