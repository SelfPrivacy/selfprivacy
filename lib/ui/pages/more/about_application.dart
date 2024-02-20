import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class AboutApplicationPage extends StatelessWidget {
  const AboutApplicationPage({super.key});

  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
        hasBackButton: true,
        hasFlashButton: false,
        heroTitle: 'about_application_page.title'.tr(),
        bodyPadding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'about_application_page.versions'.tr(),
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          FutureBuilder(
            future: _packageVersion(),
            builder: (final context, final snapshot) => ListTile(
              title: Text(
                'about_application_page.application_version_text'.tr(),
              ),
              subtitle: Text(
                snapshot.data.toString(),
              ),
              leading: const Icon(
                Icons.phone_android_outlined,
              ),
              onLongPress: () {
                PlatformAdapter.setClipboard(
                  snapshot.data.toString(),
                );
                getIt<NavigationService>().showSnackBar(
                  'basis.copied_to_clipboard'.tr(),
                );
              },
            ),
          ),
          if (getIt<ApiConnectionRepository>().apiData.apiVersion.data != null)
            FutureBuilder(
              future: _apiVersion(),
              builder: (final context, final snapshot) => ListTile(
                title: Text(
                  'about_application_page.api_version_text'.tr(),
                ),
                subtitle: Text(snapshot.data.toString()),
                leading: const Icon(
                  Icons.api_outlined,
                ),
                onLongPress: () {
                  PlatformAdapter.setClipboard(
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
            builder: (final context, final snapshot) => ListTile(
              title: Text('about_application_page.open_source_licenses'.tr()),
              onTap: () => showLicensePage(
                context: context,
                applicationName: 'SelfPrivacy',
                applicationVersion: snapshot.data.toString(),
                applicationLegalese: '© 2024 SelfPrivacy',
              ),
              leading: const Icon(
                Icons.copyright_outlined,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'about_application_page.links'.tr(),
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          ListTile(
            title: Text('about_application_page.website'.tr()),
            subtitle: const Text('selfprivacy.org'),
            onTap: () => launchUrl(
              Uri.parse('https://selfprivacy.org/'),
              mode: LaunchMode.externalApplication,
            ),
            leading: const Icon(
              Icons.language_outlined,
            ),
            onLongPress: () {
              PlatformAdapter.setClipboard(
                'https://selfprivacy.org/',
              );
              getIt<NavigationService>().showSnackBar(
                'basis.copied_to_clipboard'.tr(),
              );
            },
          ),
          ListTile(
            title: Text('about_application_page.documentation'.tr()),
            subtitle: const Text('selfprivacy.org/docs'),
            onTap: () => launchUrl(
              Uri.parse('https://selfprivacy.org/docs/'),
              mode: LaunchMode.externalApplication,
            ),
            leading: const Icon(
              Icons.library_books_outlined,
            ),
            onLongPress: () {
              PlatformAdapter.setClipboard(
                'https://selfprivacy.org/docs/',
              );
              getIt<NavigationService>().showSnackBar(
                'basis.copied_to_clipboard'.tr(),
              );
            },
          ),
          ListTile(
            title: Text('about_application_page.privacy_policy'.tr()),
            subtitle: const Text('selfprivacy.org/privacy-policy'),
            onTap: () => launchUrl(
              Uri.parse('https://selfprivacy.org/privacy-policy/'),
              mode: LaunchMode.externalApplication,
            ),
            leading: const Icon(
              Icons.policy_outlined,
            ),
            onLongPress: () {
              PlatformAdapter.setClipboard(
                'https://selfprivacy.org/privacy-policy/',
              );
              getIt<NavigationService>().showSnackBar(
                'basis.copied_to_clipboard'.tr(),
              );
            },
          ),
          // Matrix channel
          ListTile(
            title: Text('about_application_page.matrix_channel'.tr()),
            subtitle: const Text('#news:selfprivacy.org'),
            onTap: () => launchUrl(
              Uri.parse('https://matrix.to/#/#news:selfprivacy.org'),
              mode: LaunchMode.externalApplication,
            ),
            leading: const Icon(
              Icons.feed_outlined,
            ),
            onLongPress: () {
              PlatformAdapter.setClipboard(
                '#news:selfprivacy.org',
              );
              getIt<NavigationService>().showSnackBar(
                'basis.copied_to_clipboard'.tr(),
              );
            },
          ),
          // Telegram channel
          ListTile(
            title: Text('about_application_page.telegram_channel'.tr()),
            subtitle: const Text('@selfprivacy'),
            onTap: () => launchUrl(
              Uri.parse('https://t.me/selfprivacy'),
              mode: LaunchMode.externalApplication,
            ),
            leading: const Icon(
              Icons.feed_outlined,
            ),
            onLongPress: () {
              PlatformAdapter.setClipboard(
                '@selfprivacy',
              );
              getIt<NavigationService>().showSnackBar(
                'basis.copied_to_clipboard'.tr(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'about_application_page.get_support'.tr(),
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          // Matrix
          ListTile(
            title: Text('about_application_page.matrix_support_chat'.tr()),
            subtitle: const Text('#chat:selfprivacy.org'),
            onTap: () => launchUrl(
              Uri.parse('https://matrix.to/#/#chat:selfprivacy.org'),
              mode: LaunchMode.externalApplication,
            ),
            leading: const Icon(
              Icons.question_answer_outlined,
            ),
            onLongPress: () {
              PlatformAdapter.setClipboard(
                '#chat:selfprivacy.org',
              );
              getIt<NavigationService>().showSnackBar(
                'basis.copied_to_clipboard'.tr(),
              );
            }
          ),
          // Telegram
          ListTile(
            title: Text('about_application_page.telegram_support_chat'.tr()),
            subtitle: const Text('@selfprivacy_chat'),
            onTap: () => launchUrl(
              Uri.parse('https://t.me/selfprivacy_chat'),
              mode: LaunchMode.externalApplication,
            ),
            leading: const Icon(
              Icons.question_answer_outlined,
            ),
            onLongPress: () {
              PlatformAdapter.setClipboard(
                '@selfprivacy_chat',
              );
              getIt<NavigationService>().showSnackBar(
                'basis.copied_to_clipboard'.tr(),
              );
            },
          ),
          // Email
          ListTile(
            title: Text('about_application_page.email_support'.tr()),
            subtitle: const Text('support@selfprivacy.org'),
            onTap: () => launchUrl(
              Uri.parse('mailto:support@selfprivacy.org'),
              mode: LaunchMode.externalApplication,
            ),
            leading: const Icon(
              Icons.email_outlined,
            ),
            onLongPress: () {
              PlatformAdapter.setClipboard(
                'support@selfprivacy.org',
              );
              getIt<NavigationService>().showSnackBar(
                'basis.copied_to_clipboard'.tr(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'about_application_page.contribute'.tr(),
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          // Source code
          ListTile(
            title: Text('about_application_page.source_code'.tr()),
            subtitle: const Text('git.selfprivacy.org'),
            onTap: () => launchUrl(
              Uri.parse(
                'https://git.selfprivacy.org/SelfPrivacy/selfprivacy.org.app',
              ),
              mode: LaunchMode.externalApplication,
            ),
            leading: const Icon(
              Icons.code_outlined,
            ),
            onLongPress: () {
              PlatformAdapter.setClipboard(
                'https://git.selfprivacy.org/SelfPrivacy/selfprivacy.org.app',
              );
              getIt<NavigationService>().showSnackBar(
                'basis.copied_to_clipboard'.tr(),
              );
            },
          ),
          // translate
          ListTile(
            title: Text('about_application_page.help_translate'.tr()),
            subtitle: const Text('weblate.selfprivacy.org'),
            onTap: () => launchUrl(
              Uri.parse(
                'https://weblate.selfprivacy.org/projects/selfprivacy/',
              ),
              mode: LaunchMode.externalApplication,
            ),
            leading: const Icon(
              Icons.translate_outlined,
            ),
            onLongPress: () {
              PlatformAdapter.setClipboard(
                'https://weblate.selfprivacy.org/projects/selfprivacy/',
              );
              getIt<NavigationService>().showSnackBar(
                'basis.copied_to_clipboard'.tr(),
              );
            },
          ),
          // matrix chat
          ListTile(
            title: Text('about_application_page.matrix_contributors_chat'.tr()),
            subtitle: const Text('#dev:selfprivacy.org'),
            onTap: () => launchUrl(
              Uri.parse('https://matrix.to/#/#dev:selfprivacy.org'),
              mode: LaunchMode.externalApplication,
            ),
            leading: const Icon(
              Icons.question_answer_outlined,
            ),
            onLongPress: () {
              PlatformAdapter.setClipboard(
                '#dev:selfprivacy.org',
              );
              getIt<NavigationService>().showSnackBar(
                'basis.copied_to_clipboard'.tr(),
              );
            },
          ),
          // telegram
          ListTile(
            title:
                Text('about_application_page.telegram_contributors_chat'.tr()),
            subtitle: const Text('@selfprivacy_dev'),
            onTap: () => launchUrl(
              Uri.parse('https://t.me/selfprivacy_dev'),
              mode: LaunchMode.externalApplication,
            ),
            leading: const Icon(
              Icons.question_answer_outlined,
            ),
            onLongPress: () {
              PlatformAdapter.setClipboard(
                '@selfprivacy_dev',
              );
              getIt<NavigationService>().showSnackBar(
                'basis.copied_to_clipboard'.tr(),
              );
            },
          ),
        ],
      );

  Future<String> _packageVersion() async {
    String packageVersion = 'unknown';
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      packageVersion = '${packageInfo.version} (${packageInfo.buildNumber})';
    } catch (e) {
      print(e);
    }

    return packageVersion;
  }

  Future<String> _apiVersion() async {
    final apiVersion =
        getIt<ApiConnectionRepository>().apiData.apiVersion.data ?? 'unknown';

    return apiVersion;
  }
}
