import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/ui/pages/initializing/initializing.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:easy_localization/easy_localization.dart';

class NotReadyCard extends StatelessWidget {
  const NotReadyCard({Key? key}) : super(key: key);

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
              text: 'not_ready_card.1'.tr(),
              style: TextStyle(color: BrandColors.white),
            ),
            WidgetSpan(
              child: GestureDetector(
                child: Text(
                  'not_ready_card.2'.tr(),
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
              text: 'not_ready_card.3'.tr(),
              style: TextStyle(color: BrandColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
