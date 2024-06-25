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
  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<ConsoleModel>(ConsoleModel());
  getIt.registerSingleton<ResourcesModel>(ResourcesModel()..init());
  getIt.registerSingleton<WizardDataModel>(WizardDataModel()..init());

  final apiConfigModel = ApiConfigModel();
  await apiConfigModel.init();
  getIt.registerSingleton<ApiConfigModel>(apiConfigModel);

  getIt.registerSingleton<ApiConnectionRepository>(
    ApiConnectionRepository()..init(),
  );

  await getIt.allReady();
}
