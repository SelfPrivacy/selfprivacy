import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/switch_block/switch_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: BrandHeader(title: 'Настройки', hasBackButton: true),
          preferredSize: Size.fromHeight(52),
        ),
        body: ListView(
          padding: brandPagePadding2,
          children: [
            BrandDivider(),
            SwitcherBlock(
              onChange: (_) {},
              child: _TextColumn(
                title: 'Allow Auto-upgrade',
                value: 'Wether to allow automatic packages upgrades',
              ),
              isActive: true,
            ),
            SwitcherBlock(
              onChange: (_) {},
              child: _TextColumn(
                title: 'Reboot after upgrade',
                value: 'Reboot without prompt after applying updates',
              ),
              isActive: false,
            ),
            _Button(
              onTap: () {},
              child: _TextColumn(
                title: 'Server Timezone',
                value: 'Europe/Kyiv',
              ),
            ),
            _Button(
              onTap: () {},
              child: _TextColumn(
                title: 'Server Locale',
                value: 'Default',
              ),
            ),
            _Button(
              onTap: () {},
              child: _TextColumn(
                hasWarning: true,
                title: 'Factory Reset',
                value: 'Restore default settings on your server',
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key key,
    @required this.onTap,
    @required this.child,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 5),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 1, color: BrandColors.dividerColor),
        )),
        child: child,
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
        BrandText.body1(
          title,
          style: TextStyle(color: hasWarning ? BrandColors.warning : null),
        ),
        SizedBox(height: 5),
        BrandText.body1(
          value,
          style: TextStyle(
            fontSize: 13,
            height: 1.53,
            color: hasWarning ? BrandColors.warning : BrandColors.gray1,
          ),
        ),
      ],
    );
  }
}
