import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/app_controller/inherited_app_controller.dart';
import 'package:selfprivacy/config/bloc_config.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/cubit/app_readiness/app_readiness_cubit.dart';
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
  final _hub = getIt<ServerConnectionHub>();
  PageRouteInfo _section = const ProvidersRoute();
  ServerConnection? _connection;
  bool _initialized = false;
  PageRouteInfo? _initialSection;
  @override
  void didChangeDependencies() {
    if (InheritedAppController.of(context).shouldShowOnboarding) {
      unawaited(context.router.replace(const OnboardingRoute()));
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(final BuildContext context) => StreamBuilder<void>(
    stream: _hub.changes,
    builder: (final context, _) {
      final connection = _hub.active;
      if (!_initialized || !identical(connection, _connection)) {
        _initialSection = _initialized ? _section : null;
        _initialized = true;
        _connection = connection;
      }
      final navigation = _ServerNavigation(
        key: ObjectKey(connection),
        initialSection: _initialSection,
        onSectionChanged: (final section) => _section = section,
      );
      return connection == null
          ? navigation
          : ServerBlocConfig(
              key: ObjectKey(connection),
              connection: connection,
              child: navigation,
            );
    },
  );
}

class _ServerNavigation extends StatefulWidget {
  const _ServerNavigation({
    required this.initialSection,
    required this.onSectionChanged,
    super.key,
  });

  final PageRouteInfo? initialSection;
  final ValueChanged<PageRouteInfo> onSectionChanged;

  @override
  State<_ServerNavigation> createState() => _ServerNavigationState();
}

class _ServerNavigationState extends State<_ServerNavigation> {
  bool _restoring = false;
  late bool _restored = widget.initialSection == null;

  @override
  Widget build(final BuildContext context) {
    final bool isReady =
        context.watch<AppReadinessCubit>().state is ServerConfigured;

    return AutoRouter(
      builder: (final context, final child) {
        final router = context.router;
        if (!_restored) {
          if (!_restoring && router.hasEntries) {
            _restoring = true;
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (!mounted) {
                return;
              }
              final section = router.matcher.matchByRoute(
                widget.initialSection!,
              )!;
              router.removeWhere((_) => true, notify: false);
              await router.navigateAll([section]);
              if (mounted) {
                setState(() => _restored = true);
              }
            });
          }
          return const SizedBox.shrink();
        }
        final currentDestinationIndex = rootDestinations.indexWhere(
          (final destination) =>
              context.router.isRouteActive(destination.route.routeName),
        );
        if (currentDestinationIndex != -1) {
          widget.onSectionChanged(
            rootDestinations[currentDestinationIndex].route,
          );
        }
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
