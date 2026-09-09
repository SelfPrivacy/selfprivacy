import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/modals/backups/change_rotation_quotas_modal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../../catalog_case.dart';

@UseCase(
  name: 'Finite',
  type: ChangeRotationQuotasModal,
  path: '[Organisms]/modals/backups',
)
Widget changeRotationQuotasModalFinite(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('ChangeRotationQuotasModal/Finite'),
      id: 'ChangeRotationQuotasModal/Finite',
      variant: 'Finite',
      host: PreviewHost.sheet,
      width: 560,
      height: 750,
      builder:
          (final context, final fixtures, final controller, final update) =>
              ChangeRotationQuotasModal(scrollController: controller),
    );

@UseCase(
  name: 'Unlimited',
  type: ChangeRotationQuotasModal,
  path: '[Organisms]/modals/backups',
)
Widget changeRotationQuotasModalUnlimited(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('ChangeRotationQuotasModal/Unlimited'),
      id: 'ChangeRotationQuotasModal/Unlimited',
      variant: 'Unlimited',
      host: PreviewHost.sheet,
      width: 560,
      height: 750,
      builder:
          (final context, final fixtures, final controller, final update) =>
              ChangeRotationQuotasModal(scrollController: controller),
    );
