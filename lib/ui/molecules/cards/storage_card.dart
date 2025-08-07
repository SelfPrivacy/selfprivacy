import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/atoms/masks/icon_status_mask.dart';
import 'package:selfprivacy/ui/organisms/storage_list_items/server_storage_list_item.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/fake_data.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StorageCard extends StatelessWidget {
  const StorageCard({required this.diskStatus, super.key});

  final DiskStatus diskStatus;

  @override
  Widget build(final BuildContext context) {
    final List<Widget> sections = [];
    for (final DiskVolume volume in diskStatus.diskVolumes) {
      sections
        ..add(const SizedBox(height: 16))
        ..add(
          ServerStorageListItem(volume: volume, dense: true, showIcon: false),
        );
    }

    final List<Widget> fakeSections = [
      const SizedBox(height: 16),
      ServerStorageListItem(
        volume: FakeSelfPrivacyData.fakeDiskVolume,
        dense: true,
        showIcon: false,
      ),
      const SizedBox(height: 16),
      ServerStorageListItem(
        volume: FakeSelfPrivacyData.fakeDiskVolume,
        dense: true,
        showIcon: false,
      ),
    ];

    StateType state =
        context.watch<ServerInstallationCubit>().state
                is ServerInstallationFinished
            ? StateType.stable
            : StateType.uninitialized;

    if (state == StateType.stable && !diskStatus.isDiskOkay) {
      state = StateType.error;
    }

    return Skeletonizer(
      enabled: diskStatus.diskVolumes.isEmpty,
      enableSwitchAnimation: true,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkResponse(
          highlightShape: BoxShape.rectangle,
          onTap:
              () =>
                  diskStatus.diskVolumes.isEmpty
                      ? null
                      : context.pushRoute(const ServerStorageRoute()),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Skeleton.shade(
                            child: Text(
                              'storage.card_title'.tr(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
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
                    ),
                    if (state != StateType.uninitialized)
                      Skeleton.ignore(
                        child: IconStatusMask(
                          status: state,
                          icon: Icon(
                            diskStatus.isDiskOkay
                                ? Icons.check_circle_outline
                                : Icons.error_outline,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                ...sections,
                if (diskStatus.diskVolumes.isEmpty) ...fakeSections,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
