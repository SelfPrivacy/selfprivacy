import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/modals/qr_modal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Default', type: QrModal, path: '[Organisms]/modals')
Widget qrModalDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('QrModal/Default'),
  id: 'QrModal/Default',
  variant: 'Default',
  host: PreviewHost.sheet,
  width: 560,
  height: 700,
  builder: (final context, final fixtures, final controller, final update) =>
      QrModal(
        title: 'Connect a device',
        qrData: 'https://example.org/catalog-only',
        scrollController: controller,
      ),
);
