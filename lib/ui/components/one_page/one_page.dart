import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/ui/components/pre_styled_buttons.dart';

class OnePage extends StatelessWidget {
  const OnePage({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: Column(
            children: [
              Container(
                height: 51,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: BrandText.h4('basis.details'.tr()),
              ),
              BrandDivider(),
            ],
          ),
          preferredSize: Size.fromHeight(52),
        ),
        body: child,
        bottomNavigationBar: SafeArea(
          child: Container(
            decoration: BoxDecoration(boxShadow: kElevationToShadow[3]),
            height: kBottomNavigationBarHeight,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              alignment: Alignment.center,
              child: PreStyledButtons.close(
                  onPress: () => Navigator.of(context).pop()),
            ),
          ),
        ),
      ),
    );
  }
}
