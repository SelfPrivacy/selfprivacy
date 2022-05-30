import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/root_route.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class RecoveryKeyReceiving extends StatelessWidget {
  const RecoveryKeyReceiving({required this.recoveryKey, Key? key})
      : super(key: key);

  final String recoveryKey;

  @override
  Widget build(BuildContext context) {
    return BrandHeroScreen(
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outlined, size: 24),
            const SizedBox(height: 16),
            Text('recovery_key.key_receiving_info'.tr()),
          ],
        ),
        const SizedBox(height: 16),
        FilledButton(
          title: 'recovery_key.key_receiving_done'.tr(),
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(materialRoute(const RootPage()));
          },
        ),
      ],
    );
  }
}
