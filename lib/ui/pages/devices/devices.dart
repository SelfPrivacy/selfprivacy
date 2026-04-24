import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/devices/devices_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/section_title.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';
import 'package:selfprivacy/ui/molecules/list_items/device_item.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/fake_data.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override
  Widget build(final BuildContext context) {
    final DevicesState devicesStatus = context.watch<DevicesBloc>().state;

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<DevicesBloc>().refresh();
      },
      child: BrandHeroScreen(
        heroTitle: 'devices.main_screen.header'.tr(),
        heroSubtitle: 'devices.main_screen.description'.tr(),
        heroIcon: Icons.devices_outlined,
        hasBackButton: true,
        hasFlashButton: false,
        children: [
          if (devicesStatus is DevicesInitial) ...[
            const Center(
              heightFactor: 8,
              child: CircularProgressIndicator.adaptive(),
            ),
          ],
          if (devicesStatus is! DevicesInitial) ...[
            _DevicesInfo(devicesStatus: devicesStatus),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => context.pushRoute(const NewDeviceRoute()),
              child: Text('devices.main_screen.authorize_new_device'.tr()),
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            InfoBox(text: 'devices.main_screen.tip'.tr()),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _DevicesInfo extends StatelessWidget {
  const _DevicesInfo({required this.devicesStatus});

  final DevicesState devicesStatus;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SectionTitle(title: 'devices.main_screen.this_device'.tr()),
      Skeletonizer(
        enabled:
            devicesStatus.thisDevice == FakeSelfPrivacyData.thisDeviceToken,
        enableSwitchAnimation: true,
        child: DeviceItem(device: devicesStatus.thisDevice),
      ),
      const SizedBox(height: 8),
      const Divider(height: 1),
      const SizedBox(height: 8),
      SectionTitle(title: 'devices.main_screen.other_devices'.tr()),
      if (devicesStatus is DevicesDeleting) ...[
        const Center(
          heightFactor: 4,
          child: CircularProgressIndicator.adaptive(),
        ),
      ],
      if (!devicesStatus.isLoaded)
        ...List.generate(
          3,
          (final index) => Skeletonizer(
            enabled: true,
            enableSwitchAnimation: true,
            child: DeviceItem(device: FakeSelfPrivacyData.otherDeviceToken),
          ),
        ),
      if (devicesStatus is! DevicesDeleting && devicesStatus.isLoaded)
        ...devicesStatus.otherDevices.map(
          (final device) => DeviceItem(device: device),
        ),
    ],
  );
}
