import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';

class SwitcherBlock extends StatelessWidget {
  const SwitcherBlock({
    Key key,
    @required this.child,
    @required this.isActive,
    @required this.onChange,
  }) : super(key: key);

  final Widget child;
  final bool isActive;
  final ValueChanged<bool> onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 5),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1, color: BrandColors.dividerColor),
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: child),
          SizedBox(width: 5),
          Switch(
            activeColor: BrandColors.green1,
            activeTrackColor: BrandColors.green2,
            onChanged: onChange,
            value: isActive,
          ),
        ],
      ),
    );
  }
}
