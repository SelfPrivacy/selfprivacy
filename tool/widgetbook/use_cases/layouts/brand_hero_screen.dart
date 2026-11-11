import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/timezone_selection_tile.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';
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

@UseCase(name: 'Search and footer', type: BrandHeroScreen, path: '[Layouts]')
Widget brandHeroScreenSearchAndFooter(final BuildContext context) =>
    _example('Search and footer', 390);

@UseCase(name: 'Search open', type: BrandHeroScreen, path: '[Layouts]')
Widget brandHeroScreenSearchOpen(final BuildContext context) =>
    _example('Search open', 390);

@UseCase(name: 'Search scrolled', type: BrandHeroScreen, path: '[Layouts]')
Widget brandHeroScreenSearchScrolled(final BuildContext context) =>
    _example('Search scrolled', 390);

@UseCase(name: 'Search desktop', type: BrandHeroScreen, path: '[Layouts]')
Widget brandHeroScreenSearchDesktop(final BuildContext context) =>
    _example('Search desktop', 1200);

CatalogCase _example(final String variant, final double width) {
  final hasSearch = variant.startsWith('Search');
  var searching = variant == 'Search open';
  var filter = '';
  String? selected = 'Europe/Berlin';
  if (hasSearch) {
    initializeTimeZones();
  }
  return CatalogCase(
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
            collapsed: variant == 'Collapsed' || variant == 'Search scrolled',
            child: RadioGroup<String>(
              groupValue: selected,
              onChanged: (final value) => update(() => selected = value),
              child: BrandHeroScreen(
                heroTitle: hasSearch
                    ? 'Select time zone'
                    : variant == 'Long title'
                    ? 'Manage server storage, backups, and service configuration'
                    : 'Server details',
                heroIcon: hasSearch
                    ? Icons.schedule
                    : variant == 'No icon'
                    ? null
                    : Icons.dns_outlined,
                heroSubtitle: variant == 'With subtitle'
                    ? 'Manage the resources used by your personal server.'
                    : null,
                ignoreBreakpoints: variant == 'Desktop standalone',
                hasFlashButton: !searching,
                pinned: hasSearch,
                appBarTitle: searching
                    ? TextField(
                        decoration: const InputDecoration(
                          hintText: 'City, time zone or GMT offset',
                          border: InputBorder.none,
                        ),
                        onChanged: (final value) =>
                            update(() => filter = value.toLowerCase()),
                      )
                    : null,
                actions: [
                  if (hasSearch)
                    IconButton(
                      tooltip: searching
                          ? MaterialLocalizations.of(context).closeButtonTooltip
                          : MaterialLocalizations.of(context).searchFieldLabel,
                      icon: Icon(searching ? Icons.close : Icons.search),
                      onPressed: () => update(() {
                        searching = !searching;
                        filter = '';
                      }),
                    ),
                ],
                bottomBar: hasSearch
                    ? SafeArea(
                        top: false,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () => catalogActions.record(
                                'Queue time zone: $selected',
                              ),
                              child: const Text('Queue change'),
                            ),
                          ),
                        ),
                      )
                    : null,
                children: [
                  if (hasSearch) ...[
                    TimezoneSelectionTile(
                      location: getLocation('Asia/Kathmandu'),
                      title: 'Device time zone',
                      now: DateTime.utc(2026, 1, 15, 12),
                      value: 'device',
                    ),
                    for (final id in [
                      'Europe/London',
                      'Europe/Berlin',
                      'Europe/Paris',
                      'Europe/Kaliningrad',
                      'Europe/Samara',
                      'Asia/Kathmandu',
                      'Asia/Tokyo',
                      'Pacific/Kiritimati',
                    ])
                      if (id.toLowerCase().contains(filter))
                        TimezoneSelectionTile(
                          location: getLocation(id),
                          now: DateTime.utc(2026, 1, 15, 12),
                        ),
                  ] else
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
        ),
  );
}
