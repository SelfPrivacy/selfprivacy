import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/config_item_fields/basic_bool_config_item.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(
  name: 'Off',
  type: BasicBoolConfigItem,
  path: '[Molecules]/config_item_fields',
)
Widget basicBoolConfigItemOff(final BuildContext context) {
  bool? value;
  return CatalogCase(
    key: const ValueKey('BasicBoolConfigItem/Off'),
    id: 'BasicBoolConfigItem/Off',
    variant: 'Off',
    host: PreviewHost.content,
    width: 560,
    height: 200,
    builder: (final context, final fixtures, final controller, final update) =>
        BasicBoolConfigItem(
          configItem: const BoolServiceConfigItem(
            id: 'registration',
            description: 'Allow registration',
            widget: 'switch',
            type: 'bool',
            value: false,
            defaultValue: false,
          ),
          newValue: value,
          onChanged: (final next) => update(() => value = next),
        ),
  );
}

@UseCase(
  name: 'On',
  type: BasicBoolConfigItem,
  path: '[Molecules]/config_item_fields',
)
Widget basicBoolConfigItemOn(final BuildContext context) {
  bool? value;
  return CatalogCase(
    key: const ValueKey('BasicBoolConfigItem/On'),
    id: 'BasicBoolConfigItem/On',
    variant: 'On',
    host: PreviewHost.content,
    width: 560,
    height: 200,
    builder: (final context, final fixtures, final controller, final update) =>
        BasicBoolConfigItem(
          configItem: const BoolServiceConfigItem(
            id: 'registration',
            description: 'Allow registration',
            widget: 'switch',
            type: 'bool',
            value: true,
            defaultValue: false,
          ),
          newValue: value,
          onChanged: (final next) => update(() => value = next),
        ),
  );
}

@UseCase(
  name: 'Modified',
  type: BasicBoolConfigItem,
  path: '[Molecules]/config_item_fields',
)
Widget basicBoolConfigItemModified(final BuildContext context) {
  bool? value = true;
  return CatalogCase(
    key: const ValueKey('BasicBoolConfigItem/Modified'),
    id: 'BasicBoolConfigItem/Modified',
    variant: 'Modified',
    host: PreviewHost.content,
    width: 560,
    height: 200,
    builder: (final context, final fixtures, final controller, final update) =>
        BasicBoolConfigItem(
          configItem: const BoolServiceConfigItem(
            id: 'registration',
            description: 'Allow registration',
            widget: 'switch',
            type: 'bool',
            value: false,
            defaultValue: false,
          ),
          newValue: value,
          onChanged: (final next) => update(() => value = next),
        ),
  );
}
