import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/link_list_tile.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Link', type: LinkListTile, path: '[Atoms]/list_tiles')
Widget linkListTileLink(final BuildContext context) => CatalogCase(
  key: const ValueKey('LinkListTile/Link'),
  id: 'LinkListTile/Link',
  variant: 'Link',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      LinkListTile(
        title: 'Website',
        subtitle: textKnob(context, 'https://example.org'),
        icon: Icons.link,
        uri: 'https://example.org',
      ),
);

@UseCase(name: 'No link', type: LinkListTile, path: '[Atoms]/list_tiles')
Widget linkListTileNoLink(final BuildContext context) => CatalogCase(
  key: const ValueKey('LinkListTile/No link'),
  id: 'LinkListTile/No link',
  variant: 'No link',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      LinkListTile(
        title: 'Website',
        subtitle: textKnob(context, 'https://example.org'),
        icon: Icons.link,
        uri: null,
      ),
);

@UseCase(name: 'Long subtitle', type: LinkListTile, path: '[Atoms]/list_tiles')
Widget linkListTileLongSubtitle(final BuildContext context) => CatalogCase(
  key: const ValueKey('LinkListTile/Long subtitle'),
  id: 'LinkListTile/Long subtitle',
  variant: 'Long subtitle',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      LinkListTile(
        title: 'Website',
        subtitle: textKnob(
          context,
          'https://cloud.example.org/a-long-resource-name/shared-with-the-family',
        ),
        icon: Icons.link,
        uri: 'https://example.org',
      ),
);
