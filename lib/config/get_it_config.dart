import 'package:get_it/get_it.dart';
import 'package:selfprivacy/logic/get_it/console.dart';

final getIt = GetIt.instance;

void getItSetup() {
  getIt.registerSingleton<ConsoleModel>(ConsoleModelImplementation());
}
