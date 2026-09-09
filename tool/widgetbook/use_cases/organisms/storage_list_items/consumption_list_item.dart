import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/storage_list_items/server_storage_list_item.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(
  name: 'Default',
  type: ConsumptionListItem,
  path: '[Organisms]/storage_list_items',
)
Widget consumptionListItemDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('ConsumptionListItem/Default'),
  id: 'ConsumptionListItem/Default',
  variant: 'Default',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      ConsumptionListItem(
        title: 'Data volume',
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        percentage: numberKnob(context, 0.45),
        subtitle: null,
        rightSideText: '18 / 40 GiB',
        icon: const Icon(Icons.storage_outlined),
        dense: false,
      ),
);

@UseCase(
  name: 'Details',
  type: ConsumptionListItem,
  path: '[Organisms]/storage_list_items',
)
Widget consumptionListItemDetails(final BuildContext context) => CatalogCase(
  key: const ValueKey('ConsumptionListItem/Details'),
  id: 'ConsumptionListItem/Details',
  variant: 'Details',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      ConsumptionListItem(
        title: 'Data volume',
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        percentage: numberKnob(context, 0.45),
        subtitle: 'Files and backups',
        rightSideText: '18 / 40 GiB',
        icon: const Icon(Icons.storage_outlined),
        dense: false,
      ),
);

@UseCase(
  name: 'Dense',
  type: ConsumptionListItem,
  path: '[Organisms]/storage_list_items',
)
Widget consumptionListItemDense(final BuildContext context) => CatalogCase(
  key: const ValueKey('ConsumptionListItem/Dense'),
  id: 'ConsumptionListItem/Dense',
  variant: 'Dense',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      ConsumptionListItem(
        title: 'Data volume',
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        percentage: numberKnob(context, 0.45),
        subtitle: null,
        rightSideText: '18 / 40 GiB',
        icon: const Icon(Icons.storage_outlined),
        dense: true,
      ),
);
