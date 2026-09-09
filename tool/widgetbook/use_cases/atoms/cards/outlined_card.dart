import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/cards/outlined_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Default', type: OutlinedCard, path: '[Atoms]/cards')
Widget outlinedCardDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('OutlinedCard/Default'),
  id: 'OutlinedCard/Default',
  variant: 'Default',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      const OutlinedCard(
        borderColor: null,
        borderWidth: null,
        child: ListTile(
          title: Text('Storage volume'),
          subtitle: Text('40 GiB'),
        ),
      ),
);

@UseCase(name: 'Custom border', type: OutlinedCard, path: '[Atoms]/cards')
Widget outlinedCardCustomBorder(final BuildContext context) => CatalogCase(
  key: const ValueKey('OutlinedCard/Custom border'),
  id: 'OutlinedCard/Custom border',
  variant: 'Custom border',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      OutlinedCard(
        borderColor: Theme.of(context).colorScheme.primary,
        borderWidth: 3,
        child: const ListTile(
          title: Text('Storage volume'),
          subtitle: Text('40 GiB'),
        ),
      ),
);
