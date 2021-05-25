import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';

class BrandBottomSheet extends StatelessWidget {
  const BrandBottomSheet({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          60,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            padding: paddingH15V0,
            child: child,
          ),
        ),
      ),
    );
  }
}
