import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/config/app_controller/inherited_app_controller.dart';
import 'package:selfprivacy/config/localization.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/buttons/dialog_action_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/router/router.dart';

part 'language_picker.dart';
part 'reset_app_button.dart';
part 'theme_picker.dart';

@RoutePage()
class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
        hasBackButton: true,
        hasFlashButton: false,
        bodyPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        heroTitle: 'application_settings.title'.tr(),
        children: [
          _ThemePicker(
            key: ValueKey('theme_picker'.tr()),
          ),
          const Divider(height: 5, thickness: 0),
          _LanguagePicker(
            key: ValueKey('language_picker'.tr()),
          ),
          const Divider(height: 5, thickness: 0),
          const Gap(4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'application_settings.dangerous_settings'.tr(),
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          ),
          const Gap(4),
          _ResetAppTile(
            key: ValueKey('reset_app'.tr()),
          ),
        ],
      );
}
