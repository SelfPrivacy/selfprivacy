import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';

class DnsDetailsPage extends StatefulWidget {
  @override
  _DnsDetailsPageState createState() => _DnsDetailsPageState();
}

class _DnsDetailsPageState extends State<DnsDetailsPage> {
  Widget _getStateCard(DnsRecordsStatus dnsState, Function fixCallback) {
    var description = '';
    var subtitle = '';
    var icon = Icon(
      Icons.check,
      color: Colors.green,
    );
    switch (dnsState) {
      case DnsRecordsStatus.uninitialized:
        description = 'providers.domain.states.uninitialized'.tr();
        icon = Icon(
          Icons.refresh,
        );
        break;
      case DnsRecordsStatus.refreshing:
        description = 'providers.domain.states.refreshing'.tr();
        icon = Icon(
          Icons.refresh,
        );
        break;
      case DnsRecordsStatus.good:
        description = 'providers.domain.states.ok'.tr();
        icon = Icon(
          Icons.check,
          color: Colors.green,
        );
        break;
      case DnsRecordsStatus.error:
        description = 'providers.domain.states.error'.tr();
        subtitle = 'providers.domain.states.error_subtitle'.tr();
        icon = Icon(
          Icons.error,
          color: Colors.red,
        );
        break;
    }
    return ListTile(
      onTap: dnsState == DnsRecordsStatus.error ? () => fixCallback() : null,
      title: Text(
        description,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: subtitle != '' ? Text(subtitle) : null,
      leading: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    var isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;
    final domain = getIt<ApiConfigModel>().serverDomain?.domainName ?? '';
    var dnsCubit = context.watch<DnsRecordsCubit>().state;

    print(dnsCubit.dnsState);

    if (!isReady) {
      return BrandHeroScreen(
        hasBackButton: true,
        headerTitle: '',
        heroIcon: BrandIcons.globe,
        heroTitle: 'providers.domain.screen_title'.tr(),
        children: <Widget>[
          BrandCards.outlined(
            child: ListTile(
              title: Text(
                'not_ready_card.in_menu'.tr(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ],
      );
    }

    return BrandHeroScreen(
      hasBackButton: true,
      heroSubtitle: domain,
      heroIcon: BrandIcons.globe,
      heroTitle: 'providers.domain.screen_title'.tr(),
      children: <Widget>[
        BrandCards.outlined(
          child: Column(
            children: [
              _getStateCard(dnsCubit.dnsState, () {
                context.read<DnsRecordsCubit>().fix();
              }),
            ],
          ),
        ),

        SizedBox(height: 16.0),
        // Outlined card with a list of A records and their
        // status.
        BrandCards.outlined(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'providers.domain.cards.services.title'.tr(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  'providers.domain.cards.services.subtitle'.tr(),
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              ...dnsCubit.dnsRecords
                  .where(
                    (dnsRecord) =>
                        dnsRecord.category == DnsRecordsCategory.services,
                  )
                  .map(
                    (dnsRecord) => Column(
                      children: [
                        Divider(
                          height: 1.0,
                        ),
                        ListTile(
                          leading: Icon(
                            dnsRecord.isSatisfied
                                ? Icons.check
                                : dnsCubit.dnsState ==
                                        DnsRecordsStatus.refreshing
                                    ? Icons.refresh
                                    : Icons.error,
                            color: dnsRecord.isSatisfied
                                ? Colors.green
                                : dnsCubit.dnsState ==
                                        DnsRecordsStatus.refreshing
                                    ? Colors.grey
                                    : Colors.red,
                          ),
                          title: Text(
                            dnsRecord.description.tr(),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          subtitle: Text(
                            dnsRecord.name,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        BrandCards.outlined(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'providers.domain.cards.email.title'.tr(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  'providers.domain.cards.email.subtitle'.tr(),
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              ...dnsCubit.dnsRecords
                  .where(
                    (dnsRecord) =>
                        dnsRecord.category == DnsRecordsCategory.email,
                  )
                  .map(
                    (dnsRecord) => Column(
                      children: [
                        Divider(
                          height: 1.0,
                        ),
                        ListTile(
                          leading: Icon(
                            dnsRecord.isSatisfied
                                ? Icons.check
                                : dnsCubit.dnsState ==
                                        DnsRecordsStatus.refreshing
                                    ? Icons.refresh
                                    : Icons.error,
                            color: dnsRecord.isSatisfied
                                ? Colors.green
                                : dnsCubit.dnsState ==
                                        DnsRecordsStatus.refreshing
                                    ? Colors.grey
                                    : Colors.red,
                          ),
                          title: Text(
                            dnsRecord.description.tr(),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ],
    );
  }
}
