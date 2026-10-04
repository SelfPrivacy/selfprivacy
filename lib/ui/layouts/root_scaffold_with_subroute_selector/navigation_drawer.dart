part of 'root_scaffold_with_subroute_selector.dart';

class _NavigationDrawer extends SubrouteSelector {
  const _NavigationDrawer({
    required super.subroutes,
    this.showFab = true,
    this.jobsButton,
  });

  final bool showFab;
  final Widget? jobsButton;

  @override
  Widget build(final BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height,
    width: 296,
    child: NavigationDrawer(
      key: const Key('PrimaryNavigationDrawer'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      selectedIndex: getActiveIndex(context),
      onDestinationSelected: openSubpage(context),
      children: [
        if (showFab)
          Padding(
            padding: const EdgeInsets.all(16),
            child: jobsButton ?? const BrandFab(extended: true),
          ),
        const SizedBox(height: 16),
        for (final destination in subroutes)
          NavigationDrawerDestination(
            icon: Icon(destination.icon),
            label: Text(destination.label.tr()),
          ),
      ],
    ),
  );
}
