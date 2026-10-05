import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/providers/resolve_provider.dart';

import '../../../helpers/fixtures/credential_fixtures.dart';
import '../../../helpers/fixtures/json_fixture.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

class _Resources extends Mock implements ResourcesModel {}

void main() {
  late _Resources resources;
  setUp(() {
    resources = _Resources();
    when(() => resources.servers).thenReturn([
      aServer(uuid: 'a'),
      aServer(
        uuid: 'b',
        domain: aServerDomain(domainName: 'second.example'),
      ),
    ]);
    when(() => resources.serverProviderCredentials).thenReturn([
      aServerProviderCredential(token: 'first', associatedServerUuids: ['a']),
      aServerProviderCredential(
        uuid: 'second',
        token: 'second',
        associatedServerUuids: ['b'],
      ),
    ]);
    when(() => resources.dnsProviderCredentials).thenReturn([
      aDnsProviderCredential(
        token: 'first-dns',
        associatedDomainNames: ['example.org'],
      ),
      aDnsProviderCredential(
        uuid: 'second',
        token: 'second-dns',
        associatedDomainNames: ['second.example'],
      ),
    ]);
  });

  test(
    'resolved providers keep their own credentials after associations change',
    () async {
      final headers = <Object?>[];
      Dio client(final BaseOptions options) => Dio(options)
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (final request, final handler) {
              headers.add(request.headers['Authorization']);
              handler.resolve(
                Response<dynamic>(
                  requestOptions: request,
                  statusCode: 200,
                  data: request.path == '/servers'
                      ? loadJsonFixture('server_providers/hetzner/servers.json')
                      : loadJsonFixture('dns_providers/cloudflare/zones.json'),
                ),
              );
            },
          ),
        );
      final server = resolveServerProvider(
        resources,
        'b',
        clientFactory: client,
      )!;
      final dns = resolveDnsProvider(resources, 'b', clientFactory: client)!;
      when(() => resources.serverProviderCredentials).thenReturn([]);
      when(() => resources.dnsProviderCredentials).thenReturn([]);
      await server.getServers();
      await dns.domainList();
      expect(headers, ['Bearer second', 'Bearer second-dns']);
      expect(resolveServerProvider(resources, 'b'), isNull);
      expect(resolveDnsProvider(resources, 'b'), isNull);
    },
  );

  for (final tokenId in [null, '', '   ']) {
    test('Porkbun without a usable key ID is unavailable ($tokenId)', () {
      when(() => resources.servers).thenReturn([
        aServer(
          uuid: 'b',
          domain: aServerDomain(provider: DnsProviderType.porkbun),
        ),
      ]);
      when(() => resources.dnsProviderCredentials).thenReturn([
        aDnsProviderCredential(
          provider: DnsProviderType.porkbun,
          tokenId: tokenId,
          associatedDomainNames: ['example.org'],
        ),
      ]);
      expect(resolveDnsProvider(resources, 'b'), isNull);
    });
  }

  for (final scenario in ['missing', 'ambiguous', 'wrong provider']) {
    test('rejects $scenario associations', () {
      when(() => resources.serverProviderCredentials).thenReturn(
        switch (scenario) {
          'missing' => [
            aServerProviderCredential(associatedServerUuids: ['a']),
          ],
          'ambiguous' => [
            aServerProviderCredential(associatedServerUuids: ['b']),
            aServerProviderCredential(
              uuid: 'duplicate',
              associatedServerUuids: ['b'],
            ),
          ],
          _ => [
            aServerProviderCredential(
              provider: ServerProviderType.digitalOcean,
              associatedServerUuids: ['b'],
            ),
          ],
        },
      );
      when(() => resources.dnsProviderCredentials).thenReturn(
        switch (scenario) {
          'missing' => [
            aDnsProviderCredential(associatedDomainNames: ['example.org']),
          ],
          'ambiguous' => [
            aDnsProviderCredential(associatedDomainNames: ['second.example']),
            aDnsProviderCredential(
              uuid: 'duplicate',
              token: 'duplicate',
              associatedDomainNames: ['second.example'],
            ),
          ],
          _ => [
            aDnsProviderCredential(
              provider: DnsProviderType.desec,
              associatedDomainNames: ['second.example'],
            ),
          ],
        },
      );
      expect(resolveServerProvider(resources, 'b'), isNull);
      expect(resolveDnsProvider(resources, 'b'), isNull);
      expect(resolveServerProvider(resources, 'unknown'), isNull);
      expect(resolveDnsProvider(resources, 'unknown'), isNull);
    });
  }
}
