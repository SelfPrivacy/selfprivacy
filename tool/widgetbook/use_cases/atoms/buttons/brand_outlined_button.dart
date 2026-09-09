import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/buttons/outlined_button.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Enabled', type: BrandOutlinedButton, path: '[Atoms]/buttons')
Widget brandOutlinedButtonEnabled(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandOutlinedButton/Enabled'),
  id: 'BrandOutlinedButton/Enabled',
  variant: 'Enabled',
  host: PreviewHost.content,
  width: 560,
  height: 140,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandOutlinedButton(
        onPressed: () => catalogActions.record('Pressed'),
        title: textKnob(context, 'Cancel'),
        child: null,
      ),
);

@UseCase(name: 'Disabled', type: BrandOutlinedButton, path: '[Atoms]/buttons')
Widget brandOutlinedButtonDisabled(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandOutlinedButton/Disabled'),
  id: 'BrandOutlinedButton/Disabled',
  variant: 'Disabled',
  host: PreviewHost.content,
  width: 560,
  height: 140,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandOutlinedButton(
        onPressed: null,
        title: textKnob(context, 'Cancel'),
        child: null,
      ),
);

@UseCase(name: 'With icon', type: BrandOutlinedButton, path: '[Atoms]/buttons')
Widget brandOutlinedButtonWithIcon(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandOutlinedButton/With icon'),
  id: 'BrandOutlinedButton/With icon',
  variant: 'With icon',
  host: PreviewHost.content,
  width: 560,
  height: 140,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandOutlinedButton(
        onPressed: () => catalogActions.record('Pressed'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add),
            const SizedBox(width: 8),
            Text(textKnob(context, 'Add')),
          ],
        ),
      ),
);
