import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/services/services_cubit.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_card/brand_card.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:selfprivacy/ui/components/not_ready_card/not_ready_card.dart';

class ServicesPage extends StatefulWidget {
  ServicesPage({Key? key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    final serviceCubitState = context.watch<ServicesCubit>().state;

    final connected = serviceCubitState.connected;
    final uninitialized = serviceCubitState.uninitialized;
    var isReady = context.watch<AppConfigCubit>().state.isFullyInitilized;

    return Scaffold(
      appBar: PreferredSize(
        child: BrandHeader(title: 'Сервисы'),
        preferredSize: Size.fromHeight(52),
      ),
      body: ListView(
        padding: brandPagePadding2,
        children: [
          if (!isReady) NotReadyCard(),
          SizedBox(height: 24),
          ...connected.map((service) => _Card(service: service)).toList(),
          if (uninitialized.isNotEmpty) ...[
            BrandText.body1('не подключены'),
            SizedBox(height: 30),
          ],
          ...uninitialized.map((service) => _Card(service: service)).toList()
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({Key? key, required this.service}) : super(key: key);

  final Service service;
  @override
  Widget build(BuildContext context) {
    String? title;
    IconData? iconData;
    String? description;

    switch (service.type) {
      case ServiceTypes.messanger:
        iconData = BrandIcons.messanger;
        title = 'Мессенджер';
        description =
            'Delta Chat. Если бы мне надо было обсудить что-то от чего зависит жизнь. Я бы выбрал Delta.Chat + свой почтовый сервер.';
        break;
      case ServiceTypes.mail:
        iconData = BrandIcons.envelope;
        title = 'Почта';
        description = 'Электронная почта для семьи или компании ';
        break;
      case ServiceTypes.passwordManager:
        iconData = BrandIcons.key;
        title = 'Менеджер паролей';
        description = 'Надёжное хранилище для ваших паролей и ключей доступа';
        break;
      case ServiceTypes.github:
        iconData = BrandIcons.github;
        title = 'Git сервер';
        description = 'Сервис для приватного хранения своих разработок';
        break;

      case ServiceTypes.cloud:
        iconData = BrandIcons.upload;
        title = 'Файловое Облако';
        description = 'Сервис для доступа к вашим файлам в любой точке мира';
        break;
    }
    return BrandCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconStatusMask(
            status: service.state,
            child: Icon(iconData, size: 30, color: Colors.white),
          ),
          SizedBox(height: 10),
          BrandText.h2(title),
          SizedBox(height: 10),
          if (service.state == StateType.uninitialized) ...[
            BrandText.body1(description),
            SizedBox(height: 10),
            BrandButton.text(
                title: 'Подключить',
                onPressed: () {
                  context.read<ServicesCubit>().connect(service);
                })
          ],
          if (service.state == StateType.stable) BrandText.body2('Подключен'),
        ],
      ),
    );
  }
}
