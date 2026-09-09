import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/cards/not_ready_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Default', type: NotReadyCard, path: '[Molecules]/cards')
Widget notReadyCardDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('NotReadyCard/Default'),
  id: 'NotReadyCard/Default',
  variant: 'Default',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      const NotReadyCard(),
);
