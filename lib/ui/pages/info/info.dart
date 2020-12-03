import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/utils/extensions/text_extension.dart';
import 'package:package_info/package_info.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: BrandHeader(title: 'О приложении', hasBackButton: true),
          preferredSize: Size.fromHeight(52),
        ),
        body: ListView(
          padding: brandPagePadding2,
          children: [
            BrandDivider(),
            SizedBox(height: 10),
            FutureBuilder(
                future: _version(),
                builder: (context, snapshot) {
                  return Text(
                          'Тут любая служебная информация, v.${snapshot.data}')
                      .body1;
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
