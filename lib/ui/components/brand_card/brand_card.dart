import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/utils/extensions/elevation_extension.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    Key key,
    this.child,
    this.isBlocked = false,
  }) : super(key: key);

  final Widget child;
  final bool isBlocked;

  @override
  Widget build(BuildContext context) {
    Widget res = Container(
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? BrandColors.black
            : BrandColors.white,
        borderRadius: BorderRadius.circular(20),
      ).ev8,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: child,
    );

    if (!isBlocked) {
      return res;
    }

    return IgnorePointer(
      child: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.white,
              BlendMode.saturation,
            ),
            child: res,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.8),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BrandText.h3('Blocked'),
                  BrandText.h4('finish initializing first')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
