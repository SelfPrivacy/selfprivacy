import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_linear_indicator/brand_linear_indicator.dart';
import 'package:selfprivacy/ui/pages/server_storage/disk_status.dart';
import 'package:selfprivacy/ui/pages/server_storage/extending_volume.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class ServerStoragePage extends StatefulWidget {
  const ServerStoragePage({required this.diskStatus, final super.key});

  final DiskStatus diskStatus;

  @override
  State<ServerStoragePage> createState() => _ServerStoragePageState();
}

class _ServerStoragePageState extends State<ServerStoragePage> {
  List<bool> _expandedSections = [];

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

    /// The first section is expanded, the rest are hidden by default.
    /// ( true, false, false, etc... )
    _expandedSections = [
      true,
      ...List<bool>.filled(
        widget.diskStatus.diskVolumes.length - 1,
        false,
      ),
    ];

    int sectionId = 0;
    final List<Widget> sections = [];
    for (final DiskVolume volume in widget.diskStatus.diskVolumes) {
      sections.add(
        const SizedBox(height: 16),
      );
      sections.add(
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.storage_outlined,
                size: 24,
                color: Colors.white,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'providers.storage.disk_usage'.tr(
                        args: [
                          volume.gbUsed.toString(),
                        ],
                      ),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Expanded(
                      child: BrandLinearIndicator(
                        value: volume.percentage,
                        color: volume.root
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                        backgroundColor:
                            Theme.of(context).colorScheme.surfaceVariant,
                        height: 14.0,
                      ),
                    ),
                    Text(
                      'providers.storage.disk_total'.tr(
                        args: [
                          volume.gbTotal.toString(),
                          volume.name,
                        ],
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      sections.add(
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState: _expandedSections[sectionId]
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: FilledButton(
            title: 'providers.extend_volume_button.title'.tr(),
            onPressed: () => Navigator.of(context).push(
              materialRoute(
                ExtendingVolumePage(
                  diskVolume: volume,
                ),
              ),
            ),
          ),
          secondChild: Container(),
        ),
      );

      ++sectionId;
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
