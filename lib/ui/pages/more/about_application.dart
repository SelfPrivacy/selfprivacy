import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_md/brand_md.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:package_info/package_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class AboutApplicationPage extends StatelessWidget {
  const AboutApplicationPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;

    return BrandHeroScreen(
      hasBackButton: true,
      hasFlashButton: false,
      heroTitle: 'about_application_page.title'.tr(),
      children: [
        FutureBuilder(
          future: _packageVersion(),
          builder: (final context, final snapshot) => BrandText.body1(
            'about_application_page.application_version_text'
                .tr(args: [snapshot.data.toString()]),
          ),
        ),
        if (isReady)
          FutureBuilder(
            future: _apiVersion(),
            builder: (final context, final snapshot) => BrandText.body1(
              'about_application_page.api_version_text'
                  .tr(args: [snapshot.data.toString()]),
            ),
          ),
        const SizedBox(height: 10),
        // Button to call showAboutDialog
        TextButton(
          onPressed: () => showAboutDialog(
            context: context,
            applicationName: 'SelfPrivacy',
            applicationLegalese: '© 2022 SelfPrivacy',
            // Link to privacy policy
            children: [
              TextButton(
                onPressed: () => launchUrl(
                  Uri.parse('https://selfprivacy.ru/privacy-policy'),
                  mode: LaunchMode.externalApplication,
                ),
                child: Text('about_application_page.privacy_policy'.tr()),
              ),
            ],
          ),
          child: const Text('Show about dialog'),
        ),
        const SizedBox(height: 8),
        const Divider(height: 0),
        const SizedBox(height: 8),
        const BrandMarkdown(
          fileName: 'about',
        ),
      ],
    );
  }

  Future<String> _packageVersion() async {
    String packageVersion = 'unknown';
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      packageVersion = packageInfo.version;
    } catch (e) {
      print(e);
    }

    return packageVersion;
  }

  Future<String> _apiVersion() async {
    String apiVersion = 'unknown';
    try {
      apiVersion = await ServerApi().getApiVersion() ?? apiVersion;
    } catch (e) {
      print(e);
    }

    return apiVersion;
  }
}
