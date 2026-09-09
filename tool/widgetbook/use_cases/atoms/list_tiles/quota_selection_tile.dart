import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/quota_selection_tile.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

import '../../../preparation.dart';

@UseCase(name: 'Finite', type: QuotaSelectionTile, path: '[Atoms]/list_tiles')
Widget quotaSelectionTileFinite(final BuildContext context) {
  int quota = 7;
  return CatalogCase(
    key: const ValueKey('QuotaSelectionTile/Finite'),
    id: 'QuotaSelectionTile/Finite',
    variant: 'Finite',
    host: PreviewHost.content,
    width: 560,
    height: 300,
    builder: (final context, final fixtures, final controller, final update) =>
        QuotaSelectionTile(
          title: 'Daily backups',
          subtitle: 'Snapshots to retain',
          value: quota,
          min: 0,
          max: 30,
          callback: (final next) =>
              update(() => quota = next > 30 ? -1 : next.toInt()),
        ),
  );
}

@UseCase(
  name: 'Unlimited',
  type: QuotaSelectionTile,
  path: '[Atoms]/list_tiles',
)
Widget quotaSelectionTileUnlimited(final BuildContext context) {
  int quota = -1;
  return CatalogCase(
    key: const ValueKey('QuotaSelectionTile/Unlimited'),
    id: 'QuotaSelectionTile/Unlimited',
    variant: 'Unlimited',
    host: PreviewHost.content,
    width: 560,
    height: 300,
    builder: (final context, final fixtures, final controller, final update) =>
        QuotaSelectionTile(
          title: 'Daily backups',
          subtitle: 'Snapshots to retain',
          value: quota,
          min: 0,
          max: 30,
          callback: (final next) =>
              update(() => quota = next > 30 ? -1 : next.toInt()),
        ),
  );
}

@UseCase(name: 'Manual', type: QuotaSelectionTile, path: '[Atoms]/list_tiles')
Widget quotaSelectionTileManual(final BuildContext context) {
  int quota = 99;
  return CatalogCase(
    key: const ValueKey('QuotaSelectionTile/Manual'),
    id: 'QuotaSelectionTile/Manual',
    variant: 'Manual',
    host: PreviewHost.content,
    width: 560,
    height: 300,
    builder: (final context, final fixtures, final controller, final update) =>
        QuotaSelectionTile(
          title: 'Daily backups',
          subtitle: 'Snapshots to retain',
          value: quota,
          min: 0,
          max: 30,
          callback: (final next) =>
              update(() => quota = next > 30 ? -1 : next.toInt()),
        ),
  );
}

@UseCase(name: 'Expanded', type: QuotaSelectionTile, path: '[Atoms]/list_tiles')
Widget quotaSelectionTileExpanded(final BuildContext context) {
  int quota = 7;
  return CatalogCase(
    key: const ValueKey('QuotaSelectionTile/Expanded'),
    id: 'QuotaSelectionTile/Expanded',
    variant: 'Expanded',
    prepare: PreviewAction.expand,
    host: PreviewHost.content,
    width: 560,
    height: 300,
    builder: (final context, final fixtures, final controller, final update) =>
        QuotaSelectionTile(
          title: 'Daily backups',
          subtitle: 'Snapshots to retain',
          value: quota,
          min: 0,
          max: 30,
          callback: (final next) =>
              update(() => quota = next > 30 ? -1 : next.toInt()),
        ),
  );
}

@UseCase(
  name: 'Expanded manual',
  type: QuotaSelectionTile,
  path: '[Atoms]/list_tiles',
)
Widget quotaSelectionTileExpandedManual(final BuildContext context) {
  int quota = 99;
  return CatalogCase(
    key: const ValueKey('QuotaSelectionTile/Expanded manual'),
    id: 'QuotaSelectionTile/Expanded manual',
    variant: 'Expanded manual',
    prepare: PreviewAction.expand,
    host: PreviewHost.content,
    width: 560,
    height: 300,
    builder: (final context, final fixtures, final controller, final update) =>
        QuotaSelectionTile(
          title: 'Daily backups',
          subtitle: 'Snapshots to retain',
          value: quota,
          min: 0,
          max: 30,
          callback: (final next) =>
              update(() => quota = next > 30 ? -1 : next.toInt()),
        ),
  );
}
