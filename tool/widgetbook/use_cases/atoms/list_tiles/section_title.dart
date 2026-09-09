import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/section_title.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Default', type: SectionTitle, path: '[Atoms]/list_tiles')
Widget sectionTitleDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('SectionTitle/Default'),
  id: 'SectionTitle/Default',
  variant: 'Default',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      SectionTitle(title: textKnob(context, 'Backups'), error: false),
);

@UseCase(name: 'Error', type: SectionTitle, path: '[Atoms]/list_tiles')
Widget sectionTitleError(final BuildContext context) => CatalogCase(
  key: const ValueKey('SectionTitle/Error'),
  id: 'SectionTitle/Error',
  variant: 'Error',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      SectionTitle(title: textKnob(context, 'Backups'), error: true),
);
