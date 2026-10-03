import 'dart:async';

import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/sync/sync_scheduler.dart';

class DomainReader<T extends Object> {
  DomainReader({
    required this.store,
    required final DomainStore<Version> apiVersion,
    required final SyncScheduler dispatcher,
  }) : _apiVersion = apiVersion,
       _dispatcher = dispatcher;

  final DomainStore<T> store;
  final DomainStore<Version> _apiVersion;
  final SyncScheduler _dispatcher;

  CachedValue<T> get value {
    final error = _apiVersion.value.lastError;
    return error == null
        ? store.value
        : store.value.copyWith(lastError: () => error);
  }

  Stream<CachedValue<T>> get changes => Stream.multi((final output) {
    var previous = (store.value, _apiVersion.value.lastError);
    void publish() {
      final current = (store.value, _apiVersion.value.lastError);
      if (!store.isDisposed && current != previous) {
        previous = current;
        output.addSync(value);
      }
    }

    final domain = store.stream.listen((_) => publish(), onDone: output.close);
    final version = _apiVersion.stream.listen((_) => publish());
    output.onCancel = () async {
      await domain.cancel();
      await version.cancel();
    };
  });

  Future<RefreshResult> refresh({final bool force = false}) =>
      _dispatcher.refresh(store, force: force);
}
