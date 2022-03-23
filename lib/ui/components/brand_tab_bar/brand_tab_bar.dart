import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';

final _kBottomTabBarHeight = 51;

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
    final paddingBottom = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: paddingBottom + _kBottomTabBarHeight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        color: Theme.of(context).brightness == Brightness.dark
            ? BrandColors.navBackgroundDark
            : BrandColors.navBackgroundLight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getIconButton('basis.providers'.tr(), BrandIcons.server, 0),
            _getIconButton('basis.services'.tr(), BrandIcons.box, 1),
            _getIconButton('basis.users'.tr(), BrandIcons.users, 2),
            _getIconButton('basis.more'.tr(), BrandIcons.menu, 3),
          ],
        ),
      ),
    );
  }

  _getIconButton(String label, IconData iconData, int index) {
    var activeColor = Theme.of(context).brightness == Brightness.dark
        ? BrandColors.white
        : BrandColors.black;

    var isActive = currentIndex == index;
    var color = isActive ? activeColor : BrandColors.inactive;
    return InkWell(
      onTap: () => widget.controller!.animateTo(index),
      child: Padding(
        padding: EdgeInsets.all(6),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 40),
          child: Column(
            children: [
              Icon(iconData, color: color),
              SizedBox(height: 3),
              Row(
                children: [
                  if (isActive) ...[
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: BrandColors.red2,
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                  Text(label, style: TextStyle(fontSize: 9, color: color)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
