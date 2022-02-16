import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/backups/backups_cubit.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/logic/cubit/providers/providers_cubit.dart';
import 'package:selfprivacy/logic/models/provider.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:selfprivacy/ui/components/not_ready_card/not_ready_card.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';
import 'package:selfprivacy/ui/pages/backup_details/backup_details.dart';
import 'package:selfprivacy/ui/pages/dns_details/dns_details.dart';
import 'package:selfprivacy/ui/pages/server_details/server_details.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

var navigatorKey = GlobalKey<NavigatorState>();

class ProvidersPage extends StatefulWidget {
  ProvidersPage({Key? key}) : super(key: key);

  @override
  _ProvidersPageState createState() => _ProvidersPageState();
}

class _ProvidersPageState extends State<ProvidersPage> {
  @override
  Widget build(BuildContext context) {
    var isReady = context.watch<AppConfigCubit>().state is AppConfigFinished;
    var isBackupInitialized = context.watch<BackupsCubit>().state.isInitialized;
    var dnsStatus = context.watch<DnsRecordsCubit>().state.dnsState;

    StateType getDnsStatus() {
      if (dnsStatus == DnsRecordsStatus.uninitialized ||
          dnsStatus == DnsRecordsStatus.refreshing) {
        return StateType.uninitialized;
      }
      if (dnsStatus == DnsRecordsStatus.error) {
        return StateType.warning;
      }
      return StateType.stable;
    }

    final cards = ProviderType.values
        .map(
          (type) => Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: _Card(
              provider: ProviderModel(
                state: isReady
                    ? (type == ProviderType.backup && !isBackupInitialized
                        ? StateType.uninitialized
                        : (type == ProviderType.domain)
                            ? getDnsStatus()
                            : StateType.stable)
                    : StateType.uninitialized,
                type: type,
              ),
            ),
          ),
        )
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        child: BrandHeader(
          title: 'providers.page_title'.tr(),
          hasFlashButton: true,
        ),
        preferredSize: Size.fromHeight(52),
      ),
      body: ListView(
        padding: paddingH15V0,
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
    var isReady = context.watch<AppConfigCubit>().state is AppConfigFinished;
    AppConfigState appConfig = context.watch<AppConfigCubit>().state;

    var domainName =
        appConfig.isDomainFilled ? appConfig.cloudFlareDomain!.domainName : '';

    switch (provider.type) {
      case ProviderType.server:
        title = 'providers.server.card_title'.tr();
        stableText = 'providers.server.status'.tr();
        onTap = () => showBrandBottomSheet(
              context: context,
              builder: (context) => BrandBottomSheet(
                isExpended: true,
                child: ServerDetails(),
              ),
            );

        break;
      case ProviderType.domain:
        title = 'providers.domain.screen_title'.tr();
        message = domainName;
        stableText = 'providers.domain.status'.tr();

        onTap = () => Navigator.of(context).push(materialRoute(
              DnsDetailsPage(),
            ));
        break;
      case ProviderType.backup:
        title = 'providers.backup.card_title'.tr();
        stableText = 'providers.backup.status'.tr();

        onTap = () => Navigator.of(context).push(materialRoute(
              BackupDetails(),
            ));
        break;
    }
    return GestureDetector(
      onTap: isReady ? onTap : null,
      child: BrandCards.big(
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
