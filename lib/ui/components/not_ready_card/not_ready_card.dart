import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_cards/filled_card.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/initializing.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:easy_localization/easy_localization.dart';

class NotReadyCard extends StatelessWidget {
  const NotReadyCard({super.key});

  @override
  Widget build(final BuildContext context) => FilledCard(
        tertiary: true,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          onTap: () => Navigator.of(context).push(
            materialRoute(
              const InitializingPage(),
            ),
          ),
          title: Text(
            'not_ready_card.in_menu'.tr(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 16,
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
      );
}
