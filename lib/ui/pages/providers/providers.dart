import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/backups/backups_cubit.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/logic/cubit/providers/providers_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
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
import 'package:selfprivacy/ui/pages/server_details/server_details_screen.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ProvidersPage extends StatefulWidget {
  const ProvidersPage({final super.key});

  @override
  State<ProvidersPage> createState() => _ProvidersPageState();
}

class _ProvidersPageState extends State<ProvidersPage> {
  @override
  Widget build(final BuildContext context) {
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;
    final bool isBackupInitialized =
        context.watch<BackupsCubit>().state.isInitialized;
    final DnsRecordsStatus dnsStatus =
        context.watch<DnsRecordsCubit>().state.dnsState;

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

    final List<Padding> cards = ProviderType.values
        .map(
          (final ProviderType type) => Padding(
            padding: const EdgeInsets.only(bottom: 30),
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
        preferredSize: const Size.fromHeight(52),
        child: BrandHeader(
          title: 'providers.page_title'.tr(),
        ),
      ),
      body: ListView(
        padding: paddingH15V0,
        children: [
          if (!isReady) ...[
            const NotReadyCard(),
            const SizedBox(height: 24),
          ],
          ...cards,
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.provider});

  final ProviderModel provider;
  @override
  Widget build(final BuildContext context) {
    late String title;
    String? message;
    late String stableText;
    late VoidCallback onTap;
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;
    final ServerInstallationState appConfig =
        context.watch<ServerInstallationCubit>().state;

    final String domainName =
        appConfig.isDomainFilled ? appConfig.serverDomain!.domainName : '';

    switch (provider.type) {
      case ProviderType.server:
        title = 'providers.server.card_title'.tr();
        stableText = 'providers.server.status'.tr();
        onTap = () => showBrandBottomSheet(
              context: context,
              builder: (final BuildContext context) => const BrandBottomSheet(
                isExpended: true,
                child: ServerDetailsScreen(),
              ),
            );

        break;
      case ProviderType.domain:
        title = 'providers.domain.screen_title'.tr();
        message = domainName;
        stableText = 'providers.domain.status'.tr();

        onTap = () => Navigator.of(context).push(
              materialRoute(
                const DnsDetailsPage(),
              ),
            );
        break;
      case ProviderType.backup:
        title = 'providers.backup.card_title'.tr();
        stableText = 'providers.backup.status'.tr();

        onTap = () => Navigator.of(context).push(
              materialRoute(
                const BackupDetails(),
              ),
            );
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
            const SizedBox(height: 10),
            BrandText.h2(title),
            const SizedBox(height: 10),
            if (message != null) ...[
              BrandText.body2(message),
              const SizedBox(height: 10),
            ],
            if (provider.state == StateType.stable) BrandText.body2(stableText),
          ],
        ),
      ),
    );
  }
}
