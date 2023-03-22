import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:easy_localization/easy_localization.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: PageView(
          controller: pageController,
          children: [
            _withPadding(firstPage()),
            _withPadding(secondPage()),
          ],
        ),
      );

  Widget _withPadding(final Widget child) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: child,
      );

  Widget firstPage() => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'onboarding.page1_title'.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'onboarding.page1_text'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Image.asset(
                      _fileName(
                        context: context,
                        path: 'assets/images/onboarding',
                        fileExtention: 'png',
                        fileName: 'onboarding1',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BrandButton.rised(
              onPressed: () {
                pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubicEmphasized,
                );
              },
              text: 'basis.next'.tr(),
            ),
            const SizedBox(height: 30),
          ],
        ),
      );

  Widget secondPage() => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'onboarding.page2_title'.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'onboarding.page2_text'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'onboarding.page2_server_provider_title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'onboarding.page2_server_provider_text'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'onboarding.page2_dns_provider_title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'onboarding.page2_dns_provider_text'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'onboarding.page2_backup_provider_title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'onboarding.page2_backup_provider_text'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            BrandButton.rised(
              onPressed: () {
                context.read<AppSettingsCubit>().turnOffOnboarding();
                context.router.replaceAll([
                  const RootRoute(),
                  const InitializingRoute(),
                ]);
              },
              text: 'basis.got_it'.tr(),
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
}

String _fileName({
  required final BuildContext context,
  required final String path,
  required final String fileName,
  required final String fileExtention,
}) {
  final ThemeData theme = Theme.of(context);
  final bool isDark = theme.brightness == Brightness.dark;
  return '$path/$fileName${isDark ? '-dark' : '-light'}.$fileExtention';
}
