import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/porkbun/porkbun_api.dart';
import 'package:selfprivacy/logic/models/json/dns_providers/porkbun/porkbun_dns_info.dart';

void main() {
  final String tokenId = Platform.environment['PORKBUN_API_KEY'] ?? '';
  final String token = Platform.environment['PORKBUN_SECRET_API_KEY'] ?? '';
  final String domainName =
      Platform.environment['PORKBUN_TEST_DOMAIN'] ?? 'selfprivacy.team';

  final bool hasCredentials = tokenId.isNotEmpty && token.isNotEmpty;
  const String missingEnvReason =
      'Set PORKBUN_API_KEY and PORKBUN_SECRET_API_KEY to run live Porkbun tests.';

  late PorkbunApi api;

  setUpAll(() {
    if (!getIt.isRegistered<ConsoleModel>()) {
      getIt.registerSingleton<ConsoleModel>(ConsoleModel());
    }

    api = hasCredentials
        ? PorkbunApi(tokenId: tokenId, token: token)
        : PorkbunApi(isWithToken: false);
  });

  group(
    'Porkbun API live tests',
    skip: hasCredentials ? false : missingEnvReason,
    () {
      test('API credentials are valid', () async {
        final result = await api.isApiTokenValid(token, tokenId);

        expect(result.success, isTrue);
        expect(result.data, isTrue, reason: result.message);
      });

      test('can list domains and find test domain', () async {
        final result = await api.getDomains();

        expect(result.success, isTrue, reason: result.message);
        expect(
          result.data.map((final domain) => domain.domain),
          contains(domainName),
          reason:
              'Expected "$domainName" in Porkbun account domains. Got: '
              '${result.data.map((final domain) => domain.domain).join(', ')}',
        );
      });

      test(
        'can create and delete TXT record on test domain',
        () async {
          final String suffix = DateTime.now().microsecondsSinceEpoch
              .toString();
          final String subdomain = 'sp-live-$suffix';
          final String content = 'selfprivacy-live-test-$suffix';

          final PorkbunDnsRecord recordToCreate = PorkbunDnsRecord(
            content: content,
            name: subdomain,
            ttl: '600',
            type: 'TXT',
          );

          final createResult = await api.createMultipleDnsRecords(
            domainName: domainName,
            records: <PorkbunDnsRecord>[recordToCreate],
          );

          expect(createResult.success, isTrue, reason: createResult.message);

          List<PorkbunDnsRecord> createdRecords = <PorkbunDnsRecord>[];
          try {
            createdRecords = await _waitForMatchingRecords(
              api: api,
              domainName: domainName,
              subdomain: subdomain,
              content: content,
            );

            expect(
              createdRecords,
              isNotEmpty,
              reason: 'Created record not found.',
            );
          } finally {
            if (createdRecords.isEmpty) {
              createdRecords = await _findMatchingRecords(
                api: api,
                domainName: domainName,
                subdomain: subdomain,
                content: content,
              );
            }

            if (createdRecords.isNotEmpty) {
              final removeResult = await api.removeRecords(
                domainName: domainName,
                records: createdRecords,
              );
              expect(
                removeResult.success,
                isTrue,
                reason: removeResult.message,
              );
            }
          }

          final List<PorkbunDnsRecord> afterDeletion =
              await _findMatchingRecords(
                api: api,
                domainName: domainName,
                subdomain: subdomain,
                content: content,
              );
          expect(
            afterDeletion,
            isEmpty,
            reason: 'Record still present after deletion attempt.',
          );
        },
        timeout: const Timeout(Duration(minutes: 2)),
      );
    },
  );
}

Future<List<PorkbunDnsRecord>> _waitForMatchingRecords({
  required final PorkbunApi api,
  required final String domainName,
  required final String subdomain,
  required final String content,
  final int retries = 10,
  final Duration delay = const Duration(seconds: 1),
}) async {
  for (int attempt = 0; attempt < retries; attempt++) {
    final List<PorkbunDnsRecord> matches = await _findMatchingRecords(
      api: api,
      domainName: domainName,
      subdomain: subdomain,
      content: content,
    );

    if (matches.isNotEmpty) {
      return matches;
    }

    await Future<void>.delayed(delay);
  }

  return <PorkbunDnsRecord>[];
}

Future<List<PorkbunDnsRecord>> _findMatchingRecords({
  required final PorkbunApi api,
  required final String domainName,
  required final String subdomain,
  required final String content,
}) async {
  final recordsResult = await api.getDnsRecords(domainName: domainName);
  if (!recordsResult.success) {
    fail('Failed to fetch DNS records: ${recordsResult.message}');
  }

  final String fqdn = '$subdomain.$domainName';

  return recordsResult.data.where((final record) {
    final String name = record.name.toLowerCase();
    return record.type == 'TXT' &&
        record.content == content &&
        (name == subdomain || name == fqdn || name == '$fqdn.');
  }).toList();
}
