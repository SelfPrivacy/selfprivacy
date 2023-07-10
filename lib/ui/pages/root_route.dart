import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/layouts/root_scaffold_with_navigation.dart';
import 'package:selfprivacy/ui/router/root_destinations.dart';

import 'package:selfprivacy/ui/router/router.dart';

@RoutePage()
class RootPage extends StatefulWidget implements AutoRouteWrapper {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();

  @override
  Widget wrappedRoute(final BuildContext context) => this;
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin {
  bool shouldUseSplitView() => false;

  final destinations = rootDestinations;

  @override
  Widget build(final BuildContext context) {
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;

    if (context.read<AppSettingsCubit>().state.isOnboardingShowing) {
      context.router.replace(const OnboardingRoute());
    }

    return AutoRouter(
      builder: (final context, final child) {
        final currentDestinationIndex = destinations.indexWhere(
          (final destination) =>
              context.router.isRouteActive(destination.route.routeName),
        );
        final isOtherRouterActive =
            context.router.root.current.name != RootRoute.name;
        final routeName = getRouteTitle(context.router.current.name).tr();
        return RootScaffoldWithNavigation(
          title: routeName,
          destinations: destinations,
          showBottomBar:
              !(currentDestinationIndex == -1 && !isOtherRouterActive),
          showFab: isReady,
          child: child,
        );
      },
    );
  }
}

class MainScreenNavigationRail extends StatelessWidget {
  const MainScreenNavigationRail({
    required this.destinations,
    super.key,
  });

  final List<RouteDestination> destinations;

  @override
  Widget build(final BuildContext context) {
    int? activeIndex = destinations.indexWhere(
      (final destination) =>
          context.router.isRouteActive(destination.route.routeName),
    );
    if (activeIndex == -1) {
      activeIndex = null;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: 72,
        child: LayoutBuilder(
          builder: (final context, final constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: NavigationRail(
                  backgroundColor: Colors.transparent,
                  labelType: NavigationRailLabelType.all,
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
        ),
      ),
    );
  }
}

class MainScreenNavigationDrawer extends StatelessWidget {
  const MainScreenNavigationDrawer({
    required this.destinations,
    super.key,
  });

  final List<RouteDestination> destinations;

  @override
  Widget build(final BuildContext context) {
    int? activeIndex = destinations.indexWhere(
      (final destination) =>
          context.router.isRouteActive(destination.route.routeName),
    );
    if (activeIndex == -1) {
      activeIndex = null;
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: 296,
      child: LayoutBuilder(
        builder: (final context, final constraints) => NavigationDrawer(
          key: const Key('PrimaryNavigationDrawer'),
          selectedIndex: activeIndex,
          onDestinationSelected: (final index) {
            context.router.replaceAll([destinations[index].route]);
          },
          children: [
            const SizedBox(height: 18),
            ...destinations.map(
              (final destination) => NavigationDrawerDestination(
                icon: Icon(destination.icon),
                label: Text(destination.label),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeTab {
  ChangeTab(this.onPress);
  final ValueChanged<int> onPress;
}
