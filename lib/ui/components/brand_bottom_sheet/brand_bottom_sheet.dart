import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';

class BrandBottomSheet extends StatelessWidget {
  const BrandBottomSheet({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var mainHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        100;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: mainHeight + 4 + 6),
      child: Column(
        children: [
          Center(
            child: Container(
              height: 4,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: BrandColors.gray4,
              ),
            ),
          ),
          SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: mainHeight),
              child: Scaffold(body: child),
            ),
          ),
        ],
      ),
    );
  }
}
