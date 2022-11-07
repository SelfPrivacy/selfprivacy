import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:flutter/services.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({required this.log, super.key});

  final String log;
  final String telegramUrl = 'https://t.me/selfprivacy';

  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
        heroTitle: 'error.page_title'.tr(),
        heroSubtitle: 'error.page_description'.tr(),
        hasBackButton: false,
        hasFlashButton: false,
        children: [
          SizedBox(
            width: 320,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.content_copy_outlined),
                  onPressed: () async => Clipboard.setData(
                    ClipboardData(text: log),
                  ),
                ),
                const SizedBox(width: 48),
                Text('error.page_share'.tr()),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () async => UiHelpers.launchExternalApplicationURL(
                    telegramUrl,
                  ),
                  child: const Icon(Icons.telegram_outlined),
                ),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(height: 16),
          Text(
            log,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontFamily: 'RobotoMono',
                ),
          ),
        ],
      );
}
