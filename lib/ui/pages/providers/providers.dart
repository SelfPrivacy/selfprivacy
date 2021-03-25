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
import 'package:easy_localization/easy_localization.dart';

class ProvidersPage extends StatefulWidget {
  ProvidersPage({Key? key}) : super(key: key);

  @override
  _ProvidersPageState createState() => _ProvidersPageState();
}

class _ProvidersPageState extends State<ProvidersPage> {
  @override
  Widget build(BuildContext context) {
    var isReady = context.watch<AppConfigCubit>().state.isFullyInitilized;

    final cards = ProviderType.values
        .map(
          (type) => Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: _Card(
              provider: ProviderModel(
                state: isReady ? StateType.stable : StateType.uninitialized,
                type: type,
              ),
            ),
          ),
        )
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        child: BrandHeader(title: 'providers.page_title'.tr()),
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
  const _Card({Key? key, required this.provider}) : super(key: key);

  final ProviderModel provider;
  @override
  Widget build(BuildContext context) {
    String? title;
    String? message;
    String? stableText;
    AppConfigState appConfig = context.watch<AppConfigCubit>().state;

    var domainName =
        appConfig.isDomainFilled ? appConfig.cloudFlareDomain!.domainName : '';

    switch (provider.type) {
      case ProviderType.server:
        title = 'providers.server.card_title'.tr();
        stableText = 'В норме';
        break;
      case ProviderType.domain:
        title = 'providers.domain.card_title'.tr();
        message = domainName;
        stableText = 'Домен настроен';
        break;
      case ProviderType.backup:
        title = 'providers.backup.card_title'.tr();
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
    Key? key,
    required this.provider,
    required this.statusText,
  }) : super(key: key);

  final ProviderModel provider;
  final String? statusText;

  @override
  Widget build(BuildContext context) {
    late String title;
    late List<Widget> children;

    var config = context.watch<AppConfigCubit>().state;

    var domainName = config.isDomainFilled
        ? config.cloudFlareDomain!.domainName!
        : 'example.com';
    switch (provider.type) {
      case ProviderType.server:
        title = 'providers.server.card_title'.tr();
        children = [
          BrandText.body1('providers.server.bottom_sheet.1'.tr()),
          SizedBox(height: 10),
          BrandText.body1('providers.server.bottom_sheet.2'.tr()),
          SizedBox(height: 10),
          BrandText.body1('providers.server.bottom_sheet.3'.tr()),
        ];
        break;
      case ProviderType.domain:
        title = 'providers.domain.card_title'.tr();
        children = [
          BrandText.body1('providers.domain.bottom_sheet.1'.tr()),
          SizedBox(height: 10),
          BrandText.body1(
              'providers.domain.bottom_sheet.2'.tr(args: [domainName, 'Date'])),
          SizedBox(height: 10),
          BrandText.body1('providers.domain.bottom_sheet.3'.tr()),
        ];
        break;
      case ProviderType.backup:
        title = 'providers.backup.card_title'.tr();
        children = [
          BrandText.body1('providers.backup.bottom_sheet.1'.tr()),
          SizedBox(height: 10),
          BrandText.body1(
              'providers.backup.bottom_sheet.2'.tr(args: [domainName, 'Time'])),
          SizedBox(height: 10),
          BrandText.body1('providers.backup.bottom_sheet.3'.tr()),
        ];
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
                            navigatorKey.currentState!
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
                            child: Text('basis.settings'.tr()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: brandPagePadding2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconStatusMask(
                        status: provider.state,
                        child:
                            Icon(provider.icon, size: 40, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      BrandText.h1(title),
                      SizedBox(height: 10),
                      ...children
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
