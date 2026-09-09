import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/cards/server_text_details_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Loaded', type: ServerTextDetailsCard, path: '[Molecules]/cards')
Widget serverTextDetailsCardLoaded(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerTextDetailsCard/Loaded'),
  id: 'ServerTextDetailsCard/Loaded',
  variant: 'Loaded',
  host: PreviewHost.content,
  width: 560,
  height: 850,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServerTextDetailsCard(),
);

@UseCase(
  name: 'Loading',
  type: ServerTextDetailsCard,
  path: '[Molecules]/cards',
)
Widget serverTextDetailsCardLoading(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerTextDetailsCard/Loading'),
  id: 'ServerTextDetailsCard/Loading',
  variant: 'Loading',
  host: PreviewHost.content,
  width: 560,
  height: 850,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServerTextDetailsCard(),
);

@UseCase(
  name: 'Not ready',
  type: ServerTextDetailsCard,
  path: '[Molecules]/cards',
)
Widget serverTextDetailsCardNotReady(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerTextDetailsCard/Not ready'),
  id: 'ServerTextDetailsCard/Not ready',
  variant: 'Not ready',
  host: PreviewHost.content,
  width: 560,
  height: 850,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServerTextDetailsCard(),
);
