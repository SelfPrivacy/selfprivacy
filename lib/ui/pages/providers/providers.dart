import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/models/provider.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/components/brand_card/brand_card.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_modal_sheet/brand_modal_sheet.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:selfprivacy/ui/pages/settings/setting.dart';
import 'package:selfprivacy/utils/extensions/text_extension.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class ProvidersPage extends StatefulWidget {
  ProvidersPage({Key key}) : super(key: key);

  @override
  _ProvidersPageState createState() => _ProvidersPageState();
}

class _ProvidersPageState extends State<ProvidersPage> {
  @override
  Widget build(BuildContext context) {
    final cards = ProviderTypes.values
        .map((type) => _Card(
            provider:
                ProviderModel(state: ServiceStateType.stable, type: type)))
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        child: BrandHeader(title: 'Провайдеры'),
        preferredSize: Size.fromHeight(52),
      ),
      body: ListView(
        padding: brandPagePadding2,
        children: cards,
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({Key key, @required this.provider}) : super(key: key);

  final ProviderModel provider;
  @override
  Widget build(BuildContext context) {
    String title;
    String message;
    String stableText;

    switch (provider.type) {
      case ProviderTypes.server:
        title = 'Сервер';
        stableText = 'В норме';
        break;
      case ProviderTypes.domain:
        title = 'Домен';
        message = 'example.com';
        stableText = 'Домен настроен';
        break;
      case ProviderTypes.backup:
        message = '22 янв 2021 14:30';
        title = 'Резервное копирование';
        stableText = 'В норме';
        break;
    }
    return GestureDetector(
      onTap: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return _ProviderDetails(
            provider: provider,
            statusText: stableText,
          );
        },
      ),
      child: BrandCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconStatusMaks(
              status: provider.state,
              child: Icon(provider.icon, size: 30, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(title).h2,
            SizedBox(height: 10),
            if (message != null) ...[
              Text(message).body2,
              SizedBox(height: 10),
            ],
            if (provider.state == ServiceStateType.stable)
              Text(stableText).body2,
          ],
        ),
      ),
    );
  }
}

class _ProviderDetails extends StatelessWidget {
  const _ProviderDetails({
    Key key,
    @required this.provider,
    @required this.statusText,
  }) : super(key: key);

  final ProviderModel provider;
  final String statusText;

  @override
  Widget build(BuildContext context) {
    String title;

    switch (provider.type) {
      case ProviderTypes.server:
        title = 'Сервер';
        break;
      case ProviderTypes.domain:
        title = 'Домен';

        break;
      case ProviderTypes.backup:
        title = 'Резервное копирование';
        break;
    }
    return BrandModalSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 2,
              ),
              child: PopupMenuButton<_PopupMenuItemType>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onSelected: (_PopupMenuItemType result) {
                  switch (result) {
                    case _PopupMenuItemType.setting:
                      Navigator.of(context)
                          .pushReplacement(materialRoute(SettingsPage()));
                      break;
                  }
                },
                icon: Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem<_PopupMenuItemType>(
                    value: _PopupMenuItemType.setting,
                    child: Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text('Настройки'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: brandPagePadding1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 13),
                IconStatusMaks(
                  status: provider.state,
                  child: Icon(provider.icon, size: 40, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(title).h1,
                SizedBox(height: 10),
                Text(statusText).body1,
                SizedBox(
                  height: 20,
                ),
                Text('Статусы сервера и сервис провайдера и т.д.')
              ],
            ),
          )
        ],
      ),
    );
  }
}

enum _PopupMenuItemType { setting }
