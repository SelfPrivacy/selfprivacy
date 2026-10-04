part of 'root_scaffold_with_subroute_selector.dart';

abstract class SubrouteSelector extends StatelessWidget {
  const SubrouteSelector({required this.subroutes, super.key});

  final List<RouteDestination> subroutes;

  int getActiveIndex(final BuildContext context) {
    final router = context.router;
    final sectionRouter = identical(router, router.root)
        ? router.innerRouterOf<StackRouter>(RootRoute.name) ?? router
        : router;
    int activeIndex = subroutes.indexWhere(
      (final destination) =>
          sectionRouter.isRouteActive(destination.route.routeName),
    );

    final prevActiveIndex = subroutes.indexWhere(
      (final destination) => sectionRouter.stack.any(
        (final route) => route.name == destination.route.routeName,
      ),
    );

    if (activeIndex == -1) {
      activeIndex = prevActiveIndex != -1 ? prevActiveIndex : 0;
    }

    return activeIndex;
  }

  ValueSetter<int> openSubpage(final BuildContext context) =>
      (final index) async {
        final router = context.router;
        final route = subroutes[index].route;
        if (router.routeCollection.containsKey(route.routeName)) {
          await router.replaceAll([route]);
          return;
        }
        await router.root.navigate(RootRoute(children: [route]));
      };
}
