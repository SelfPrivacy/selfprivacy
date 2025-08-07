import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/bloc/outdated_server_checker/outdated_server_checker_bloc.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/atoms/icons/brand_icons.dart';
import 'package:selfprivacy/ui/molecules/cards/not_ready_card.dart';
import 'package:selfprivacy/ui/molecules/cards/providers_page_card.dart';
import 'package:selfprivacy/ui/molecules/cards/server_outdated_card.dart';
import 'package:selfprivacy/ui/organisms/headers/brand_header.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/breakpoints.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    final bool isReady =
        context.watch<ServerInstallationCubit>().state
            is ServerInstallationFinished;
    final BackupsState backupsState = context.watch<BackupsBloc>().state;

    final DnsRecordsStatus dnsStatus =
        context.watch<DnsRecordsCubit>().state.dnsState;

    final diskStatus = context.watch<VolumesBloc>().state.diskStatus;

    final ServerInstallationState appConfig =
        context.watch<ServerInstallationCubit>().state;

    final OutdatedServerCheckerState outdatedServerCheckerState =
        context.watch<OutdatedServerCheckerBloc>().state;

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
      appBar:
          Breakpoints.small.isActive(context)
              ? BrandHeader(title: 'basis.providers_title'.tr())
              : null,
      body: ListView(
        padding: paddingH16V0,
        children: [
          if (!isReady) ...[const NotReadyCard(), const SizedBox(height: 16)],
          if (outdatedServerCheckerState is OutdatedServerCheckerOutdated) ...[
            ServerOutdatedCard(
              requiredVersion:
                  outdatedServerCheckerState.requiredVersion.toString(),
              currentVersion:
                  outdatedServerCheckerState.currentVersion.toString(),
            ),
            const SizedBox(height: 16),
          ],
          ProvidersPageCard(
            state: getServerStatus(),
            icon: BrandIcons.server,
            title: 'server.card_title'.tr(),
            subtitle:
                diskStatus.isDiskOkay
                    ? 'storage.status_ok'.tr()
                    : 'storage.status_error'.tr(),
            onTap:
                isClickable()
                    ? () => context.pushRoute(const ServerDetailsRoute())
                    : null,
          ),
          const SizedBox(height: 16),
          Skeletonizer(
            enabled: dnsStatus == DnsRecordsStatus.refreshing,
            enableSwitchAnimation: true,
            child: ProvidersPageCard(
              state: getDnsStatus(),
              icon: BrandIcons.globe,
              title: 'domain.screen_title'.tr(),
              subtitle:
                  appConfig.isDomainSelected
                      ? appConfig.serverDomain!.domainName
                      : '',
              onTap:
                  isClickable()
                      ? () => context.pushRoute(const DnsDetailsRoute())
                      : null,
            ),
          ),
          const SizedBox(height: 16),
          Skeletonizer(
            enabled:
                isReady &&
                (backupsState is BackupsLoading ||
                    backupsState is BackupsInitial),
            enableSwitchAnimation: true,
            child: ProvidersPageCard(
              state:
                  backupsState is BackupsInitialized
                      ? StateType.stable
                      : StateType.uninitialized,
              icon: BrandIcons.save,
              title: 'backup.card_title'.tr(),
              subtitle: _backupsCardSubtitle(backupsState),
              onTap:
                  isClickable()
                      ? () => context.pushRoute(const BackupDetailsRoute())
                      : null,
            ),
          ),
        ],
      ),
    );
  }

  String _backupsCardSubtitle(final BackupsState backupsState) {
    if (backupsState is BackupsInitialized) {
      final timeSince = backupsState.timeSinceLastBackup();
      if (timeSince == null) {
        return '';
      }

      int numericValue = 0;
      String measurement = 'backup.measurement.seconds'.tr();
      if (timeSince.inMinutes < 1) {
        numericValue = timeSince.inSeconds;
      } else if (timeSince.inHours < 1) {
        numericValue = timeSince.inMinutes;
        measurement = 'backup.measurement.minutes'.tr();
      } else if (timeSince.inDays < 1) {
        numericValue = timeSince.inHours;
        measurement = 'backup.measurement.hours'.tr();
      } else {
        numericValue = timeSince.inDays;
        measurement = 'backup.measurement.days'.tr();
      }

      return 'backup.card_subtitle'.tr(
        namedArgs: {
          'numericValue': numericValue.toString(),
          'measurement': measurement,
        },
      );
    } else if (backupsState is BackupsLoading ||
        backupsState is BackupsInitial) {
      return 'basis.loading'.tr();
    } else {
      return '';
    }
  }
}
