import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/utils/named_font_weight.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({Key key}) : super(key: key);

  @override
  _AppSettingsPageState createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  @override
  Widget build(BuildContext context) {
    var appSettings = context.watch<AppSettingsCubit>();

    var isDarkModeOn = appSettings.state.isDarkModeOn;

    return SafeArea(
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: PreferredSize(
            child:
                BrandHeader(title: 'Настройки приложения', hasBackButton: true),
            preferredSize: Size.fromHeight(52),
          ),
          body: ListView(
            padding: brandPagePadding2,
            children: [
              BrandDivider(),
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1, color: BrandColors.dividerColor),
                )),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: _TextColumn(
                        title: 'Dark Theme',
                        value: 'Change your the app theme',
                      ),
                    ),
                    SizedBox(width: 5),
                    Switch(
                      activeColor: BrandColors.green1,
                      activeTrackColor: BrandColors.green2,
                      value: Theme.of(context).brightness == Brightness.dark,
                      onChanged: (value) => appSettings.updateDarkMode(
                          isDarkModeOn: !isDarkModeOn),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1, color: BrandColors.dividerColor),
                )),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: _TextColumn(
                        title: 'Reset app config',
                        value: 'Reset api keys and root user',
                      ),
                    ),
                    SizedBox(width: 5),
                    RaisedButton(
                      color: BrandColors.red1,
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          color: BrandColors.white,
                          fontWeight: NamedFontWeight.demiBold,
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            child: AlertDialog(
                              title: Text('Are you sure?'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('Reset all keys?'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Reset',
                                    style: TextStyle(
                                      color: BrandColors.red1,
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<AppConfigCubit>().clearAppConfig();
                                    Navigator.of(context)..pop()..pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context)..pop();
                                  },
                                ),
                              ],
                            ));
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
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
        BrandText.body1(value,
            style: TextStyle(
              fontSize: 13,
              height: 1.53,
              color: BrandColors.gray1,
            ).merge(TextStyle(color: hasWarning ? BrandColors.warning : null))),
      ],
    );
  }
}
