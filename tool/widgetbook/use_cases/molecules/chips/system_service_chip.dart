import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/chips/support_level_chip.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

import '../../../preparation.dart';

@UseCase(name: 'Default', type: SystemServiceChip, path: '[Molecules]/chips')
Widget systemServiceChipDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('SystemServiceChip/Default'),
  id: 'SystemServiceChip/Default',
  variant: 'Default',
  host: PreviewHost.content,
  width: 560,
  height: 160,
  builder: (final context, final fixtures, final controller, final update) =>
      const SystemServiceChip(dense: false),
);

@UseCase(name: 'Dense', type: SystemServiceChip, path: '[Molecules]/chips')
Widget systemServiceChipDense(final BuildContext context) => CatalogCase(
  key: const ValueKey('SystemServiceChip/Dense'),
  id: 'SystemServiceChip/Dense',
  variant: 'Dense',
  host: PreviewHost.content,
  width: 560,
  height: 160,
  builder: (final context, final fixtures, final controller, final update) =>
      const SystemServiceChip(dense: true),
);

@UseCase(
  name: 'Explanation',
  type: SystemServiceChip,
  path: '[Molecules]/chips',
)
Widget systemServiceChipExplanation(final BuildContext context) => CatalogCase(
  key: const ValueKey('SystemServiceChip/Explanation'),
  id: 'SystemServiceChip/Explanation',
  variant: 'Explanation',
  prepare: PreviewAction.chipDialog,
  host: PreviewHost.content,
  width: 560,
  height: 600,
  builder: (final context, final fixtures, final controller, final update) =>
      const SystemServiceChip(dense: false),
);
