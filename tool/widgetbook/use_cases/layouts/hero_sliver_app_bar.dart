import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';
import '../../layout_router_preview.dart';
import '../../layout_scroll_preview.dart';

@UseCase(name: 'Mobile', type: HeroSliverAppBar, path: '[Layouts]')
Widget heroSliverAppBarMobile(final BuildContext context) =>
    _example('Mobile', 390);

@UseCase(name: 'Desktop nested', type: HeroSliverAppBar, path: '[Layouts]')
Widget heroSliverAppBarDesktopNested(final BuildContext context) =>
    _example('Desktop nested', 1200);

@UseCase(name: 'Desktop standalone', type: HeroSliverAppBar, path: '[Layouts]')
Widget heroSliverAppBarDesktopStandalone(final BuildContext context) =>
    _example('Desktop standalone', 1200);

@UseCase(name: 'No icon', type: HeroSliverAppBar, path: '[Layouts]')
Widget heroSliverAppBarNoIcon(final BuildContext context) =>
    _example('No icon', 390);

@UseCase(name: 'Long title', type: HeroSliverAppBar, path: '[Layouts]')
Widget heroSliverAppBarLongTitle(final BuildContext context) =>
    _example('Long title', 390);

@UseCase(name: 'Collapsed', type: HeroSliverAppBar, path: '[Layouts]')
Widget heroSliverAppBarCollapsed(final BuildContext context) =>
    _example('Collapsed', 390);

CatalogCase _example(final String variant, final double width) => CatalogCase(
  key: ValueKey('HeroSliverAppBar/$variant'),
  id: 'HeroSliverAppBar/$variant',
  variant: variant == 'Jobs pending' ? 'Queued' : variant,
  host: PreviewHost.screen,
  width: width,
  height: 800,
  builder: (final context, final fixtures, final controller, final update) =>
      LayoutRouterPreview(
        detail: true,
        builder: (final context, final route) => LayoutScrollPreview(
          collapsed: variant == 'Collapsed',
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                HeroSliverAppBar(
                  heroTitle: variant == 'Long title'
                      ? 'Manage server storage, backups, and service configuration'
                      : 'Server details',
                  hasHeroIcon: variant != 'No icon',
                  heroIconWidget: const Icon(Icons.dns_outlined, size: 48),
                  hasBackButton: true,
                  onBackButtonPressed: null,
                  hasFlashButton: true,
                  ignoreBreakpoints: variant == 'Desktop standalone',
                ),
                SliverList.list(
                  children: [
                    for (var index = 0; index < 12; index++)
                      ListTile(
                        title: Text('Storage volume ${index + 1}'),
                        subtitle: const Text('12 GiB of 40 GiB used'),
                        leading: const Icon(Icons.storage),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
);
