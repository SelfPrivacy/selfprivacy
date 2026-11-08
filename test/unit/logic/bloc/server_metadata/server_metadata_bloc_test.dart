import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/bloc/server_metadata/server_metadata_bloc.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';

void main() {
  late StreamController<void> source;
  late ServerMetadataBloc bloc;
  late Completer<List<ServerMetadataEntity>> metadata;
  late bool attached;
  late int requests;
  late int failures;

  setUp(() {
    source = StreamController.broadcast();
    metadata = Completer();
    attached = true;
    requests = 0;
    failures = 0;
    bloc = ServerMetadataBloc(
      onFailure: () => failures++,
      isAttached: () => attached,
      connectionChanges: source.stream,
      loadMetadata: () {
        requests++;
        return metadata.future;
      },
    );
  });
  tearDown(() async {
    if (!metadata.isCompleted) {
      metadata.complete([]);
    }
    await bloc.close();
    await source.close();
  });

  test('metadata loads without settings and owns its result', () async {
    expect(bloc.state, isA<ServerMetadataLoading>());
    await pumpEventQueue();
    expect(requests, 1);
    final input = [
      ServerMetadataEntity(trId: 'server.server_provider', value: 'Hetzner'),
    ];
    metadata.complete(input);
    await pumpEventQueue();
    input.clear();
    expect(bloc.state.metadata.single.value, 'Hetzner');
    expect(bloc.state, isA<ServerMetadataLoaded>());
  });

  test('detachment rejects held metadata', () async {
    await pumpEventQueue();
    attached = false;
    source.add(null);
    metadata.complete([
      ServerMetadataEntity(trId: 'server.server_provider', value: 'old'),
    ]);
    await pumpEventQueue();
    expect(bloc.state, isA<ServerMetadataDetached>());
    expect(bloc.state.metadata, isEmpty);
  });

  test('close discards held metadata', () async {
    await pumpEventQueue();
    final closing = bloc.close();
    metadata.complete([]);
    await closing;
    expect(bloc.isClosed, true);
  });

  test('provider failure settles and permits explicit retry', () async {
    await pumpEventQueue();
    metadata.completeError(Exception('provider unavailable'));
    await pumpEventQueue();
    expect(bloc.state, isA<ServerMetadataFailed>());
    expect(failures, 1);
    metadata = Completer();
    bloc.add(const ServerMetadataRequested());
    await pumpEventQueue();
    expect(bloc.state, isA<ServerMetadataLoading>());
    metadata.complete([
      ServerMetadataEntity(trId: 'server.server_provider', value: 'Hetzner'),
    ]);
    await pumpEventQueue();
    expect(bloc.state.metadata.single.value, 'Hetzner');
    expect(bloc.state, isA<ServerMetadataLoaded>());
  });

  test('refresh failure retains metadata and can recover', () async {
    metadata.complete([
      ServerMetadataEntity(trId: 'server.server_provider', value: 'Hetzner'),
    ]);
    await pumpEventQueue();
    metadata = Completer();
    bloc.add(const ServerMetadataRequested());
    await pumpEventQueue();
    expect(bloc.state, isA<ServerMetadataLoading>());
    expect(bloc.state.metadata.single.value, 'Hetzner');
    metadata.completeError(Exception('offline'));
    await pumpEventQueue();
    expect(bloc.state, isA<ServerMetadataFailed>());
    expect(bloc.state.metadata.single.value, 'Hetzner');
    metadata = Completer();
    bloc.add(const ServerMetadataRequested());
    await pumpEventQueue();
    metadata.complete([
      ServerMetadataEntity(trId: 'server.server_provider', value: 'new'),
    ]);
    await pumpEventQueue();
    expect(bloc.state, isA<ServerMetadataLoaded>());
    expect(bloc.state.metadata.single.value, 'new');
  });
}
