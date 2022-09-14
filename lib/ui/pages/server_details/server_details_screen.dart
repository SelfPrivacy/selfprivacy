import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/hetzner_metrics/hetzner_metrics_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_loader/brand_loader.dart';
import 'package:selfprivacy/ui/components/brand_radio_tile/brand_radio_tile.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:selfprivacy/ui/components/switch_block/switch_bloc.dart';
import 'package:selfprivacy/ui/pages/server_details/time_zone/lang.dart';
import 'package:selfprivacy/utils/extensions/duration.dart';
import 'package:selfprivacy/utils/named_font_weight.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:timezone/timezone.dart';

import 'package:selfprivacy/ui/pages/server_details/cpu_chart.dart';
import 'package:selfprivacy/ui/pages/server_details/network_charts.dart';

part 'chart.dart';
part 'header.dart';
part 'server_settings.dart';
part 'text_details.dart';
part 'time_zone/time_zone.dart';

var navigatorKey = GlobalKey<NavigatorState>();

class ServerDetailsScreen extends StatefulWidget {
  const ServerDetailsScreen({final super.key});

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
    final providerState = isReady ? StateType.stable : StateType.uninitialized;

    return BlocProvider(
      create: (final context) => ServerDetailsCubit()..check(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Column(
            children: [
              Container(
                height: 51,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: BrandText.h4('basis.details'.tr()),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: paddingH15V0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Header(
                          providerState: providerState,
                          tabController: tabController,
                        ),
                        BrandText.body1('providers.server.bottom_sheet.1'.tr()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocProvider(
                    create: (final context) => HetznerMetricsCubit()..restart(),
                    child: _Chart(),
                  ),
                  const SizedBox(height: 20),
                  _TextDetails(),
                ],
              ),
            ),
            _ServerSettings(tabController: tabController),
          ],
        ),
      ),
    );
  }
}
