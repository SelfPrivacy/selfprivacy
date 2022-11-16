import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:package_info/package_info.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutApplicationPage extends StatelessWidget {
  const AboutApplicationPage({super.key});

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
              const SizedBox(height: 10),
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
