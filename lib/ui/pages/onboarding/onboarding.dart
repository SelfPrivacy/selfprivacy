import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/ui/pages/onboarding/views/views.dart';
import 'package:selfprivacy/ui/router/router.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> scrollTo(final int targetView) => pageController.animateToPage(
        targetView,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubicEmphasized,
      );

  @override
  Widget build(final BuildContext context) => Material(
        child: PageView(
          controller: pageController,
          children: [
            OnboardingFirstView(
              onProceed: () => scrollTo(1),
            ),
            OnboardingSecondView(
              onProceed: () {
                context.read<AppSettingsCubit>().turnOffOnboarding();
                context.router.replaceAll([
                  const RootRoute(),
                  const InitializingRoute(),
                ]);
              },
            ),
          ],
        ),
      );
}
