import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/cubit/providers/providers_cubit.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:selfprivacy/ui/pages/server_storage/disk_status.dart';
import 'package:selfprivacy/ui/pages/server_storage/server_storage.dart';
import 'package:selfprivacy/ui/pages/server_storage/server_storage_list_item.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class StorageCard extends StatelessWidget {
  const StorageCard({
    required final this.diskStatus,
    final super.key,
  });

  final DiskStatus diskStatus;

  @override
  Widget build(final BuildContext context) {
    final List<Widget> sections = [];
    for (final DiskVolume volume in diskStatus.diskVolumes) {
      sections.add(
        const SizedBox(height: 16),
      );
      sections.add(
        ServerStorageListItem(
          volume: volume,
          dense: true,
          showIcon: false,
        ),
      );
    }

    StateType state = context.watch<ServerInstallationCubit>().state
            is ServerInstallationFinished
        ? StateType.stable
        : StateType.uninitialized;

    if (state == StateType.stable && !diskStatus.isDiskOkay) {
      state = StateType.error;
    }

    return Card(
      child: InkResponse(
        highlightShape: BoxShape.rectangle,
      onTap: () => Navigator.of(context).push(
        materialRoute(
          ServerStoragePage(
            diskStatus: diskStatus,
          ),
        ),
      ),

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'providers.storage.card_title'.tr(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (state != StateType.uninitialized)
                        Text(
                          diskStatus.isDiskOkay
                              ? 'providers.storage.status_ok'.tr()
                              : 'providers.storage.status_error'.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                    ],
                  ),
                  if (state != StateType.uninitialized)
                    IconStatusMask(
                      status: state,
                      child: Icon(
                        diskStatus.isDiskOkay
                            ? Icons.check_circle_outline
                            : Icons.error_outline,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
              ...sections,
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
