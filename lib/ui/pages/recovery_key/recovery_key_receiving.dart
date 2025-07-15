import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/organisms/displays/key_display.dart';

class NewRecoveryKeyPage extends StatelessWidget {
  const NewRecoveryKeyPage({required this.recoveryKey, super.key});

  final String recoveryKey;

  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
    heroTitle: 'recovery_key.key_main_header'.tr(),
    heroSubtitle: 'recovery_key.key_receiving_description'.tr(),
    hasBackButton: false,
    hasFlashButton: false,
    children: [
      KeyDisplay(
        keyToDisplay: recoveryKey,
        canCopy: false,
        infoboxText: 'recovery_key.key_receiving_info'.tr(),
      ),
    ],
  );
}
