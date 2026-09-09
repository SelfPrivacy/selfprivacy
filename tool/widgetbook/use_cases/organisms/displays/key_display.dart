import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/displays/key_display.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'Selectable', type: KeyDisplay, path: '[Organisms]/displays')
Widget keyDisplaySelectable(final BuildContext context) => CatalogCase(
  key: const ValueKey('KeyDisplay/Selectable'),
  id: 'KeyDisplay/Selectable',
  variant: 'Selectable',
  host: PreviewHost.content,
  width: 560,
  height: 450,
  builder: (final context, final fixtures, final controller, final update) =>
      KeyDisplay(
        keyToDisplay: demoMnemonic,
        canCopy: true,
        infoboxText: 'Keep this recovery key in a safe place.',
      ),
);

@UseCase(name: 'Read only', type: KeyDisplay, path: '[Organisms]/displays')
Widget keyDisplayReadOnly(final BuildContext context) => CatalogCase(
  key: const ValueKey('KeyDisplay/Read only'),
  id: 'KeyDisplay/Read only',
  variant: 'Read only',
  host: PreviewHost.content,
  width: 560,
  height: 450,
  builder: (final context, final fixtures, final controller, final update) =>
      KeyDisplay(
        keyToDisplay: demoMnemonic,
        canCopy: false,
        infoboxText: 'Keep this recovery key in a safe place.',
      ),
);
