import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';

class _MockApiConnectionRepository extends Mock
    implements ApiConnectionRepository {}

class _MockServerApi extends Mock implements ServerApi {}

void main() {
  test('uses the API from the active connection repository', () {
    final repository = _MockApiConnectionRepository();
    final api = _MockServerApi();
    when(
      () => repository.connectionStatusStream,
    ).thenAnswer((_) => const Stream.empty());
    when(
      () => repository.connectionStatus,
    ).thenReturn(ConnectionStatus.reconnecting);
    when(() => repository.api).thenReturn(api);
    getIt.registerSingleton<ApiConnectionRepository>(repository);
    addTearDown(getIt.reset);

    final cubit = DnsRecordsCubit();
    addTearDown(cubit.close);

    expect(cubit.api, same(api));
  });
}
