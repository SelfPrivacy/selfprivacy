import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';
import '../../layout_router_preview.dart';
import '../../layout_scroll_preview.dart';

@UseCase(name: 'Mobile', type: BrandHeroScreen, path: '[Layouts]')
Widget brandHeroScreenMobile(final BuildContext context) =>
    _example('Mobile', 390);

@UseCase(name: 'Desktop nested', type: BrandHeroScreen, path: '[Layouts]')
Widget brandHeroScreenDesktopNested(final BuildContext context) =>
    _example('Desktop nested', 1200);

@UseCase(name: 'Desktop standalone', type: BrandHeroScreen, path: '[Layouts]')
Widget brandHeroScreenDesktopStandalone(final BuildContext context) =>
    _example('Desktop standalone', 1200);

@UseCase(name: 'No icon', type: BrandHeroScreen, path: '[Layouts]')
Widget brandHeroScreenNoIcon(final BuildContext context) =>
    _example('No icon', 390);

@UseCase(name: 'Long title', type: BrandHeroScreen, path: '[Layouts]')
Widget brandHeroScreenLongTitle(final BuildContext context) =>
    _example('Long title', 390);

@UseCase(name: 'Collapsed', type: BrandHeroScreen, path: '[Layouts]')
Widget brandHeroScreenCollapsed(final BuildContext context) =>
    _example('Collapsed', 390);

@UseCase(name: 'With subtitle', type: BrandHeroScreen, path: '[Layouts]')
Widget brandHeroScreenWithSubtitle(final BuildContext context) =>
    _example('With subtitle', 390);

@UseCase(name: 'Jobs pending', type: BrandHeroScreen, path: '[Layouts]')
Widget brandHeroScreenJobsPending(final BuildContext context) =>
    _example('Jobs pending', 390);

CatalogCase _example(final String variant, final double width) => CatalogCase(
  key: ValueKey('BrandHeroScreen/$variant'),
  id: 'BrandHeroScreen/$variant',
  variant: variant == 'Jobs pending' ? 'Queued' : variant,
  host: PreviewHost.screen,
  width: width,
  height: 800,
  builder: (final context, final fixtures, final controller, final update) =>
      LayoutRouterPreview(
        detail: true,
        builder: (final context, final route) => LayoutScrollPreview(
          collapsed: variant == 'Collapsed',
          child: BrandHeroScreen(
            heroTitle: variant == 'Long title'
                ? 'Manage server storage, backups, and service configuration'
                : 'Server details',
            heroIcon: variant == 'No icon' ? null : Icons.dns_outlined,
            heroSubtitle: variant == 'With subtitle'
                ? 'Manage the resources used by your personal server.'
                : null,
            ignoreBreakpoints: variant == 'Desktop standalone',
            hasFlashButton: true,
            children: [
              for (var index = 0; index < 12; index++)
                ListTile(
                  title: Text('Storage volume ${index + 1}'),
                  subtitle: const Text('12 GiB of 40 GiB used'),
                  leading: const Icon(Icons.storage),
                ),
            ],
          ),
        ),
      ),
);
