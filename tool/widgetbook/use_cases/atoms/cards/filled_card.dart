import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Default', type: FilledCard, path: '[Atoms]/cards')
Widget filledCardDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('FilledCard/Default'),
  id: 'FilledCard/Default',
  variant: 'Default',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      const FilledCard(
        secondary: false,
        tertiary: false,
        error: false,
        child: ListTile(
          title: Text('Server storage'),
          subtitle: Text('12 GiB used of 40 GiB'),
        ),
      ),
);

@UseCase(name: 'Secondary', type: FilledCard, path: '[Atoms]/cards')
Widget filledCardSecondary(final BuildContext context) => CatalogCase(
  key: const ValueKey('FilledCard/Secondary'),
  id: 'FilledCard/Secondary',
  variant: 'Secondary',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      const FilledCard(
        secondary: true,
        tertiary: false,
        error: false,
        child: ListTile(
          title: Text('Server storage'),
          subtitle: Text('12 GiB used of 40 GiB'),
        ),
      ),
);

@UseCase(name: 'Tertiary', type: FilledCard, path: '[Atoms]/cards')
Widget filledCardTertiary(final BuildContext context) => CatalogCase(
  key: const ValueKey('FilledCard/Tertiary'),
  id: 'FilledCard/Tertiary',
  variant: 'Tertiary',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      const FilledCard(
        secondary: false,
        tertiary: true,
        error: false,
        child: ListTile(
          title: Text('Server storage'),
          subtitle: Text('12 GiB used of 40 GiB'),
        ),
      ),
);

@UseCase(name: 'Error', type: FilledCard, path: '[Atoms]/cards')
Widget filledCardError(final BuildContext context) => CatalogCase(
  key: const ValueKey('FilledCard/Error'),
  id: 'FilledCard/Error',
  variant: 'Error',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      const FilledCard(
        secondary: false,
        tertiary: false,
        error: true,
        child: ListTile(
          title: Text('Server storage'),
          subtitle: Text('12 GiB used of 40 GiB'),
        ),
      ),
);
