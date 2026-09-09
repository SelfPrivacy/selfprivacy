import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Information', type: InfoBox, path: '[Molecules]/info_box')
Widget infoBoxInformation(final BuildContext context) => CatalogCase(
  key: const ValueKey('InfoBox/Information'),
  id: 'InfoBox/Information',
  variant: 'Information',
  host: PreviewHost.content,
  width: 560,
  height: 200,
  builder: (final context, final fixtures, final controller, final update) =>
      InfoBox(
        text: textKnob(context, 'Your backups are encrypted.'),
        isWarning: false,
      ),
);

@UseCase(name: 'Warning', type: InfoBox, path: '[Molecules]/info_box')
Widget infoBoxWarning(final BuildContext context) => CatalogCase(
  key: const ValueKey('InfoBox/Warning'),
  id: 'InfoBox/Warning',
  variant: 'Warning',
  host: PreviewHost.content,
  width: 560,
  height: 200,
  builder: (final context, final fixtures, final controller, final update) =>
      InfoBox(
        text: textKnob(context, 'Your backups are encrypted.'),
        isWarning: true,
      ),
);

@UseCase(name: 'Long text', type: InfoBox, path: '[Molecules]/info_box')
Widget infoBoxLongText(final BuildContext context) => CatalogCase(
  key: const ValueKey('InfoBox/Long text'),
  id: 'InfoBox/Long text',
  variant: 'Long text',
  host: PreviewHost.content,
  width: 560,
  height: 200,
  builder: (final context, final fixtures, final controller, final update) =>
      InfoBox(
        text: textKnob(
          context,
          'Keep a copy of the encryption key in a safe place. You will need it to restore your files on another server.',
        ),
        isWarning: false,
      ),
);
