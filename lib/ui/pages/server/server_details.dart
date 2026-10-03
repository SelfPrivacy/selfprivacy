import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/connection_blocs.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/cubit/app_readiness/app_readiness_cubit.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';
import 'package:selfprivacy/ui/atoms/icons/brand_icons.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/section_headline.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/cards/server_text_details_card.dart';
import 'package:selfprivacy/ui/molecules/cards/storage_card.dart';
import 'package:selfprivacy/ui/organisms/charts/server_charts.dart';
import 'package:selfprivacy/ui/router/router.dart';

var navigatorKey = GlobalKey<NavigatorState>();

@RoutePage()
class ServerDetailsPage extends StatefulWidget {
  const ServerDetailsPage({super.key});

  @override
  State<ServerDetailsPage> createState() => _ServerDetailsPageState();
}

class _ServerDetailsPageState extends State<ServerDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final bool isReady =
        context.watch<AppReadinessCubit>().state is ServerConfigured;

    if (!isReady) {
      return BrandHeroScreen(
        heroIcon: BrandIcons.server,
        heroTitle: 'server.card_title'.tr(),
        heroSubtitle: 'not_ready_card.in_menu'.tr(),
        children: const [],
      );
    }

    return BrandHeroScreen(
      hasFlashButton: true,
      heroIcon: BrandIcons.server,
      heroTitle: 'server.card_title'.tr(),
      heroSubtitle: 'server.description'.tr(),
      children: [
        if (context.watch<VolumesBloc>().state case VolumesUnavailable(
          :final isUnsupported,
        ))
          Text(
            (isUnsupported
                    ? 'basis.feature_unsupported'
                    : 'basis.network_error')
                .tr(),
          )
        else
          StorageCard(
            diskStatus: context.watch<VolumesBloc>().state.diskStatus,
          ),
        const SizedBox(height: 16),
        ListTile(
          title: Text('server.settings'.tr()),
          leading: const Icon(Icons.settings_outlined),
          onTap: () => context.pushRoute(const ServerSettingsRoute()),
        ),
        ListTile(
          title: Text('server.logs'.tr()),
          leading: const Icon(Icons.manage_search_outlined),
          onTap: () => context.pushRoute(ServerLogsRoute()),
        ),
        const Divider(height: 32),
        SectionHeadline(title: 'server.resource_usage'.tr()),
        const SizedBox(height: 8),
        BlocProvider(
          create: (final context) => createMetricsCubit(
            getIt<ServerConnectionHub>(),
            resources: getIt<ResourcesModel>(),
            serverProvider: () => ProvidersController.currentServerProvider,
          ),
          child: const ServerCharts(),
        ),
        const SizedBox(height: 8),
        const ServerTextDetailsCard(),
      ],
    );
  }
}
