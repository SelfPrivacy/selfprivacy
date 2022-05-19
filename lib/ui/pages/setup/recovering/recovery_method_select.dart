import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recover_by_old_token.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

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
            onTap: () => context
                .read<ServerInstallationCubit>()
                .selectRecoveryMethod(ServerRecoveryMethods.newDeviceKey),
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
            onTap: () => context
                .read<ServerInstallationCubit>()
                .selectRecoveryMethod(ServerRecoveryMethods.recoveryKey),
          ),
        ),
        SizedBox(height: 16),
        BrandButton.text(
          title: "recovering.method_select_nothing".tr(),
          onPressed: () => Navigator.of(context)
              .push(materialRoute(RecoveryFallbackMethodSelect())),
        )
      ],
    );
  }
}

class RecoveryFallbackMethodSelect extends StatelessWidget {
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
            onTap: () => Navigator.of(context)
                .push(materialRoute(RecoverByOldTokenInstruction(
              instructionFilename: 'how_fallback_old',
            ))),
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
            onTap: () => Navigator.of(context)
                .push(materialRoute(RecoverByOldTokenInstruction(
              instructionFilename: 'how_fallback_ssh',
            ))),
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
            onTap: () => Navigator.of(context)
                .push(materialRoute(RecoverByOldTokenInstruction(
              instructionFilename: 'how_fallback_terminal',
            ))),
          ),
        ),
      ],
    );
  }
}
