import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_reader.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_reconciler.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

class JobsSnapshot extends Equatable {
  JobsSnapshot({required this.value, required final Iterable<ServerJob> jobs})
    : jobs = List.unmodifiable(jobs);

  final CachedValue<List<ServerJob>> value;
  final List<ServerJob> jobs;
  bool get isComplete => value.data != null;

  @override
  List<Object> get props => [value, jobs];
}

class JobsRepository {
  JobsRepository({
    required this.commands,
    required this.reader,
    required this.backupsStore,
    required this.servicesStore,
    required this.volumesStore,
    required final Iterable<DomainStore<Object>> stores,
  }) : _stores = List.unmodifiable(stores),
       _reconciler = JobsReconciler(store: reader.store, commands: commands) {
    _subscriptions
      ..add(store.stream.listen((_) => _trackCompletions()))
      ..add(_reconciler.changes.listen((_) => _trackCompletions()));
  }

  final ServerCommandCoordinator commands;
  final DomainReader<List<ServerJob>> reader;
  DomainStore<List<ServerJob>> get store => reader.store;
  final DomainStore<Object> backupsStore;
  final DomainStore<Object> servicesStore;
  final DomainStore<List<ServerDiskVolume>> volumesStore;
  final List<DomainStore<Object>> _stores;
  final JobsReconciler _reconciler;
  final _subscriptions = <StreamSubscription<Object?>>[];
  final _observed = <String, ServerJob>{};
  final _effects = <String, Set<DomainStore<Object>>>{};

  CachedValue<List<ServerJob>> get value => reader.value;
  JobsSnapshot get snapshot => JobsSnapshot(
    value: value,
    jobs: value.data ?? confirmedBeforeLoad.values,
  );
  Stream<JobsSnapshot> get changes => Stream<JobsSnapshot>.multi((
    final output,
  ) {
    void publish() {
      if (commands.isAttached) {
        output.add(snapshot);
      }
    }

    final reads = reader.changes.listen((_) => publish(), onDone: output.close);
    final accepted = _reconciler.changes.listen((_) => publish());
    output.onCancel = () async {
      await reads.cancel();
      await accepted.cancel();
    };
  }).distinct();
  Map<String, ServerJob> get confirmedBeforeLoad =>
      _reconciler.confirmedBeforeLoad;
  Future<RefreshResult> refresh({final bool force = false}) =>
      reader.refresh(force: force);

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

  void receiveVerifiedJob(final ServerJob job) {
    _reconciler.upsertConfirmed(job);
    _trackCompletions();
  }

  void _trackCompletions() {
    if (!commands.isAttached) {
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
      return [backupsStore, servicesStore];
    }
    if (type.contains('backup')) {
      return [backupsStore];
    }
    if (type.contains('move') || type.contains('migrate_to_binds')) {
      return [servicesStore, volumesStore];
    }
    if (type.contains('collect_garbage')) {
      return [volumesStore];
    }
    return _stores.where((final domain) => domain != store);
  }

  bool _finished(final ServerJob job) =>
      job.status == JobStatusEnum.finished || job.status == JobStatusEnum.error;

  Future<ServerMutationResult<void>> removeJob(final String uid) =>
      commands.mutate(
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
  ) => commands.mutate(
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
  Iterable<DomainStore<Object>> get _systemDomains sync* {
    yield store;
    yield* _stores.where(
      (final domain) =>
          domain != store && domain.value.support == DomainSupport.supported,
    );
  }

  Future<ServerMutationResult<ServerJob>> collectNixGarbage() =>
      _start((final api) => api.collectNixGarbage(), [store, volumesStore]);
  Future<ServerMutationResult<ServerJob>> migrateToBinds(
    final Map<String, String> serviceToDisk,
  ) {
    final submitted = Map<String, String>.unmodifiable(serviceToDisk);
    final fallbackDrive =
        volumesStore.value.data
            ?.where((final volume) => volume.root)
            .firstOrNull
            ?.name ??
        'sda1';
    return _start((final api) => api.migrateToBinds(submitted, fallbackDrive), [
      store,
      servicesStore,
      volumesStore,
    ]);
  }

  void dispose() {
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    _reconciler.dispose();
  }
}
