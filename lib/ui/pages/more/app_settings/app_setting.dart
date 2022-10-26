import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/action_button/action_button.dart';
import 'package:selfprivacy/ui/components/brand_alert/brand_alert.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_switch/brand_switch.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/utils/named_font_weight.dart';
import 'package:easy_localization/easy_localization.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  @override
  Widget build(final BuildContext context) {
    final bool isDarkModeOn =
        context.watch<AppSettingsCubit>().state.isDarkModeOn;

    return SafeArea(
      child: Builder(
        builder: (final context) => Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(52),
            child: BrandHeader(
              title: 'application_settings.title'.tr(),
              hasBackButton: true,
            ),
          ),
          body: ListView(
            padding: paddingH15V0,
            children: [
              const Divider(height: 1),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: _TextColumn(
                        title: 'application_settings.dark_theme_title'.tr(),
                        value:
                            'application_settings.dark_theme_description'.tr(),
                        hasWarning: false,
                      ),
                    ),
                    const SizedBox(width: 5),
                    BrandSwitch(
                      value: Theme.of(context).brightness == Brightness.dark,
                      onChanged: (final value) => context
                          .read<AppSettingsCubit>()
                          .updateDarkMode(isDarkModeOn: !isDarkModeOn),
                    ),
                  ],
                ),
              ),
              const Divider(height: 0),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: _TextColumn(
                        title: 'application_settings.reset_config_title'.tr(),
                        value: 'application_settings.reset_config_description'
                            .tr(),
                        hasWarning: false,
                      ),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BrandColors.red1,
                      ),
                      child: Text(
                        'basis.reset'.tr(),
                        style: const TextStyle(
                          color: BrandColors.white,
                          fontWeight: NamedFontWeight.demiBold,
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (final _) => BrandAlert(
                            title: 'modals.are_you_sure'.tr(),
                            contentText: 'modals.purge_all_keys'.tr(),
                            actions: [
                              ActionButton(
                                text: 'modals.purge_all_keys_confirm'.tr(),
                                isRed: true,
                                onPressed: () {
                                  context
                                      .read<ServerInstallationCubit>()
                                      .clearAppConfig();
                                  Navigator.of(context).pop();
                                },
                              ),
                              ActionButton(
                                text: 'basis.cancel'.tr(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Divider(height: 0),
              _deleteServer(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _deleteServer(final BuildContext context) {
    final bool isDisabled =
        context.watch<ServerInstallationCubit>().state.serverDetails == null;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: _TextColumn(
              title: 'application_settings.delete_server_title'.tr(),
              value: 'application_settings.delete_server_description'.tr(),
              hasWarning: false,
            ),
          ),
          const SizedBox(width: 5),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: BrandColors.red1,
            ),
            onPressed: isDisabled
                ? null
                : () {
                    showDialog(
                      context: context,
                      builder: (final _) => BrandAlert(
                        title: 'modals.are_you_sure'.tr(),
                        contentText: 'modals.delete_server_volume'.tr(),
                        actions: [
                          ActionButton(
                            text: 'modals.yes'.tr(),
                            isRed: true,
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (final context) => Container(
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(),
                                ),
                              );
                              await context
                                  .read<ServerInstallationCubit>()
                                  .serverDelete();
                              if (!mounted) {
                                return;
                              }
                              Navigator.of(context).pop();
                            },
                          ),
                          ActionButton(
                            text: 'basis.cancel'.tr(),
                          ),
                        ],
                      ),
                    );
                  },
            child: Text(
              'basis.delete'.tr(),
              style: const TextStyle(
                color: BrandColors.white,
                fontWeight: NamedFontWeight.demiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextColumn extends StatelessWidget {
  const _TextColumn({
    required this.title,
    required this.value,
    this.hasWarning = false,
  });

  final String title;
  final String value;
  final bool hasWarning;
  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BrandText.body1(
            title,
            style: TextStyle(color: hasWarning ? BrandColors.warning : null),
          ),
          const SizedBox(height: 5),
          BrandText.body1(
            value,
            style: const TextStyle(
              fontSize: 13,
              height: 1.53,
              color: BrandColors.gray1,
            ).merge(TextStyle(color: hasWarning ? BrandColors.warning : null)),
          ),
        ],
      );
}
