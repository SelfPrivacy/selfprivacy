import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';
import 'package:timezone/data/latest.dart';

import '../../../../helpers/fixtures/system_settings_fixtures.dart';

void main() {
  setUpAll(initializeTimeZones);
  late StreamController<CachedValue<SystemSettings>?> source;
  late ServerDetailsCubit cubit;
  late Completer<List<ServerMetadataEntity>> metadata;
  late int requested;
  late int failures;

  setUp(() {
    source = StreamController.broadcast(sync: true);
    metadata = Completer();
    requested = 0;
    failures = 0;
    cubit = ServerDetailsCubit(
      onMetadataFailure: () => failures++,
      settings: source.stream,
      loadMetadata: () {
        requested++;
        return metadata.future;
      },
    );
  });
  tearDown(() async {
    await cubit.close();
    await source.close();
  });

  void publish() => source.add(CachedValue(data: aSystemSettings()));

  for (final unsupported in [false, true]) {
    test('initial settings failure settles: unsupported=$unsupported', () {
      source.add(
        CachedValue<SystemSettings>(
          support: unsupported
              ? DomainSupport.unsupported
              : DomainSupport.supported,
          lastError: unsupported ? null : StateError('unavailable'),
        ),
      );
      expect(cubit.state, isNot(isA<ServerDetailsLoading>()));
      expect(cubit.state, isNot(isA<Loaded>()));
      expect(
        (cubit.state as ServerDetailsUnavailable).isUnsupported,
        unsupported,
      );
    });
  }

  test(
    'settings updates share one metadata request and retain its immutable result',
    () async {
      publish();
      publish();
      expect(requested, 1);
      final input = [
        ServerMetadataEntity(trId: 'server.server_provider', value: 'Hetzner'),
      ];
      metadata.complete(input);
      await pumpEventQueue();
      final saved = cubit.state;
      input.clear();
      expect(saved.metadata.single.value, 'Hetzner');
      publish();
      expect(requested, 1);
      expect(cubit.state.metadata, saved.metadata);
    },
  );

  test('detachment rejects held metadata', () async {
    publish();
    source.add(null);
    metadata.complete([
      ServerMetadataEntity(trId: 'server.server_provider', value: 'old'),
    ]);
    await pumpEventQueue();
    expect(cubit.state, isA<ServerDetailsNotReady>());
    expect(cubit.state.metadata, isEmpty);
  });

  test('close discards metadata that is already in flight', () async {
    publish();
    await cubit.close();
    metadata.complete([]);
    await pumpEventQueue();
  });

  test(
    'a metadata failure retains loaded settings and permits explicit retry',
    () async {
      publish();
      final previous = cubit.state;
      metadata.completeError(Exception('provider unavailable'));
      await pumpEventQueue();
      expect(cubit.state, previous);
      expect(failures, 1);
      metadata = Completer();
      final retry = cubit.check();
      metadata.complete([
        ServerMetadataEntity(trId: 'server.server_provider', value: 'Hetzner'),
      ]);
      await retry;
      expect(cubit.state.metadata.single.value, 'Hetzner');
    },
  );
}
