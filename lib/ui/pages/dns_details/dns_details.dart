import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/ui/atoms/icons/brand_icons.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/section_headline.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/cards/dns_state_card.dart';
import 'package:selfprivacy/ui/molecules/list_items/dns_record_item.dart';
import 'package:selfprivacy/utils/fake_data.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class DnsDetailsPage extends StatefulWidget {
  const DnsDetailsPage({super.key});

  @override
  State<DnsDetailsPage> createState() => _DnsDetailsPageState();
}

class _DnsDetailsPageState extends State<DnsDetailsPage> {
  @override
  Widget build(final BuildContext context) {
    final bool isReady =
        context.watch<ServerInstallationCubit>().state
            is ServerInstallationFinished;
    final String domain =
        getIt<ResourcesModel>().serverDomain?.domainName ?? '';
    final DnsRecordsState dnsCubit = context.watch<DnsRecordsCubit>().state;
    final List<DesiredDnsRecord> dnsRecords =
        context.watch<DnsRecordsCubit>().state.dnsRecords;

    if (!isReady) {
      return BrandHeroScreen(
        hasBackButton: true,
        heroIcon: BrandIcons.globe,
        heroTitle: 'domain.screen_title'.tr(),
        heroSubtitle: 'not_ready_card.in_menu'.tr(),
        children: const [],
      );
    }

    final recordsToShow =
        dnsRecords.isEmpty ? FakeSelfPrivacyData.desiredDnsRecords : dnsRecords;
    final refreshing =
        dnsCubit.dnsState == DnsRecordsStatus.refreshing || dnsRecords.isEmpty;

    List<Widget> recordsSection(
      final String title,
      final String subtitle,
      final DnsRecordsCategory category,
    ) => [
      SectionHeadline(title: title, subtitle: subtitle),
      ...recordsToShow
          .where((final dnsRecord) => dnsRecord.category == category)
          .map(
            (final dnsRecord) => Skeletonizer(
              enabled: refreshing,
              enableSwitchAnimation: true,
              child: DnsRecordItem(
                dnsRecord: dnsRecord,
                refreshing: refreshing,
              ),
            ),
          ),
    ];

    return BrandHeroScreen(
      hasBackButton: true,
      heroSubtitle: domain,
      heroIcon: BrandIcons.globe,
      heroTitle: 'domain.screen_title'.tr(),
      children: <Widget>[
        DnsStateCard(
          dnsState: dnsCubit.dnsState,
          fixCallback: () async {
            await context.read<DnsRecordsCubit>().fix();
          },
        ),
        const Gap(8),
        ...recordsSection(
          'domain.services_title'.tr(),
          'domain.services_subtitle'.tr(),
          DnsRecordsCategory.services,
        ),
        const Gap(8),
        ...recordsSection(
          'domain.email_title'.tr(),
          'domain.email_subtitle'.tr(),
          DnsRecordsCategory.email,
        ),
        const Gap(8),
        ...recordsSection(
          'domain.other_title'.tr(),
          'domain.other_subtitle'.tr(),
          DnsRecordsCategory.other,
        ),
      ],
    );
  }
}
