part of 'root_scaffold_with_subroute_selector.dart';

class _BottomTabBar extends SubrouteSelector {
  const _BottomTabBar({
    required super.subroutes,
    required this.hidden,
    super.key,
  });

  final bool hidden;

  @override
  Widget build(final BuildContext context) {
    final int activeIndex = getActiveIndex(context);

    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: hidden ? 0 : 80 + bottomPadding,
      curve: Curves.easeInOutCubicEmphasized,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child:
          Platform.isIOS
              ? CupertinoTabBar(
                currentIndex: activeIndex,
                onTap: openSubpage(context),
                items: [
                  for (final destination in subroutes)
                    BottomNavigationBarItem(
                      icon: Icon(destination.icon),
                      label: destination.label.tr(),
                    ),
                ],
              )
              : NavigationBar(
                selectedIndex: activeIndex,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                onDestinationSelected: openSubpage(context),
                destinations:
                    [
                      for (final destination in subroutes)
                        NavigationDestination(
                          icon: Icon(destination.icon),
                          label: destination.label.tr(),
                        ),
                    ].toList(),
              ),
    );
  }
}
