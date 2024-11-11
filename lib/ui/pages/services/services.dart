import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/bloc/outdated_server_checker/outdated_server_checker_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/atoms/icons/brand_icons.dart';
import 'package:selfprivacy/ui/molecules/cards/server_outdated_card.dart';
import 'package:selfprivacy/ui/molecules/cards/services_page_card.dart';
import 'package:selfprivacy/ui/molecules/placeholders/empty_page_placeholder.dart';
import 'package:selfprivacy/ui/organisms/headers/brand_header.dart';
import 'package:selfprivacy/utils/breakpoints.dart';

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

    final OutdatedServerCheckerState outdatedServerCheckerState =
        context.watch<OutdatedServerCheckerBloc>().state;

    final services = [...context.watch<ServicesBloc>().state.services];
    services
        .sort((final a, final b) => a.status.index.compareTo(b.status.index));

    return Scaffold(
      appBar: Breakpoints.small.isActive(context)
          ? BrandHeader(
              title: 'basis.services'.tr(),
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
                padding: paddingH16V0,
                children: [
                  if (outdatedServerCheckerState
                      is OutdatedServerCheckerOutdated) ...[
                    ServerOutdatedCard(
                      requiredVersion:
                          outdatedServerCheckerState.requiredVersion.toString(),
                      currentVersion:
                          outdatedServerCheckerState.currentVersion.toString(),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Text(
                    'basis.services_title'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ...services.map(
                    (final service) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                      ),
                      child: ServicesPageCard(service: service),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
