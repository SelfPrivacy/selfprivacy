import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/cubit/providers/providers_cubit.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/ui/components/storage_list_items/server_storage_list_item.dart';
import 'package:selfprivacy/ui/router/router.dart';

class StorageCard extends StatelessWidget {
  const StorageCard({
    required this.diskStatus,
    super.key,
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
      clipBehavior: Clip.antiAlias,
      child: InkResponse(
        highlightShape: BoxShape.rectangle,

        /// TODO: when 'isEmpty' replace with a skeleton
        onTap: () => diskStatus.diskVolumes.isEmpty
            ? null
            : context.pushRoute(ServerStorageRoute(diskStatus: diskStatus)),
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
                        'storage.card_title'.tr(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (state != StateType.uninitialized)
                        Text(
                          diskStatus.isDiskOkay
                              ? 'storage.status_ok'.tr()
                              : 'storage.status_error'.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                    ],
                  ),
                  if (state != StateType.uninitialized)
                    IconStatusMask(
                      status: state,
                      icon: Icon(
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
