import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/ui/molecules/list_items/dns_record_item.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Satisfied', type: DnsRecordItem, path: '[Molecules]/list_items')
Widget dnsRecordItemSatisfied(final BuildContext context) => CatalogCase(
  key: const ValueKey('DnsRecordItem/Satisfied'),
  id: 'DnsRecordItem/Satisfied',
  variant: 'Satisfied',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      const DnsRecordItem(
        dnsRecord: DesiredDnsRecord(
          type: 'A',
          name: 'cloud.example.org',
          content: '192.0.2.10',
          isSatisfied: true,
        ),
        refreshing: false,
      ),
);

@UseCase(name: 'Mismatch', type: DnsRecordItem, path: '[Molecules]/list_items')
Widget dnsRecordItemMismatch(final BuildContext context) => CatalogCase(
  key: const ValueKey('DnsRecordItem/Mismatch'),
  id: 'DnsRecordItem/Mismatch',
  variant: 'Mismatch',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      const DnsRecordItem(
        dnsRecord: DesiredDnsRecord(
          type: 'A',
          name: 'cloud.example.org',
          content: '192.0.2.10',
          isSatisfied: false,
        ),
        refreshing: false,
      ),
);

@UseCase(
  name: 'Refreshing',
  type: DnsRecordItem,
  path: '[Molecules]/list_items',
)
Widget dnsRecordItemRefreshing(final BuildContext context) => CatalogCase(
  key: const ValueKey('DnsRecordItem/Refreshing'),
  id: 'DnsRecordItem/Refreshing',
  variant: 'Refreshing',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      const DnsRecordItem(
        dnsRecord: DesiredDnsRecord(
          type: 'A',
          name: 'cloud.example.org',
          content: '192.0.2.10',
          isSatisfied: false,
        ),
        refreshing: true,
      ),
);
