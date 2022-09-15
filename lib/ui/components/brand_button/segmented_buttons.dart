import 'package:flutter/material.dart';

class SegmentedButtons extends StatelessWidget {
  const SegmentedButtons({
    required this.isSelected,
    required this.onPressed,
    required this.titles,
    final super.key,
  });

  final List<bool> isSelected;
  final Function(int)? onPressed;
  final List<String> titles;

  @override
  Widget build(final BuildContext context) => LayoutBuilder(
        builder: (final context, final constraints) => ToggleButtons(
          constraints: BoxConstraints(
            minWidth: (constraints.maxWidth - 8) / 3,
            minHeight: 40,
          ),
          borderRadius: BorderRadius.circular(48),
          borderColor: Theme.of(context).colorScheme.outline,
          selectedBorderColor: Theme.of(context).colorScheme.outline,
          fillColor: Theme.of(context).colorScheme.secondaryContainer,
          selectedColor: Theme.of(context).colorScheme.onSecondaryContainer,
          color: Theme.of(context).colorScheme.onSurface,
          isSelected: isSelected,
          onPressed: onPressed,
          children: titles.asMap().entries.map((final entry) {
            final index = entry.key;
            final title = entry.value;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isSelected[index])
                  Icon(
                    Icons.check,
                    size: 18,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                if (isSelected[index]) const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            );
          }).toList(),
        ),
      );
}
