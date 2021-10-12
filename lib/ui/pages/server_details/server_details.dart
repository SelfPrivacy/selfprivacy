import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/hetzner_metrics/hetzner_metrics_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_radio_tile/brand_radio_tile.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/ui/components/switch_block/switch_bloc.dart';
import 'package:selfprivacy/utils/named_font_weight.dart';
import 'cpu_chart.dart';
import 'network_charts.dart';

part 'server_settings.dart';
part 'text_details.dart';
part 'chart.dart';
part 'header.dart';

var navigatorKey = GlobalKey<NavigatorState>();

class ServerDetails extends StatefulWidget {
  const ServerDetails({Key? key}) : super(key: key);

  @override
  _ServerDetailsState createState() => _ServerDetailsState();
}

class _ServerDetailsState extends State<ServerDetails>
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
  Widget build(BuildContext context) {
    var isReady = context.watch<AppConfigCubit>().state  is AppConfigFinished;
    var providerState = isReady ? StateType.stable : StateType.uninitialized;

    return Scaffold(
      appBar: PreferredSize(
        child: Column(
          children: [
            Container(
              height: 51,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: BrandText.h4('basis.details'.tr()),
            ),
            BrandDivider(),
          ],
        ),
        preferredSize: Size.fromHeight(52),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
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
                          tabController: tabController),
                      BrandText.body1('providers.server.bottom_sheet.1'.tr()),
                      SizedBox(height: 10),
                      BlocProvider(
                        create: (context) => HetznerMetricsCubit()..restart(),
                        child: _Chart(),
                      ),
                      SizedBox(height: 20),
                      BlocProvider(
                        create: (context) => ServerDetailsCubit()..check(),
                        child: _TextDetails(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _ServerSettings(tabController: tabController),
        ],
      ),
    );
  }
}
