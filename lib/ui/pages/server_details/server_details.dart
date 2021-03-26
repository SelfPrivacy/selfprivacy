import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/ui/components/switch_block/switch_bloc.dart';
import 'package:selfprivacy/utils/named_font_weight.dart';

part 'server_settings.dart';

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
    var isReady = context.watch<AppConfigCubit>().state.isFullyInitilized;
    var providerState = isReady ? StateType.stable : StateType.uninitialized;

    late String title = 'providers.server.card_title'.tr();

    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: tabController,
      children: [
        BlocProvider(
          create: (context) => ServerDetailsCubit()..check(),
          child: Builder(builder: (context) {
            var details = context.watch<ServerDetailsCubit>().state;
            if (details is ServerDetailsLoading ||
                details is ServerDetailsInitial) {
              return _TempMessage(message: 'basis.loading'.tr());
            } else if (details is ServerDetailsNotReady) {
              return _TempMessage(message: 'basis.no_data'.tr());
            } else if (details is Loaded) {
              var data = details.serverInfo;
              var checkTime = details.checkTime;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: brandPagePadding2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconStatusMask(
                              status: providerState,
                              child: Icon(
                                BrandIcons.server,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            BrandText.h2(title),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 2,
                              ),
                              child: PopupMenuButton<_PopupMenuItemType>(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onSelected: (_PopupMenuItemType result) {
                                  switch (result) {
                                    case _PopupMenuItemType.setting:
                                      tabController.animateTo(1);
                                      break;
                                  }
                                },
                                icon: Icon(Icons.more_vert),
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem<_PopupMenuItemType>(
                                    value: _PopupMenuItemType.setting,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text('basis.settings'.tr()),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        BrandText.body1('providers.server.bottom_sheet.1'.tr()),
                        SizedBox(height: 30),
                        Center(child: BrandText.h2('General information')),
                        SizedBox(height: 10),
                        Table(
                          columnWidths: {
                            0: FractionColumnWidth(.5),
                            1: FractionColumnWidth(.5),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: [
                                getRowTitle('Last check'),
                                getRowValue(formater.format(checkTime)),
                              ],
                            ),
                            TableRow(
                              children: [
                                getRowTitle('Server Id'),
                                getRowValue(data.id.toString()),
                              ],
                            ),
                            TableRow(
                              children: [
                                getRowTitle('Status:'),
                                getRowValue(
                                  '${data.status.toString().split('.')[1].toUpperCase()}',
                                  isBold: true,
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                getRowTitle('CPU'),
                                getRowValue(
                                  data.serverType.cores.toString(),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                getRowTitle('Memory'),
                                getRowValue(
                                  '${data.serverType.memory.toString()} GB',
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                getRowTitle('Disk Local'),
                                getRowValue(
                                  '${data.serverType.disk.toString()} GB',
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                getRowTitle('Price monthly:'),
                                getRowValue(
                                  '${data.serverType.prices[1].monthly.toString()}',
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                getRowTitle('Price hourly:'),
                                getRowValue(
                                  '${data.serverType.prices[1].hourly.toString()}',
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Center(child: BrandText.h2('Location')),
                        SizedBox(height: 10),
                        Table(
                          columnWidths: {
                            0: FractionColumnWidth(.5),
                            1: FractionColumnWidth(.5),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: [
                                getRowTitle('Country'),
                                getRowValue(
                                  '${data.location.country}',
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                getRowTitle('City'),
                                getRowValue(data.location.city),
                              ],
                            ),
                            TableRow(
                              children: [
                                getRowTitle('Description'),
                                getRowValue(data.location.description),
                              ],
                            ),
                          ],
                        ),
                        // BrandText.body1('providers.server.bottom_sheet.2'.tr()),
                        // SizedBox(height: 10),
                        // BrandText.body1('providers.server.bottom_sheet.3'.tr()),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              throw Exception('wrong state');
            }
          }),
        ),
        _ServerSettings(tabController: tabController),
      ],
    );
  }

  Widget getRowTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: BrandText.h5(
        title,
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget getRowValue(String title, {bool isBold = false}) {
    return BrandText.body1(
      title,
      style: isBold
          ? TextStyle(
              fontWeight: NamedFontWeight.demiBold,
            )
          : null,
    );
  }
}

enum _PopupMenuItemType { setting }

class _TempMessage extends StatelessWidget {
  const _TempMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Center(
        child: BrandText.body2(message),
      ),
    );
  }
}

final DateFormat formater = DateFormat('HH:mm:ss');
