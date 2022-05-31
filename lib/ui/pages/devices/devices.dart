import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/devices/devices_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/devices/new_device.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({Key? key}) : super(key: key);

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  @override
  Widget build(BuildContext context) {
    final devicesStatus = context.watch<ApiDevicesCubit>().state;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ApiDevicesCubit>().refresh();
      },
      child: BrandHeroScreen(
        heroTitle: 'devices.main_screen.header'.tr(),
        heroSubtitle: 'devices.main_screen.description'.tr(),
        hasBackButton: true,
        hasFlashButton: false,
        children: [
          Text(
            'devices.main_screen.this_device'.tr(),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          _DeviceTile(device: devicesStatus.thisDevice),
          const Divider(height: 1),
          const SizedBox(height: 16),
          Text(
            'devices.main_screen.other_devices'.tr(),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          ...devicesStatus.otherDevices
              .map((device) => _DeviceTile(device: device))
              .toList(),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => Navigator.of(context)
                .push(materialRoute(const NewDeviceScreen())),
            child: Text('devices.main_screen.authorize_new_device'.tr()),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(height: 16),
              Text(
                'devices.main_screen.tip'.tr(),
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _DeviceTile extends StatelessWidget {
  const _DeviceTile({Key? key, required this.device}) : super(key: key);

  final ApiToken device;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      title: Text(device.name),
      subtitle: Text('devices.main_screen.access_granted_on'
          .tr(args: [DateFormat.yMMMMd().format(device.date)])),
      onTap: device.isCaller
          ? null
          : () => _showConfirmationDialog(context, device),
    );
  }

  _showConfirmationDialog(BuildContext context, ApiToken device) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.link_off_outlined),
                const SizedBox(height: 16),
                Text(
                  'devices.revoke_device_alert.header'.tr(),
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    'devices.revoke_device_alert.description'
                        .tr(args: [device.name]),
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('devices.revoke_device_alert.no'.tr()),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('devices.revoke_device_alert.yes'.tr()),
                onPressed: () {
                  context.read<ApiDevicesCubit>().deleteDevice(device);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
}
