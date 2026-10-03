import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';

part 'outdated_server_checker_event.dart';
part 'outdated_server_checker_state.dart';

const String requiredServerVersion = '>=3.8.3';

class OutdatedServerCheckerBloc
    extends Bloc<OutdatedServerCheckerEvent, OutdatedServerCheckerState> {
  OutdatedServerCheckerBloc({
    required final Stream<ConnectionObservation<CachedValue<Version>>> versions,
  }) : super(OutdatedServerCheckerInitial()) {
    on<_ServerApiVersionObserved>((final event, final emit) {
      if (!identical(event.observation.origin, _latest?.origin)) {
        return;
      }
      final currentVersion = event.observation.value?.data;
      if (currentVersion == null) {
        emit(OutdatedServerCheckerInitial());
      } else if (VersionConstraint.parse(
        requiredServerVersion,
      ).allows(currentVersion)) {
        emit(OutdatedServerCheckerUpToDate(currentVersion));
      } else {
        emit(OutdatedServerCheckerOutdated(currentVersion));
      }
    });
    _subscription = versions.listen((final observation) {
      _latest = observation;
      add(_ServerApiVersionObserved(observation));
    });
  }

  late final StreamSubscription<ConnectionObservation<CachedValue<Version>>>
  _subscription;
  ConnectionObservation<CachedValue<Version>>? _latest;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
