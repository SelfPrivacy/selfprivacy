import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_volumes/server_volume_cubit.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/ui/components/brand_button/segmented_buttons.dart';
import 'package:selfprivacy/ui/components/brand_cards/filled_card.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_loader/brand_loader.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/list_tiles/list_tile_on_surface_variant.dart';
import 'package:selfprivacy/ui/pages/server_details/charts/cpu_chart.dart';
import 'package:selfprivacy/ui/pages/server_details/charts/network_charts.dart';
import 'package:selfprivacy/ui/pages/server_storage/storage_card.dart';
import 'package:selfprivacy/utils/extensions/duration.dart';
import 'package:selfprivacy/utils/named_font_weight.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:timezone/timezone.dart';

part 'charts/chart.dart';
part 'server_settings.dart';
part 'text_details.dart';
part 'time_zone/time_zone.dart';

var navigatorKey = GlobalKey<NavigatorState>();

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
        heroIcon: BrandIcons.server,
        heroTitle: 'server.card_title'.tr(),
        heroSubtitle: 'server.description'.tr(),
        children: [
          StorageCard(
            diskStatus: context.watch<ApiServerVolumeCubit>().state.diskStatus,
          ),
          const SizedBox(height: 16),
          const _ServerSettings(),
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
