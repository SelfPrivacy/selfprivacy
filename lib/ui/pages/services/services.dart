import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:selfprivacy/ui/helpers/empty_page_placeholder.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/breakpoints.dart';
import 'package:selfprivacy/utils/launch_url.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';

@RoutePage()
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

    final services = [...context.watch<ServicesBloc>().state.services];
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
      body: !isReady
          ? EmptyPagePlaceholder(
              showReadyCard: true,
              title: 'service_page.nothing_here'.tr(),
              description: 'basis.please_connect'.tr(),
              iconData: BrandIcons.box,
            )
          : RefreshIndicator(
              onRefresh: context.read<ServicesBloc>().awaitReload,
              child: ListView(
                padding: paddingH15V0,
                children: [
                  Text(
                    'basis.services_title'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  ...services.map(
                    (final service) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: 30,
                      ),
                      child: _Card(service: service),
                    ),
                  ),
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
                  const Gap(8),
                  Expanded(
                    child: Text(
                      service.displayName,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  if (service.url != '' && service.url != null)
                    Column(
                      children: [
                        _ServiceLink(
                          url: service.url ?? '',
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  if (service.id == 'mailserver')
                    Column(
                      children: [
                        _ServiceLink(
                          url: domainName,
                          isActive: false,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  Text(
                    service.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service.loginInfo,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceLink extends StatelessWidget {
  const _ServiceLink({
    required this.url,
    this.isActive = true,
  });

  final String url;
  final bool isActive;

  @override
  Widget build(final BuildContext context) => GestureDetector(
        onTap: isActive
            ? () => launchURL(
                  url,
                )
            : null,
        child: Text(
          url,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                decoration: TextDecoration.underline,
              ),
        ),
      );
}
