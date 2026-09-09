import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/cards/service_status.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'failed', type: ServiceStatusCard, path: '[Molecules]/cards')
Widget serviceStatusCardFailed(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServiceStatusCard/failed'),
  id: 'ServiceStatusCard/failed',
  variant: 'failed',
  host: PreviewHost.content,
  width: 560,
  height: 150,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServiceStatusCard(status: ServiceStatus.failed),
);

@UseCase(name: 'reloading', type: ServiceStatusCard, path: '[Molecules]/cards')
Widget serviceStatusCardReloading(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServiceStatusCard/reloading'),
  id: 'ServiceStatusCard/reloading',
  variant: 'reloading',
  host: PreviewHost.content,
  width: 560,
  height: 150,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServiceStatusCard(status: ServiceStatus.reloading),
);

@UseCase(name: 'activating', type: ServiceStatusCard, path: '[Molecules]/cards')
Widget serviceStatusCardActivating(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServiceStatusCard/activating'),
  id: 'ServiceStatusCard/activating',
  variant: 'activating',
  host: PreviewHost.content,
  width: 560,
  height: 150,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServiceStatusCard(status: ServiceStatus.activating),
);

@UseCase(name: 'active', type: ServiceStatusCard, path: '[Molecules]/cards')
Widget serviceStatusCardActive(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServiceStatusCard/active'),
  id: 'ServiceStatusCard/active',
  variant: 'active',
  host: PreviewHost.content,
  width: 560,
  height: 150,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServiceStatusCard(status: ServiceStatus.active),
);

@UseCase(
  name: 'deactivating',
  type: ServiceStatusCard,
  path: '[Molecules]/cards',
)
Widget serviceStatusCardDeactivating(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServiceStatusCard/deactivating'),
  id: 'ServiceStatusCard/deactivating',
  variant: 'deactivating',
  host: PreviewHost.content,
  width: 560,
  height: 150,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServiceStatusCard(status: ServiceStatus.deactivating),
);

@UseCase(name: 'inactive', type: ServiceStatusCard, path: '[Molecules]/cards')
Widget serviceStatusCardInactive(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServiceStatusCard/inactive'),
  id: 'ServiceStatusCard/inactive',
  variant: 'inactive',
  host: PreviewHost.content,
  width: 560,
  height: 150,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServiceStatusCard(status: ServiceStatus.inactive),
);

@UseCase(name: 'off', type: ServiceStatusCard, path: '[Molecules]/cards')
Widget serviceStatusCardOff(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServiceStatusCard/off'),
  id: 'ServiceStatusCard/off',
  variant: 'off',
  host: PreviewHost.content,
  width: 560,
  height: 150,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServiceStatusCard(status: ServiceStatus.off),
);
