import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/services/services_cubit.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:selfprivacy/ui/components/not_ready_card/not_ready_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/breakpoints.dart';
import 'package:selfprivacy/utils/launch_url.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(final BuildContext context) {
    final isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;

    final services = [...context.watch<ServicesCubit>().state.services];
    services
        .sort((final a, final b) => a.status.index.compareTo(b.status.index));

    return Scaffold(
      appBar: Breakpoints.small.isActive(context)
          ? PreferredSize(
              preferredSize: const Size.fromHeight(52),
              child: BrandHeader(
                title: 'basis.services'.tr(),
              ),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ServicesCubit>().reload();
        },
        child: ListView(
          padding: paddingH15V0,
          children: [
            BrandText.body1('basis.services_title'.tr()),
            const SizedBox(height: 24),
            if (!isReady) ...[const NotReadyCard(), const SizedBox(height: 24)],
            ...services
                .map(
                  (final service) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: _Card(service: service),
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
  const _Card({required this.service});

  final Service service;
  @override
  Widget build(final BuildContext context) {
    final isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;

    final config = context.watch<ServerInstallationCubit>().state;
    final domainName = UiHelpers.getDomainName(config);

    StateType getStatus(final ServiceStatus status) {
      switch (status) {
        case ServiceStatus.active:
          return StateType.stable;
        case ServiceStatus.activating:
          return StateType.stable;
        case ServiceStatus.deactivating:
          return StateType.uninitialized;
        case ServiceStatus.inactive:
          return StateType.uninitialized;
        case ServiceStatus.failed:
          return StateType.error;
        case ServiceStatus.off:
          return StateType.uninitialized;
        case ServiceStatus.reloading:
          return StateType.stable;
      }
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkResponse(
        highlightShape: BoxShape.rectangle,
        onTap: isReady
            ? () => context.pushRoute(
                  ServiceRoute(serviceId: service.id),
                )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconStatusMask(
                    status: getStatus(service.status),
                    icon: SvgPicture.string(
                      service.svgIcon,
                      width: 30.0,
                      height: 30.0,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  BrandText.h2(service.displayName),
                  const SizedBox(height: 10),
                  if (service.url != '' && service.url != null)
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => launchURL(
                            service.url,
                          ),
                          child: Text(
                            '${service.url}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  if (service.id == 'mailserver')
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
                  BrandText.body2(service.loginInfo),
                  const SizedBox(height: 10),
                  BrandText.body2(service.description),
                  const SizedBox(height: 10),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
