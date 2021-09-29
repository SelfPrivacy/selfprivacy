import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/jobs/jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/services/services_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_switch/brand_switch.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:selfprivacy/ui/components/not_ready_card/not_ready_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';
import 'package:url_launcher/url_launcher.dart';

import '../rootRoute.dart';

const switchableServices = [
  ServiceTypes.passwordManager,
  ServiceTypes.cloud,
  ServiceTypes.socialNetwork,
  ServiceTypes.git,
  ServiceTypes.vpn,
];

class ServicesPage extends StatefulWidget {
  ServicesPage({Key? key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    var isReady = context.watch<AppConfigCubit>().state  is AppConfigFinished;

    return Scaffold(
      appBar: PreferredSize(
        child: BrandHeader(
          title: 'basis.services'.tr(),
          hasFlashButton: true,
        ),
        preferredSize: Size.fromHeight(52),
      ),
      body: ListView(
        padding: paddingH15V0,
        children: [
          BrandText.body1('services.title'.tr()),
          SizedBox(height: 24),
          if (!isReady) ...[NotReadyCard(), SizedBox(height: 24)],
          ...ServiceTypes.values
              .map((t) => Padding(
                    padding: EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: _Card(serviceType: t),
                  ))
              .toList()
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({Key? key, required this.serviceType}) : super(key: key);

  final ServiceTypes serviceType;
  @override
  Widget build(BuildContext context) {
    var isReady = context.watch<AppConfigCubit>().state  is AppConfigFinished;
    var changeTab = context.read<ChangeTab>().onPress;

    var serviceState = context.watch<ServicesCubit>().state;
    var jobsCubit = context.watch<JobsCubit>();
    var jobState = jobsCubit.state;

    var switchebleService = switchableServices.contains(serviceType);
    var hasSwitchJob = switchebleService &&
        jobState is JobsStateWithJobs &&
        jobState.jobList
            .any((el) => el is ServiceToggleJob && el.type == serviceType);

    var isSwithOn = isReady &&
        (!switchableServices.contains(serviceType) ||
            serviceState.isEnableByType(serviceType));

    return GestureDetector(
      onTap: isSwithOn
          ? () => showDialog<void>(
                context: context,
                // isScrollControlled: true,
                // backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return _ServiceDetails(
                    serviceType: serviceType,
                    status:
                        isSwithOn ? StateType.stable : StateType.uninitialized,
                    title: serviceType.title,
                    icon: serviceType.icon,
                    changeTab: changeTab,
                  );
                },
              )
          : null,
      child: BrandCards.big(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconStatusMask(
                  status:
                      isSwithOn ? StateType.stable : StateType.uninitialized,
                  child: Icon(serviceType.icon, size: 30, color: Colors.white),
                ),
                if (isReady && switchebleService) ...[
                  Spacer(),
                  Builder(
                    builder: (context) {
                      late bool isActive;
                      if (hasSwitchJob) {
                        isActive = ((jobState as JobsStateWithJobs)
                                .jobList
                                .firstWhere((el) =>
                                    el is ServiceToggleJob &&
                                    el.type == serviceType) as ServiceToggleJob)
                            .needToTurnOn;
                      } else {
                        isActive = serviceState.isEnableByType(serviceType);
                      }

                      return BrandSwitch(
                        value: isActive,
                        onChanged: (value) =>
                            jobsCubit.createOrRemoveServiceToggleJob(
                          ServiceToggleJob(
                            type: serviceType,
                            needToTurnOn: value,
                          ),
                        ),
                      );
                    },
                  ),
                ]
              ],
            ),
            ClipRect(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      BrandText.h2(serviceType.title),
                      SizedBox(height: 10),
                      BrandText.body2(serviceType.subtitle),
                      SizedBox(height: 10),
                    ],
                  ),
                  if (hasSwitchJob)
                    Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 3,
                          sigmaY: 2,
                        ),
                        child: BrandText.h2(
                          'jobs.runJobs'.tr(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ServiceDetails extends StatelessWidget {
  const _ServiceDetails({
    Key? key,
    required this.serviceType,
    required this.icon,
    required this.status,
    required this.title,
    required this.changeTab,
  }) : super(key: key);

  final ServiceTypes serviceType;
  final IconData icon;
  final StateType status;
  final String title;
  final ValueChanged<int> changeTab;

  @override
  Widget build(BuildContext context) {
    late Widget child;

    var config = context.watch<AppConfigCubit>().state;
    var domainName = UiHelpers.getDomainName(config);

    var linksStyle = body1Style.copyWith(
      fontSize: 15,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : BrandColors.black,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    );

    var textStyle = body1Style.copyWith(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : BrandColors.black,
    );
    switch (serviceType) {
      case ServiceTypes.mail:
        child = RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: 'services.mail.bottom_sheet.1'.tr(args: [domainName]),
              style: textStyle,
            ),
            WidgetSpan(child: SizedBox(width: 5)),
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.8),
                child: GestureDetector(
                  child: Text(
                    'services.mail.bottom_sheet.2'.tr(),
                    style: linksStyle,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    changeTab(2);
                  },
                ),
              ),
            ),
          ],
        ));
        break;
      case ServiceTypes.messenger:
        child = RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: 'services.messenger.bottom_sheet.1'.tr(args: [domainName]),
              style: textStyle,
            )
          ],
        ));
        break;
      case ServiceTypes.passwordManager:
        child = RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: 'services.password_manager.bottom_sheet.1'
                  .tr(args: [domainName]),
              style: textStyle,
            ),
            WidgetSpan(child: SizedBox(width: 5)),
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.8),
                child: GestureDetector(
                  onTap: () => _launchURL('https://password.$domainName'),
                  child: Text(
                    'password.$domainName',
                    style: linksStyle,
                  ),
                ),
              ),
            ),
          ],
        ));
        break;
      case ServiceTypes.video:
        child = RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: 'services.video.bottom_sheet.1'.tr(args: [domainName]),
              style: textStyle,
            ),
            WidgetSpan(child: SizedBox(width: 5)),
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.8),
                child: GestureDetector(
                  onTap: () => _launchURL('https://meet.$domainName'),
                  child: Text(
                    'meet.$domainName',
                    style: linksStyle,
                  ),
                ),
              ),
            ),
          ],
        ));
        break;
      case ServiceTypes.cloud:
        child = RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: 'services.cloud.bottom_sheet.1'.tr(args: [domainName]),
              style: textStyle,
            ),
            WidgetSpan(child: SizedBox(width: 5)),
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.8),
                child: GestureDetector(
                  onTap: () => _launchURL('https://cloud.$domainName'),
                  child: Text(
                    'cloud.$domainName',
                    style: linksStyle,
                  ),
                ),
              ),
            ),
          ],
        ));
        break;
      case ServiceTypes.socialNetwork:
        child = RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: 'services.social_network.bottom_sheet.1'
                  .tr(args: [domainName]),
              style: textStyle,
            ),
            WidgetSpan(child: SizedBox(width: 5)),
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.8),
                child: GestureDetector(
                  onTap: () => _launchURL('https://social.$domainName'),
                  child: Text(
                    'social.$domainName',
                    style: linksStyle,
                  ),
                ),
              ),
            ),
          ],
        ));
        break;
      case ServiceTypes.git:
        child = RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: 'services.git.bottom_sheet.1'.tr(args: [domainName]),
              style: textStyle,
            ),
            WidgetSpan(child: SizedBox(width: 5)),
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.8),
                child: GestureDetector(
                  onTap: () => _launchURL('https://git.$domainName'),
                  child: Text(
                    'git.$domainName',
                    style: linksStyle,
                  ),
                ),
              ),
            ),
          ],
        ));
        break;
      case ServiceTypes.vpn:
        child = Text(
          'services.vpn.bottom_sheet.1'.tr(),
        );
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Container(
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: paddingH15V30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconStatusMask(
                      status: status,
                      child: Icon(icon, size: 40, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    BrandText.h2(title),
                    SizedBox(height: 10),
                    child,
                    SizedBox(height: 40),
                    Center(
                      child: Container(
                        child: BrandButton.rised(
                          onPressed: () => Navigator.of(context).pop(),
                          text: 'basis.close'.tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(url) async {
    var _possible = await canLaunch(url);

    if (_possible) {
      try {
        await launch(
          url,
          enableJavaScript: true,
        );
      } catch (e) {
        print(e);
      }
    } else {
      throw 'Could not launch $url';
    }
  }
}
