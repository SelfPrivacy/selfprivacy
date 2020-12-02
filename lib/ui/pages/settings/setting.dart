import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/utils/extensions/text_extension.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            BrandHeader(title: 'Настройки', hasBackButton: true),
            Padding(
              padding: brandPagePadding2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BrandDivider(),
                  _SwitcherBlock(
                    child: _TextColumn(
                      title: 'Allow Auto-upgrade',
                      value: 'Wether to allow automatic packages upgrades',
                    ),
                    isActive: true,
                  ),
                  _SwitcherBlock(
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
            )
          ],
        ),
      ),
    );
  }
}

class _SwitcherBlock extends StatelessWidget {
  const _SwitcherBlock({
    Key key,
    @required this.child,
    @required this.isActive,
  }) : super(key: key);

  final Widget child;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 5),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1, color: BrandColors.dividerColor),
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(child: child),
          SizedBox(width: 5),
          Switch(
            activeColor: BrandColors.green1,
            activeTrackColor: BrandColors.green2,
            onChanged: (v) {},
            value: isActive,
          ),
        ],
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
