import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/cards/outlined_card.dart';

class RadioSelectionCard extends StatelessWidget {
  const RadioSelectionCard({
    required this.isSelected,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final bool isSelected;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final disabled = onTap == null;
    // surfaceContainerHighest changes the disabled background in dark mode.
    // ignore: deprecated_member_use
    final backgroundColor = disabled ? colors.surfaceVariant : null;
    final textColor = disabled ? colors.onSurfaceVariant : null;
    return Semantics(
      enabled: !disabled,
      selected: isSelected,
      child: OutlinedCard(
        backgroundColor: backgroundColor,
        borderColor: disabled
            ? colors.outlineVariant
            : isSelected
            ? colors.primary
            : null,
        borderWidth: isSelected ? 3 : 1,
        child: InkResponse(
          highlightShape: BoxShape.rectangle,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_on_outlined
                      : Icons.radio_button_off_outlined,
                  color: isSelected && !disabled
                      ? colors.primary
                      : colors.outline,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: textColor,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
