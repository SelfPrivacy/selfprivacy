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
import 'package:selfprivacy/ui/components/one_page/one_page.dart';
import 'package:selfprivacy/ui/pages/providers/settings/settings.dart';
import 'package:selfprivacy/ui/pages/server_details/server_details.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/utils/route_transitions/slide_bottom.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';

var navigatorKey = GlobalKey<NavigatorState>();

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
    late String title;
    String? message;
    late String stableText;
    late VoidCallback onTap;

    AppConfigState appConfig = context.watch<AppConfigCubit>().state;

    var domainName =
        appConfig.isDomainFilled ? appConfig.cloudFlareDomain!.domainName : '';

    switch (provider.type) {
      case ProviderType.server:
        title = 'providers.server.card_title'.tr();
        stableText = 'providers.domain.status'.tr();

        stableText = 'providers.server.status'.tr();
        onTap = () => Navigator.of(context).push(
              SlideBottomRoute(
                OnePage(
                  title: title,
                  child: ServerDetails(),
                ),
              ),
            );
        break;
      case ProviderType.domain:
        title = 'providers.domain.card_title'.tr();
        message = domainName;
        stableText = 'providers.domain.status'.tr();

        onTap = () => showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return _ProviderDetails(
                  provider: provider,
                  statusText: stableText,
                );
              },
            );
        break;
      case ProviderType.backup:
        title = 'providers.backup.card_title'.tr();
        stableText = 'providers.backup.status'.tr();

        onTap = () => showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return _ProviderDetails(
                  provider: provider,
                  statusText: stableText,
                );
              },
            );
        break;
    }
    return GestureDetector(
      onTap: onTap,
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

    var domainName = UiHelpers.getDomainName(config);

    switch (provider.type) {
      case ProviderType.server:
        throw ('wrong type');
      case ProviderType.domain:
        title = 'providers.domain.card_title'.tr();
        children = [
          BrandText.body1('providers.domain.bottom_sheet.1'.tr()),
          SizedBox(height: 10),
          BrandText.body1(
              'providers.domain.bottom_sheet.2'.tr(args: [domainName, 'Date'])),
          SizedBox(height: 10),
          BrandText.body1('providers.domain.status'.tr()),
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
                SizedBox(height: 40),
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
