import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key key, @required this.nextPage}) : super(key: key);

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
              'Цифровая независимость и приватность, доступная каждому'),
          SizedBox(height: 20),
          BrandText.body2(
              'Почта и мессенджер с открытым исходным кодом на вашем личном сервере под вашим полным контролем.'),
          Flexible(
            child: Center(
              child: Image.asset(
                'assets/images/onboarding/onboarding1.png',
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
            title: 'Далее',
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
          BrandText.h2('Для работы понадобятся ваши аккаунты'),
          SizedBox(height: 20),
          BrandText.body2(
              'Для максимальноей приватности и независимости SelfPrivacy не использует свои серверы. \n \n Если у вас нет домена, аккаунтов на Hetzner, AWS и Clouflare, мы поможем их создать и подключить.'),
          SizedBox(height: 20),
          Center(
            child: Image.asset(
              'assets/images/onboarding/logos_line.png',
            ),
          ),
          Flexible(
            child: Center(
              child: Image.asset(
                'assets/images/onboarding/onboarding2.png',
              ),
            ),
          ),
          BrandButton.rised(
            onPressed: () {
              context.read<AppSettingsCubit>().turnOffOnboarding();
              Navigator.of(context)
                  .pushReplacement(materialRoute(widget.nextPage));
            },
            title: 'Понял',
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
