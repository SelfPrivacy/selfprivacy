import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/cards/server_outdated_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Default', type: ServerOutdatedCard, path: '[Molecules]/cards')
Widget serverOutdatedCardDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerOutdatedCard/Default'),
  id: 'ServerOutdatedCard/Default',
  variant: 'Default',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServerOutdatedCard(
        requiredVersion: '>=3.0.0',
        currentVersion: '2.9.0',
      ),
);
