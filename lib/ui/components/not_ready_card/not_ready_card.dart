import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/initializing.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:easy_localization/easy_localization.dart';

class NotReadyCard extends StatelessWidget {
  const NotReadyCard({super.key});

  @override
  Widget build(final BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: BrandColors.gray6,
        ),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'not_ready_card.begin'.tr(),
                style: const TextStyle(color: BrandColors.white),
              ),
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0.5),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      materialRoute(
                        const InitializingPage(),
                      ),
                    ),
                    child: Text(
                      'not_ready_card.insertion'.tr(),
                      style: body1Style.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        // height: 1.1,
                      ),
                    ),
                  ),
                ),
              ),
              TextSpan(
                text: 'not_ready_card.end'.tr(),
                style: const TextStyle(color: BrandColors.white),
              ),
            ],
          ),
        ),
      );
}
