import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/layouts/root_scaffold_with_subroute_selector/root_scaffold_with_subroute_selector.dart';
import 'package:selfprivacy/ui/router/root_destinations.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';
import '../../layout_router_preview.dart';

@UseCase(
  name: 'Mobile',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorMobile(final BuildContext context) =>
    _example('Mobile', 390);

@UseCase(
  name: 'Rail',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorRail(final BuildContext context) =>
    _example('Rail', 720);

@UseCase(
  name: 'Drawer',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorDrawer(final BuildContext context) =>
    _example('Drawer', 1200);

@UseCase(
  name: 'Below rail',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorBelowRail(final BuildContext context) =>
    _example('Below rail', 599);

@UseCase(
  name: 'Rail boundary',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorRailBoundary(
  final BuildContext context,
) => _example('Rail boundary', 600);

@UseCase(
  name: 'Below drawer',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorBelowDrawer(
  final BuildContext context,
) => _example('Below drawer', 839);

@UseCase(
  name: 'Drawer boundary',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorDrawerBoundary(
  final BuildContext context,
) => _example('Drawer boundary', 840);

@UseCase(
  name: 'Services selected',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorServicesSelected(
  final BuildContext context,
) => _example('Services selected', 720);

@UseCase(
  name: 'Users selected',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorUsersSelected(
  final BuildContext context,
) => _example('Users selected', 1200);

@UseCase(
  name: 'More selected',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorMoreSelected(
  final BuildContext context,
) => _example('More selected', 390);

@UseCase(
  name: 'Mobile detail',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorMobileDetail(
  final BuildContext context,
) => _example('Mobile detail', 390);

@UseCase(
  name: 'Desktop detail',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorDesktopDetail(
  final BuildContext context,
) => _example('Desktop detail', 1200);

@UseCase(
  name: 'Mobile without configured server',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorMobileWithoutConfiguredServer(
  final BuildContext context,
) => _example('Mobile without configured server', 390);

@UseCase(
  name: 'Rail without configured server',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorRailWithoutConfiguredServer(
  final BuildContext context,
) => _example('Rail without configured server', 720);

@UseCase(
  name: 'Drawer without configured server',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorDrawerWithoutConfiguredServer(
  final BuildContext context,
) => _example('Drawer without configured server', 1200);

@UseCase(
  name: 'Support open',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorSupportOpen(
  final BuildContext context,
) => _example('Support open', 1200);

@UseCase(
  name: 'Jobs pending',
  type: RootScaffoldWithSubrouteSelector,
  path: '[Layouts]',
)
Widget rootScaffoldWithSubrouteSelectorJobsPending(
  final BuildContext context,
) => _example('Jobs pending', 390);

CatalogCase _example(final String variant, final double width) => CatalogCase(
  key: ValueKey('RootScaffoldWithSubrouteSelector/$variant'),
  id: 'RootScaffoldWithSubrouteSelector/$variant',
  variant: variant.endsWith('without configured server')
      ? 'Not configured'
      : variant == 'Jobs pending'
      ? 'Queued'
      : variant,
  host: PreviewHost.screen,
  width: width,
  height: 800,
  builder: (final context, final fixtures, final controller, final update) =>
      LayoutRouterPreview(
        initialRoute: switch (variant) {
          'Services selected' => 'ServicesRoute',
          'Users selected' => 'UsersRoute',
          'More selected' => 'MoreRoute',
          _ => 'ProvidersRoute',
        },
        detail: variant.endsWith('detail'),
        builder: (final context, final route) =>
            RootScaffoldWithSubrouteSelector(
              destinations: rootDestinations,
              showBottomBar: route != 'ServerDetailsRoute',
              showFab: !variant.endsWith('without configured server'),
              child: _NavigationBody(
                route: route,
                openSupport: variant == 'Support open',
              ),
            ),
      ),
);

class _NavigationBody extends StatefulWidget {
  const _NavigationBody({required this.route, required this.openSupport});
  final String route;
  final bool openSupport;
  @override
  State<_NavigationBody> createState() => _NavigationBodyState();
}

class _NavigationBodyState extends State<_NavigationBody> {
  @override
  void initState() {
    super.initState();
    if (widget.openSupport) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Scaffold.of(context).openEndDrawer();
        }
      });
    }
  }

  @override
  Widget build(final BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          getRouteTitle(widget.route).tr(),
          key: const ValueKey('navigation-content-title'),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 24),
        if (widget.route == 'ServerDetailsRoute')
          OutlinedButton(
            onPressed: () => unawaited(context.router.maybePop()),
            child: Text('basis.back'.tr()),
          )
        else
          OutlinedButton(
            onPressed: () => unawaited(
              context.router.push(const PageRouteInfo('ServerDetailsRoute')),
            ),
            child: Text('server.card_title'.tr()),
          ),
        const SizedBox(height: 16),
        IconButton(
          tooltip: 'Support',
          onPressed: () => Scaffold.of(context).openEndDrawer(),
          icon: const Icon(Icons.help_outline),
        ),
      ],
    ),
  );
}
