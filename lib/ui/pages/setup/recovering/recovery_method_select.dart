import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_fallback_select.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_method_device_1.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_method_token.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:selfprivacy/ui/pages/rootRoute.dart';

class RecoveryMethodSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BrandHeroScreen(
      heroTitle: "recovering.recovery_main_header".tr(),
      heroSubtitle: "recovering.method_select_description".tr(),
      hasBackButton: true,
      hasFlashButton: false,
      children: [
        BrandCards.outlined(
          child: ListTile(
            title: Text(
              "recovering.method_select_other_device".tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            leading: Icon(Icons.offline_share_outlined),
            onTap: () => Navigator.of(context)
                .push(materialRoute(RecoveryMethodDevice1())),
          ),
        ),
        SizedBox(height: 16),
        BrandCards.outlined(
          child: ListTile(
            title: Text(
              "recovering.method_select_recovery_key".tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            leading: Icon(Icons.password_outlined),
            onTap: () => Navigator.of(context)
                .push(materialRoute(RecoveryMethodToken())),
          ),
        ),
        SizedBox(height: 16),
        BrandButton.text(
          title: "recovering.method_select_nothing".tr(),
          onPressed: () => Navigator.of(context)
              .push(materialRoute(RecoveryFallbackSelect())),
        )
      ],
    );
  }
}
