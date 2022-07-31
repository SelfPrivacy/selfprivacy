import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_linear_indicator/brand_linear_indicator.dart';
import 'package:selfprivacy/ui/pages/server_storage/disk_status.dart';

class ServerStoragePage extends StatefulWidget {
  const ServerStoragePage({required this.diskStatus, final super.key});

  final DiskStatus diskStatus;

  @override
  State<ServerStoragePage> createState() => _ServerStoragePageState();
}

class _ServerStoragePageState extends State<ServerStoragePage> {
  @override
  Widget build(final BuildContext context) {
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;

    if (!isReady) {
      return BrandHeroScreen(
        hasBackButton: true,
        heroTitle: 'providers.storage.card_title'.tr(),
        children: const [],
      );
    }

    final List<Widget> sections = [];
    for (final DiskVolume volume in widget.diskStatus.diskVolumes) {
      sections.add(
        const SizedBox(height: 16),
      );
      sections.add(
        Text(
          'providers.storage.disk_usage'.tr(
            args: [
              volume.gbUsed.toString(),
            ],
          ),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
      sections.add(
        const SizedBox(height: 4),
      );
      sections.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.storage_outlined,
              size: 24,
              color: Colors.white,
            ),
            Expanded(
              child: BrandLinearIndicator(
                value: volume.percentage,
                color: volume.root
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                height: 14.0,
              ),
            ),
          ],
        ),
      );
      sections.add(
        const SizedBox(height: 4),
      );
      sections.add(
        Text(
          'providers.storage.disk_total'.tr(
            args: [
              volume.gbTotal.toString(),
              volume.name,
            ],
          ),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }

    return BrandHeroScreen(
      hasBackButton: true,
      heroTitle: 'providers.storage.card_title'.tr(),
      children: [
        ...sections,
        const SizedBox(height: 8),
      ],
    );
  }
}
