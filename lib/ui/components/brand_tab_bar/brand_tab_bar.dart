import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';

final _kBottomTabBarHeight = 51;

class BottomTabBar extends StatefulWidget {
  BottomTabBar({Key key, this.controller}) : super(key: key);

  final TabController controller;
  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
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
        color: BrandColors.navBackground,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getIconButton('Серверы', BrandIcons.server, 0),
            _getIconButton('Сервисы', BrandIcons.box, 1),
            _getIconButton('Пользователи', BrandIcons.users, 2),
            _getIconButton('Еще', BrandIcons.menu, 3),
          ],
        ),
      ),
    );
  }

  _getIconButton(String label, IconData iconData, int index) {
    var color =
        currentIndex == index ? BrandColors.black : BrandColors.inactive;
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
