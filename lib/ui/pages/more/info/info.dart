import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:package_info/package_info.dart';
import 'package:easy_localization/easy_localization.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: BrandHeader(title: 'more.about_app'.tr(), hasBackButton: true),
        ),
        body: ListView(
          padding: paddingH15V0,
          children: [
            const BrandDivider(),
            const SizedBox(height: 10),
            FutureBuilder(
                future: _version(),
                builder: (context, snapshot) {
                  return BrandText.body1('more.about_app_page.text'
                      .tr(args: [snapshot.data.toString()]));
                }),
          ],
        ),
      ),
    );
  }

  Future<String> _version() async {
    var packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
