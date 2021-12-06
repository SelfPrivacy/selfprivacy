import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/jobs/jobs_cubit.dart';
import 'package:selfprivacy/logic/get_it/ssh.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/action_button/action_button.dart';
import 'package:selfprivacy/ui/components/brand_alert/brand_alert.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:selfprivacy/ui/pages/initializing/initializing.dart';
import 'package:selfprivacy/ui/pages/onboarding/onboarding.dart';
import 'package:selfprivacy/ui/pages/rootRoute.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:share_plus/share_plus.dart';

import 'about/about.dart';
import 'app_settings/app_setting.dart';
import 'console/console.dart';
import 'info/info.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var jobsCubit = context.watch<JobsCubit>();
    var isReady = context.watch<AppConfigCubit>().state is AppConfigFinished;

    return Scaffold(
      appBar: PreferredSize(
        child: BrandHeader(
          title: 'basis.more'.tr(),
          hasFlashButton: true,
        ),
        preferredSize: Size.fromHeight(52),
      ),
      body: ListView(
        children: [
          Padding(
            padding: paddingH15V0,
            child: Column(
              children: [
                BrandDivider(),
                _NavItem(
                  title: 'more.configuration_wizard'.tr(),
                  iconData: BrandIcons.triangle,
                  goTo: InitializingPage(),
                ),
                _NavItem(
                  title: 'more.settings.title'.tr(),
                  iconData: BrandIcons.settings,
                  goTo: AppSettingsPage(),
                ),
                _NavItem(
                  title: 'more.about_project'.tr(),
                  iconData: BrandIcons.engineer,
                  goTo: AboutPage(),
                ),
                _NavItem(
                  title: 'more.about_app'.tr(),
                  iconData: BrandIcons.fire,
                  goTo: InfoPage(),
                ),
                _NavItem(
                  title: 'more.onboarding'.tr(),
                  iconData: BrandIcons.start,
                  goTo: OnboardingPage(nextPage: RootPage()),
                ),
                _NavItem(
                  title: 'more.console'.tr(),
                  iconData: BrandIcons.terminal,
                  goTo: Console(),
                ),
                _MoreMenuTapItem(
                  title: 'more.create_ssh_key'.tr(),
                  iconData: Ionicons.key_outline,
                  onTap: isReady
                      ? () {
                          if (getIt<SSHModel>().isSSHKeyGenerated) {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return _SSHExitsDetails(
                                  onShareTap: () {
                                    Share.share(
                                        getIt<SSHModel>().savedPrivateKey!);
                                  },
                                  onDeleteTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return BrandAlert(
                                          title: 'modals.3'.tr(),
                                          contentText:
                                              'more.delete_ssh_text'.tr(),
                                          actions: [
                                            ActionButton(
                                                text: 'more.yes_delete'.tr(),
                                                isRed: true,
                                                onPressed: () {
                                                  getIt<SSHModel>().clear();
                                                  Navigator.of(context).pop();
                                                }),
                                            ActionButton(
                                              text: 'basis.cancel'.tr(),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  onCopyTap: () {
                                    Clipboard.setData(ClipboardData(
                                        text: getIt<SSHModel>()
                                            .savedPrivateKey!));
                                    getIt<NavigationService>()
                                        .showSnackBar('more.copied_ssh'.tr());
                                  },
                                );
                              },
                            );
                          } else {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return _MoreDetails(
                                  title: 'more.create_ssh_key'.tr(),
                                  icon: Ionicons.key_outline,
                                  onTap: () {
                                    jobsCubit.createShhJobIfNotExist(
                                        CreateSSHKeyJob());
                                  },
                                  text: 'more.generate_key_text'.tr(),
                                );
                              },
                            );
                          }
                        }
                      : null,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SSHExitsDetails extends StatelessWidget {
  const _SSHExitsDetails({
    Key? key,
    required this.onDeleteTap,
    required this.onShareTap,
    required this.onCopyTap,
  }) : super(key: key);
  final Function onDeleteTap;
  final Function onShareTap;
  final Function onCopyTap;

  @override
  Widget build(BuildContext context) {
    var textStyle = body1Style.copyWith(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : BrandColors.black);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Container(
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: paddingH15V30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'more.ssh_key_exist_text'.tr(),
                      style: textStyle,
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: BrandButton.text(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onShareTap();
                        },
                        title: 'more.share'.tr(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: BrandButton.text(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onDeleteTap();
                        },
                        title: 'basis.delete'.tr(),
                      ),
                    ),
                    Container(
                      child: BrandButton.text(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onCopyTap();
                        },
                        title: 'more.copy_buffer'.tr(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MoreDetails extends StatelessWidget {
  const _MoreDetails({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Function onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    var textStyle = body1Style.copyWith(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : BrandColors.black);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Container(
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: paddingH15V30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconStatusMask(
                      status: StateType.stable,
                      child: Icon(icon, size: 40, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    BrandText.h2(title),
                    SizedBox(height: 10),
                    Text(
                      text,
                      style: textStyle,
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: Container(
                        child: BrandButton.rised(
                          onPressed: () {
                            Navigator.of(context).pop();
                            onTap();
                          },
                          text: 'more.generate_key'.tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    Key? key,
    required this.iconData,
    required this.goTo,
    required this.title,
  }) : super(key: key);

  final IconData iconData;
  final Widget goTo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(materialRoute(goTo)),
      child: _MoreMenuItem(
        iconData: iconData,
        title: title,
        isActive: true,
      ),
    );
  }
}

class _MoreMenuTapItem extends StatelessWidget {
  const _MoreMenuTapItem({
    Key? key,
    required this.iconData,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _MoreMenuItem(
        isActive: onTap != null,
        iconData: iconData,
        title: title,
      ),
    );
  }
}

class _MoreMenuItem extends StatelessWidget {
  const _MoreMenuItem({
    Key? key,
    required this.iconData,
    required this.title,
    required this.isActive,
  }) : super(key: key);

  final IconData iconData;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: BrandColors.dividerColor,
          ),
        ),
      ),
      child: Row(
        children: [
          BrandText.body1(
            title,
            style: TextStyle(
              color: isActive ? null : Colors.grey,
            ),
          ),
          Spacer(),
          SizedBox(
            width: 56,
            child: Icon(
              iconData,
              size: 20,
              color: isActive ? null : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
