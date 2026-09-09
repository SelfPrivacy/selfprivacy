import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/modals/backups/snapshot_modal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../../catalog_case.dart';
import '../../../../fixtures.dart';

import '../../../../preparation.dart';

@UseCase(
  name: 'Default',
  type: SnapshotModal,
  path: '[Organisms]/modals/backups',
)
Widget snapshotModalDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('SnapshotModal/Default'),
  id: 'SnapshotModal/Default',
  variant: 'Default',
  host: PreviewHost.sheet,
  width: 600,
  height: 1000,
  builder: (final context, final fixtures, final controller, final update) =>
      SnapshotModal(snapshot: demoBackup(), scrollController: controller),
);

@UseCase(name: 'Busy', type: SnapshotModal, path: '[Organisms]/modals/backups')
Widget snapshotModalBusy(final BuildContext context) => CatalogCase(
  key: const ValueKey('SnapshotModal/Busy'),
  id: 'SnapshotModal/Busy',
  variant: 'Busy',
  host: PreviewHost.sheet,
  width: 600,
  height: 1000,
  builder: (final context, final fixtures, final controller, final update) =>
      SnapshotModal(snapshot: demoBackup(), scrollController: controller),
);

@UseCase(
  name: 'Missing service',
  type: SnapshotModal,
  path: '[Organisms]/modals/backups',
)
Widget snapshotModalMissingService(final BuildContext context) => CatalogCase(
  key: const ValueKey('SnapshotModal/Missing service'),
  id: 'SnapshotModal/Missing service',
  variant: 'Missing service',
  host: PreviewHost.sheet,
  width: 600,
  height: 1000,
  builder: (final context, final fixtures, final controller, final update) =>
      SnapshotModal(snapshot: demoBackup(), scrollController: controller),
);

@UseCase(
  name: 'Inplace restore',
  type: SnapshotModal,
  path: '[Organisms]/modals/backups',
)
Widget snapshotModalInplaceRestore(final BuildContext context) => CatalogCase(
  key: const ValueKey('SnapshotModal/Inplace restore'),
  id: 'SnapshotModal/Inplace restore',
  variant: 'Inplace restore',
  prepare: PreviewAction.inplaceRestore,
  host: PreviewHost.sheet,
  width: 600,
  height: 1000,
  builder: (final context, final fixtures, final controller, final update) =>
      SnapshotModal(snapshot: demoBackup(), scrollController: controller),
);
