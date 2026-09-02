import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/bloc/tokens/tokens_bloc.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/provider_credentials.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';
import 'package:selfprivacy/ui/forms/server_provider_form_view.dart';
import 'package:selfprivacy/ui/pages/more/tokens/add_server_provider_token.dart';
import 'package:selfprivacy/ui/pages/more/tokens/tokens_page.dart';
import 'package:uuid/uuid.dart';

import '../../../../fakes/hive/in_memory_hive.dart';
import '../../../../helpers/fixtures/credential_fixtures.dart';
import '../../../../helpers/fixtures/server_fixtures.dart';
import '../../../../helpers/widget_harness.dart';

class _MockTokensBloc extends Mock implements TokensBloc {}

void main() {
  setUpAll(() async {
    await setUpWidgetTestHarness();
    await setUpInMemoryHive();
    registerFallbackValue(const RevalidateTokens());
  });
  tearDownAll(tearDownInMemoryHive);

  late ResourcesModel resourcesModel;
  late _MockTokensBloc tokensBloc;

  setUp(() async {
    await Hive.openBox(BNames.resourcesBox);
    resourcesModel = ResourcesModel()..init();
    tokensBloc = _MockTokensBloc();
    when(
      () => tokensBloc.stream,
    ).thenAnswer((_) => const Stream<TokensState>.empty());
    when(() => tokensBloc.add(any())).thenReturn(null);
    getIt.registerSingleton<ResourcesModel>(resourcesModel);
  });

  tearDown(() async {
    await resourcesModel.dispose();
    await getIt.reset();
    final box = Hive.box(BNames.resourcesBox);
    await box.clear();
    await box.close();
  });

  Future<void> pumpPage(final WidgetTester tester, final Widget child) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        wrapForTest(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<TokensBloc>.value(value: tokensBloc),
              BlocProvider<SupportSystemCubit>(
                create: (final _) => SupportSystemCubit(),
              ),
            ],
            child: child,
          ),
        ),
      );
      await Future<void>.delayed(Duration.zero);
    });
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  }

  testWidgets('shows token identifiers, masked tokens, and server usage', (
    final tester,
  ) async {
    final server = aServer(uuid: 'server-a');
    await tester.runAsync(() => resourcesModel.addServer(server));
    final credentials = [
      aServerProviderCredential(
        uuid: 'token-id-credential',
        token: 'unused-provider-token',
        tokenId: 'visible-id',
      ),
      aServerProviderCredential(
        uuid: 'long-token-credential',
        token: '123456789abcdef',
        associatedServerUuids: ['server-a'],
      ),
      aServerProviderCredential(uuid: 'short-token-credential', token: 'short'),
      ServerProviderCredential(
        uuid: 'legacy-token-credential',
        tokenId: null,
        credentials: null,
        legacyToken: 'legacy-token-value',
        provider: ServerProviderType.hetzner,
        associatedServerUuids: const [],
      ),
    ];
    final state = TokensChecked(
      serverProviderCredentials: credentials
          .map(
            (final credential) =>
                TokenStatusWrapper(data: credential, status: TokenStatus.valid),
          )
          .toList(),
      dnsProviderCredentials: const [],
      backupsCredentials: const [],
    );
    when(() => tokensBloc.state).thenReturn(state);

    await pumpPage(tester, const TokensPage());

    expect(find.textContaining('visible-id...'), findsOneWidget);
    expect(find.textContaining('12345678...'), findsOneWidget);
    expect(find.textContaining('********...'), findsOneWidget);
    expect(find.textContaining('legacy-t...'), findsOneWidget);
    expect(find.textContaining(server.domain.domainName), findsOneWidget);
  });

  testWidgets('creates a sealed credential from a submitted provider token', (
    final tester,
  ) async {
    when(() => tokensBloc.state).thenReturn(const TokensInitial());
    final server = aServer(
      hostingDetails: aServerHostingDetails(
        provider: ServerProviderType.hetzner,
      ),
    );
    await pumpPage(tester, AddServerProviderTokenPage(server: server));
    final formView = tester.widget<ServerProviderFormView>(
      find.byType(ServerProviderFormView),
    );

    await formView.serverProviderForm.onSubmit('submitted-provider-token');

    final event =
        verify(() => tokensBloc.add(captureAny())).captured.single
            as AddServerProviderToken;
    final credential = event.serverProviderCredential;
    expect(Uuid.isValidUUID(fromString: credential.uuid), isTrue);
    expect(credential.provider, ServerProviderType.hetzner);
    expect(credential.associatedServerUuids, isEmpty);
    expect(
      credential.credentials,
      isA<BearerTokenCredential>().having(
        (final value) => value.token,
        'token',
        'submitted-provider-token',
      ),
    );
  });
}
