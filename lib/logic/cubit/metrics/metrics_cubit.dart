import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/metrics.dart';

import 'package:selfprivacy/logic/cubit/metrics/metrics_repository.dart';

part 'metrics_state.dart';

class MetricsCubit extends Cubit<MetricsState> {
  MetricsCubit() : super(const MetricsLoading(Period.day));

  final MetricsRepository repository = MetricsRepository();

  Timer? timer;

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

  void changePeriod(final Period period) async {
    closeTimer();
    emit(MetricsLoading(period));
    load(period);
  }

  void restart() async {
    load(state.period);
  }

  void load(final Period period) async {
    try {
      final MetricsLoaded newState = await repository.getMetrics(period);
      timer = Timer(
        Duration(seconds: newState.metrics.stepsInSecond.toInt()),
        () => load(newState.period),
      );
      emit(newState);
    } on StateError {
      print('Tried to emit metrics when cubit is closed');
    } on MetricsLoadException {
      timer = Timer(
        Duration(seconds: state.period.stepPeriodInSeconds),
        () => load(state.period),
      );
    }
  }
}
