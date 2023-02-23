import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/info_box/info_box.dart';

class RecoveryKeyReceiving extends StatelessWidget {
  const RecoveryKeyReceiving({required this.recoveryKey, super.key});

  final String recoveryKey;

  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
        heroTitle: 'recovery_key.key_main_header'.tr(),
        heroSubtitle: 'recovery_key.key_receiving_description'.tr(),
        hasBackButton: true,
        hasFlashButton: false,
        children: [
          const Divider(),
          const SizedBox(height: 16),
          Text(
            recoveryKey,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 24,
                  fontFamily: 'RobotoMono',
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          InfoBox(
            text: 'recovery_key.key_receiving_info'.tr(),
          ),
          const SizedBox(height: 16),
          BrandButton.filled(
            child: Text('recovery_key.key_receiving_done'.tr()),
            onPressed: () {
              Navigator.of(context).popUntil((final route) => route.isFirst);
            },
          ),
        ],
      );
}
