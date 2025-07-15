import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/ui/pages/onboarding/views/onboarding_view.dart';

class OnboardingSecondView extends StatelessWidget {
  const OnboardingSecondView({required this.onProceed, super.key});

  final VoidCallback onProceed;

  @override
  Widget build(final BuildContext context) => OnboardingView(
    buttonTitle: 'basis.got_it',
    onProceed: onProceed,
    children: [
      Text(
        'onboarding.page2_title'.tr(),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const Gap(16),
      Text(
        'onboarding.page2_text'.tr(),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      const Gap(16),
      Text(
        'onboarding.page2_server_provider_title'.tr(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const Gap(16),
      Text(
        'onboarding.page2_server_provider_text'.tr(),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      const Gap(16),
      Text(
        'onboarding.page2_dns_provider_title'.tr(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const Gap(16),
      Text(
        'onboarding.page2_dns_provider_text'.tr(),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      const Gap(16),
      Text(
        'onboarding.page2_backup_provider_title'.tr(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const Gap(16),
      Text(
        'onboarding.page2_backup_provider_text'.tr(),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ],
  );
}
