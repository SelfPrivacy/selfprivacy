import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';

class MoreMenuItem extends StatelessWidget {
  const MoreMenuItem({
    required this.iconData,
    required this.title,
    required this.goTo,
    this.subtitle,
    this.longGoTo,
    this.accent = false,
    super.key,
  });

  final IconData iconData;
  final String title;
  final PageRouteInfo Function() goTo;
  final PageRouteInfo? longGoTo;
  final String? subtitle;
  final bool accent;

  @override
  Widget build(final BuildContext context) {
    final Color color =
        accent
            ? Theme.of(context).colorScheme.onTertiaryContainer
            : Theme.of(context).colorScheme.onSurface;
    return FilledCard(
      tertiary: accent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: () => context.pushRoute(goTo()),
        onLongPress:
            longGoTo != null ? () => context.pushRoute(longGoTo!) : null,
        leading: Icon(iconData, size: 24, color: color),
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: color),
        ),
        subtitle:
            subtitle != null
                ? Text(
                  subtitle!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: color),
                )
                : null,
      ),
    );
  }
}
