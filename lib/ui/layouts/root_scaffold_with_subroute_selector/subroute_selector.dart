part of 'root_scaffold_with_subroute_selector.dart';

abstract class SubrouteSelector extends StatelessWidget {
  const SubrouteSelector({required this.subroutes, super.key});

  final List<RouteDestination> subroutes;

  int getActiveIndex(final BuildContext context) {
    int activeIndex = subroutes.indexWhere(
      (final destination) =>
          context.router.isRouteActive(destination.route.routeName),
    );

    final prevActiveIndex = subroutes.indexWhere(
      (final destination) => context.router.stack.any(
        (final route) => route.name == destination.route.routeName,
      ),
    );

    if (activeIndex == -1) {
      activeIndex = prevActiveIndex != -1 ? prevActiveIndex : 0;
    }

    return activeIndex;
  }

  ValueSetter<int> openSubpage(final BuildContext context) => (
    final index,
  ) async {
    await context.router.replaceAll([subroutes[index].route]);
  };
}
