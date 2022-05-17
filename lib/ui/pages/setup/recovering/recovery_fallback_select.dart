import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:selfprivacy/ui/pages/rootRoute.dart';

class RecoveryFallbackSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BrandHeroScreen(
      heroTitle: "recovering.recovery_main_header".tr(),
      heroSubtitle: "recovering.fallback_select_description".tr(),
      hasBackButton: true,
      hasFlashButton: false,
      children: [
        BrandCards.outlined(
          child: ListTile(
            title: Text(
              "recovering.fallback_select_token_copy".tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            leading: Icon(Icons.vpn_key),
            onTap: () => Navigator.of(context).push(materialRoute(RootPage())),
          ),
        ),
        SizedBox(height: 16),
        BrandCards.outlined(
          child: ListTile(
            title: Text(
              "recovering.fallback_select_root_ssh".tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            leading: Icon(Icons.terminal),
            onTap: () => Navigator.of(context).push(materialRoute(RootPage())),
          ),
        ),
        SizedBox(height: 16),
        BrandCards.outlined(
          child: ListTile(
            title: Text(
              "recovering.fallback_select_provider_console".tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              "recovering.fallback_select_provider_console_hint".tr(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            leading: Icon(Icons.web),
            onTap: () => Navigator.of(context).push(materialRoute(RootPage())),
          ),
        ),
      ],
    );
  }
}
