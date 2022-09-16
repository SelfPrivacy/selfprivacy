import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/services/services_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_switch/brand_switch.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:selfprivacy/ui/components/not_ready_card/not_ready_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/ui/pages/services/service_page.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';
import 'package:url_launcher/url_launcher.dart';

const switchableServices = [
  ServiceTypes.bitwarden,
  ServiceTypes.nextcloud,
  ServiceTypes.pleroma,
  ServiceTypes.gitea,
  ServiceTypes.ocserv,
];

class ServicesPage extends StatefulWidget {
  const ServicesPage({final super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

void _launchURL(final url) async {
  try {
    final Uri uri = Uri.parse(url);
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    print(e);
  }
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(final BuildContext context) {
    final isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(52),
        child: BrandHeader(
          title: 'basis.services'.tr(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ServicesCubit>().reload();
        },
        child: ListView(
          padding: paddingH15V0,
          children: [
            BrandText.body1('services.title'.tr()),
            const SizedBox(height: 24),
            if (!isReady) ...[const NotReadyCard(), const SizedBox(height: 24)],
            ...ServiceTypes.values
                .map(
                  (final t) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: _Card(serviceType: t),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.serviceType});

  final ServiceTypes serviceType;
  @override
  Widget build(final BuildContext context) {
    final isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;

    final serviceState = context.watch<ServicesCubit>().state;
    final jobsCubit = context.watch<JobsCubit>();
    final jobState = jobsCubit.state;

    final switchableService = switchableServices.contains(serviceType);
    final hasSwitchJob = switchableService &&
        jobState is JobsStateWithJobs &&
        jobState.clientJobList.any(
          (final el) => el is ServiceToggleJob && el.type == serviceType,
        );

    final isSwitchOn = isReady &&
        (!switchableServices.contains(serviceType) ||
            serviceState.isEnableByType(serviceType));

    final config = context.watch<ServerInstallationCubit>().state;
    final domainName = UiHelpers.getDomainName(config);

    return GestureDetector(
      onTap: isReady
          ? () => Navigator.of(context)
              .push(materialRoute(ServicePage(serviceId: serviceType.name)))
          : null,
      child: BrandCards.big(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconStatusMask(
                  status:
                      isSwitchOn ? StateType.stable : StateType.uninitialized,
                  child: Icon(serviceType.icon, size: 30, color: Colors.white),
                ),
                if (isReady && switchableService) ...[
                  const Spacer(),
                  Builder(
                    builder: (final context) {
                      late bool isActive;
                      if (hasSwitchJob) {
                        isActive = (jobState.clientJobList.firstWhere(
                          (final el) =>
                              el is ServiceToggleJob && el.type == serviceType,
                        ) as ServiceToggleJob)
                            .needToTurnOn;
                      } else {
                        isActive = serviceState.isEnableByType(serviceType);
                      }

                      return BrandSwitch(
                        value: isActive,
                        onChanged: (final value) =>
                            jobsCubit.createOrRemoveServiceToggleJob(
                          ServiceToggleJob(
                            type: serviceType,
                            needToTurnOn: value,
                          ),
                        ),
                      );
                    },
                  ),
                ]
              ],
            ),
            ClipRect(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      BrandText.h2(serviceType.title),
                      const SizedBox(height: 10),
                      if (serviceType.subdomain != '')
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => _launchURL(
                                'https://${serviceType.subdomain}.$domainName',
                              ),
                              child: Text(
                                '${serviceType.subdomain}.$domainName',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      if (serviceType == ServiceTypes.mailserver)
                        Column(
                          children: [
                            Text(
                              domainName,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      BrandText.body2(serviceType.loginInfo),
                      const SizedBox(height: 10),
                      BrandText.body2(serviceType.subtitle),
                      const SizedBox(height: 10),
                    ],
                  ),
                  if (hasSwitchJob)
                    Positioned(
                      bottom: 24,
                      left: 0,
                      right: 0,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 3,
                          sigmaY: 2,
                        ),
                        child: BrandText.h2(
                          'jobs.runJobs'.tr(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
