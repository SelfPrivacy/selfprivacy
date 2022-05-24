import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/hetzner_metrics.dart';

import 'hetzner_metrics_repository.dart';

part 'hetzner_metrics_state.dart';

class HetznerMetricsCubit extends Cubit<HetznerMetricsState> {
  HetznerMetricsCubit() : super(const HetznerMetricsLoading(Period.day));

  final repository = HetznerMetricsRepository();

  Timer? timer;

  @override
  close() {
    closeTimer();
    return super.close();
  }

  void closeTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }

  void changePeriod(Period period) async {
    closeTimer();
    emit(HetznerMetricsLoading(period));
    load(period);
  }

  void restart() async {
    load(state.period);
  }

  void load(Period period) async {
    var newState = await repository.getMetrics(period);
    timer = Timer(
      Duration(seconds: newState.stepInSeconds.toInt()),
      () => load(newState.period),
    );

    emit(newState);
  }
}
