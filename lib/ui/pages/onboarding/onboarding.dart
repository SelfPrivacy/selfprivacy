import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/pages/rootRoute.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:selfprivacy/utils/extensions/text_extension.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 45,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Онбординг',
                      ).h1,
                      SizedBox(height: 20),
                      Text(
                        'Тут рассказ на 1-2 слайда о том, что делает это приложение, какие твои проблемы решает и как (в общем чего ожидать от сервиса).',
                      ).body2,
                    ],
                  ),
                ),
              ),
              BrandButton.rised(
                onPressed: () {
                  Navigator.of(context).push(materialRoute(RootPage()));
                },
                title: 'Приступим!',
              )
            ],
          ),
        ),
      ),
    );
  }
}
