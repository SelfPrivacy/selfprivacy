import 'package:get_it/get_it.dart';
import 'package:selfprivacy/logic/get_it/api_config.dart';
import 'package:selfprivacy/logic/get_it/api_connection_repository.dart';
import 'package:selfprivacy/logic/get_it/console.dart';
import 'package:selfprivacy/logic/get_it/navigation.dart';

export 'package:selfprivacy/logic/get_it/api_config.dart';
export 'package:selfprivacy/logic/get_it/api_connection_repository.dart';
export 'package:selfprivacy/logic/get_it/console.dart';
export 'package:selfprivacy/logic/get_it/navigation.dart';

final GetIt getIt = GetIt.instance;

Future<void> getItSetup() async {
  getIt.registerSingleton<NavigationService>(NavigationService());

  getIt.registerSingleton<ConsoleModel>(ConsoleModel());
  getIt.registerSingleton<ApiConfigModel>(ApiConfigModel()..init());

  getIt.registerSingleton<ApiConnectionRepository>(
    ApiConnectionRepository()..init(),
  );

  await getIt.allReady();
}
