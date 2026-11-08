import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/not_applied_label.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';

@UseCase(name: 'Default', type: NotAppliedLabel, path: '[Atoms]')
Widget notAppliedLabel(final BuildContext context) => CatalogCase(
  id: 'NotAppliedLabel/Default',
  variant: 'Default',
  width: 360,
  builder: (final context, final fixtures, final controller, final update) =>
      const NotAppliedLabel(),
);
