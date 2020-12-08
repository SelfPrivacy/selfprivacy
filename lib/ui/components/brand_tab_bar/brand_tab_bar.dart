import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';

final _kBottomTabBarHeight = 51;

class BrandTabBar extends StatefulWidget {
  BrandTabBar({Key key, this.controller}) : super(key: key);

  final TabController controller;
  @override
  _BrandTabBarState createState() => _BrandTabBarState();
}

class _BrandTabBarState extends State<BrandTabBar> {
  int currentIndex;
  @override
  void initState() {
    currentIndex = widget.controller.index;
    widget.controller.addListener(() {
      if (currentIndex != widget.controller.index) {
        setState(() {
          currentIndex = widget.controller.index;
        });
      }
    });
    super.initState();
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
            _getIconButton('Провайдеры', BrandIcons.server, 0),
            _getIconButton('Сервисы', BrandIcons.box, 1),
            _getIconButton('Пользователи', BrandIcons.users, 2),
            _getIconButton('Еще', BrandIcons.menu, 3),
          ],
        ),
      ),
    );
  }

  _getIconButton(String label, IconData iconData, int index) {
    var acitivColor = Theme.of(context).brightness == Brightness.dark
        ? BrandColors.white
        : BrandColors.black;
    var color = currentIndex == index ? acitivColor : BrandColors.inactive;
    return InkWell(
      onTap: () => widget.controller.animateTo(index),
      child: Padding(
        padding: EdgeInsets.all(6),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 40),
          child: Column(
            children: [
              Icon(iconData, color: color),
              SizedBox(height: 3),
              Text(label, style: TextStyle(fontSize: 9, color: color))
            ],
          ),
        ),
      ),
    );
  }
}
