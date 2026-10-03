import 'package:get_it/get_it.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/get_it/api_config.dart';
import 'package:selfprivacy/logic/get_it/console_model.dart';
import 'package:selfprivacy/logic/get_it/developer_settings_model.dart';
import 'package:selfprivacy/logic/get_it/navigation.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';

export 'package:selfprivacy/logic/get_it/api_config.dart';
export 'package:selfprivacy/logic/get_it/console_model.dart';
export 'package:selfprivacy/logic/get_it/developer_settings_model.dart';
export 'package:selfprivacy/logic/get_it/navigation.dart';

final GetIt getIt = GetIt.instance;

GraphQLTransport createGraphQLTransport({
  required final GraphQLDomainProvider domainProvider,
  final GraphQLTokenProvider? tokenProvider,
  final GraphQLAuthFailureHandler? onAuthFailure,
  final void Function(GraphQLTransportEvent)? onEvent,
  final void Function()? beforeRequest,
  final TlsPolicy tlsPolicy = TlsPolicy.strict,
}) => GraphQLTransport(
  domainProvider: domainProvider,
  tokenProvider: tokenProvider,
  onAuthFailure: onAuthFailure,
  onEvent: onEvent,
  beforeRequest: beforeRequest,
  localeProvider: () => getIt<ApiConfigModel>().localeCode,
  tlsContext: getIt<TlsContext>(),
  tlsPolicy: tlsPolicy,
  consoleLog: getIt<ConsoleModel>().log,
);

Future<void> getItSetup() async {
  final developerSettings = DeveloperSettingsModel();
  final tlsContext = TlsContext(developerSettings);
  final resourcesModel = ResourcesModel()..init();
  await tlsContext.loadStagingRoots();

  getIt
    ..registerSingleton<DeveloperSettingsModel>(developerSettings)
    ..registerSingleton<TlsContext>(tlsContext)
    ..registerSingleton<NavigationService>(NavigationService())
    ..registerSingleton<ConsoleModel>(ConsoleModel())
    ..registerSingleton<ResourcesModel>(
      resourcesModel,
      dispose: (final ResourcesModel model) => model.dispose(),
    )
    ..registerSingleton<WizardDataModel>(WizardDataModel()..init());

  final apiConfigModel = ApiConfigModel();
  final hub = ServerConnectionHub(resourcesModel: resourcesModel);
  getIt
    ..registerSingleton<ApiConfigModel>(apiConfigModel)
    ..registerSingleton<ServerConnectionHub>(
      hub,
      dispose: (final hub) => hub.dispose(),
    );

  await getIt.allReady();
  hub.start();
}
