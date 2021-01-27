import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/providers/providers_cubit.dart';
import 'package:selfprivacy/logic/models/provider.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/brand_card/brand_card.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_modal_sheet/brand_modal_sheet.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:selfprivacy/ui/components/not_ready_card/not_ready_card.dart';
import 'package:selfprivacy/ui/pages/providers/settings/settings.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class ProvidersPage extends StatefulWidget {
  ProvidersPage({Key key}) : super(key: key);

  @override
  _ProvidersPageState createState() => _ProvidersPageState();
}

class _ProvidersPageState extends State<ProvidersPage> {
  @override
  Widget build(BuildContext context) {
    var isReady = context.watch<AppConfigCubit>().state.isFullyInitilized;

    final cards = ProviderType.values
        .map((type) => _Card(
            provider:
                ProviderModel(state: StateType.uninitialized, type: type)))
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        child: BrandHeader(title: 'Провайдеры'),
        preferredSize: Size.fromHeight(52),
      ),
      body: ListView(
        padding: brandPagePadding2,
        children: [
          if (!isReady) ...[
            NotReadyCard(),
            SizedBox(height: 24),
          ],
          ...cards,
        ],
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
    var appConfig = context.watch<AppConfigCubit>().state;

    var domainName =
        appConfig.isDomainFilled ? appConfig.cloudFlareDomain.domainName : '';

    switch (provider.type) {
      case ProviderType.server:
        title = 'Сервер';
        stableText = 'В норме';
        break;
      case ProviderType.domain:
        title = 'Домен';
        message = domainName;
        stableText = 'Домен настроен';
        break;
      case ProviderType.backup:
        // message = '22 янв 2021 14:30';
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
            IconStatusMask(
              status: provider.state,
              child: Icon(provider.icon, size: 30, color: Colors.white),
            ),
            SizedBox(height: 10),
            BrandText.h2(title),
            SizedBox(height: 10),
            if (message != null) ...[
              BrandText.body2(message),
              SizedBox(height: 10),
            ],
            if (provider.state == StateType.stable) BrandText.body2(stableText),
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
      case ProviderType.server:
        title = 'Сервер';
        break;
      case ProviderType.domain:
        title = 'Домен';

        break;
      case ProviderType.backup:
        title = 'Резервное копирование';
        break;
    }
    return BrandModalSheet(
      child: Navigator(
        key: navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (_) {
          return materialRoute(
            Column(
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
                            navigatorKey.currentState
                                .push(materialRoute(SettingsPage()));
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
                      IconStatusMask(
                        status: provider.state,
                        child:
                            Icon(provider.icon, size: 40, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      BrandText.h1(title),
                      SizedBox(height: 10),
                      BrandText.body1(statusText),
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
        },
      ),
    );
  }
}

enum _PopupMenuItemType { setting }
