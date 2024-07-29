import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/buttons/segmented_buttons.dart';
import 'package:selfprivacy/ui/components/cards/filled_card.dart';
import 'package:selfprivacy/ui/components/list_tiles/list_tile_on_surface_variant.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/server_details/charts/cpu_chart.dart';
import 'package:selfprivacy/ui/pages/server_details/charts/network_charts.dart';
import 'package:selfprivacy/ui/pages/server_storage/storage_card.dart';
import 'package:selfprivacy/ui/router/router.dart';

part 'charts/chart.dart';
part 'text_details.dart';

var navigatorKey = GlobalKey<NavigatorState>();

@RoutePage()
class ServerDetailsScreen extends StatefulWidget {
  const ServerDetailsScreen({super.key});

  @override
  State<ServerDetailsScreen> createState() => _ServerDetailsScreenState();
}

class _ServerDetailsScreenState extends State<ServerDetailsScreen>
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
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;

    if (!isReady) {
      return BrandHeroScreen(
        heroIcon: BrandIcons.server,
        heroTitle: 'server.card_title'.tr(),
        heroSubtitle: 'not_ready_card.in_menu'.tr(),
        children: const [],
      );
    }

    return BlocProvider(
      create: (final context) => context.read<ServerDetailsCubit>()..check(),
      child: BrandHeroScreen(
        hasFlashButton: true,
        heroIcon: BrandIcons.server,
        heroTitle: 'server.card_title'.tr(),
        heroSubtitle: 'server.description'.tr(),
        children: [
          StorageCard(
            diskStatus: context.watch<VolumesBloc>().state.diskStatus,
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Text('server.settings'.tr()),
            leading: const Icon(BrandIcons.settings),
            onTap: () => context.pushRoute(const ServerSettingsRoute()),
          ),
          ListTile(
            title: Text('server.logs'.tr()),
            leading: const Icon(Icons.manage_search_outlined),
            onTap: () => context.pushRoute(ServerLogsRoute()),
          ),
          const Divider(height: 32),
          Text(
            'server.resource_usage'.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          BlocProvider(
            create: (final context) => MetricsCubit()..restart(),
            child: _Chart(),
          ),
          const SizedBox(height: 8),
          _TextDetails(),
        ],
      ),
    );
  }
}
