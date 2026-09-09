import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/storage_list_items/service_migration_list_item.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(
  name: 'Default',
  type: ServiceConsumptionTitle,
  path: '[Organisms]/storage_list_items',
)
Widget serviceConsumptionTitleDefault(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('ServiceConsumptionTitle/Default'),
      id: 'ServiceConsumptionTitle/Default',
      variant: 'Default',
      host: PreviewHost.content,
      width: 560,
      height: 110,
      builder:
          (final context, final fixtures, final controller, final update) =>
              ServiceConsumptionTitle(service: demoService()),
    );
