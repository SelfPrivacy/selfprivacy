import 'package:flutter/material.dart';

/// For some reason original [SegmentedButton] does not have animations.
///
/// The [SegmentedButtons] was written for SelfPrivacy before [SegmentedButton] was introduced.
/// While it doesn't have that much options to pass, it has cute little animation.
/// It is based on [ToggleButtons].
class SegmentedButtons extends StatelessWidget {
  /// Creates a segmented buttons widget. This is a SelfPrivacy implementation.
  ///
  /// Provide the button titles in [titles] as a [List<String>].
  /// Current selection is provided in [isSelected] as a [List<bool>].
  /// This widget will call [onPressed] with the index of the button that was pressed.
  const SegmentedButtons({
    required this.isSelected,
    required this.onPressed,
    required this.titles,
    super.key,
  });

  /// The current selection state of the buttons.
  ///
  /// The length of this list must be equal to the length of [titles].
  /// Several buttons can be selected at the same time.
  final List<bool> isSelected;

  /// The callback that is called when a button is pressed.
  /// It will be called with the index of the button that was pressed.
  final Function(int)? onPressed;

  /// The titles of the buttons.
  final List<String> titles;

  @override
  Widget build(final BuildContext context) => LayoutBuilder(
    builder:
        (final context, final constraints) => ToggleButtons(
          constraints: BoxConstraints(
            minWidth: (constraints.maxWidth - 8) / titles.length,
            minHeight: 40 + Theme.of(context).visualDensity.vertical * 4,
          ),
          borderRadius: BorderRadius.circular(48),
          borderColor: Theme.of(context).colorScheme.outline,
          selectedBorderColor: Theme.of(context).colorScheme.outline,
          fillColor: Theme.of(context).colorScheme.secondaryContainer,
          selectedColor: Theme.of(context).colorScheme.onSecondaryContainer,
          color: Theme.of(context).colorScheme.onSurface,
          isSelected: isSelected,
          onPressed: onPressed,
          children: [
            for (int i = 0; i < titles.length; i++)
              _ButtonSegment(
                key: ValueKey(i),
                isSelected: isSelected[i],
                title: titles[i],
              ),
          ],
        ),
  );
}

class _ButtonSegment extends StatelessWidget {
  const _ButtonSegment({
    required this.isSelected,
    required this.title,
    super.key,
  });

  final bool isSelected;
  final String title;

  @override
  Widget build(final BuildContext context) => Stack(
    alignment: Alignment.centerLeft,
    children: [
      AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isSelected ? 1 : 0,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutCubicEmphasized,
          alignment: Alignment.centerLeft,
          scale: isSelected ? 1 : 0,
          child: Icon(
            Icons.check,
            size: 18,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
      ),
      AnimatedPadding(
        padding: isSelected ? const EdgeInsets.only(left: 24) : EdgeInsets.zero,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOutCubicEmphasized,
        child: Text(title, style: Theme.of(context).textTheme.labelLarge),
      ),
    ],
  );
}
