import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/section_headline.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Title', type: SectionHeadline, path: '[Atoms]/list_tiles')
Widget sectionHeadlineTitle(final BuildContext context) => CatalogCase(
  key: const ValueKey('SectionHeadline/Title'),
  id: 'SectionHeadline/Title',
  variant: 'Title',
  host: PreviewHost.content,
  width: 560,
  height: 160,
  builder: (final context, final fixtures, final controller, final update) =>
      SectionHeadline(title: textKnob(context, 'Backups'), subtitle: null),
);

@UseCase(name: 'Subtitle', type: SectionHeadline, path: '[Atoms]/list_tiles')
Widget sectionHeadlineSubtitle(final BuildContext context) => CatalogCase(
  key: const ValueKey('SectionHeadline/Subtitle'),
  id: 'SectionHeadline/Subtitle',
  variant: 'Subtitle',
  host: PreviewHost.content,
  width: 560,
  height: 160,
  builder: (final context, final fixtures, final controller, final update) =>
      SectionHeadline(
        title: textKnob(context, 'Backups'),
        subtitle: 'Automatic and manual snapshots',
      ),
);
