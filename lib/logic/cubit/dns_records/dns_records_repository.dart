import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/operations/operation_execution.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';

class DnsRecordsRepository {
  DnsRecordsRepository({
    required final ServerApi api,
    required final ServerDomain domain,
    required final DnsProvider? provider,
    required final bool Function() canContinue,
  }) : _api = api,
       _domain = domain,
       _provider = provider,
       _canContinue = canContinue;

  final ServerApi _api;
  final ServerDomain _domain;
  final DnsProvider? _provider;
  final bool Function() _canContinue;

  void _requireCurrent() {
    if (!_canContinue()) {
      throw const GraphQLDispatchDeferred();
    }
  }

  Future<GenericResult<List<DesiredDnsRecord>>> read() async {
    _requireCurrent();
    if (_provider == null || !_provider.isAuthorized) {
      return GenericResult(success: false, data: []);
    }
    final records = await _api.getDnsRecords();
    _requireCurrent();
    return records == null
        ? GenericResult(success: false, data: [])
        : _validate(records);
  }

  Future<GenericResult<List<DesiredDnsRecord>>> repair() async {
    _requireCurrent();
    if (_provider == null || !_provider.isAuthorized) {
      OperationExecution.current?.recordCompletion(succeeded: false);
      return GenericResult(success: false, data: []);
    }
    final required = await _api.getDnsRecords();
    _requireCurrent();
    if (required == null) {
      OperationExecution.current?.recordCompletion(succeeded: false);
      return GenericResult(success: false, data: []);
    }
    final records = required
        .where(
          (final record) =>
              record.type != 'AAAA' ||
              !(record.content?.trim().startsWith('fe80::') ?? false),
        )
        .toList();
    if (!records.any((final record) => record.type == 'AAAA')) {
      records.addAll(
        records
            .where((final record) => record.type == 'A')
            .map(
              (final record) =>
                  DnsRecord(name: record.name, type: 'AAAA', content: null),
            )
            .toList(),
      );
    }
    final removed = await _provider.removeDomainRecords(
      records: records,
      domain: _domain,
    );
    OperationExecution.current?.recordCompletion(succeeded: removed.success);
    _requireCurrent();
    if (!removed.success) {
      return GenericResult(success: false, data: []);
    }
    final created = await _provider.createDomainRecords(
      records: records.where((final record) => record.content != null).toList(),
      domain: _domain,
    );
    OperationExecution.current?.recordCompletion(succeeded: created.success);
    _requireCurrent();
    return created.success ? read() : GenericResult(success: false, data: []);
  }

  Future<GenericResult<List<DesiredDnsRecord>>> _validate(
    final List<DnsRecord> pendingDnsRecords,
  ) async {
    final result = await _provider!.getDnsRecords(domain: _domain);
    _requireCurrent();
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: [],
        code: result.code,
        message: result.message,
      );
    }

    final List<DnsRecord> providerDnsRecords = result.data;
    final List<DesiredDnsRecord> foundRecords = [];
    try {
      for (final DnsRecord pendingDnsRecord in pendingDnsRecords) {
        if (pendingDnsRecord.type == 'AAAA' &&
            (pendingDnsRecord.content?.startsWith('fe80::') ?? false)) {
          continue;
        }
        if (pendingDnsRecord.name == 'selector._domainkey') {
          final foundRecord = providerDnsRecords.firstWhere(
            (final r) =>
                (r.name == pendingDnsRecord.name) &&
                r.type == pendingDnsRecord.type,
            orElse: () => DnsRecord(
              displayName: pendingDnsRecord.displayName,
              name: pendingDnsRecord.name,
              type: pendingDnsRecord.type,
              content: pendingDnsRecord.content,
              ttl: pendingDnsRecord.ttl,
            ),
          );
          final String foundContent = foundRecord.content!
              .replaceAll(RegExp(r'\s+'), '')
              .trim();
          final String desiredContent = pendingDnsRecord.content!
              .replaceAll(RegExp(r'\s+'), '')
              .trim();
          final isSatisfied = (desiredContent == foundContent);
          foundRecords.add(
            DesiredDnsRecord(
              name: pendingDnsRecord.name!,
              displayName: pendingDnsRecord.displayName,
              content: pendingDnsRecord.content!,
              isSatisfied: isSatisfied,
              type: pendingDnsRecord.type,
            ),
          );
        } else {
          final foundMatch = providerDnsRecords.any(
            (final r) =>
                r.name == pendingDnsRecord.name &&
                r.type == pendingDnsRecord.type &&
                r.content == pendingDnsRecord.content,
          );
          foundRecords.add(
            DesiredDnsRecord(
              name: pendingDnsRecord.name!,
              displayName: pendingDnsRecord.displayName,
              content: pendingDnsRecord.content!,
              isSatisfied: foundMatch,
              type: pendingDnsRecord.type,
            ),
          );
        }
      }
    } catch (_) {
      return GenericResult(
        data: [],
        success: false,
        message: 'dns_validation_failed',
      );
    }
    // If providerDnsRecords contains a link-local ipv6 record, return an error
    if (providerDnsRecords.any(
      (final r) =>
          r.type == 'AAAA' && (r.content?.trim().startsWith('fe80::') ?? false),
    )) {
      return GenericResult(
        data: foundRecords,
        success: false,
        message: 'link-local',
      );
    }
    return GenericResult(data: foundRecords, success: true);
  }
}
