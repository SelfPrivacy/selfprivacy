import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/ui/molecules/list_items/device_item.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

import '../../../preparation.dart';

@UseCase(
  name: 'Current device',
  type: DeviceItem,
  path: '[Molecules]/list_items',
)
Widget deviceItemCurrentDevice(final BuildContext context) => CatalogCase(
  key: const ValueKey('DeviceItem/Current device'),
  id: 'DeviceItem/Current device',
  variant: 'Current device',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      DeviceItem(
        device: ApiToken(
          name: 'This Linux computer',
          isCaller: true,
          date: referenceTime,
        ),
      ),
);

@UseCase(name: 'Other device', type: DeviceItem, path: '[Molecules]/list_items')
Widget deviceItemOtherDevice(final BuildContext context) => CatalogCase(
  key: const ValueKey('DeviceItem/Other device'),
  id: 'DeviceItem/Other device',
  variant: 'Other device',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      DeviceItem(
        device: ApiToken(name: 'Phone', isCaller: false, date: referenceTime),
      ),
);

@UseCase(
  name: 'Refresh dialog',
  type: DeviceItem,
  path: '[Molecules]/list_items',
)
Widget deviceItemRefreshDialog(final BuildContext context) => CatalogCase(
  key: const ValueKey('DeviceItem/Refresh dialog'),
  id: 'DeviceItem/Refresh dialog',
  variant: 'Refresh dialog',
  prepare: PreviewAction.deviceDialog,
  host: PreviewHost.content,
  width: 560,
  height: 600,
  builder: (final context, final fixtures, final controller, final update) =>
      DeviceItem(
        device: ApiToken(
          name: 'This Linux computer',
          isCaller: true,
          date: referenceTime,
        ),
      ),
);

@UseCase(
  name: 'Revoke dialog',
  type: DeviceItem,
  path: '[Molecules]/list_items',
)
Widget deviceItemRevokeDialog(final BuildContext context) => CatalogCase(
  key: const ValueKey('DeviceItem/Revoke dialog'),
  id: 'DeviceItem/Revoke dialog',
  variant: 'Revoke dialog',
  prepare: PreviewAction.deviceDialog,
  host: PreviewHost.content,
  width: 560,
  height: 600,
  builder: (final context, final fixtures, final controller, final update) =>
      DeviceItem(
        device: ApiToken(name: 'Phone', isCaller: false, date: referenceTime),
      ),
);
