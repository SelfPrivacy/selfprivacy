import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/modals/backups/change_period_modal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../../catalog_case.dart';

@UseCase(
  name: 'Enabled',
  type: ChangeAutobackupsPeriodModal,
  path: '[Organisms]/modals/backups',
)
Widget changeAutobackupsPeriodModalEnabled(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('ChangeAutobackupsPeriodModal/Enabled'),
      id: 'ChangeAutobackupsPeriodModal/Enabled',
      variant: 'Enabled',
      host: PreviewHost.sheet,
      width: 560,
      height: 750,
      builder:
          (final context, final fixtures, final controller, final update) =>
              ChangeAutobackupsPeriodModal(scrollController: controller),
    );

@UseCase(
  name: 'Disabled',
  type: ChangeAutobackupsPeriodModal,
  path: '[Organisms]/modals/backups',
)
Widget changeAutobackupsPeriodModalDisabled(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('ChangeAutobackupsPeriodModal/Disabled'),
      id: 'ChangeAutobackupsPeriodModal/Disabled',
      variant: 'Disabled',
      host: PreviewHost.sheet,
      width: 560,
      height: 750,
      builder:
          (final context, final fixtures, final controller, final update) =>
              ChangeAutobackupsPeriodModal(scrollController: controller),
    );
