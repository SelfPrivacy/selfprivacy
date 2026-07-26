import 'package:get_it/get_it.dart';
import 'package:selfprivacy/logic/get_it/api_config.dart';
import 'package:selfprivacy/logic/get_it/api_connection_repository.dart';
import 'package:selfprivacy/logic/get_it/console_model.dart';
import 'package:selfprivacy/logic/get_it/developer_settings_model.dart';
import 'package:selfprivacy/logic/get_it/navigation.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';

export 'package:selfprivacy/logic/get_it/api_config.dart';
export 'package:selfprivacy/logic/get_it/api_connection_repository.dart';
export 'package:selfprivacy/logic/get_it/console_model.dart';
export 'package:selfprivacy/logic/get_it/developer_settings_model.dart';
export 'package:selfprivacy/logic/get_it/navigation.dart';

final GetIt getIt = GetIt.instance;

Future<void> getItSetup() async {
  final developerSettings = DeveloperSettingsModel();
  final tlsContext = TlsContext(developerSettings);
  await tlsContext.loadStagingRoots();

  getIt
    ..registerSingleton<DeveloperSettingsModel>(developerSettings)
    ..registerSingleton<TlsContext>(tlsContext)
    ..registerSingleton<NavigationService>(NavigationService())
    ..registerSingleton<ConsoleModel>(ConsoleModel())
    ..registerSingleton<ResourcesModel>(
      ResourcesModel()..init(),
      dispose: (final ResourcesModel model) => model.dispose(),
    )
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
