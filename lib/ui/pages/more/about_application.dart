import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_md/brand_md.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(final BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(52),
            child: BrandHeader(
              title: 'about_application_page.title'.tr(),
              hasBackButton: true,
            ),
          ),
          body: ListView(
            padding: paddingH15V0,
            children: [
              const SizedBox(height: 16),
              FutureBuilder(
                future: _packageVersion(),
                builder: (final context, final snapshot) => BrandText.body1(
                  'about_application_page.application_version_text'
                      .tr(args: [snapshot.data.toString()]),
                ),
              ),
              FutureBuilder(
                future: _apiVersion(),
                builder: (final context, final snapshot) => BrandText.body1(
                  'about_application_page.api_version_text'
                      .tr(args: [snapshot.data.toString()]),
                ),
              ),
              const SizedBox(height: 16),
              const BrandMarkdown(
                fileName: 'about',
              ),
            ],
          ),
        ),
      );

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
