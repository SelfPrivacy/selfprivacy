import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/config_item_fields/domain_string_config_item.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

import '../../../preparation.dart';

@UseCase(
  name: 'Default',
  type: DomainStringConfigItem,
  path: '[Molecules]/config_item_fields',
)
Widget domainStringConfigItemDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('DomainStringConfigItem/Default'),
  id: 'DomainStringConfigItem/Default',
  variant: 'Default',
  host: PreviewHost.content,
  width: 560,
  height: 200,
  builder: (final context, final fixtures, final controller, final update) =>
      DomainStringConfigItem(
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
  type: DomainStringConfigItem,
  path: '[Molecules]/config_item_fields',
)
Widget domainStringConfigItemModified(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('DomainStringConfigItem/Modified'),
      id: 'DomainStringConfigItem/Modified',
      variant: 'Modified',
      host: PreviewHost.content,
      width: 560,
      height: 200,
      builder:
          (final context, final fixtures, final controller, final update) =>
              DomainStringConfigItem(
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
  type: DomainStringConfigItem,
  path: '[Molecules]/config_item_fields',
)
Widget domainStringConfigItemInvalidInput(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('DomainStringConfigItem/Invalid input'),
      id: 'DomainStringConfigItem/Invalid input',
      variant: 'Invalid input',
      prepare: PreviewAction.invalidInput,
      host: PreviewHost.content,
      width: 560,
      height: 200,
      builder:
          (final context, final fixtures, final controller, final update) =>
              DomainStringConfigItem(
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
