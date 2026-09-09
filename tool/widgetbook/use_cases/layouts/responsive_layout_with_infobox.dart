import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:selfprivacy/ui/layouts/responsive_layout_with_infobox.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';

@UseCase(name: 'Stacked', type: ResponsiveLayoutWithInfobox, path: '[Layouts]')
Widget responsiveLayoutWithInfoboxStacked(final BuildContext context) =>
    _example('Stacked', 390);

@UseCase(
  name: 'Below columns',
  type: ResponsiveLayoutWithInfobox,
  path: '[Layouts]',
)
Widget responsiveLayoutWithInfoboxBelowColumns(final BuildContext context) =>
    _example('Below columns', 839);

@UseCase(
  name: 'Columns boundary',
  type: ResponsiveLayoutWithInfobox,
  path: '[Layouts]',
)
Widget responsiveLayoutWithInfoboxColumnsBoundary(final BuildContext context) =>
    _example('Columns boundary', 840);

@UseCase(name: 'Columns', type: ResponsiveLayoutWithInfobox, path: '[Layouts]')
Widget responsiveLayoutWithInfoboxColumns(final BuildContext context) =>
    _example('Columns', 1200);

@UseCase(
  name: 'Primary only',
  type: ResponsiveLayoutWithInfobox,
  path: '[Layouts]',
)
Widget responsiveLayoutWithInfoboxPrimaryOnly(final BuildContext context) =>
    _example('Primary only', 1200);

@UseCase(
  name: 'No header',
  type: ResponsiveLayoutWithInfobox,
  path: '[Layouts]',
)
Widget responsiveLayoutWithInfoboxNoHeader(final BuildContext context) =>
    _example('No header', 1200);

CatalogCase _example(final String variant, final double width) => CatalogCase(
  key: ValueKey('ResponsiveLayoutWithInfobox/$variant'),
  id: 'ResponsiveLayoutWithInfobox/$variant',
  variant: variant,
  width: width,
  height: 800,
  builder: (final context, final fixtures, final controller, final update) =>
      ResponsiveLayoutWithInfobox(
        topChild: variant == 'No header'
            ? null
            : Text(
                'Server storage',
                key: const ValueKey('layout-header'),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
        primaryColumn: const FilledCard(
          key: ValueKey('layout-primary'),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('System disk'),
                SizedBox(height: 16),
                LinearProgressIndicator(value: 0.3),
                SizedBox(height: 16),
                Text('12 GiB of 40 GiB used'),
              ],
            ),
          ),
        ),
        secondaryColumn: variant == 'Primary only'
            ? null
            : const InfoBox(
                key: ValueKey('layout-secondary'),
                text:
                    'Keep free space available for system updates and backups.',
              ),
      ),
);
