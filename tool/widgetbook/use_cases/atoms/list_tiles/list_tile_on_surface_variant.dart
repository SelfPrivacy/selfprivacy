import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/list_tile_on_surface_variant.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(
  name: 'Title',
  type: ListTileOnSurfaceVariant,
  path: '[Atoms]/list_tiles',
)
Widget listTileOnSurfaceVariantTitle(final BuildContext context) => CatalogCase(
  key: const ValueKey('ListTileOnSurfaceVariant/Title'),
  id: 'ListTileOnSurfaceVariant/Title',
  variant: 'Title',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      ListTileOnSurfaceVariant(
        title: 'Server',
        subtitle: null,
        leadingIcon: null,
        disableSubtitleOverflow: false,
        onTap: () => catalogActions.record('Selected'),
      ),
);

@UseCase(
  name: 'Subtitle',
  type: ListTileOnSurfaceVariant,
  path: '[Atoms]/list_tiles',
)
Widget listTileOnSurfaceVariantSubtitle(
  final BuildContext context,
) => CatalogCase(
  key: const ValueKey('ListTileOnSurfaceVariant/Subtitle'),
  id: 'ListTileOnSurfaceVariant/Subtitle',
  variant: 'Subtitle',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      ListTileOnSurfaceVariant(
        title: 'Server',
        subtitle: textKnob(
          context,
          'A very long server description for this personal cloud installation',
        ),
        leadingIcon: null,
        disableSubtitleOverflow: false,
        onTap: () => catalogActions.record('Selected'),
      ),
);

@UseCase(
  name: 'Icon',
  type: ListTileOnSurfaceVariant,
  path: '[Atoms]/list_tiles',
)
Widget listTileOnSurfaceVariantIcon(final BuildContext context) => CatalogCase(
  key: const ValueKey('ListTileOnSurfaceVariant/Icon'),
  id: 'ListTileOnSurfaceVariant/Icon',
  variant: 'Icon',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      ListTileOnSurfaceVariant(
        title: 'Server',
        subtitle: textKnob(
          context,
          'A very long server description for this personal cloud installation',
        ),
        leadingIcon: Icons.dns,
        disableSubtitleOverflow: false,
        onTap: () => catalogActions.record('Selected'),
      ),
);

@UseCase(
  name: 'Ellipsis',
  type: ListTileOnSurfaceVariant,
  path: '[Atoms]/list_tiles',
)
Widget listTileOnSurfaceVariantEllipsis(
  final BuildContext context,
) => CatalogCase(
  key: const ValueKey('ListTileOnSurfaceVariant/Ellipsis'),
  id: 'ListTileOnSurfaceVariant/Ellipsis',
  variant: 'Ellipsis',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      ListTileOnSurfaceVariant(
        title: 'Server',
        subtitle: textKnob(
          context,
          'A very long server description for this personal cloud installation',
        ),
        leadingIcon: null,
        disableSubtitleOverflow: true,
        onTap: () => catalogActions.record('Selected'),
      ),
);
