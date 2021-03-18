import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/ui/components/brand_md/brand_md.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: BrandHeader(
              title: 'more.about_project'.tr(), hasBackButton: true),
          preferredSize: Size.fromHeight(52),
        ),
        body: Container(
          child: BrandMarkdown(
            fileName: 'about',
          ),
        ),
      ),
    );
  }
}
