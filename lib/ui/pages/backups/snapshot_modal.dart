import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/backups/backups_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_jobs/server_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/services/services_cubit.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/components/cards/outlined_card.dart';
import 'package:selfprivacy/ui/components/info_box/info_box.dart';
import 'package:selfprivacy/ui/pages/backups/snapshot_id_list_tile.dart';

class SnapshotModal extends StatefulWidget {
  const SnapshotModal({
    required this.snapshot,
    required this.scrollController,
    super.key,
  });

  final Backup snapshot;
  final ScrollController scrollController;

  @override
  State<SnapshotModal> createState() => _SnapshotModalState();
}

class _SnapshotModalState extends State<SnapshotModal> {
  BackupRestoreStrategy selectedStrategy =
      BackupRestoreStrategy.downloadVerifyOverwrite;

  @override
  Widget build(final BuildContext context) {
    final List<String> busyServices = context
        .watch<ServerJobsCubit>()
        .state
        .backupJobList
        .where(
          (final ServerJob job) =>
              job.status == JobStatusEnum.running ||
              job.status == JobStatusEnum.created,
        )
        .map((final ServerJob job) => job.typeId.split('.')[1])
        .toList();

    final bool isServiceBusy = busyServices.contains(widget.snapshot.serviceId);

    final Service? service = context
        .read<ServicesCubit>()
        .state
        .getServiceById(widget.snapshot.serviceId);

    return ListView(
      controller: widget.scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 16),
        Text(
          'backup.snapshot_modal_heading'.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ListTile(
          leading: service != null
              ? SvgPicture.string(
                  service.svgIcon,
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                )
              : const Icon(
                  Icons.question_mark_outlined,
                ),
          title: Text(
            'backup.snapshot_service_title'.tr(),
          ),
          subtitle: Text(
            service?.displayName ?? widget.snapshot.fallbackServiceName,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.access_time_outlined,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            'backup.snapshot_creation_time_title'.tr(),
          ),
          subtitle: Text(
            '${MaterialLocalizations.of(context).formatShortDate(widget.snapshot.time)} ${TimeOfDay.fromDateTime(widget.snapshot.time).format(context)}',
          ),
        ),
        SnapshotIdListTile(snapshotId: widget.snapshot.id),
        if (service != null)
          Column(
            children: [
              const SizedBox(height: 8),
              Text(
                'backup.snapshot_modal_select_strategy'.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              _BackupStrategySelectionCard(
                isSelected: selectedStrategy ==
                    BackupRestoreStrategy.downloadVerifyOverwrite,
                onTap: () {
                  setState(() {
                    selectedStrategy =
                        BackupRestoreStrategy.downloadVerifyOverwrite;
                  });
                },
                title:
                    'backup.snapshot_modal_download_verify_option_title'.tr(),
                subtitle:
                    'backup.snapshot_modal_download_verify_option_description'
                        .tr(),
              ),
              const SizedBox(height: 8),
              _BackupStrategySelectionCard(
                isSelected: selectedStrategy == BackupRestoreStrategy.inplace,
                onTap: () {
                  setState(() {
                    selectedStrategy = BackupRestoreStrategy.inplace;
                  });
                },
                title: 'backup.snapshot_modal_inplace_option_title'.tr(),
                subtitle:
                    'backup.snapshot_modal_inplace_option_description'.tr(),
              ),
              const SizedBox(height: 8),
              // Restore backup button
              BrandButton.filled(
                onPressed: isServiceBusy
                    ? null
                    : () {
                        context.read<BackupsCubit>().restoreBackup(
                              widget.snapshot.id,
                              selectedStrategy,
                            );
                        Navigator.of(context).pop();
                        getIt<NavigationService>()
                            .showSnackBar('backup.restore_started'.tr());
                      },
                text: 'backup.restore'.tr(),
              ),
            ],
          )
        else
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InfoBox(
              isWarning: true,
              text: 'backup.snapshot_modal_service_not_found'.tr(),
            ),
          )
      ],
    );
  }
}

class _BackupStrategySelectionCard extends StatelessWidget {
  const _BackupStrategySelectionCard({
    required this.isSelected,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final bool isSelected;
  final String title;
  final String subtitle;
  final void Function() onTap;

  @override
  Widget build(final BuildContext context) => OutlinedCard(
        borderColor: isSelected ? Theme.of(context).colorScheme.primary : null,
        borderWidth: isSelected ? 3 : 1,
        child: InkResponse(
          highlightShape: BoxShape.rectangle,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (isSelected)
                  Icon(
                    Icons.radio_button_on_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  )
                else
                  Icon(
                    Icons.radio_button_off_outlined,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
