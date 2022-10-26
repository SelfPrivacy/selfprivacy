import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';

class BrandTabBar extends StatefulWidget {
  const BrandTabBar({super.key, this.controller});

  final TabController? controller;
  @override
  State<BrandTabBar> createState() => _BrandTabBarState();
}

class _BrandTabBarState extends State<BrandTabBar> {
  int? currentIndex;
  @override
  void initState() {
    currentIndex = widget.controller!.index;
    widget.controller!.addListener(_listener);
    super.initState();
  }

  void _listener() {
    if (currentIndex != widget.controller!.index) {
      setState(() {
        currentIndex = widget.controller!.index;
      });
    }
  }

  @override
  void dispose() {
    widget.controller ?? widget.controller!.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => NavigationBar(
        destinations: [
          _getIconButton('basis.providers'.tr(), BrandIcons.server, 0),
          _getIconButton('basis.services'.tr(), BrandIcons.box, 1),
          _getIconButton('basis.users'.tr(), BrandIcons.users, 2),
          _getIconButton('basis.more'.tr(), Icons.menu_rounded, 3),
        ],
        onDestinationSelected: (final index) {
          widget.controller!.animateTo(index);
        },
        selectedIndex: currentIndex ?? 0,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      );

  NavigationDestination _getIconButton(
    final String label,
    final IconData iconData,
    final int index,
  ) =>
      NavigationDestination(
        icon: Icon(iconData),
        label: label,
      );
}
