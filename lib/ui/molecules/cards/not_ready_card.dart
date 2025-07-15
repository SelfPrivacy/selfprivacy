import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:selfprivacy/ui/router/router.dart';

class NotReadyCard extends StatelessWidget {
  const NotReadyCard({super.key});

  @override
  Widget build(final BuildContext context) => FilledCard(
    tertiary: true,
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: () => context.pushRoute(const InitializingRoute()),
      title: Text(
        'not_ready_card.in_menu'.tr(),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.onTertiaryContainer,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        size: 24,
        color: Theme.of(context).colorScheme.onTertiaryContainer,
      ),
    ),
  );
}
