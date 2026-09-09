import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/cards/radio_selection_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Selected', type: RadioSelectionCard, path: '[Molecules]/cards')
Widget radioSelectionCardSelected(final BuildContext context) {
  bool selected = true;
  return CatalogCase(
    key: const ValueKey('RadioSelectionCard/Selected'),
    id: 'RadioSelectionCard/Selected',
    variant: 'Selected',
    host: PreviewHost.content,
    width: 360,
    height: 240,
    builder: (final context, final fixtures, final controller, final update) =>
        RadioSelectionCard(
          isSelected: selected,
          title: textKnob(context, 'Download, verify, and restore'),
          subtitle: 'Verify the snapshot before replacing existing files.',
          onTap: () => update(() => selected = !selected),
        ),
  );
}

@UseCase(
  name: 'Unselected',
  type: RadioSelectionCard,
  path: '[Molecules]/cards',
)
Widget radioSelectionCardUnselected(final BuildContext context) {
  bool selected = false;
  return CatalogCase(
    key: const ValueKey('RadioSelectionCard/Unselected'),
    id: 'RadioSelectionCard/Unselected',
    variant: 'Unselected',
    host: PreviewHost.content,
    width: 360,
    height: 240,
    builder: (final context, final fixtures, final controller, final update) =>
        RadioSelectionCard(
          isSelected: selected,
          title: textKnob(context, 'Download, verify, and restore'),
          subtitle: 'Verify the snapshot before replacing existing files.',
          onTap: () => update(() => selected = !selected),
        ),
  );
}

@UseCase(name: 'Long text', type: RadioSelectionCard, path: '[Molecules]/cards')
Widget radioSelectionCardLongText(final BuildContext context) {
  bool selected = false;
  return CatalogCase(
    key: const ValueKey('RadioSelectionCard/Long text'),
    id: 'RadioSelectionCard/Long text',
    variant: 'Long text',
    host: PreviewHost.content,
    width: 360,
    height: 240,
    builder: (final context, final fixtures, final controller, final update) =>
        RadioSelectionCard(
          isSelected: selected,
          title: textKnob(context, 'Download, verify, and restore'),
          subtitle: 'Verify the snapshot before replacing existing files.',
          onTap: () => update(() => selected = !selected),
        ),
  );
}
