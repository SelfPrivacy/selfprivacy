import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/buttons/flash_fab.dart';
import 'package:selfprivacy/ui/organisms/drawers/support_drawer.dart';
import 'package:selfprivacy/ui/router/root_destinations.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/breakpoints.dart';

part 'bottom_tab_bar.dart';
part 'navigation_drawer.dart';
part 'navigation_rail.dart';
part 'root_app_bar.dart';
part 'subroute_selector.dart';

class RootScaffoldWithSubrouteSelector extends StatelessWidget {
  const RootScaffoldWithSubrouteSelector({
    required this.child,
    required this.destinations,
    this.showBottomBar = true,
    this.showFab = true,
    super.key,
  });

  final Widget child;
  final bool showBottomBar;
  final List<RouteDestination> destinations;
  final bool showFab;

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar:
        Breakpoints.mediumAndUp.isActive(context)
            ? _RootAppBar(
              title: getRouteTitle(context.router.current.name).tr(),
            )
            : null,
    endDrawer: const SupportDrawer(),
    endDrawerEnableOpenDragGesture: false,
    body: Row(
      children: [
        if (Breakpoints.medium.isActive(context))
          _NavigationRail(subroutes: destinations, showFab: showFab)
        else if (Breakpoints.large.isActive(context))
          _NavigationDrawer(subroutes: destinations, showFab: showFab),
        Expanded(child: child),
      ],
    ),
    bottomNavigationBar: _BottomTabBar(
      key: const ValueKey('bottomBar'),
      subroutes: destinations,
      hidden: !(Breakpoints.small.isActive(context) && showBottomBar),
    ),
    floatingActionButton:
        showFab && Breakpoints.small.isActive(context) && showBottomBar
            ? const BrandFab()
            : null,
  );
}
