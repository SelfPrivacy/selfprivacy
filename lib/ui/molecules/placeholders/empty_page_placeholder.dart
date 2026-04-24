import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/ui/molecules/cards/not_ready_card.dart';

class EmptyPagePlaceholder extends StatelessWidget {
  const EmptyPagePlaceholder({
    required this.title,
    required this.iconData,
    this.description,
    this.showReadyCard = false,
    super.key,
  });

  final bool showReadyCard;
  final IconData iconData;
  final String title;
  final String? description;

  @override
  Widget build(final BuildContext context) =>
      showReadyCard
          ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showReadyCard)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: NotReadyCard(),
                ),
              Expanded(
                child: _ContentWidget(
                  iconData: iconData,
                  title: title,
                  description: description,
                ),
              ),
            ],
          )
          : _ContentWidget(
            iconData: iconData,
            title: title,
            description: description,
          );
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    required this.iconData,
    required this.title,
    required this.description,
  });

  final IconData iconData;
  final String title;
  final String? description;

  @override
  Widget build(final BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 48,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        const Gap(16),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        if (description != null) const Gap(8),
        if (description != null)
          Text(
            description!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
      ],
    ),
  );
}
