import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/bloc/outdated_server_checker/outdated_server_checker_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';

void main() {
  late StreamController<ConnectionObservation<CachedValue<Version>>> source;
  late OutdatedServerCheckerBloc bloc;
  late ServerStateOrigin origin;

  setUp(() {
    source = StreamController.broadcast(sync: true);
    origin = ServerStateOrigin('server');
    bloc = OutdatedServerCheckerBloc(versions: source.stream);
  });
  tearDown(() async {
    await bloc.close();
    await source.close();
  });

  test('checks the observed version against the required version', () async {
    source.add(
      ConnectionObservation.attached(
        origin,
        CachedValue(data: Version(3, 8, 2)),
      ),
    );
    await pumpEventQueue();
    expect(bloc.state, OutdatedServerCheckerOutdated(Version(3, 8, 2)));
    source.add(
      ConnectionObservation.attached(
        origin,
        CachedValue(data: Version(3, 8, 3)),
      ),
    );
    await pumpEventQueue();
    expect(bloc.state, OutdatedServerCheckerUpToDate(Version(3, 8, 3)));
  });

  test(
    'a retained version survives refresh failure, but not removal',
    () async {
      source.add(
        ConnectionObservation.attached(
          origin,
          CachedValue(data: Version(3, 8, 3), lastError: StateError('offline')),
        ),
      );
      await pumpEventQueue();
      expect(bloc.state, isA<OutdatedServerCheckerUpToDate>());
      source.add(const ConnectionObservation.absent());
      await pumpEventQueue();
      expect(bloc.state, isA<OutdatedServerCheckerInitial>());
    },
  );
}
