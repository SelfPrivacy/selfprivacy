import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/cards/services_page_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'failed', type: ServicesPageCard, path: '[Molecules]/cards')
Widget servicesPageCardFailed(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServicesPageCard/failed'),
  id: 'ServicesPageCard/failed',
  variant: 'failed',
  host: PreviewHost.content,
  width: 560,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      ServicesPageCard(
        service: demoService(
          status: ServiceStatus.failed,
          system: false,
          noIcon: false,
          id: 'nextcloud',
        ),
      ),
);

@UseCase(name: 'reloading', type: ServicesPageCard, path: '[Molecules]/cards')
Widget servicesPageCardReloading(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServicesPageCard/reloading'),
  id: 'ServicesPageCard/reloading',
  variant: 'reloading',
  host: PreviewHost.content,
  width: 560,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      ServicesPageCard(
        service: demoService(
          status: ServiceStatus.reloading,
          system: false,
          noIcon: false,
          id: 'nextcloud',
        ),
      ),
);

@UseCase(name: 'activating', type: ServicesPageCard, path: '[Molecules]/cards')
Widget servicesPageCardActivating(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServicesPageCard/activating'),
  id: 'ServicesPageCard/activating',
  variant: 'activating',
  host: PreviewHost.content,
  width: 560,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      ServicesPageCard(
        service: demoService(
          status: ServiceStatus.activating,
          system: false,
          noIcon: false,
          id: 'nextcloud',
        ),
      ),
);

@UseCase(name: 'active', type: ServicesPageCard, path: '[Molecules]/cards')
Widget servicesPageCardActive(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServicesPageCard/active'),
  id: 'ServicesPageCard/active',
  variant: 'active',
  host: PreviewHost.content,
  width: 560,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      ServicesPageCard(
        service: demoService(
          status: ServiceStatus.active,
          system: false,
          noIcon: false,
          id: 'nextcloud',
        ),
      ),
);

@UseCase(
  name: 'deactivating',
  type: ServicesPageCard,
  path: '[Molecules]/cards',
)
Widget servicesPageCardDeactivating(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServicesPageCard/deactivating'),
  id: 'ServicesPageCard/deactivating',
  variant: 'deactivating',
  host: PreviewHost.content,
  width: 560,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      ServicesPageCard(
        service: demoService(
          status: ServiceStatus.deactivating,
          system: false,
          noIcon: false,
          id: 'nextcloud',
        ),
      ),
);

@UseCase(name: 'inactive', type: ServicesPageCard, path: '[Molecules]/cards')
Widget servicesPageCardInactive(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServicesPageCard/inactive'),
  id: 'ServicesPageCard/inactive',
  variant: 'inactive',
  host: PreviewHost.content,
  width: 560,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      ServicesPageCard(
        service: demoService(
          status: ServiceStatus.inactive,
          system: false,
          noIcon: false,
          id: 'nextcloud',
        ),
      ),
);

@UseCase(name: 'off', type: ServicesPageCard, path: '[Molecules]/cards')
Widget servicesPageCardOff(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServicesPageCard/off'),
  id: 'ServicesPageCard/off',
  variant: 'off',
  host: PreviewHost.content,
  width: 560,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      ServicesPageCard(
        service: demoService(
          status: ServiceStatus.off,
          system: false,
          noIcon: false,
          id: 'nextcloud',
        ),
      ),
);

@UseCase(
  name: 'System service',
  type: ServicesPageCard,
  path: '[Molecules]/cards',
)
Widget servicesPageCardSystemService(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServicesPageCard/System service'),
  id: 'ServicesPageCard/System service',
  variant: 'System service',
  host: PreviewHost.content,
  width: 560,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      ServicesPageCard(
        service: demoService(
          status: ServiceStatus.active,
          system: true,
          noIcon: false,
          id: 'nextcloud',
        ),
      ),
);

@UseCase(name: 'No icon', type: ServicesPageCard, path: '[Molecules]/cards')
Widget servicesPageCardNoIcon(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServicesPageCard/No icon'),
  id: 'ServicesPageCard/No icon',
  variant: 'No icon',
  host: PreviewHost.content,
  width: 560,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      ServicesPageCard(
        service: demoService(
          status: ServiceStatus.active,
          system: false,
          noIcon: true,
          id: 'nextcloud',
        ),
      ),
);

@UseCase(name: 'Mail', type: ServicesPageCard, path: '[Molecules]/cards')
Widget servicesPageCardMail(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServicesPageCard/Mail'),
  id: 'ServicesPageCard/Mail',
  variant: 'Mail',
  host: PreviewHost.content,
  width: 560,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      ServicesPageCard(
        service: demoService(
          status: ServiceStatus.active,
          system: false,
          noIcon: false,
          id: 'simple-nixos-mailserver',
        ),
      ),
);

@UseCase(
  name: 'Not configured',
  type: ServicesPageCard,
  path: '[Molecules]/cards',
)
Widget servicesPageCardNotConfigured(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServicesPageCard/Not configured'),
  id: 'ServicesPageCard/Not configured',
  variant: 'Not configured',
  host: PreviewHost.content,
  width: 560,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      ServicesPageCard(
        service: demoService(
          status: ServiceStatus.active,
          system: false,
          noIcon: false,
          id: 'nextcloud',
        ),
      ),
);
