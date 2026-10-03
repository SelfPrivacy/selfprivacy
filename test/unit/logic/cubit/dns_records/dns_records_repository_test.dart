import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_repository.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';

import '../../../../helpers/fixtures/dns_record_fixtures.dart';
import '../../../../helpers/fixtures/server_fixtures.dart';

class _Api extends Mock implements ServerApi {}

class _Provider extends Mock implements DnsProvider {}

void main() {
  final domain = aServerDomain();
  late _Api api;
  late _Provider provider;
  late DnsRecordsRepository repository;
  var current = true;
  setUpAll(() => registerFallbackValue(aServerDomain()));
  setUp(() {
    api = _Api();
    provider = _Provider();
    current = true;
    when(() => provider.isAuthorized).thenReturn(true);
    when(api.getDnsRecords).thenAnswer((_) async => [aDnsRecord()]);
    when(() => provider.getDnsRecords(domain: any(named: 'domain'))).thenAnswer(
      (_) async => GenericResult(success: true, data: [aDnsRecord()]),
    );
    repository = DnsRecordsRepository(
      api: api,
      domain: domain,
      provider: provider,
      canContinue: () => current,
    );
  });

  test('validation uses the captured API, provider, and domain', () async {
    final result = await repository.read();
    expect(result.success, isTrue);
    expect(result.data.single.isSatisfied, isTrue);
    verify(() => provider.getDnsRecords(domain: domain)).called(1);
  });

  test(
    'detaching during the server read prevents a provider request',
    () async {
      final pending = Completer<List<DnsRecord>?>();
      when(api.getDnsRecords).thenAnswer((_) => pending.future);
      final reading = repository.read();
      final rejected = expectLater(
        reading,
        throwsA(isA<GraphQLDispatchDeferred>()),
      );
      current = false;
      pending.complete([aDnsRecord()]);
      await rejected;
      verifyNever(() => provider.getDnsRecords(domain: any(named: 'domain')));
    },
  );

  for (final detach in [false, true]) {
    test(
      'repair does not continue after ${detach ? 'detachment' : 'failed removal'}',
      () async {
        final pending = Completer<GenericResult<void>>();
        final sent = Completer<void>();
        when(
          () => provider.removeDomainRecords(
            records: any(named: 'records'),
            domain: any(named: 'domain'),
          ),
        ).thenAnswer((_) {
          sent.complete();
          return pending.future;
        });
        final repairing = repository.repair();
        final rejected = detach
            ? expectLater(repairing, throwsA(isA<GraphQLDispatchDeferred>()))
            : expectLater(
                repairing,
                completion(
                  isA<GenericResult>().having(
                    (final result) => result.success,
                    'success',
                    isFalse,
                  ),
                ),
              );
        await sent.future;
        current = !detach;
        pending.complete(GenericResult(success: detach, data: null));
        await rejected;
        verifyNever(
          () => provider.createDomainRecords(
            records: any(named: 'records'),
            domain: any(named: 'domain'),
          ),
        );
      },
    );
  }
}
