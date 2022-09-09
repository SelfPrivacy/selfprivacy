import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/hetzner_metrics.dart';

import 'package:selfprivacy/logic/cubit/hetzner_metrics/hetzner_metrics_repository.dart';

part 'hetzner_metrics_state.dart';

class HetznerMetricsCubit extends Cubit<HetznerMetricsState> {
  HetznerMetricsCubit() : super(const HetznerMetricsLoading(Period.day));

  final HetznerMetricsRepository repository = HetznerMetricsRepository();

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
    emit(HetznerMetricsLoading(period));
    load(period);
  }

  void restart() async {
    load(state.period);
  }

  void load(final Period period) async {
    final HetznerMetricsLoaded newState = await repository.getMetrics(period);
    timer = Timer(
      Duration(seconds: newState.stepInSeconds.toInt()),
      () => load(newState.period),
    );

    try {
      emit(newState);
    } on StateError {
      print('Tried to emit Hetzner metrics when cubit is closed');
    }
  }
}
