import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/buttons/segmented_buttons.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(
  name: 'First selected',
  type: SegmentedButtons,
  path: '[Atoms]/buttons',
)
Widget segmentedButtonsFirstSelected(final BuildContext context) {
  final selection = [true, false, false];
  return CatalogCase(
    key: const ValueKey('SegmentedButtons/First selected'),
    id: 'SegmentedButtons/First selected',
    variant: 'First selected',
    host: PreviewHost.content,
    width: 560,
    height: 140,
    builder: (final context, final fixtures, final controller, final update) =>
        SegmentedButtons(
          isSelected: selection,
          titles: const ['Month', 'Day', 'Hour'],
          onPressed: (final index) => update(() {
            selection[index] = !selection[index];
          }),
        ),
  );
}

@UseCase(name: 'Last selected', type: SegmentedButtons, path: '[Atoms]/buttons')
Widget segmentedButtonsLastSelected(final BuildContext context) {
  final selection = [false, false, true];
  return CatalogCase(
    key: const ValueKey('SegmentedButtons/Last selected'),
    id: 'SegmentedButtons/Last selected',
    variant: 'Last selected',
    host: PreviewHost.content,
    width: 560,
    height: 140,
    builder: (final context, final fixtures, final controller, final update) =>
        SegmentedButtons(
          isSelected: selection,
          titles: const ['Month', 'Day', 'Hour'],
          onPressed: (final index) => update(() {
            selection[index] = !selection[index];
          }),
        ),
  );
}

@UseCase(
  name: 'Multiple selected',
  type: SegmentedButtons,
  path: '[Atoms]/buttons',
)
Widget segmentedButtonsMultipleSelected(final BuildContext context) {
  final selection = [true, true, false];
  return CatalogCase(
    key: const ValueKey('SegmentedButtons/Multiple selected'),
    id: 'SegmentedButtons/Multiple selected',
    variant: 'Multiple selected',
    host: PreviewHost.content,
    width: 560,
    height: 140,
    builder: (final context, final fixtures, final controller, final update) =>
        SegmentedButtons(
          isSelected: selection,
          titles: const ['Month', 'Day', 'Hour'],
          onPressed: (final index) => update(() {
            selection[index] = !selection[index];
          }),
        ),
  );
}

@UseCase(name: 'Disabled', type: SegmentedButtons, path: '[Atoms]/buttons')
Widget segmentedButtonsDisabled(final BuildContext context) {
  final selection = [true, false, false];
  return CatalogCase(
    key: const ValueKey('SegmentedButtons/Disabled'),
    id: 'SegmentedButtons/Disabled',
    variant: 'Disabled',
    host: PreviewHost.content,
    width: 560,
    height: 140,
    builder: (final context, final fixtures, final controller, final update) =>
        SegmentedButtons(
          isSelected: selection,
          titles: const ['Month', 'Day', 'Hour'],
          onPressed: null,
        ),
  );
}
