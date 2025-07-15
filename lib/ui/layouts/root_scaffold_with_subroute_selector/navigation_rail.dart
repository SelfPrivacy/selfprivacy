part of 'root_scaffold_with_subroute_selector.dart';

class _NavigationRail extends SubrouteSelector {
  const _NavigationRail({required super.subroutes, this.showFab = true});

  final bool showFab;

  @override
  Widget build(final BuildContext context) {
    final isExtended = Breakpoints.large.isActive(context);

    return LayoutBuilder(
      builder:
          (final context, final constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: NavigationRail(
                  backgroundColor: Colors.transparent,
                  labelType:
                      isExtended
                          ? NavigationRailLabelType.none
                          : NavigationRailLabelType.all,
                  extended: isExtended,
                  leading:
                      showFab
                          ? const BrandFab(extended: false, elevation: 0)
                          : null,
                  groupAlignment: 0,
                  destinations: [
                    for (final destination in subroutes)
                      NavigationRailDestination(
                        icon: Icon(destination.icon),
                        label: Text(destination.label.tr()),
                      ),
                  ],
                  selectedIndex: getActiveIndex(context),
                  onDestinationSelected: openSubpage(context),
                ),
              ),
            ),
          ),
    );
  }
}
