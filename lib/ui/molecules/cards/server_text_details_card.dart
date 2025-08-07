import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/list_tile_on_surface_variant.dart';
import 'package:selfprivacy/utils/fake_data.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ServerTextDetailsCard extends StatelessWidget {
  const ServerTextDetailsCard({super.key});

  @override
  Widget build(final BuildContext context) {
    final details = context.watch<ServerDetailsCubit>().state;

    final isLoading = details is! Loaded;

    if (details is ServerDetailsNotReady) {
      return _TempMessage(message: 'basis.no_data'.tr());
    } else {
      return Skeletonizer(
        enabled: isLoading || details.metadata.isEmpty,
        containersColor: Theme.of(context).colorScheme.surfaceContainerLow,
        enableSwitchAnimation: true,
        child: FilledCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Skeleton.keep(
                  child: Text(
                    'server.general_information'.tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              if (!isLoading)
                ...details.metadata.map(
                  (final metadata) => _ServerTextDetailTile(metadata: metadata),
                ),
              if (isLoading || details.metadata.isEmpty)
                ...List.generate(
                  8,
                  (final index) => FakeSelfPrivacyData.fakeServerMetadataEntity,
                ).map(
                  (final metadata) => _ServerTextDetailTile(metadata: metadata),
                ),
            ],
          ),
        ),
      );
    }
  }
}

class _ServerTextDetailTile extends StatelessWidget {
  const _ServerTextDetailTile({required this.metadata});

  final ServerMetadataEntity metadata;

  @override
  Widget build(final BuildContext context) => ListTileOnSurfaceVariant(
    leadingIcon: metadata.type.icon,
    title: metadata.trId.tr(),
    subtitle: metadata.value,
  );
}

class _TempMessage extends StatelessWidget {
  const _TempMessage({required this.message});

  final String message;
  @override
  Widget build(final BuildContext context) => SizedBox(
    height: 200,
    child: Center(
      child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
    ),
  );
}
