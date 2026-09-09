import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/list_items/create_backup_checkbox_item.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(
  name: 'Selected',
  type: CreateBackupCheckboxItem,
  path: '[Molecules]/list_items',
)
Widget createBackupCheckboxItemSelected(final BuildContext context) {
  const variant = 'Selected';
  bool selected = true;
  return CatalogCase(
    key: const ValueKey('CreateBackupCheckboxItem/Selected'),
    id: 'CreateBackupCheckboxItem/Selected',
    variant: 'Selected',
    host: PreviewHost.content,
    width: 560,
    height: 200,
    builder: (final context, final fixtures, final controller, final update) =>
        CreateBackupCheckboxItem(
          service: demoService(),
          busy: variant == 'Busy',
          selected: selected,
          onChanged: (final next) => update(() => selected = next ?? false),
        ),
  );
}

@UseCase(
  name: 'Unselected',
  type: CreateBackupCheckboxItem,
  path: '[Molecules]/list_items',
)
Widget createBackupCheckboxItemUnselected(final BuildContext context) {
  const variant = 'Unselected';
  bool selected = false;
  return CatalogCase(
    key: const ValueKey('CreateBackupCheckboxItem/Unselected'),
    id: 'CreateBackupCheckboxItem/Unselected',
    variant: 'Unselected',
    host: PreviewHost.content,
    width: 560,
    height: 200,
    builder: (final context, final fixtures, final controller, final update) =>
        CreateBackupCheckboxItem(
          service: demoService(),
          busy: variant == 'Busy',
          selected: selected,
          onChanged: (final next) => update(() => selected = next ?? false),
        ),
  );
}

@UseCase(
  name: 'Busy',
  type: CreateBackupCheckboxItem,
  path: '[Molecules]/list_items',
)
Widget createBackupCheckboxItemBusy(final BuildContext context) {
  const variant = 'Busy';
  bool selected = false;
  return CatalogCase(
    key: const ValueKey('CreateBackupCheckboxItem/Busy'),
    id: 'CreateBackupCheckboxItem/Busy',
    variant: 'Busy',
    host: PreviewHost.content,
    width: 560,
    height: 200,
    builder: (final context, final fixtures, final controller, final update) =>
        CreateBackupCheckboxItem(
          service: demoService(),
          busy: variant == 'Busy',
          selected: selected,
          onChanged: (final next) => update(() => selected = next ?? false),
        ),
  );
}
