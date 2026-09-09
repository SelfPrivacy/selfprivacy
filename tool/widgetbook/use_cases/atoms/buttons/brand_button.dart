import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Filled', type: BrandButton, path: '[Atoms]/buttons')
Widget brandButtonFilled(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandButton/Filled'),
  id: 'BrandButton/Filled',
  variant: 'Filled',
  host: PreviewHost.content,
  width: 560,
  height: 140,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandButton.filled(
        onPressed: () => catalogActions.record('Pressed'),
        title: textKnob(context, 'Continue'),
      ),
);

@UseCase(name: 'Disabled', type: BrandButton, path: '[Atoms]/buttons')
Widget brandButtonDisabled(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandButton/Disabled'),
  id: 'BrandButton/Disabled',
  variant: 'Disabled',
  host: PreviewHost.content,
  width: 560,
  height: 140,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandButton.filled(onPressed: null, title: textKnob(context, 'Continue')),
);

@UseCase(name: 'With icon', type: BrandButton, path: '[Atoms]/buttons')
Widget brandButtonWithIcon(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandButton/With icon'),
  id: 'BrandButton/With icon',
  variant: 'With icon',
  host: PreviewHost.content,
  width: 560,
  height: 140,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandButton.filled(
        onPressed: () => catalogActions.record('Pressed'),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.add), Text('Add service')],
        ),
      ),
);

@UseCase(name: 'Long label', type: BrandButton, path: '[Atoms]/buttons')
Widget brandButtonLongLabel(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandButton/Long label'),
  id: 'BrandButton/Long label',
  variant: 'Long label',
  host: PreviewHost.content,
  width: 560,
  height: 140,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandButton.filled(
        onPressed: () => catalogActions.record('Pressed'),
        title: textKnob(
          context,
          'Continue with the selected server and DNS providers',
        ),
      ),
);

@UseCase(name: 'Text', type: BrandButton, path: '[Atoms]/buttons')
Widget brandButtonText(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandButton/Text'),
  id: 'BrandButton/Text',
  variant: 'Text',
  host: PreviewHost.content,
  width: 560,
  height: 140,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandButton.text(
        onPressed: () => catalogActions.record('Pressed'),
        title: textKnob(context, 'Continue'),
      ),
);
