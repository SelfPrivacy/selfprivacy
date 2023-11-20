import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/not_ready_card/not_ready_card.dart';

class EmptyPagePlaceholder extends StatelessWidget {
  const EmptyPagePlaceholder({
    required this.title,
    required this.iconData,
    required this.description,
    this.showReadyCard = false,
    super.key,
  });

  final String title;
  final String description;
  final IconData iconData;
  final bool showReadyCard;

  @override
  Widget build(final BuildContext context) => !showReadyCard
      ? _expandedContent(context)
      : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: NotReadyCard(),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Center(
                  child: _expandedContent(context),
                ),
              ),
            ),
          ],
        );

  Widget _expandedContent(final BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 50,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
}
