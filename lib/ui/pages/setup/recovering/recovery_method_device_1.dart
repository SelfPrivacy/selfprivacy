import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_button/FilledButton.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:selfprivacy/ui/pages/rootRoute.dart';

class RecoveryMethodDevice1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BrandHeroScreen(
      heroTitle: "recovering.recovery_main_header".tr(),
      heroSubtitle: "recovering.method_device_description".tr(),
      hasBackButton: true,
      hasFlashButton: false,
      children: [
        FilledButton(
          title: "recovering.method_device_button".tr(),
          onPressed: () =>
              Navigator.of(context).push(materialRoute(RootPage())),
        )
      ],
    );
  }
}
