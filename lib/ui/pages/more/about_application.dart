import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/link_list_tile.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/section_title.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/utils/breakpoints.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';

@RoutePage()
class AboutApplicationPage extends StatelessWidget {
  const AboutApplicationPage({super.key});

  @override
  Widget build(final BuildContext context) {
    IconData getPlatformIcon() {
      if (Platform.isAndroid) {
        if (Breakpoints.small.isActive(context)) {
          return Icons.phone_android_outlined;
        }
        return Icons.tablet_android_outlined;
      } else if (Platform.isIOS) {
        if (Breakpoints.small.isActive(context)) {
          return Icons.phone_iphone_outlined;
        }
        return Icons.tablet_mac_outlined;
      } else if (Platform.isWindows || Platform.isLinux) {
        return Icons.desktop_windows_outlined;
      } else if (Platform.isMacOS) {
        return Icons.desktop_mac_outlined;
      } else {
        return Icons.devices_other_outlined;
      }
    }

    final deviceIcon = getPlatformIcon();

    return BrandHeroScreen(
      hasBackButton: true,
      hasFlashButton: false,
      heroTitle: 'about_application_page.title'.tr(),
      heroIcon: Icons.info_outline,
      children: [
        SectionTitle(title: 'about_application_page.versions'.tr()),
        FutureBuilder(
          future: _packageVersion(),
          builder:
              (final context, final snapshot) => ListTile(
                title: Text(
                  'about_application_page.application_version_text'.tr(),
                ),
                subtitle: Text(snapshot.data.toString()),
                leading: Icon(deviceIcon),
                onLongPress: () async {
                  await PlatformAdapter.setClipboard(snapshot.data.toString());
                  getIt<NavigationService>().showSnackBar(
                    'basis.copied_to_clipboard'.tr(),
                  );
                },
              ),
        ),
        if (getIt<ApiConnectionRepository>().apiData.apiVersion.data != null)
          FutureBuilder(
            future: _apiVersion(),
            builder:
                (final context, final snapshot) => ListTile(
                  title: Text('about_application_page.api_version_text'.tr()),
                  subtitle: Text(snapshot.data.toString()),
                  leading: const Icon(Icons.api_outlined),
                  onLongPress: () async {
                    await PlatformAdapter.setClipboard(
                      snapshot.data.toString(),
                    );
                    getIt<NavigationService>().showSnackBar(
                      'basis.copied_to_clipboard'.tr(),
                    );
                  },
                ),
          ),
        FutureBuilder(
          future: _packageVersion(),
          builder:
              (final context, final snapshot) => ListTile(
                title: Text('about_application_page.open_source_licenses'.tr()),
                onTap:
                    () => showLicensePage(
                      context: context,
                      applicationName: 'SelfPrivacy',
                      applicationVersion: snapshot.data.toString(),
                      applicationLegalese: '© 2024 SelfPrivacy',
                    ),
                leading: const Icon(Icons.copyright_outlined),
              ),
        ),
        SectionTitle(title: 'about_application_page.links'.tr()),
        LinkListTile(
          title: 'about_application_page.website'.tr(),
          subtitle: 'selfprivacy.org',
          uri: 'https://selfprivacy.org/',
          icon: Icons.language_outlined,
        ),
        LinkListTile(
          title: 'about_application_page.documentation'.tr(),
          subtitle: 'selfprivacy.org/docs',
          uri: 'https://selfprivacy.org/docs/',
          icon: Icons.library_books_outlined,
        ),
        LinkListTile(
          title: 'about_application_page.privacy_policy'.tr(),
          subtitle: 'selfprivacy.org/privacy-policy',
          uri: 'https://selfprivacy.org/privacy-policy/',
          icon: Icons.policy_outlined,
        ),
        LinkListTile(
          title: 'about_application_page.matrix_channel'.tr(),
          subtitle: '#news:selfprivacy.org',
          uri: 'https://matrix.to/#/#news:selfprivacy.org',
          icon: Icons.feed_outlined,
          longPressText: '#news:selfprivacy.org',
        ),
        LinkListTile(
          title: 'about_application_page.telegram_channel'.tr(),
          subtitle: '@selfprivacy',
          uri: 'https://t.me/selfprivacy',
          icon: Icons.feed_outlined,
          longPressText: '@selfprivacy',
        ),
        SectionTitle(title: 'about_application_page.get_support'.tr()),
        LinkListTile(
          title: 'about_application_page.matrix_support_chat'.tr(),
          subtitle: '#chat:selfprivacy.org',
          uri: 'https://matrix.to/#/#chat:selfprivacy.org',
          icon: Icons.question_answer_outlined,
          longPressText: '#chat:selfprivacy.org',
        ),
        LinkListTile(
          title: 'about_application_page.telegram_support_chat'.tr(),
          subtitle: '@selfprivacy_chat',
          uri: 'https://t.me/selfprivacy_chat',
          icon: Icons.question_answer_outlined,
          longPressText: '@selfprivacy_chat',
        ),
        LinkListTile(
          title: 'about_application_page.email_support'.tr(),
          subtitle: 'support@selfprivacy.org',
          uri: 'mailto:support@selfprivacy.org',
          icon: Icons.email_outlined,
          longPressText: 'support@selfprivacy.org',
        ),
        SectionTitle(title: 'about_application_page.contribute'.tr()),
        LinkListTile(
          title: 'about_application_page.source_code'.tr(),
          subtitle: 'git.selfprivacy.org',
          uri: 'https://git.selfprivacy.org/SelfPrivacy/selfprivacy.org.app',
          icon: Icons.code_outlined,
        ),
        LinkListTile(
          title: 'about_application_page.bug_report'.tr(),
          subtitle: 'about_application_page.bug_report_subtitle'.tr(),
          uri:
              'https://git.selfprivacy.org/SelfPrivacy/selfprivacy.org.app/issues',
          icon: Icons.bug_report_outlined,
        ),
        LinkListTile(
          title: 'about_application_page.help_translate'.tr(),
          subtitle: 'weblate.selfprivacy.org',
          uri: 'https://weblate.selfprivacy.org/projects/selfprivacy/',
          icon: Icons.translate_outlined,
        ),
        LinkListTile(
          title: 'about_application_page.matrix_contributors_chat'.tr(),
          subtitle: '#dev:selfprivacy.org',
          uri: 'https://matrix.to/#/#dev:selfprivacy.org',
          icon: Icons.question_answer_outlined,
          longPressText: '#dev:selfprivacy.org',
        ),
        LinkListTile(
          title: 'about_application_page.telegram_contributors_chat'.tr(),
          subtitle: '@selfprivacy_dev',
          uri: 'https://t.me/selfprivacy_dev',
          icon: Icons.question_answer_outlined,
          longPressText: '@selfprivacy_dev',
        ),
      ],
    );
  }

  Future<String> _packageVersion() async {
    String packageVersion = 'unknown';
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      packageVersion = '${packageInfo.version} (${packageInfo.buildNumber})';
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return packageVersion;
  }

  Future<String> _apiVersion() async {
    final apiVersion =
        getIt<ApiConnectionRepository>().apiData.apiVersion.data ?? 'unknown';

    return apiVersion;
  }
}
