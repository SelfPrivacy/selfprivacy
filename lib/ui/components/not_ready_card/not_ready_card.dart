import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/text_themes.dart';

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
                    onTap: () => context.go('/initial-setup'),
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
