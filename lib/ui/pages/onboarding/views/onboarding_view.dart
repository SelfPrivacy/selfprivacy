import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';

// base widget for onboarding view
class OnboardingView extends StatelessWidget {
  const OnboardingView({
    required this.onProceed,
    required this.children,
    this.buttonTitle = 'basis.next',
    super.key,
  });

  /// Proceed button title
  final String buttonTitle;

  /// Proceed button callback
  final VoidCallback onProceed;

  /// Current view content
  final List<Widget> children;

  @override
  Widget build(final BuildContext context) => Scaffold(
    body: SafeArea(
      child: Align(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  primary: true,
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.all(15) + const EdgeInsets.only(top: 15),
                  children: children,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15) +
                    const EdgeInsets.only(bottom: 30),
                child: BrandButton.filled(
                  title: buttonTitle.tr(),
                  onPressed: onProceed,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
