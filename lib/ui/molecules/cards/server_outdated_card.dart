import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';

class ServerOutdatedCard extends StatelessWidget {
  const ServerOutdatedCard({
    required this.requiredVersion,
    required this.currentVersion,
    super.key,
  });

  final String requiredVersion;
  final String currentVersion;

  @override
  Widget build(final BuildContext context) => FilledCard(
    error: true,
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(
        'basis.server_is_outdated'.tr(
          namedArgs: {
            'versionConstraint': requiredVersion,
            'currentVersion': currentVersion,
          },
        ),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.onErrorContainer,
        ),
      ),
      trailing: Icon(
        Icons.error_outline,
        size: 24,
        color: Theme.of(context).colorScheme.onTertiaryContainer,
      ),
    ),
  );
}
