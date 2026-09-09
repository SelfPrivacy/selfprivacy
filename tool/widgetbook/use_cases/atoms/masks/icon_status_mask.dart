import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/atoms/masks/icon_status_mask.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'uninitialized', type: IconStatusMask, path: '[Atoms]/masks')
Widget iconStatusMaskUninitialized(final BuildContext context) => CatalogCase(
  key: const ValueKey('IconStatusMask/uninitialized'),
  id: 'IconStatusMask/uninitialized',
  variant: 'uninitialized',
  host: PreviewHost.content,
  width: 560,
  height: 120,
  builder: (final context, final fixtures, final controller, final update) =>
      const IconStatusMask(
        icon: Icon(Icons.dns, color: Colors.white, size: 48),
        status: StateType.uninitialized,
      ),
);

@UseCase(name: 'stable', type: IconStatusMask, path: '[Atoms]/masks')
Widget iconStatusMaskStable(final BuildContext context) => CatalogCase(
  key: const ValueKey('IconStatusMask/stable'),
  id: 'IconStatusMask/stable',
  variant: 'stable',
  host: PreviewHost.content,
  width: 560,
  height: 120,
  builder: (final context, final fixtures, final controller, final update) =>
      const IconStatusMask(
        icon: Icon(Icons.dns, color: Colors.white, size: 48),
        status: StateType.stable,
      ),
);

@UseCase(name: 'warning', type: IconStatusMask, path: '[Atoms]/masks')
Widget iconStatusMaskWarning(final BuildContext context) => CatalogCase(
  key: const ValueKey('IconStatusMask/warning'),
  id: 'IconStatusMask/warning',
  variant: 'warning',
  host: PreviewHost.content,
  width: 560,
  height: 120,
  builder: (final context, final fixtures, final controller, final update) =>
      const IconStatusMask(
        icon: Icon(Icons.dns, color: Colors.white, size: 48),
        status: StateType.warning,
      ),
);

@UseCase(name: 'error', type: IconStatusMask, path: '[Atoms]/masks')
Widget iconStatusMaskError(final BuildContext context) => CatalogCase(
  key: const ValueKey('IconStatusMask/error'),
  id: 'IconStatusMask/error',
  variant: 'error',
  host: PreviewHost.content,
  width: 560,
  height: 120,
  builder: (final context, final fixtures, final controller, final update) =>
      const IconStatusMask(
        icon: Icon(Icons.dns, color: Colors.white, size: 48),
        status: StateType.error,
      ),
);
