import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/brand_card/brand_card.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_modal_sheet/brand_modal_sheet.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:selfprivacy/ui/components/not_ready_card/not_ready_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:url_launcher/url_launcher.dart';

import '../rootRoute.dart';

class ServicesPage extends StatefulWidget {
  ServicesPage({Key? key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    var isReady = context.watch<AppConfigCubit>().state.isFullyInitilized;

    return Scaffold(
      appBar: PreferredSize(
        child: BrandHeader(title: 'basis.services'.tr()),
        preferredSize: Size.fromHeight(52),
      ),
      body: ListView(
        padding: brandPagePadding2,
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
    String title;
    IconData iconData;
    String subtitle;

    switch (serviceType) {
      case ServiceTypes.mail:
        iconData = BrandIcons.envelope;
        title = 'services.mail.title'.tr();
        subtitle = 'services.mail.subtitle'.tr();
        break;
      case ServiceTypes.messenger:
        iconData = BrandIcons.messanger;
        title = 'services.messenger.title'.tr();
        subtitle = 'services.messenger.subtitle'.tr();
        break;
      case ServiceTypes.passwordManager:
        iconData = BrandIcons.key;
        title = 'services.password_manager.title'.tr();
        subtitle = 'services.password_manager.subtitle'.tr();
        break;
      case ServiceTypes.video:
        iconData = BrandIcons.webcam;
        title = 'services.video.title'.tr();
        subtitle = 'services.video.subtitle'.tr();
        break;
      case ServiceTypes.cloud:
        iconData = BrandIcons.upload;
        title = 'services.cloud.title'.tr();
        subtitle = 'services.cloud.subtitle'.tr();
        break;
      case ServiceTypes.socialNetwork:
        iconData = BrandIcons.social;
        title = 'services.social_network.title'.tr();
        subtitle = 'services.social_network.subtitle'.tr();
        break;
      case ServiceTypes.git:
        iconData = BrandIcons.git;
        title = 'services.git.title'.tr();
        subtitle = 'services.git.subtitle'.tr();
        break;
    }

    var isReady = context.watch<AppConfigCubit>().state.isFullyInitilized;
    var changeTab = context.read<ChangeTab>().onPress;
    return GestureDetector(
      onTap: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return _ServiceDetails(
            serviceType: serviceType,
            status: isReady ? StateType.stable : StateType.uninitialized,
            title: title,
            icon: iconData,
            changeTab: changeTab,
          );
        },
      ),
      child: BrandCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconStatusMask(
              status: isReady ? StateType.stable : StateType.uninitialized,
              child: Icon(iconData, size: 30, color: Colors.white),
            ),
            SizedBox(height: 10),
            BrandText.h2(title),
            SizedBox(height: 10),
            BrandText.body2(subtitle),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

enum ServiceTypes {
  mail,
  messenger,
  passwordManager,
  video,
  cloud,
  socialNetwork,
  git,
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
    var domainName = config.isDomainFilled
        ? config.cloudFlareDomain!.domainName!
        : 'example.com';

    var linksStyle = body1Style.copyWith(
      fontSize: 15,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : BrandColors.black,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
      // height: 1.1,
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
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.8, left: 5),
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
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.8, left: 5),
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
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.8, left: 5),
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
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.8, left: 5),
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
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.8, left: 5),
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
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.8, left: 5),
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
    }
    return BrandModalSheet(
      child: Navigator(
        key: navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (_) {
          return materialRoute(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: brandPagePadding1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 13),
                      IconStatusMask(
                        status: status,
                        child: Icon(icon, size: 40, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      BrandText.h1(title),
                      SizedBox(height: 10),
                      child,
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _launchURL(url) async {
    var _possible = await canLaunch(url);

    if (_possible) {
      try {
        await launch(
          url,
          forceSafariVC: true,
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
