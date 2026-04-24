import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/bloc/outdated_server_checker/outdated_server_checker_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/atoms/buttons/outlined_button.dart';
import 'package:selfprivacy/ui/atoms/icons/brand_icons.dart';
import 'package:selfprivacy/ui/molecules/cards/server_outdated_card.dart';
import 'package:selfprivacy/ui/molecules/cards/services_page_card.dart';
import 'package:selfprivacy/ui/molecules/placeholders/empty_page_placeholder.dart';
import 'package:selfprivacy/ui/organisms/headers/brand_header.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/breakpoints.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  bool _showSystemServices = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final isReady =
        context.watch<ServerInstallationCubit>().state
            is ServerInstallationFinished;

    final OutdatedServerCheckerState outdatedServerCheckerState =
        context.watch<OutdatedServerCheckerBloc>().state;

    final services = context
        .watch<ServicesBloc>()
        .state
        .installedServices
        .sorted((final a, final b) => a.status.index.compareTo(b.status.index));

    final systemServices = context.watch<ServicesBloc>().state.systemServices;

    final isLoading = isReady && services.isEmpty && systemServices.isEmpty;
    final fakeServices = List.generate(7, (final int index) => Service.empty);

    void toggleSystemServices() {
      setState(() {
        _showSystemServices = !_showSystemServices;
      });

      if (_showSystemServices) {
        WidgetsBinding.instance.addPostFrameCallback((final _) {
          Future.delayed(const Duration(milliseconds: 300), () {
            unawaited(
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
            );
          });
        });
      }
    }

    return Scaffold(
      appBar:
          Breakpoints.small.isActive(context)
              ? BrandHeader(title: 'basis.services'.tr())
              : null,
      body:
          !isReady
              ? EmptyPagePlaceholder(
                showReadyCard: true,
                title: 'service_page.nothing_here'.tr(),
                description: 'basis.please_connect'.tr(),
                iconData: BrandIcons.box,
              )
              : RefreshIndicator(
                onRefresh: context.read<ServicesBloc>().awaitReload,
                child: ListView(
                  padding: paddingH16V0,
                  controller: _scrollController,
                  children: [
                    if (outdatedServerCheckerState
                        is OutdatedServerCheckerOutdated) ...[
                      ServerOutdatedCard(
                        requiredVersion:
                            outdatedServerCheckerState.requiredVersion
                                .toString(),
                        currentVersion:
                            outdatedServerCheckerState.currentVersion
                                .toString(),
                      ),
                      const Gap(16),
                    ],
                    Text(
                      'basis.services_title'.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Gap(16),
                    Skeletonizer(
                      enabled: isLoading,
                      enableSwitchAnimation: true,
                      child: FilledButton.tonal(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add_box_outlined, size: 18),
                            const Gap(8),
                            Text('services_catalog.title'.tr()),
                          ],
                        ),
                        onPressed: () async {
                          await context.pushRoute(const ServicesCatalogRoute());
                        },
                      ),
                    ),
                    const Gap(16),
                    if (isLoading)
                      ...fakeServices.map(
                        (final service) => Skeletonizer(
                          enabled: isLoading,
                          enableSwitchAnimation: true,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: ServicesPageCard(service: service),
                          ),
                        ),
                      ),
                    ...services.map(
                      (final service) => Skeletonizer(
                        enabled: isLoading,
                        enableSwitchAnimation: true,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ServicesPageCard(service: service),
                        ),
                      ),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        reverseDuration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (
                              final Widget child,
                              final Animation<double> animation,
                            ) => FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                        child:
                            _showSystemServices
                                ? Column(
                                  key: const ValueKey('systemServicesVisible'),
                                  children:
                                      systemServices
                                          .map(
                                            (final service) => Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 16,
                                              ),
                                              child: ServicesPageCard(
                                                service: service,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                )
                                : const SizedBox.shrink(
                                  key: ValueKey('systemServicesHidden'),
                                ),
                      ),
                    ),
                    if (systemServices.isNotEmpty)
                      BrandOutlinedButton(
                        onPressed: toggleSystemServices,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _showSystemServices
                                  ? Icons.unfold_less_outlined
                                  : Icons.unfold_more_outlined,
                              size: 18,
                            ),
                            const Gap(8),
                            Text(
                              _showSystemServices
                                  ? 'service_page.hide_system_services'.tr()
                                  : 'service_page.show_system_services'.tr(),
                            ),
                          ],
                        ),
                      ),
                    const Gap(16),
                  ],
                ),
              ),
    );
  }
}
