import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/devices/devices_bloc.dart';
import 'package:selfprivacy/logic/connection/lifecycle/token_rotation.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/section_title.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';
import 'package:selfprivacy/ui/molecules/list_items/device_item.dart';
import 'package:selfprivacy/ui/router/router.dart';

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
          if (devicesStatus.hasError) ...[
            InfoBox(text: 'devices.main_screen.load_error'.tr()),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed:
                    devicesStatus.isRefreshing ||
                        devicesStatus.pendingDeviceName != null
                    ? null
                    : () => context.read<DevicesBloc>().refresh(),
                child: Text('devices.main_screen.retry'.tr()),
              ),
            ),
          ],
          if (devicesStatus.isLoaded) ...[
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
  Widget build(final BuildContext context) {
    final bloc = context.read<DevicesBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'devices.main_screen.this_device'.tr()),
        if (devicesStatus.thisDevice case final device?)
          StreamBuilder<RotationStatus>(
            stream: context.read<DevicesBloc>().rotationChanges,
            builder: (final context, final snapshot) => DeviceItem(
              device: device,
              rotationStatus: snapshot.data ?? RotationStatus.idle,
              onCancelRotation: context.read<DevicesBloc>().cancelRotation,
            ),
          ),
        const SizedBox(height: 8),
        const Divider(height: 1),
        const SizedBox(height: 8),
        SectionTitle(title: 'devices.main_screen.other_devices'.tr()),
        if (devicesStatus.otherDevices.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('devices.main_screen.no_other_devices'.tr()),
          ),
        ...devicesStatus.otherDevices.map(
          (final device) => DeviceItem(
            key: ValueKey(device.name),
            device: device,
            pending: devicesStatus.pendingDeviceName == device.name,
            enabled: devicesStatus.pendingDeviceName == null,
            onRevoke: () {
              if (!bloc.isClosed) {
                bloc.add(DeleteDevice(device, origin: devicesStatus.origin));
              }
            },
          ),
        ),
      ],
    );
  }
}
