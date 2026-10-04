import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/bloc/tokens/tokens_bloc.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/provider_credentials.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';

import '../../../../fakes/hive/in_memory_hive.dart';
import '../../../../helpers/fixtures/credential_fixtures.dart';
import '../../../../helpers/fixtures/server_fixtures.dart';

class _MockServerProvider extends Mock implements ServerProvider {}

ServerBasicInfo _providerServer(final String providerId) => ServerBasicInfo(
  providerId: providerId,
  name: 'server',
  reverseDns: 'server.example.org',
  ip: '135.181.45.111',
  created: DateTime.utc(2026, 1, 1),
  location: 'fsn1',
);

ServerBasicInfoWithValidators _selectedProviderServer() =>
    ServerBasicInfoWithValidators(
      providerId: 'provider-99',
      name: 'server',
      reverseDns: 'server.example.org',
      ip: '135.181.45.112',
      created: DateTime.utc(2026, 2, 1),
      location: 'hel1',
      isIpValid: true,
      isReverseDnsValid: true,
    );

void main() {
  setUpAll(setUpInMemoryHive);
  tearDownAll(tearDownInMemoryHive);

  late ResourcesModel resourcesModel;
  late _MockServerProvider provider;
  TokensBloc? bloc;

  setUp(() async {
    await Hive.openBox(BNames.resourcesBox);
    resourcesModel = ResourcesModel()..init();
    provider = _MockServerProvider();
    when(
      () => provider.tryInitApiByToken(any()),
    ).thenAnswer((_) async => GenericResult(success: true, data: true));
    when(() => provider.getServers()).thenAnswer(
      (_) async => GenericResult(
        success: true,
        data: [_providerServer('provider-7'), _providerServer('provider-99')],
      ),
    );
    getIt.registerSingleton<ResourcesModel>(resourcesModel);
  });

  tearDown(() async {
    await bloc?.close();
    await resourcesModel.dispose();
    ProvidersController.clearProviders();
    await getIt.reset();
    final box = Hive.box(BNames.resourcesBox);
    await box.clear();
    await box.close();
  });

  TokensBloc createBloc() => bloc = TokensBloc(
    createServerProvider: (final ServerProviderSettings settings) {
      expect(
        settings.credentials,
        isA<BearerTokenCredential>().having(
          (final credentials) => credentials.token,
          'token',
          'provider-token',
        ),
      );
      return provider;
    },
  );

  Future<TokensChecked> waitForChecked(final TokensBloc tokensBloc) =>
      tokensBloc.stream
          .where((final state) => state is TokensChecked)
          .cast<TokensChecked>()
          .first;

  test('validates an associated server through its provider ID', () async {
    await resourcesModel.addServer(
      aServer(
        uuid: 'server-a',
        hostingDetails: aServerHostingDetails(providerId: 'provider-7'),
      ),
    );
    await resourcesModel.addServerProviderToken(
      aServerProviderCredential(
        token: 'provider-token',
        associatedServerUuids: ['server-a'],
      ),
    );

    final state = await waitForChecked(createBloc());

    expect(state.serverProviderCredentials.single.status, TokenStatus.valid);
    verify(() => provider.tryInitApiByToken('provider-token')).called(1);
    verify(() => provider.getServers()).called(1);
  });

  test('reports no access when the provider server is absent', () async {
    await resourcesModel.addServer(
      aServer(
        uuid: 'server-a',
        hostingDetails: aServerHostingDetails(providerId: 'provider-7'),
      ),
    );
    await resourcesModel.addServerProviderToken(
      aServerProviderCredential(
        token: 'provider-token',
        associatedServerUuids: ['server-a'],
      ),
    );
    when(() => provider.getServers()).thenAnswer(
      (_) async => GenericResult(
        success: true,
        data: [_providerServer('different-provider-id')],
      ),
    );

    final state = await waitForChecked(createBloc());

    expect(state.serverProviderCredentials.single.status, TokenStatus.noAccess);
  });

  test('adds a credential with sealed provider credentials', () async {
    final tokensBloc = createBloc();
    await waitForChecked(tokensBloc);
    final credential = aServerProviderCredential(token: 'provider-token');
    final changed = resourcesModel.statusStream.firstWhere(
      (final event) => event is ChangedServerProviderCredentials,
    );

    tokensBloc.add(AddServerProviderToken(credential));
    await changed;

    expect(resourcesModel.serverProviderCredentials, [credential]);
    expect(ProvidersController.currentServerProvider?.isAuthorized, isTrue);
  });

  test('connects a server by app UUID and stores its provider ID', () async {
    final server = aServer(
      uuid: 'server-a',
      hostingDetails: aServerHostingDetails(providerId: 'provider-7'),
    );
    final credential = aServerProviderCredential(token: 'provider-token');
    await resourcesModel.addServer(server);
    await resourcesModel.addServerProviderToken(credential);
    final tokensBloc = createBloc();
    await waitForChecked(tokensBloc);
    final changed = resourcesModel.statusStream.firstWhere(
      (final event) => event is ChangedServers,
    );

    tokensBloc.add(
      ServerSelectedForProviderToken(
        _selectedProviderServer(),
        server,
        credential,
      ),
    );
    await changed;

    final connectedServer = resourcesModel.servers.single;
    expect(connectedServer.uuid, 'server-a');
    expect(connectedServer.hostingDetails.providerId, 'provider-99');
    expect(connectedServer.hostingDetails.volume.serverId, 'provider-99');
    expect(connectedServer.hostingDetails.ip4, '135.181.45.112');
    expect(connectedServer.hostingDetails.serverLocation, 'hel1');
    expect(
      resourcesModel.serverProviderCredentials.single.associatedServerUuids,
      ['server-a'],
    );
  });

  test('filters associated servers and resolves servers by UUID', () async {
    final associatedServer = aServer(uuid: 'associated-server');
    final unassociatedServer = aServer(uuid: 'unassociated-server');
    final manualServer = aServer(
      uuid: 'manual-server',
      hostingDetails: aServerHostingDetails(
        provider: ServerProviderType.unknown,
      ),
    );
    await resourcesModel.addServer(associatedServer);
    await resourcesModel.addServer(unassociatedServer);
    await resourcesModel.addServer(manualServer);
    final credential = aServerProviderCredential(
      associatedServerUuids: ['associated-server'],
    );
    final state = TokensChecked(
      serverProviderCredentials: [
        TokenStatusWrapper(data: credential, status: TokenStatus.valid),
      ],
      dnsProviderCredentials: const [],
      backupsCredentials: const [],
    );

    expect(state.serversWithoutProviderCredentials, [unassociatedServer]);
    expect(state.getServerByUuid('associated-server'), associatedServer);
  });
}
