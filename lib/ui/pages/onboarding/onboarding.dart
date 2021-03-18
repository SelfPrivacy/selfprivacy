import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:easy_localization/easy_localization.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key, required this.nextPage}) : super(key: key);

  final Widget nextPage;
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pageController,
          children: [
            _withPadding(firstPage()),
            _withPadding(secondPage()),
          ],
        ),
      ),
    );
  }

  Widget _withPadding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: child,
    );
  }

  Widget firstPage() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          BrandText.h2(
            'onboarding.page1_title'.tr(),
          ),
          SizedBox(height: 20),
          BrandText.body2('services.page1_text'.tr()),
          Flexible(
            child: Center(
              child: Image.asset(
                _fileName(
                  context: context,
                  path: 'assets/images/onboarding',
                  fileExtention: 'png',
                  fileName: 'onboarding1',
                ),
              ),
            ),
          ),
          BrandButton.rised(
            onPressed: () {
              pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            title: 'basis.next'.tr(),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget secondPage() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
      ),
      child: Column(
        children: [
          SizedBox(height: 30),
          BrandText.h2('onboarding.page2_title'.tr()),
          SizedBox(height: 20),
          BrandText.body2('onboarding.page2_text'.tr()),
          SizedBox(height: 20),
          Center(
            child: Image.asset(
              _fileName(
                context: context,
                path: 'assets/images/onboarding',
                fileExtention: 'png',
                fileName: 'logos_line',
              ),
            ),
          ),
          Flexible(
            child: Center(
              child: Image.asset(
                _fileName(
                  context: context,
                  path: 'assets/images/onboarding',
                  fileExtention: 'png',
                  fileName: 'onboarding2',
                ),
              ),
            ),
          ),
          BrandButton.rised(
            onPressed: () {
              context.read<AppSettingsCubit>().turnOffOnboarding();
              Navigator.of(context)
                  .pushReplacement(materialRoute(widget.nextPage));
            },
            title: 'basis.got_it'.tr(),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

String _fileName({
  required BuildContext context,
  required String path,
  required String fileName,
  required String fileExtention,
}) {
  var theme = Theme.of(context);
  var isDark = theme.brightness == Brightness.dark;
  return '$path/$fileName${isDark ? '-dark' : '-light'}.$fileExtention';
}
