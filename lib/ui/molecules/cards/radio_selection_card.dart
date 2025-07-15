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
  final void Function() onTap;

  @override
  Widget build(final BuildContext context) => OutlinedCard(
    borderColor: isSelected ? Theme.of(context).colorScheme.primary : null,
    borderWidth: isSelected ? 3 : 1,
    child: InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (isSelected)
              Icon(
                Icons.radio_button_on_outlined,
                color: Theme.of(context).colorScheme.primary,
              )
            else
              Icon(
                Icons.radio_button_off_outlined,
                color: Theme.of(context).colorScheme.outline,
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
