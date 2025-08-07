import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/atoms/masks/icon_status_mask.dart';
import 'package:selfprivacy/ui/molecules/chips/support_level_chip.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/launch_url.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ServicesPageCard extends StatelessWidget {
  const ServicesPageCard({required this.service, super.key});

  final Service service;
  @override
  Widget build(final BuildContext context) {
    final isReady =
        context.watch<ServerInstallationCubit>().state
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
        onTap:
            isReady
                ? () => context.pushRoute(ServiceRoute(serviceId: service.id))
                : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Skeleton.leaf(
                    child:
                        service.svgIcon == ''
                            ? const Icon(Icons.question_mark_outlined, size: 32)
                            : IconStatusMask(
                              status: getStatus(service.status),
                              icon: SvgPicture.string(
                                service.svgIcon,
                                width: 32,
                                height: 32,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
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
                  if (service.url != '' &&
                      service.url != null &&
                      service.isEnabled)
                    Column(
                      children: [
                        _ServiceLink(url: service.url ?? ''),
                        const SizedBox(height: 8),
                      ],
                    ),
                  if (service.id == 'simple-nixos-mailserver')
                    Column(
                      children: [
                        _ServiceLink(url: 'https://api.$domainName/user'),
                        const SizedBox(height: 8),
                      ],
                    ),
                  Text(
                    service.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (service.loginInfo != '') ...[
                    const SizedBox(height: 8),
                    Text(
                      service.loginInfo,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  if (service.isInstalled)
                    Row(
                      children: [
                        if (service.supportLevel != SupportLevel.normal)
                          SupportLevelChip(
                            supportLevel: service.supportLevel,
                            dense: true,
                          ),
                        if (service.isSystemService)
                          const SystemServiceChip(dense: true),
                      ],
                    ),
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
  const _ServiceLink({required this.url});

  final String url;
  @override
  Widget build(final BuildContext context) => GestureDetector(
    onTap: () => launchURL(url),
    child: Text(
      url,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
      ),
    ),
  );
}
