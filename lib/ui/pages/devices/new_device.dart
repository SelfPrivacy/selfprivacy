import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/devices/devices_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/operations/secret_recipient.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/organisms/displays/key_display.dart';

@RoutePage()
class NewDevicePage extends StatefulWidget {
  const NewDevicePage({super.key});

  @override
  State<NewDevicePage> createState() => _NewDevicePageState();
}

class _NewDevicePageState extends State<NewDevicePage> {
  final _recipient = SecretRecipient();
  late final Future<String?> _key = context.read<DevicesBloc>().getNewDeviceKey(
    recipient: _recipient,
  );

  @override
  void dispose() {
    _recipient.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
    heroTitle: 'devices.add_new_device_screen.header'.tr(),
    heroSubtitle: 'devices.add_new_device_screen.description'.tr(),
    hasBackButton: true,
    hasFlashButton: false,
    children: [
      FutureBuilder(
        future: _key,
        builder:
            (
              final BuildContext context,
              final AsyncSnapshot<Object?> snapshot,
            ) {
              if (snapshot.hasData) {
                return KeyDisplay(
                  keyToDisplay: snapshot.data.toString(),
                  canCopy: true,
                  infoboxText: 'devices.add_new_device_screen.tip'.tr(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Text('basis.no_data'.tr());
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
      ),
    ],
  );
}
