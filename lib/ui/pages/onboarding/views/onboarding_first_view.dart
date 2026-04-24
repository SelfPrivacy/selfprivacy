import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/ui/pages/onboarding/views/onboarding_view.dart';

class OnboardingFirstView extends StatelessWidget {
  const OnboardingFirstView({required this.onProceed, super.key});

  final VoidCallback onProceed;

  String assetName({
    required final BuildContext context,
    required final String path,
    required final String fileName,
    required final String fileExtension,
  }) {
    final String suffix =
        Theme.of(context).brightness == Brightness.dark ? '-dark' : '-light';
    return '$path/$fileName$suffix.$fileExtension';
  }

  @override
  Widget build(final BuildContext context) => OnboardingView(
    onProceed: onProceed,
    children: [
      Text(
        'onboarding.page1_title'.tr(),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const Gap(15),
      Text(
        'onboarding.page1_text'.tr(),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      const Gap(30),
      Image.asset(
        assetName(
          context: context,
          path: 'assets/images/onboarding',
          fileName: 'onboarding1',
          fileExtension: 'png',
        ),
        fit: BoxFit.fitWidth,
      ),
    ],
  );
}
