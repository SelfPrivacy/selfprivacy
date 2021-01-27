import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/ui/pages/initializing/initializing.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class NotReadyCard extends StatelessWidget {
  const NotReadyCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: BrandColors.gray6),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Завершите настройку приложения используя ',
              style: TextStyle(color: BrandColors.white),
            ),
            WidgetSpan(
              child: GestureDetector(
                child: Text(
                  'Мастер подключения',
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.blueAccent
                          : BrandColors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
                onTap: () => Navigator.of(context).push(
                  materialRoute(
                    InitializingPage(),
                  ),
                ),
              ),
            ),
            TextSpan(
              text: ' для продолжения работы',
              style: TextStyle(color: BrandColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
