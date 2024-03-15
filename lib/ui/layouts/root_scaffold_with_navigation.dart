import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/drawers/support_drawer.dart';
import 'package:selfprivacy/ui/components/pre_styled_buttons/flash_fab.dart';
import 'package:selfprivacy/ui/router/root_destinations.dart';
import 'package:selfprivacy/utils/breakpoints.dart';

class RootScaffoldWithNavigation extends StatelessWidget {
  const RootScaffoldWithNavigation({
    required this.child,
    required this.title,
    required this.destinations,
    this.showBottomBar = true,
    this.showFab = true,
    super.key,
  });

  final Widget child;
  final String title;
  final bool showBottomBar;
  final List<RouteDestination> destinations;
  final bool showFab;

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: Breakpoints.mediumAndUp.isActive(context)
          ? PreferredSize(
              preferredSize: const Size.fromHeight(52),
              child: _RootAppBar(title: title),
            )
          : null,
      endDrawer: const SupportDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: Row(
        children: [
          if (Breakpoints.medium.isActive(context))
            _MainScreenNavigationRail(
              destinations: destinations,
              showFab: showFab,
            ),
          if (Breakpoints.large.isActive(context))
            _MainScreenNavigationDrawer(
              destinations: destinations,
              showFab: showFab,
            ),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: _BottomBar(
        destinations: destinations,
        hidden: !(Breakpoints.small.isActive(context) && showBottomBar),
        key: const Key('bottomBar'),
      ),
      floatingActionButton:
          showFab && Breakpoints.small.isActive(context) && showBottomBar
              ? const BrandFab()
              : null,
    );
  }
}

class _RootAppBar extends StatelessWidget {
  const _RootAppBar({
    required this.title,
  });

  final String title;

  @override
  Widget build(final BuildContext context) => AppBar(
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder:
              (final Widget child, final Animation<double> animation) =>
                  SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: const Offset(0.0, 0.2),
                end: Offset.zero,
              ),
            ),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
          child: SizedBox(
            key: ValueKey<String>(title),
            width: double.infinity,
            child: Text(
              title,
            ),
          ),
        ),
        leading: context.router.pageCount > 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.router.pop(),
              )
            : null,
        actions: const [
          SizedBox.shrink(),
        ],
      );
}

class _MainScreenNavigationRail extends StatelessWidget {
  const _MainScreenNavigationRail({
    required this.destinations,
    this.showFab = true,
  });

  final List<RouteDestination> destinations;
  final bool showFab;

  @override
  Widget build(final BuildContext context) {
    int? activeIndex = destinations.indexWhere(
      (final destination) =>
          context.router.isRouteActive(destination.route.routeName),
    );

    final prevActiveIndex = destinations.indexWhere(
      (final destination) => context.router.stack
          .any((final route) => route.name == destination.route.routeName),
    );

    if (activeIndex == -1) {
      if (prevActiveIndex != -1) {
        activeIndex = prevActiveIndex;
      } else {
        activeIndex = 0;
      }
    }

    final isExtended = Breakpoints.large.isActive(context);

    return LayoutBuilder(
      builder: (final context, final constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: NavigationRail(
              backgroundColor: Colors.transparent,
              labelType: isExtended
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              extended: isExtended,
              leading: showFab
                  ? const BrandFab(
                      extended: false,
                    )
                  : null,
              groupAlignment: 0.0,
              destinations: destinations
                  .map(
                    (final destination) => NavigationRailDestination(
                      icon: Icon(destination.icon),
                      label: Text(destination.label),
                    ),
                  )
                  .toList(),
              selectedIndex: activeIndex,
              onDestinationSelected: (final index) {
                context.router.replaceAll([destinations[index].route]);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.destinations,
    required this.hidden,
    super.key,
  });

  final List<RouteDestination> destinations;
  final bool hidden;

  @override
  Widget build(final BuildContext context) {
    final prevActiveIndex = destinations.indexWhere(
      (final destination) => context.router.stack
          .any((final route) => route.name == destination.route.routeName),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: hidden ? 0 : 80,
      curve: Curves.easeInOutCubicEmphasized,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Platform.isIOS
          ? CupertinoTabBar(
              currentIndex: prevActiveIndex == -1 ? 0 : prevActiveIndex,
              onTap: (final index) {
                context.router.replaceAll([destinations[index].route]);
              },
              items: destinations
                  .map(
                    (final destination) => BottomNavigationBarItem(
                      icon: Icon(destination.icon),
                      label: destination.label,
                    ),
                  )
                  .toList(),
            )
          : NavigationBar(
              selectedIndex: prevActiveIndex == -1 ? 0 : prevActiveIndex,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              onDestinationSelected: (final index) {
                context.router.replaceAll([destinations[index].route]);
              },
              destinations: destinations
                  .map(
                    (final destination) => NavigationDestination(
                      icon: Icon(destination.icon),
                      label: destination.label,
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class _MainScreenNavigationDrawer extends StatelessWidget {
  const _MainScreenNavigationDrawer({
    required this.destinations,
    this.showFab = true,
  });

  final List<RouteDestination> destinations;
  final bool showFab;

  @override
  Widget build(final BuildContext context) {
    int? activeIndex = destinations.indexWhere(
      (final destination) =>
          context.router.isRouteActive(destination.route.routeName),
    );

    final prevActiveIndex = destinations.indexWhere(
      (final destination) => context.router.stack
          .any((final route) => route.name == destination.route.routeName),
    );

    if (activeIndex == -1) {
      if (prevActiveIndex != -1) {
        activeIndex = prevActiveIndex;
      } else {
        activeIndex = 0;
      }
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: 296,
      child: NavigationDrawer(
        key: const Key('PrimaryNavigationDrawer'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        selectedIndex: activeIndex,
        onDestinationSelected: (final index) {
          context.router.replaceAll([destinations[index].route]);
        },
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: BrandFab(extended: true),
          ),
          const SizedBox(height: 16),
          ...destinations.map(
            (final destination) => NavigationDrawerDestination(
              icon: Icon(destination.icon),
              label: Text(destination.label),
            ),
          ),
        ],
      ),
    );
  }
}
