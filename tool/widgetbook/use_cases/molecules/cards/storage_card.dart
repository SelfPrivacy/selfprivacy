import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/cards/storage_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'Healthy', type: StorageCard, path: '[Molecules]/cards')
Widget storageCardHealthy(final BuildContext context) => CatalogCase(
  key: const ValueKey('StorageCard/Healthy'),
  id: 'StorageCard/Healthy',
  variant: 'Healthy',
  host: PreviewHost.content,
  width: 560,
  height: 400,
  builder: (final context, final fixtures, final controller, final update) =>
      StorageCard(diskStatus: demoDisks(full: false, empty: false)),
);

@UseCase(name: 'Full', type: StorageCard, path: '[Molecules]/cards')
Widget storageCardFull(final BuildContext context) => CatalogCase(
  key: const ValueKey('StorageCard/Full'),
  id: 'StorageCard/Full',
  variant: 'Full',
  host: PreviewHost.content,
  width: 560,
  height: 400,
  builder: (final context, final fixtures, final controller, final update) =>
      StorageCard(diskStatus: demoDisks(full: true, empty: false)),
);

@UseCase(name: 'Loading', type: StorageCard, path: '[Molecules]/cards')
Widget storageCardLoading(final BuildContext context) => CatalogCase(
  key: const ValueKey('StorageCard/Loading'),
  id: 'StorageCard/Loading',
  variant: 'Loading',
  host: PreviewHost.content,
  width: 560,
  height: 400,
  builder: (final context, final fixtures, final controller, final update) =>
      StorageCard(diskStatus: demoDisks(full: false, empty: true)),
);

@UseCase(name: 'Not configured', type: StorageCard, path: '[Molecules]/cards')
Widget storageCardNotConfigured(final BuildContext context) => CatalogCase(
  key: const ValueKey('StorageCard/Not configured'),
  id: 'StorageCard/Not configured',
  variant: 'Not configured',
  host: PreviewHost.content,
  width: 560,
  height: 400,
  builder: (final context, final fixtures, final controller, final update) =>
      StorageCard(diskStatus: demoDisks(full: false, empty: false)),
);
