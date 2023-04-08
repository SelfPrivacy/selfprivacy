import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/ui/components/cards/filled_card.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/utils/network_utils.dart';

@RoutePage()
class DnsDetailsPage extends StatefulWidget {
  const DnsDetailsPage({super.key});

  @override
  State<DnsDetailsPage> createState() => _DnsDetailsPageState();
}

class _DnsDetailsPageState extends State<DnsDetailsPage> {
  Widget _getStateCard(
    final DnsRecordsStatus dnsState,
    final Function fixCallback,
  ) {
    String description = '';
    String subtitle = '';
    Icon icon = const Icon(
      Icons.check_circle_outline,
      size: 24.0,
    );
    bool isError = false;
    switch (dnsState) {
      case DnsRecordsStatus.uninitialized:
        description = 'domain.uninitialized'.tr();
        icon = const Icon(
          Icons.refresh,
          size: 24.0,
        );
        isError = false;
        break;
      case DnsRecordsStatus.refreshing:
        description = 'domain.refreshing'.tr();
        icon = const Icon(
          Icons.refresh,
          size: 24.0,
        );
        isError = false;
        break;
      case DnsRecordsStatus.good:
        description = 'domain.ok'.tr();
        icon = const Icon(
          Icons.check_circle_outline,
          size: 24.0,
        );
        isError = false;
        break;
      case DnsRecordsStatus.error:
        description = 'domain.error'.tr();
        subtitle = 'domain.error_subtitle'.tr();
        icon = const Icon(
          Icons.error_outline,
          size: 24.0,
        );
        isError = true;
        break;
    }
    return FilledCard(
      error: isError,
      child: ListTile(
        onTap: dnsState == DnsRecordsStatus.error ? () => fixCallback() : null,
        leading: icon,
        title: Text(description),
        subtitle: subtitle != '' ? Text(subtitle) : null,
        textColor: isError
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.onSurfaceVariant,
        iconColor: isError
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;
    final String domain =
        getIt<ApiConfigModel>().serverDomain?.domainName ?? '';
    final DnsRecordsState dnsCubit = context.watch<DnsRecordsCubit>().state;

    print(dnsCubit.dnsState);

    if (!isReady) {
      return BrandHeroScreen(
        hasBackButton: true,
        heroIcon: BrandIcons.globe,
        heroTitle: 'domain.screen_title'.tr(),
        heroSubtitle: 'not_ready_card.in_menu'.tr(),
        children: const [],
      );
    }

    final Color goodColor = Theme.of(context).colorScheme.onBackground;
    final Color errorColor = Theme.of(context).colorScheme.error;
    final Color neutralColor = Theme.of(context).colorScheme.onBackground;

    return BrandHeroScreen(
      hasBackButton: true,
      heroSubtitle: domain,
      heroIcon: BrandIcons.globe,
      heroTitle: 'domain.screen_title'.tr(),
      children: <Widget>[
        _getStateCard(dnsCubit.dnsState, () {
          context.read<DnsRecordsCubit>().fix();
        }),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'domain.services_title'.tr(),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          subtitle: Text(
            'domain.services_subtitle'.tr(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        ...dnsCubit.dnsRecords
            .where(
              (final dnsRecord) =>
                  dnsRecord.category == DnsRecordsCategory.services,
            )
            .map(
              (final dnsRecord) => Column(
                children: [
                  ListTile(
                    leading: Icon(
                      dnsRecord.isSatisfied
                          ? Icons.check_circle_outline
                          : dnsCubit.dnsState == DnsRecordsStatus.refreshing
                              ? Icons.refresh
                              : Icons.error_outline,
                      color: dnsRecord.isSatisfied
                          ? goodColor
                          : dnsCubit.dnsState == DnsRecordsStatus.refreshing
                              ? neutralColor
                              : errorColor,
                    ),
                    title: Text(
                      dnsRecord.description.tr(),
                    ),
                    subtitle: Text(
                      dnsRecord.name,
                    ),
                  ),
                ],
              ),
            ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'domain.email_title'.tr(),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          subtitle: Text(
            'domain.email_subtitle'.tr(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        ...dnsCubit.dnsRecords
            .where(
              (final dnsRecord) =>
                  dnsRecord.category == DnsRecordsCategory.email,
            )
            .map(
              (final dnsRecord) => Column(
                children: [
                  ListTile(
                    leading: Icon(
                      dnsRecord.isSatisfied
                          ? Icons.check_circle_outline
                          : dnsCubit.dnsState == DnsRecordsStatus.refreshing
                              ? Icons.refresh
                              : Icons.error_outline,
                      color: dnsRecord.isSatisfied
                          ? goodColor
                          : dnsCubit.dnsState == DnsRecordsStatus.refreshing
                              ? neutralColor
                              : errorColor,
                    ),
                    title: Text(
                      dnsRecord.description.tr(),
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
