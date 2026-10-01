import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_repository.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/utils/app_logger.dart';

part 'metrics_state.dart';

class MetricsCubit extends Cubit<MetricsState> {
  MetricsCubit({final MetricsRepository? repository})
    : repository = repository ?? MetricsRepository(),
      super(const MetricsLoading(Period.day)) {
    _connectionChanges = getIt<ApiConnectionRepository>().hub.changes.listen((
      _,
    ) {
      if (!getIt<ApiConnectionRepository>().hub.canRead) {
        closeTimer();
      } else if (timer == null && !_loading) {
        unawaited(load(state.period));
      }
    });
  }

  final MetricsRepository repository;

  Timer? timer;
  StreamSubscription<void>? _connectionChanges;
  bool _loading = false;
  Period _requestedPeriod = Period.day;

  static final logger = const AppLogger(name: 'metrics_cubit').log;

  @override
  Future<void> close() {
    closeTimer();
    unawaited(_connectionChanges?.cancel());
    return super.close();
  }

  void closeTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    timer = null;
  }

  Future<void> changePeriod(final Period period) async {
    if (!isClosed && period != _requestedPeriod) {
      closeTimer();
      emit(MetricsLoading(period));
      await load(period);
    }
  }

  void restart() {
    unawaited(load(state.period));
  }

  Future<void> load(final Period period) async {
    _requestedPeriod = period;
    final hub = getIt<ApiConnectionRepository>().hub;
    if (isClosed || _loading || !hub.canRead) {
      return;
    }
    final owner = hub.active;
    _loading = true;
    closeTimer();
    try {
      final MetricsStateUpdate newStateUpdate = await repository
          .getRelevantServerMetrics(period);

      int duration = newStateUpdate.nextCheckInSeconds;
      if (duration <= 0) {
        duration = state.period.stepPeriodInSeconds;
      }
      if (!isClosed &&
          (owner?.isAttached ?? false) &&
          hub.canRead &&
          period == _requestedPeriod) {
        timer = Timer(Duration(seconds: duration), () => load(period));
        emit(newStateUpdate.newState);
      }
    } on StateError {
      logger('Tried to emit metrics when cubit is closed');
    } finally {
      _loading = false;
      if (!isClosed &&
          hub.canRead &&
          (period != _requestedPeriod || owner?.isAttached != true)) {
        unawaited(load(_requestedPeriod));
      }
    }
  }
}
