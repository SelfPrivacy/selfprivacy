import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/devices/devices_bloc.dart';
import 'package:selfprivacy/logic/bloc/tokens/tokens_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/ui/components/info_box/info_box.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/devices/new_device.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

@RoutePage()
class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
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
            _DevicesInfo(
              devicesStatus: devicesStatus,
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => Navigator.of(context)
                  .push(materialRoute(const NewDeviceScreen())),
              child: Text('devices.main_screen.authorize_new_device'.tr()),
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            InfoBox(
              text: 'devices.main_screen.tip'.tr(),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _DevicesInfo extends StatelessWidget {
  const _DevicesInfo({
    required this.devicesStatus,
  });

  final DevicesState devicesStatus;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'devices.main_screen.this_device'.tr(),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          _DeviceTile(
            device: devicesStatus.thisDevice,
          ),
          const Divider(height: 1),
          const SizedBox(height: 16),
          Text(
            'devices.main_screen.other_devices'.tr(),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          if (devicesStatus is DevicesDeleting) ...[
            const Center(
              heightFactor: 4,
              child: CircularProgressIndicator.adaptive(),
            ),
          ],
          if (devicesStatus is! DevicesDeleting)
            ...devicesStatus.otherDevices.map(
              (final device) => _DeviceTile(
                device: device,
              ),
            ),
        ],
      );
}

class _DeviceTile extends StatelessWidget {
  const _DeviceTile({required this.device});

  final ApiToken device;

  @override
  Widget build(final BuildContext context) => ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(device.name),
        subtitle: Text(
          'devices.main_screen.access_granted_on'
              .tr(args: [DateFormat.yMMMMd().format(device.date)]),
        ),
        onTap: device.isCaller
            ? () => _showTokenRefreshDialog(context, device)
            : () => _showConfirmationDialog(context, device),
      );

  Future _showConfirmationDialog(
    final BuildContext context,
    final ApiToken device,
  ) =>
      showDialog(
        context: context,
        builder: (final context) => AlertDialog(
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
                style: Theme.of(context).textTheme.bodyMedium,
              ),
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
                context.read<DevicesBloc>().add(DeleteDevice(device));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

  Future _showTokenRefreshDialog(
    final BuildContext context,
    final ApiToken device,
  ) =>
      showDialog(
        context: context,
        builder: (final context) => AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.update_outlined),
              const SizedBox(height: 16),
              Text(
                'devices.refresh_token_alert.header'.tr(),
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
                'devices.refresh_token_alert.description'
                    .tr(args: [device.name]),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('devices.refresh_token_alert.no'.tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('devices.refresh_token_alert.yes'.tr()),
              onPressed: () {
                context
                    .read<TokensBloc>()
                    .add(const RefreshServerApiTokenEvent());
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
}
