import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/connection/lifecycle/token_rotation.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';

class DeviceItem extends StatelessWidget {
  const DeviceItem({
    required this.device,
    this.pending = false,
    this.enabled = true,
    this.onRevoke,
    this.onRotate,
    this.rotationStatus = RotationStatus.idle,
    this.onCancelRotation,
    super.key,
  });

  final ApiToken device;
  final bool pending;
  final bool enabled;
  final VoidCallback? onRevoke;
  final VoidCallback? onRotate;
  final RotationStatus rotationStatus;
  final VoidCallback? onCancelRotation;

  @override
  Widget build(final BuildContext context) => ListTile(
    enabled: enabled && !pending,
    trailing: rotationStatus == RotationStatus.waiting
        ? TextButton(
            onPressed: onCancelRotation,
            child: Text('basis.cancel'.tr()),
          )
        : pending || rotationStatus == RotationStatus.rotating
        ? SizedBox.square(
            dimension: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              semanticsLabel: rotationStatus == RotationStatus.rotating
                  ? 'devices.rotation.running'.tr()
                  : 'devices.main_screen.revoking'.tr(args: [device.name]),
            ),
          )
        : null,
    title: Text(device.name),
    subtitle: Text(switch (rotationStatus) {
      RotationStatus.waiting => 'devices.rotation.waiting'.tr(),
      RotationStatus.rotating => 'devices.rotation.running'.tr(),
      RotationStatus.suppressed => 'devices.rotation.suppressed'.tr(),
      RotationStatus.idle => 'devices.main_screen.access_granted_on'.tr(
        args: [DateFormat.yMMMMd().format(device.date)],
      ),
    }),
    onTap: !enabled || pending || rotationStatus != RotationStatus.idle
        ? null
        : device.isCaller
        ? () => _showTokenRefreshDialog(context, device)
        : onRevoke == null
        ? null
        : () => _showConfirmationDialog(context, device),
  );

  Future _showConfirmationDialog(
    final BuildContext context,
    final ApiToken device,
  ) => showDialog(
    useRootNavigator: false,
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
            'devices.revoke_device_alert.description'.tr(args: [device.name]),
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
            onRevoke?.call();
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
    useRootNavigator: false,
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
            'devices.refresh_token_alert.description'.tr(args: [device.name]),
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
            onRotate?.call();
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
