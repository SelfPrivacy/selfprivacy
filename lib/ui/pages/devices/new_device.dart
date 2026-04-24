import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/devices/devices_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/organisms/displays/key_display.dart';

@RoutePage()
class NewDevicePage extends StatelessWidget {
  const NewDevicePage({super.key});

  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
    heroTitle: 'devices.add_new_device_screen.header'.tr(),
    heroSubtitle: 'devices.add_new_device_screen.description'.tr(),
    hasBackButton: true,
    hasFlashButton: false,
    children: [
      FutureBuilder(
        future: context.read<DevicesBloc>().getNewDeviceKey(),
        builder: (
          final BuildContext context,
          final AsyncSnapshot<Object?> snapshot,
        ) {
          if (snapshot.hasData) {
            return KeyDisplay(
              keyToDisplay: snapshot.data.toString(),
              canCopy: true,
              infoboxText: 'devices.add_new_device_screen.tip'.tr(),
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    ],
  );
}
