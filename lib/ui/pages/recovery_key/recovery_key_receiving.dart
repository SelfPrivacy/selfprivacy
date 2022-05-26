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
      heroSubtitle: 'recovering.method_select_description'.tr(),
      hasBackButton: true,
      hasFlashButton: false,
      children: [
        Text(recoveryKey, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 18),
        const Icon(Icons.info_outlined, size: 14),
        Text('recovery_key.key_receiving_info'.tr()),
        const SizedBox(height: 18),
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
