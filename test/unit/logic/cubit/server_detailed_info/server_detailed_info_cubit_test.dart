import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';
import 'package:timezone/data/latest.dart';

import '../../../../helpers/fixtures/system_settings_fixtures.dart';

void main() {
  setUpAll(initializeTimeZones);
  late StreamController<ConnectionObservation<CachedValue<SystemSettings>>>
  source;
  late ServerDetailsCubit cubit;
  late ServerStateOrigin origin;
  late Completer<List<ServerMetadataEntity>> metadata;
  late List<ServerStateOrigin> requested;
  late int failures;

  setUp(() {
    source = StreamController.broadcast(sync: true);
    origin = ServerStateOrigin('server');
    metadata = Completer();
    requested = [];
    failures = 0;
    cubit = ServerDetailsCubit(
      onMetadataFailure: () => failures++,
      settings: source.stream,
      loadMetadata: (final origin) {
        requested.add(origin);
        return metadata.future;
      },
    );
  });
  tearDown(() async {
    await cubit.close();
    await source.close();
  });

  void publish() => source.add(
    ConnectionObservation.attached(
      origin,
      CachedValue(data: aSystemSettings()),
    ),
  );

  for (final unsupported in [false, true]) {
    test('initial settings failure settles: unsupported=$unsupported', () {
      source.add(
        ConnectionObservation.attached(
          origin,
          CachedValue<SystemSettings>(
            support: unsupported
                ? DomainSupport.unsupported
                : DomainSupport.supported,
            lastError: unsupported ? null : StateError('unavailable'),
          ),
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
      expect(requested, [origin]);
      final input = [
        ServerMetadataEntity(trId: 'server.server_provider', value: 'Hetzner'),
      ];
      metadata.complete(input);
      await pumpEventQueue();
      final saved = cubit.state;
      input.clear();
      expect(saved.metadata.single.value, 'Hetzner');
      publish();
      expect(requested, hasLength(1));
      expect(cubit.state.metadata, saved.metadata);
    },
  );

  test(
    'reset rejects held metadata and permits a fresh same-UUID binding',
    () async {
      publish();
      source.add(const ConnectionObservation.absent());
      metadata.complete([
        ServerMetadataEntity(trId: 'server.server_provider', value: 'old'),
      ]);
      await pumpEventQueue();
      expect(cubit.state, isA<ServerDetailsNotReady>());
      expect(cubit.state.metadata, isEmpty);
      metadata = Completer();
      origin = ServerStateOrigin('server');
      publish();
      expect(requested, hasLength(2));
      expect(cubit.state.metadata, isEmpty);
      metadata.complete([]);
    },
  );

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
