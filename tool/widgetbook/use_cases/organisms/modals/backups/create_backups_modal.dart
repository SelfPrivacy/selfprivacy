import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/modals/backups/create_backups_modal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../../catalog_case.dart';
import '../../../../fixtures.dart';

import '../../../../preparation.dart';

@UseCase(
  name: 'Selected',
  type: CreateBackupsModal,
  path: '[Organisms]/modals/backups',
)
Widget createBackupsModalSelected(final BuildContext context) => CatalogCase(
  key: const ValueKey('CreateBackupsModal/Selected'),
  id: 'CreateBackupsModal/Selected',
  variant: 'Selected',
  host: PreviewHost.sheet,
  width: 560,
  height: 650,
  builder: (final context, final fixtures, final controller, final update) =>
      CreateBackupsModal(
        services: [demoService()],
        scrollController: controller,
      ),
);

@UseCase(
  name: 'Empty',
  type: CreateBackupsModal,
  path: '[Organisms]/modals/backups',
)
Widget createBackupsModalEmpty(final BuildContext context) => CatalogCase(
  key: const ValueKey('CreateBackupsModal/Empty'),
  id: 'CreateBackupsModal/Empty',
  variant: 'Empty',
  host: PreviewHost.sheet,
  width: 560,
  height: 650,
  builder: (final context, final fixtures, final controller, final update) =>
      CreateBackupsModal(services: const [], scrollController: controller),
);

@UseCase(
  name: 'Busy',
  type: CreateBackupsModal,
  path: '[Organisms]/modals/backups',
)
Widget createBackupsModalBusy(final BuildContext context) => CatalogCase(
  key: const ValueKey('CreateBackupsModal/Busy'),
  id: 'CreateBackupsModal/Busy',
  variant: 'Busy',
  host: PreviewHost.sheet,
  width: 560,
  height: 650,
  builder: (final context, final fixtures, final controller, final update) =>
      CreateBackupsModal(
        services: [demoService()],
        scrollController: controller,
      ),
);

@UseCase(
  name: 'Unselected',
  type: CreateBackupsModal,
  path: '[Organisms]/modals/backups',
)
Widget createBackupsModalUnselected(final BuildContext context) => CatalogCase(
  key: const ValueKey('CreateBackupsModal/Unselected'),
  id: 'CreateBackupsModal/Unselected',
  variant: 'Unselected',
  prepare: PreviewAction.deselectBackups,
  host: PreviewHost.sheet,
  width: 560,
  height: 650,
  builder: (final context, final fixtures, final controller, final update) =>
      CreateBackupsModal(
        services: [demoService()],
        scrollController: controller,
      ),
);
