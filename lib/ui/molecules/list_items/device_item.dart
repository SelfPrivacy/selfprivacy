import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/devices/devices_bloc.dart';
import 'package:selfprivacy/logic/bloc/tokens/tokens_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';

class DeviceItem extends StatelessWidget {
  const DeviceItem({required this.device, super.key});

  final ApiToken device;

  @override
  Widget build(final BuildContext context) => ListTile(
    title: Text(device.name),
    subtitle: Text(
      'devices.main_screen.access_granted_on'.tr(
        args: [DateFormat.yMMMMd().format(device.date)],
      ),
    ),
    onTap:
        device.isCaller
            ? () => _showTokenRefreshDialog(context, device)
            : () => _showConfirmationDialog(context, device),
  );

  Future _showConfirmationDialog(
    final BuildContext context,
    final ApiToken device,
  ) => showDialog(
    context: context,
    builder:
        (final context) => AlertDialog(
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
                'devices.revoke_device_alert.description'.tr(
                  args: [device.name],
                ),
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
              child: Text(
                'devices.revoke_device_alert.yes'.tr(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
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
  ) => showDialog(
    context: context,
    builder:
        (final context) => AlertDialog(
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
                'devices.refresh_token_alert.description'.tr(
                  args: [device.name],
                ),
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
                context.read<TokensBloc>().add(
                  const RefreshServerApiTokenEvent(),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
  );
}
