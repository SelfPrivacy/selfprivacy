import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/switch_block/switch_bloc.dart';
import 'package:selfprivacy/utils/extensions/text_extension.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child:
              BrandHeader(title: 'Настройки приложения', hasBackButton: true),
          preferredSize: Size.fromHeight(52),
        ),
        body: ListView(
          padding: brandPagePadding2,
          children: [
            BrandDivider(),
            SwitcherBlock(
              child: _TextColumn(
                title: 'Dark Theme',
                value: 'Change your the app theme',
              ),
              isActive: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _TextColumn extends StatelessWidget {
  const _TextColumn({
    Key key,
    @required this.title,
    @required this.value,
    this.hasWarning = false,
  }) : super(key: key);

  final String title;
  final String value;
  final bool hasWarning;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title).body1.copyWith(
            style: TextStyle(color: hasWarning ? BrandColors.warning : null)),
        SizedBox(height: 5),
        Text(value)
            .body1
            .copyWith(
              style: TextStyle(
                fontSize: 13,
                height: 1.53,
                color: BrandColors.gray1,
              ),
            )
            .copyWith(
                style:
                    TextStyle(color: hasWarning ? BrandColors.warning : null)),
      ],
    );
  }
}
