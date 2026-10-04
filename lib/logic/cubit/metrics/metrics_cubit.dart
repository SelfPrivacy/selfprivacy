import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_repository.dart';
import 'package:selfprivacy/logic/models/metrics.dart';

part 'metrics_state.dart';

class MetricsCubit extends Cubit<MetricsState> {
  MetricsCubit({
    required final Stream<bool?> access,
    required final Future<MetricsStateUpdate> Function(Period) loadMetrics,
  }) : _loadMetrics = loadMetrics,
       super(const MetricsLoading(Period.day)) {
    _connectionChanges = access.listen((final observation) {
      _access = observation;
      _accessRevision++;
      if (!_canRead) {
        closeTimer();
      } else if (timer == null && _inFlight == null) {
        unawaited(load(_requestedPeriod));
      }
    });
  }

  final Future<MetricsStateUpdate> Function(Period) _loadMetrics;
  late final StreamSubscription<bool?> _connectionChanges;
  bool? _access;
  int _accessRevision = 0;
  Object? _inFlight;
  Timer? timer;
  Period _requestedPeriod = Period.day;
  bool get _canRead => !isClosed && (_access ?? false);

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
    final revision = _accessRevision;
    final request = Object();
    var deferred = false;
    _inFlight = request;
    closeTimer();
    try {
      final update = await _loadMetrics(period);
      if (_canRead && period == _requestedPeriod) {
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
                (deferred && revision != _accessRevision))) {
          unawaited(load(_requestedPeriod));
        }
      }
    }
  }
}
