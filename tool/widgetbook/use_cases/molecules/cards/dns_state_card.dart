import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/ui/molecules/cards/dns_state_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'uninitialized', type: DnsStateCard, path: '[Molecules]/cards')
Widget dnsStateCardUninitialized(final BuildContext context) => CatalogCase(
  key: const ValueKey('DnsStateCard/uninitialized'),
  id: 'DnsStateCard/uninitialized',
  variant: 'uninitialized',
  host: PreviewHost.content,
  width: 560,
  height: 250,
  builder: (final context, final fixtures, final controller, final update) =>
      DnsStateCard(
        dnsState: DnsRecordsStatus.uninitialized,
        fixCallback: () => catalogActions.record('Fix DNS'),
      ),
);

@UseCase(name: 'refreshing', type: DnsStateCard, path: '[Molecules]/cards')
Widget dnsStateCardRefreshing(final BuildContext context) => CatalogCase(
  key: const ValueKey('DnsStateCard/refreshing'),
  id: 'DnsStateCard/refreshing',
  variant: 'refreshing',
  host: PreviewHost.content,
  width: 560,
  height: 250,
  builder: (final context, final fixtures, final controller, final update) =>
      DnsStateCard(
        dnsState: DnsRecordsStatus.refreshing,
        fixCallback: () => catalogActions.record('Fix DNS'),
      ),
);

@UseCase(name: 'good', type: DnsStateCard, path: '[Molecules]/cards')
Widget dnsStateCardGood(final BuildContext context) => CatalogCase(
  key: const ValueKey('DnsStateCard/good'),
  id: 'DnsStateCard/good',
  variant: 'good',
  host: PreviewHost.content,
  width: 560,
  height: 250,
  builder: (final context, final fixtures, final controller, final update) =>
      DnsStateCard(
        dnsState: DnsRecordsStatus.good,
        fixCallback: () => catalogActions.record('Fix DNS'),
      ),
);

@UseCase(name: 'error', type: DnsStateCard, path: '[Molecules]/cards')
Widget dnsStateCardError(final BuildContext context) => CatalogCase(
  key: const ValueKey('DnsStateCard/error'),
  id: 'DnsStateCard/error',
  variant: 'error',
  host: PreviewHost.content,
  width: 560,
  height: 250,
  builder: (final context, final fixtures, final controller, final update) =>
      DnsStateCard(
        dnsState: DnsRecordsStatus.error,
        fixCallback: () => catalogActions.record('Fix DNS'),
      ),
);
