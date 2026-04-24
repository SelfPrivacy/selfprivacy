import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_repository.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/utils/app_logger.dart';

part 'metrics_state.dart';

class MetricsCubit extends Cubit<MetricsState> {
  MetricsCubit() : super(const MetricsLoading(Period.day));

  final MetricsRepository repository = MetricsRepository();

  Timer? timer;

  static final logger = const AppLogger(name: 'metrics_cubit').log;

  @override
  Future<void> close() {
    closeTimer();
    return super.close();
  }

  void closeTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }

  Future<void> changePeriod(final Period period) async {
    if (state is! MetricsLoading) {
      closeTimer();
      emit(MetricsLoading(period));
      await load(period);
    }
  }

  void restart() {
    unawaited(load(state.period));
  }

  Future<void> load(final Period period) async {
    try {
      final MetricsStateUpdate newStateUpdate = await repository
          .getRelevantServerMetrics(period);

      int duration = newStateUpdate.nextCheckInSeconds;
      if (duration <= 0) {
        duration = state.period.stepPeriodInSeconds;
      }
      timer = Timer(Duration(seconds: duration), () => load(period));

      emit(newStateUpdate.newState);
    } on StateError {
      logger('Tried to emit metrics when cubit is closed');
    }
  }
}
