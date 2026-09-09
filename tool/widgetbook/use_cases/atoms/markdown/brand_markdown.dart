import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/markdown/brand_md.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Article', type: BrandMarkdown, path: '[Atoms]/markdown')
Widget brandMarkdownArticle(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandMarkdown/Article'),
  id: 'BrandMarkdown/Article',
  variant: 'Article',
  host: PreviewHost.scroll,
  width: 560,
  height: 800,
  builder: (final context, final fixtures, final controller, final update) =>
      const BrandMarkdown(fileName: 'how_backblaze'),
);
