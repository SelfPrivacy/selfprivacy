import 'package:get_it/get_it.dart';
import 'package:selfprivacy/logic/get_it/api_config.dart';
import 'package:selfprivacy/logic/get_it/api_connection_repository.dart';
import 'package:selfprivacy/logic/get_it/console_model.dart';
import 'package:selfprivacy/logic/get_it/navigation.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';

export 'package:selfprivacy/logic/get_it/api_config.dart';
export 'package:selfprivacy/logic/get_it/api_connection_repository.dart';
export 'package:selfprivacy/logic/get_it/console_model.dart';
export 'package:selfprivacy/logic/get_it/navigation.dart';

final GetIt getIt = GetIt.instance;

Future<void> getItSetup() async {
  getIt
    ..registerSingleton<NavigationService>(NavigationService())
    ..registerSingleton<ConsoleModel>(ConsoleModel())
    ..registerSingleton<ResourcesModel>(ResourcesModel()..init())
    ..registerSingleton<WizardDataModel>(WizardDataModel()..init());

  final apiConfigModel = ApiConfigModel();
  getIt
    ..registerSingleton<ApiConfigModel>(apiConfigModel)
    ..registerSingleton<ApiConnectionRepository>(
      // ignore: unawaited_futures
      ApiConnectionRepository()..init(),
    );

  await getIt.allReady();
}
