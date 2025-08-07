import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/backup_snapshot_tiles/snapshot_creation_reason_tile.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/backup_snapshot_tiles/snapshot_creation_time_tile.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/backup_snapshot_tiles/snapshot_id_tile.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/backup_snapshot_tiles/snapshot_service_tile.dart';
import 'package:selfprivacy/ui/molecules/cards/radio_selection_card.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';

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
    final List<String> busyServices =
        context.watch<ServerJobsBloc>().state.busyServices;

    final bool isServiceBusy = busyServices.contains(widget.snapshot.serviceId);

    final Service? service = context.read<ServicesBloc>().state.getServiceById(
      widget.snapshot.serviceId,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
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
          SnapshotServiceTile(
            service: service,
            fallbackServiceName: widget.snapshot.fallbackServiceName,
          ),
          SnapshotCreationTimeTile(time: widget.snapshot.time),
          SnapshotIdTile(snapshotId: widget.snapshot.id),
          SnapshotCreationReasonTile(
            reason: widget.snapshot.reason.displayName.tr(),
          ),
          if (service != null)
            Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  'backup.snapshot_modal_select_strategy'.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                RadioSelectionCard(
                  isSelected:
                      selectedStrategy ==
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
                RadioSelectionCard(
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
                const SizedBox(height: 16),
                // Restore backup button
                BrandButton.filled(
                  onPressed:
                      isServiceBusy
                          ? null
                          : () {
                            context.read<BackupsBloc>().add(
                              RestoreBackup(
                                widget.snapshot.id,
                                selectedStrategy,
                              ),
                            );
                            Navigator.of(context).pop();
                            getIt<NavigationService>().showSnackBar(
                              'backup.restore_started'.tr(),
                            );
                          },
                  title: 'backup.restore'.tr(),
                ),
              ],
            )
          else
            Padding(
              padding: const EdgeInsets.all(16),
              child: InfoBox(
                isWarning: true,
                text: 'backup.snapshot_modal_service_not_found'.tr(),
              ),
            ),
        ],
      ),
    );
  }
}
