import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/backups/backups_cubit.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/logic/cubit/providers/providers_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_volumes/server_volume_cubit.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:selfprivacy/ui/components/not_ready_card/not_ready_card.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/breakpoints.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@RoutePage()
class ProvidersPage extends StatefulWidget {
  const ProvidersPage({super.key});

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

    final diskStatus = context.watch<ApiServerVolumeCubit>().state.diskStatus;

    final ServerInstallationState appConfig =
        context.watch<ServerInstallationCubit>().state;

    StateType getServerStatus() {
      if (!isReady) {
        return StateType.uninitialized;
      }
      if (!diskStatus.isDiskOkay) {
        return StateType.warning;
      }
      return StateType.stable;
    }

    bool isClickable() => getServerStatus() != StateType.uninitialized;

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

    return Scaffold(
      appBar: Breakpoints.small.isActive(context)
          ? PreferredSize(
              preferredSize: const Size.fromHeight(52),
              child: BrandHeader(
                title: 'basis.providers_title'.tr(),
              ),
            )
          : null,
      body: ListView(
        padding: paddingH15V0,
        children: [
          if (!isReady) ...[
            const NotReadyCard(),
            const SizedBox(height: 16),
          ],
          _Card(
            state: getServerStatus(),
            icon: BrandIcons.server,
            title: 'server.card_title'.tr(),
            subtitle: diskStatus.isDiskOkay
                ? 'storage.status_ok'.tr()
                : 'storage.status_error'.tr(),
            onTap: isClickable()
                ? () => context.pushRoute(const ServerDetailsRoute())
                : null,
          ),
          const SizedBox(height: 16),
          _Card(
            state: getDnsStatus(),
            icon: BrandIcons.globe,
            title: 'domain.screen_title'.tr(),
            subtitle: appConfig.isDomainSelected
                ? appConfig.serverDomain!.domainName
                : '',
            onTap: isClickable()
                ? () => context.pushRoute(const DnsDetailsRoute())
                : null,
          ),
          const SizedBox(height: 16),
          _Card(
            state: isBackupInitialized
                ? StateType.stable
                : StateType.uninitialized,
            icon: BrandIcons.save,
            title: 'backup.card_title'.tr(),
            subtitle: isBackupInitialized ? 'backup.card_subtitle'.tr() : '',
            onTap: isClickable()
                ? () => context.pushRoute(const BackupDetailsRoute())
                : null,
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.state,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final Function()? onTap;
  final StateType state;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(final BuildContext context) => Card(
        clipBehavior: Clip.antiAlias,
        child: InkResponse(
          highlightShape: BoxShape.rectangle,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconStatusMask(
                      status: state,
                      icon: Icon(icon, size: 30, color: Colors.white),
                    ),
                    if (state == StateType.uninitialized)
                      const SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(
                          Icons.access_time,
                          color: Colors.white,
                        ),
                      ),
                    if (state != StateType.uninitialized)
                      IconStatusMask(
                        status: state,
                        icon: Icon(
                          state == StateType.stable
                              ? Icons.check_circle_outline
                              : state == StateType.warning
                                  ? Icons.warning_amber_outlined
                                  : Icons.error_outline,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (state != StateType.uninitialized)
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
              ],
            ),
          ),
        ),
      );
}
