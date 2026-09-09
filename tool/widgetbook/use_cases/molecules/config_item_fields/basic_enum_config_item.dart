import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/config_item_fields/basic_enum_config_item.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(
  name: 'Default',
  type: BasicEnumConfigItem,
  path: '[Molecules]/config_item_fields',
)
Widget basicEnumConfigItemDefault(final BuildContext context) {
  String? value;
  return CatalogCase(
    key: const ValueKey('BasicEnumConfigItem/Default'),
    id: 'BasicEnumConfigItem/Default',
    variant: 'Default',
    host: PreviewHost.content,
    width: 560,
    height: 200,
    builder: (final context, final fixtures, final controller, final update) =>
        BasicEnumConfigItem(
          configItem: const EnumServiceConfigItem(
            id: 'mode',
            description: 'Visibility',
            widget: 'select',
            type: 'enum',
            value: 'private',
            defaultValue: 'private',
            options: ['private', 'public'],
          ),
          newValue: value,
          onChanged: (final next) => update(() => value = next),
        ),
  );
}

@UseCase(
  name: 'Modified',
  type: BasicEnumConfigItem,
  path: '[Molecules]/config_item_fields',
)
Widget basicEnumConfigItemModified(final BuildContext context) {
  String? value = 'public';
  return CatalogCase(
    key: const ValueKey('BasicEnumConfigItem/Modified'),
    id: 'BasicEnumConfigItem/Modified',
    variant: 'Modified',
    host: PreviewHost.content,
    width: 560,
    height: 200,
    builder: (final context, final fixtures, final controller, final update) =>
        BasicEnumConfigItem(
          configItem: const EnumServiceConfigItem(
            id: 'mode',
            description: 'Visibility',
            widget: 'select',
            type: 'enum',
            value: 'private',
            defaultValue: 'private',
            options: ['private', 'public'],
          ),
          newValue: value,
          onChanged: (final next) => update(() => value = next),
        ),
  );
}

@UseCase(
  name: 'Invalid stored value',
  type: BasicEnumConfigItem,
  path: '[Molecules]/config_item_fields',
)
Widget basicEnumConfigItemInvalidStoredValue(final BuildContext context) {
  String? value;
  return CatalogCase(
    key: const ValueKey('BasicEnumConfigItem/Invalid stored value'),
    id: 'BasicEnumConfigItem/Invalid stored value',
    variant: 'Invalid stored value',
    host: PreviewHost.content,
    width: 560,
    height: 200,
    builder: (final context, final fixtures, final controller, final update) =>
        BasicEnumConfigItem(
          configItem: const EnumServiceConfigItem(
            id: 'mode',
            description: 'Visibility',
            widget: 'select',
            type: 'enum',
            value: 'removed',
            defaultValue: 'private',
            options: ['private', 'public'],
          ),
          newValue: value,
          onChanged: (final next) => update(() => value = next),
        ),
  );
}
