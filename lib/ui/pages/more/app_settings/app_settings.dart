import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/app_controller/inherited_app_controller.dart';
import 'package:selfprivacy/config/localization.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/atoms/buttons/dialog_action_button.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/section_title.dart';
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
    heroTitle: 'application_settings.title'.tr(),
    heroIcon: Icons.settings_outlined,
    children: [
      _ThemePicker(key: ValueKey('theme_picker'.tr())),
      _LanguagePicker(key: ValueKey('language_picker'.tr())),
      SectionTitle(
        title: 'application_settings.dangerous_settings'.tr(),
        error: true,
      ),
      _ResetAppTile(key: ValueKey('reset_app'.tr())),
    ],
  );
}
