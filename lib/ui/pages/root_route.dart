import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/app_controller/inherited_app_controller.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/layouts/root_scaffold_with_subroute_selector/root_scaffold_with_subroute_selector.dart';
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
  @override
  void didChangeDependencies() {
    if (InheritedAppController.of(context).shouldShowOnboarding) {
      unawaited(context.router.replace(const OnboardingRoute()));
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(final BuildContext context) {
    final bool isReady =
        context.watch<ServerInstallationCubit>().state
            is ServerInstallationFinished;

    return AutoRouter(
      builder: (final context, final child) {
        final currentDestinationIndex = rootDestinations.indexWhere(
          (final destination) =>
              context.router.isRouteActive(destination.route.routeName),
        );
        final isOtherRouterActive =
            context.router.root.current.name != RootRoute.name;

        return RootScaffoldWithSubrouteSelector(
          destinations: rootDestinations,
          showBottomBar:
              !(currentDestinationIndex == -1 && !isOtherRouterActive),
          showFab: isReady,
          child: child,
        );
      },
    );
  }
}
