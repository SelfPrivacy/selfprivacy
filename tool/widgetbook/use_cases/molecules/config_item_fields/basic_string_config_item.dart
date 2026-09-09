import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/config_item_fields/basic_string_config_item.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

import '../../../preparation.dart';

@UseCase(
  name: 'Default',
  type: BasicStringConfigItem,
  path: '[Molecules]/config_item_fields',
)
Widget basicStringConfigItemDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('BasicStringConfigItem/Default'),
  id: 'BasicStringConfigItem/Default',
  variant: 'Default',
  host: PreviewHost.content,
  width: 560,
  height: 200,
  builder: (final context, final fixtures, final controller, final update) =>
      BasicStringConfigItem(
        configItem: const StringServiceConfigItem(
          id: 'name',
          description: 'Name',
          widget: 'text',
          type: 'string',
          value: 'cloud',
          defaultValue: 'cloud',
          regex: r'^[a-z]+$',
        ),
        newValue: null,
        onChanged: (final value, final valid) =>
            catalogActions.record('Input: $value; valid: $valid'),
      ),
);

@UseCase(
  name: 'Modified',
  type: BasicStringConfigItem,
  path: '[Molecules]/config_item_fields',
)
Widget basicStringConfigItemModified(final BuildContext context) => CatalogCase(
  key: const ValueKey('BasicStringConfigItem/Modified'),
  id: 'BasicStringConfigItem/Modified',
  variant: 'Modified',
  host: PreviewHost.content,
  width: 560,
  height: 200,
  builder: (final context, final fixtures, final controller, final update) =>
      BasicStringConfigItem(
        configItem: const StringServiceConfigItem(
          id: 'name',
          description: 'Name',
          widget: 'text',
          type: 'string',
          value: 'cloud',
          defaultValue: 'cloud',
          regex: r'^[a-z]+$',
        ),
        newValue: 'files',
        onChanged: (final value, final valid) =>
            catalogActions.record('Input: $value; valid: $valid'),
      ),
);

@UseCase(
  name: 'Invalid input',
  type: BasicStringConfigItem,
  path: '[Molecules]/config_item_fields',
)
Widget basicStringConfigItemInvalidInput(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('BasicStringConfigItem/Invalid input'),
      id: 'BasicStringConfigItem/Invalid input',
      variant: 'Invalid input',
      prepare: PreviewAction.invalidInput,
      host: PreviewHost.content,
      width: 560,
      height: 200,
      builder:
          (final context, final fixtures, final controller, final update) =>
              BasicStringConfigItem(
                configItem: const StringServiceConfigItem(
                  id: 'name',
                  description: 'Name',
                  widget: 'text',
                  type: 'string',
                  value: 'cloud',
                  defaultValue: 'cloud',
                  regex: r'^[a-z]+$',
                ),
                newValue: null,
                onChanged: (final value, final valid) =>
                    catalogActions.record('Input: $value; valid: $valid'),
              ),
    );
