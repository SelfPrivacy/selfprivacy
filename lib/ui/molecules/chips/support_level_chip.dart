import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/service.dart';

class SupportLevelChip extends StatelessWidget {
  const SupportLevelChip({
    required this.supportLevel,
    this.dense = false,
    super.key,
  });

  final SupportLevel supportLevel;
  final bool dense;

  @override
  Widget build(final BuildContext context) {
    final baseTextTheme =
        dense
            ? Theme.of(context).textTheme.labelSmall
            : Theme.of(context).textTheme.labelLarge;
    switch (supportLevel) {
      case SupportLevel.normal:
        return ActionChip(
          avatar: const Icon(Icons.check_circle_outline_outlined),
          label: Text(
            'service_page.support_levels.normal'.tr(),
            style: baseTextTheme,
          ),
          onPressed: () async {
            await showDialog(
              context: context,
              builder:
                  (final BuildContext context) => _SupportLevelDialog(
                    icon: Icons.check_circle_outline_outlined,
                    title: 'service_page.support_levels.normal'.tr(),
                    description:
                        'service_page.support_levels.normal_description'.tr(),
                  ),
            );
          },
          visualDensity: dense ? VisualDensity.compact : null,
          padding: dense ? const EdgeInsets.all(4) : null,
        );
      case SupportLevel.experimental:
        return ActionChip(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          avatar: Icon(
            Icons.science_outlined,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          label: Text(
            'service_page.support_levels.experimental'.tr(),
            style: baseTextTheme?.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          onPressed: () async {
            await showDialog(
              context: context,
              builder:
                  (final BuildContext context) => _SupportLevelDialog(
                    icon: Icons.science_outlined,
                    title: 'service_page.support_levels.experimental'.tr(),
                    description:
                        'service_page.support_levels.experimental_description'
                            .tr(),
                  ),
            );
          },
          visualDensity: dense ? VisualDensity.compact : null,
          padding: dense ? const EdgeInsets.all(4) : null,
        );
      case SupportLevel.deprecated:
        return ActionChip(
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          avatar: Icon(
            Icons.wb_twilight_outlined,
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
          label: Text(
            'service_page.support_levels.deprecated'.tr(),
            style: baseTextTheme?.copyWith(
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
          onPressed: () async {
            await showDialog(
              context: context,
              builder:
                  (final BuildContext context) => _SupportLevelDialog(
                    icon: Icons.wb_twilight_outlined,
                    title: 'service_page.support_levels.deprecated'.tr(),
                    description:
                        'service_page.support_levels.deprecated_description'
                            .tr(),
                  ),
            );
          },
          visualDensity: dense ? VisualDensity.compact : null,
          padding: dense ? const EdgeInsets.all(4) : null,
        );
      case SupportLevel.community:
        return ActionChip(
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          avatar: Icon(
            Icons.people_alt_outlined,
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
          label: Text(
            'service_page.support_levels.community'.tr(),
            style: baseTextTheme?.copyWith(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          ),
          onPressed: () async {
            await showDialog(
              context: context,
              builder:
                  (final BuildContext context) => _SupportLevelDialog(
                    icon: Icons.people_alt_outlined,
                    title: 'service_page.support_levels.community'.tr(),
                    description:
                        'service_page.support_levels.community_description'
                            .tr(),
                  ),
            );
          },
          visualDensity: dense ? VisualDensity.compact : null,
          padding: dense ? const EdgeInsets.all(4) : null,
        );
      case SupportLevel.unknown:
        return ActionChip(
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          avatar: Icon(
            Icons.question_mark_outlined,
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
          label: Text(
            'service_page.support_levels.unknown'.tr(),
            style: baseTextTheme?.copyWith(
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
          onPressed: () async {
            await showDialog(
              context: context,
              builder:
                  (final BuildContext context) => _SupportLevelDialog(
                    icon: Icons.question_mark_outlined,
                    title: 'service_page.support_levels.unknown'.tr(),
                    description:
                        'service_page.support_levels.unknown_description'.tr(),
                  ),
            );
          },
          visualDensity: dense ? VisualDensity.compact : null,
          padding: dense ? const EdgeInsets.all(4) : null,
        );
    }
  }
}

class SystemServiceChip extends StatelessWidget {
  const SystemServiceChip({this.dense = false, super.key});

  final bool dense;

  @override
  Widget build(final BuildContext context) {
    final baseTextTheme =
        dense
            ? Theme.of(context).textTheme.labelSmall
            : Theme.of(context).textTheme.labelLarge;

    return ActionChip(
      avatar: const Icon(Icons.miscellaneous_services_outlined),
      label: Text(
        'service_page.support_levels.system'.tr(),
        style: baseTextTheme,
      ),
      onPressed: () async {
        await showDialog(
          context: context,
          builder:
              (final BuildContext context) => _SupportLevelDialog(
                icon: Icons.miscellaneous_services_outlined,
                title: 'service_page.support_levels.system'.tr(),
                description:
                    'service_page.support_levels.system_description'.tr(),
              ),
        );
      },
      visualDensity: dense ? VisualDensity.compact : null,
      padding: dense ? const EdgeInsets.all(4) : null,
    );
  }
}

class _SupportLevelDialog extends StatelessWidget {
  const _SupportLevelDialog({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(final BuildContext context) => AlertDialog(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(height: 16),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      ],
    ),
    content: SingleChildScrollView(
      child: ListBody(
        children: [
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('basis.close'.tr()),
      ),
    ],
  );
}
