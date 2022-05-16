import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';

class BrandTabBar extends StatefulWidget {
  BrandTabBar({Key? key, this.controller}) : super(key: key);

  final TabController? controller;
  @override
  _BrandTabBarState createState() => _BrandTabBarState();
}

class _BrandTabBarState extends State<BrandTabBar> {
  int? currentIndex;
  @override
  void initState() {
    currentIndex = widget.controller!.index;
    widget.controller!.addListener(_listener);
    super.initState();
  }

  _listener() {
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
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: [
        _getIconButton('basis.providers'.tr(), BrandIcons.server, 0),
        _getIconButton('basis.services'.tr(), BrandIcons.box, 1),
        _getIconButton('basis.users'.tr(), BrandIcons.users, 2),
        _getIconButton('basis.more'.tr(), Icons.menu_rounded, 3),
      ],
      onDestinationSelected: (index) {
        widget.controller!.animateTo(index);
      },
      selectedIndex: currentIndex ?? 0,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    );
  }

  _getIconButton(String label, IconData iconData, int index) {
    return NavigationDestination(
      icon: Icon(iconData),
      label: label,
    );
  }
}
