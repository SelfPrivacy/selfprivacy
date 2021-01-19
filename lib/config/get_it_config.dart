import 'package:get_it/get_it.dart';
import 'package:selfprivacy/logic/get_it/console.dart';
import 'package:selfprivacy/logic/get_it/timer.dart';

final getIt = GetIt.instance;

void getItSetup() {
  getIt.registerSingleton<ConsoleModel>(ConsoleModel());
  getIt.registerSingleton<TimerModel>(TimerModel());
}
