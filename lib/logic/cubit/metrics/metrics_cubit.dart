import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_repository.dart';
import 'package:selfprivacy/logic/models/metrics.dart';

part 'metrics_state.dart';

class MetricsCubit extends Cubit<MetricsState> {
  MetricsCubit({
    required final Stream<ConnectionObservation<bool>> access,
    required final Future<MetricsStateUpdate> Function(
      ServerStateOrigin,
      Period,
    )
    loadMetrics,
  }) : _loadMetrics = loadMetrics,
       super(const MetricsLoading(Period.day)) {
    _connectionChanges = access.listen((final observation) {
      final previous = _access;
      _access = observation;
      if (!identical(previous?.origin, observation.origin)) {
        _inFlight = null;
        closeTimer();
        if (!identical(
          previous?.origin?.continuity,
          observation.origin?.continuity,
        )) {
          emit(MetricsLoading(_requestedPeriod));
        }
      }
      if (!_canRead) {
        closeTimer();
      } else if (timer == null && _inFlight == null) {
        unawaited(load(_requestedPeriod));
      }
    });
  }

  final Future<MetricsStateUpdate> Function(ServerStateOrigin, Period)
  _loadMetrics;
  late final StreamSubscription<ConnectionObservation<bool>> _connectionChanges;
  ConnectionObservation<bool>? _access;
  Object? _inFlight;
  Timer? timer;
  Period _requestedPeriod = Period.day;
  bool get _canRead => !isClosed && (_access?.value ?? false);

  @override
  Future<void> close() {
    closeTimer();
    unawaited(_connectionChanges.cancel());
    return super.close();
  }

  void closeTimer() {
    timer?.cancel();
    timer = null;
  }

  Future<void> changePeriod(final Period period) async {
    if (!isClosed && period != _requestedPeriod) {
      closeTimer();
      emit(MetricsLoading(period));
      await load(period);
    }
  }

  void restart() => unawaited(load(state.period));

  Future<void> load(final Period period) async {
    _requestedPeriod = period;
    if (!_canRead || _inFlight != null) {
      return;
    }
    final access = _access!;
    final origin = access.origin!;
    final request = Object();
    var deferred = false;
    _inFlight = request;
    closeTimer();
    try {
      final update = await _loadMetrics(origin, period);
      if (_canRead &&
          identical(origin, _access?.origin) &&
          period == _requestedPeriod) {
        final delay = update.nextCheckInSeconds > 0
            ? update.nextCheckInSeconds
            : period.stepPeriodInSeconds;
        timer = Timer(Duration(seconds: delay), () => unawaited(load(period)));
        emit(update.newState);
      }
    } on GraphQLDispatchDeferred {
      deferred = true;
    } finally {
      if (identical(_inFlight, request)) {
        _inFlight = null;
        if (_canRead &&
            (period != _requestedPeriod ||
                (deferred && !identical(access, _access)))) {
          unawaited(load(_requestedPeriod));
        }
      }
    }
  }
}
