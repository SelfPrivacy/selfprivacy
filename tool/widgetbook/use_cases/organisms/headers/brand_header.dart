import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/headers/brand_header.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Title', type: BrandHeader, path: '[Organisms]/headers')
Widget brandHeaderTitle(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandHeader/Title'),
  id: 'BrandHeader/Title',
  variant: 'Title',
  host: PreviewHost.header,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandHeader(
        title: textKnob(context, 'Services'),
        hasBackButton: false,
        onBackButtonPressed: () => catalogActions.record('Back'),
      ),
);

@UseCase(name: 'Back button', type: BrandHeader, path: '[Organisms]/headers')
Widget brandHeaderBackButton(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandHeader/Back button'),
  id: 'BrandHeader/Back button',
  variant: 'Back button',
  host: PreviewHost.header,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandHeader(
        title: textKnob(context, 'Services'),
        hasBackButton: true,
        onBackButtonPressed: () => catalogActions.record('Back'),
      ),
);
