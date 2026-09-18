import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/disk_volumes.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';

import '../../../../helpers/fixtures/json_fixture.dart';
import '../../../../helpers/fixtures/server_fixtures.dart';
import '../../../../helpers/widget_harness.dart';

class _Repository extends Mock implements ApiConnectionRepository {}

class _Api extends Mock implements ServerApi {}

class _Navigation extends Mock implements NavigationService {}

class _Resources extends Mock implements ResourcesModel {}

class _Provider extends Mock implements ServerProvider {}

void main() {
  setUpAll(setUpWidgetTestHarness);
  late _Repository repository;
  late _Api api;
  late _Navigation navigation;
  late _Provider provider;
  late ApiData data;
  setUp(() {
    repository = _Repository();
    api = _Api();
    navigation = _Navigation();
    provider = _Provider();
    final resources = _Resources();
    data = ApiData(api);
    data.volumes.data = Query$GetServerDiskVolumes.fromJson(
      loadJsonFixture('graphql/domain_reads.json')['GetServerDiskVolumes']
          as Map<String, dynamic>,
    ).storage.volumes.map(ServerDiskVolume.fromGraphQL).toList();
    when(() => repository.api).thenReturn(api);
    when(() => repository.apiData).thenReturn(data);
    when(() => repository.dataStream).thenAnswer((_) => const Stream.empty());
    when(
      () => repository.connectionStatusStream,
    ).thenAnswer((_) => const Stream.empty());
    when(
      () => repository.currentConnectionStatus,
    ).thenReturn(ConnectionStatus.connected);
    when(() => resources.statusStream).thenAnswer((_) => const Stream.empty());
    when(() => provider.isAuthorized).thenReturn(true);
    when(
      () => provider.getVolumes(),
    ).thenAnswer((_) async => GenericResult(success: true, data: []));
    getIt
      ..registerSingleton<ApiConnectionRepository>(repository)
      ..registerSingleton<NavigationService>(navigation)
      ..registerSingleton<ResourcesModel>(resources);
  });
  tearDown(getIt.reset);

  test('the default provider lookup handles missing credentials', () async {
    ProvidersController.clearServerProvider();
    final bloc = VolumesBloc();
    expect(await bloc.getPricePerGb(), isNull);
    await bloc.close();
  });

  for (final outcome in ServerMutationOutcome.values) {
    testWidgets('resize workflow continues only after $outcome', (
      final tester,
    ) async {
      await pumpForTest(tester, const SizedBox.shrink());
      final providerVolume = aServerProviderVolume();
      final volume = DiskVolume(name: 'sdb', providerVolume: providerVolume);
      const size = DiskSize(byte: 20000000000);
      when(
        () => provider.resizeVolume(providerVolume, size),
      ).thenAnswer((_) async => GenericResult(success: true, data: true));
      when(() => api.resizeVolume('sdb')).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: outcome,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      when(api.reboot).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.indeterminate,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      final bloc = VolumesBloc(serverProvider: () => provider)
        ..add(const VolumesServerLoaded());

      await tester.pump();
      expect(bloc.state, isA<VolumesLoaded>());
      bloc.add(VolumeResize(volume, size));
      await tester.pump();
      expect(bloc.state, isA<VolumesResizing>());
      await tester.pump(const Duration(seconds: 10));
      if (outcome == ServerMutationOutcome.confirmed) {
        expect(data.volumes.isExpired, isTrue);
        await tester.pump(const Duration(seconds: 20));
        verify(api.reboot).called(1);
        verify(
          () => navigation.showSnackBar('server_mutation.outcome_unknown'.tr()),
        ).called(1);
      } else {
        await tester.pump(const Duration(seconds: 60));
        verifyNever(api.reboot);
        final key = outcome == ServerMutationOutcome.rejected
            ? 'server_mutation.rejected'
            : 'server_mutation.outcome_unknown';
        verify(() => navigation.showSnackBar(key.tr())).called(1);
      }
      expect(bloc.state, isA<VolumesLoaded>());
      verify(() => api.resizeVolume('sdb')).called(1);
      await tester.runAsync(() async {
        final closing = bloc.close();
        await Future<void>.delayed(Duration.zero);
        await tester.pump();
        await closing;
      });
    });
  }
}
