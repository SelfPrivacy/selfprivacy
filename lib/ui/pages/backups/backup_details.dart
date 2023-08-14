import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/backups/backups_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_jobs/server_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/services/services_cubit.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/components/jobs_content/server_job_card.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';
import 'package:selfprivacy/ui/pages/backups/change_period_modal.dart';
import 'package:selfprivacy/ui/pages/backups/copy_encryption_key_modal.dart';
import 'package:selfprivacy/ui/pages/backups/create_backups_modal.dart';
import 'package:selfprivacy/ui/pages/backups/snapshot_modal.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/extensions/duration.dart';

@RoutePage()
class BackupDetailsPage extends StatelessWidget {
  const BackupDetailsPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;
    final BackupsState backupsState = context.watch<BackupsCubit>().state;
    final bool isBackupInitialized = backupsState.isInitialized;
    final StateType providerState = isReady && isBackupInitialized
        ? StateType.stable
        : StateType.uninitialized;
    final bool preventActions = backupsState.preventActions;
    final List<Backup> backups = backupsState.backups;
    final bool refreshing = backupsState.refreshing;
    final List<Service> services =
        context.watch<ServicesCubit>().state.servicesThatCanBeBackedUp;
    final Duration? autobackupPeriod = backupsState.autobackupPeriod;
    final List<ServerJob> backupJobs = context
        .watch<ServerJobsCubit>()
        .state
        .backupJobList
        .where((final job) => job.status != JobStatusEnum.finished)
        .toList();

    if (!isReady) {
      return BrandHeroScreen(
        heroIcon: BrandIcons.save,
        heroTitle: 'backup.card_title'.tr(),
        heroSubtitle: 'not_ready_card.in_menu'.tr(),
        hasFlashButton: true,
        children: const [],
      );
    }

    if (!isBackupInitialized) {
      return BrandHeroScreen(
        heroIcon: BrandIcons.save,
        heroTitle: 'backup.card_title'.tr(),
        heroSubtitle: 'backup.description'.tr(),
        hasFlashButton: true,
        children: [
          if (preventActions)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            ),
          if (!preventActions)
            BrandButton.rised(
              onPressed: preventActions
                  ? null
                  : () async {
                      await context.read<BackupsCubit>().initializeBackups();
                    },
              text: 'backup.initialize'.tr(),
            ),
        ],
      );
    }

    return BrandHeroScreen(
      heroIcon: BrandIcons.save,
      heroTitle: 'backup.card_title'.tr(),
      heroSubtitle: 'backup.description'.tr(),
      hasFlashButton: true,
      children: [
        ListTile(
          onTap: preventActions
              ? null
              : () {
                  showModalBottomSheet(
                    useRootNavigator: true,
                    context: context,
                    isScrollControlled: true,
                    builder: (final BuildContext context) =>
                        DraggableScrollableSheet(
                      expand: false,
                      maxChildSize: 0.9,
                      minChildSize: 0.4,
                      initialChildSize: 0.6,
                      builder: (final context, final scrollController) =>
                          CreateBackupsModal(
                        services: services,
                        scrollController: scrollController,
                      ),
                    ),
                  );
                },
          leading: const Icon(
            Icons.add_circle_outline_rounded,
          ),
          title: Text(
            'backup.create_new'.tr(),
          ),
        ),
        ListTile(
          onTap: preventActions
              ? null
              : () {
                  showModalBottomSheet(
                    useRootNavigator: true,
                    context: context,
                    isScrollControlled: true,
                    builder: (final BuildContext context) =>
                        DraggableScrollableSheet(
                      expand: false,
                      maxChildSize: 0.9,
                      minChildSize: 0.4,
                      initialChildSize: 0.6,
                      builder: (final context, final scrollController) =>
                          ChangeAutobackupsPeriodModal(
                        scrollController: scrollController,
                      ),
                    ),
                  );
                },
          leading: const Icon(
            Icons.manage_history_outlined,
          ),
          title: Text(
            'backup.autobackup_period_title'.tr(),
          ),
          subtitle: Text(
            autobackupPeriod != null
                ? 'backup.autobackup_period_subtitle'.tr(
                    namedArgs: {
                      'period': autobackupPeriod.toPrettyString(context.locale)
                    },
                  )
                : 'backup.autobackup_period_never'.tr(),
          ),
        ),
        ListTile(
          onTap: preventActions
              ? null
              : () {
                  showModalBottomSheet(
                    useRootNavigator: true,
                    context: context,
                    isScrollControlled: true,
                    builder: (final BuildContext context) =>
                        DraggableScrollableSheet(
                      expand: false,
                      maxChildSize: 0.9,
                      minChildSize: 0.5,
                      initialChildSize: 0.7,
                      builder: (final context, final scrollController) =>
                          CopyEncryptionKeyModal(
                        scrollController: scrollController,
                      ),
                    ),
                  );
                },
          leading: const Icon(
            Icons.key_outlined,
          ),
          title: Text(
            'backup.backups_encryption_key'.tr(),
          ),
          subtitle: Text(
            'backup.backups_encryption_key_subtitle'.tr(),
          ),
        ),
        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),
        if (backupJobs.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'backup.pending_jobs'.tr(),
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ),
              for (final job in backupJobs)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ServerJobCard(
                    serverJob: job,
                  ),
                ),
            ],
          ),
        if (isBackupInitialized)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'backup.latest_snapshots'.tr(),
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                subtitle: Text(
                  'backup.latest_snapshots_subtitle'.tr(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              if (backups.isEmpty)
                ListTile(
                  leading: const Icon(
                    Icons.error_outline,
                  ),
                  title: Text('backup.no_backups'.tr()),
                ),
              if (backups.isNotEmpty)
                Column(
                  children: backups.take(15).map(
                    (final Backup backup) {
                      final service = context
                          .read<ServicesCubit>()
                          .state
                          .getServiceById(backup.serviceId);
                      return ListTile(
                        onTap: preventActions
                            ? null
                            : () {
                                showModalBottomSheet(
                                  useRootNavigator: true,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (final BuildContext context) =>
                                      DraggableScrollableSheet(
                                    expand: false,
                                    maxChildSize: 0.9,
                                    minChildSize: 0.5,
                                    initialChildSize: 0.7,
                                    builder: (
                                      final context,
                                      final scrollController,
                                    ) =>
                                        SnapshotModal(
                                      snapshot: backup,
                                      scrollController: scrollController,
                                    ),
                                  ),
                                );
                              },
                        onLongPress: preventActions
                            ? null
                            : () {
                                showPopUpAlert(
                                  alertTitle: 'backup.forget_snapshot'.tr(),
                                  description:
                                      'backup.forget_snapshot_alert'.tr(),
                                  actionButtonTitle:
                                      'backup.forget_snapshot'.tr(),
                                  actionButtonOnPressed: () => {
                                    context.read<BackupsCubit>().forgetSnapshot(
                                          backup.id,
                                        )
                                  },
                                );
                              },
                        title: Text(
                          '${MaterialLocalizations.of(context).formatShortDate(backup.time)} ${TimeOfDay.fromDateTime(backup.time).format(context)}',
                        ),
                        subtitle: Text(
                          service?.displayName ?? backup.fallbackServiceName,
                        ),
                        leading: service != null
                            ? SvgPicture.string(
                                service.svgIcon,
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.onBackground,
                                  BlendMode.srcIn,
                                ),
                              )
                            : const Icon(
                                Icons.question_mark_outlined,
                              ),
                      );
                    },
                  ).toList(),
                ),
              if (backups.isNotEmpty && backups.length > 15)
                ListTile(
                  title: Text(
                    'backup.show_more'.tr(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  leading: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  onTap: () =>
                      context.pushRoute(BackupsListRoute(service: null)),
                )
            ],
          ),
        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),
        ListTile(
          title: Text(
            'backup.refresh'.tr(),
          ),
          onTap: refreshing
              ? null
              : () => {context.read<BackupsCubit>().updateBackups()},
          enabled: !refreshing,
          leading: const Icon(
            Icons.refresh_outlined,
          ),
        ),
        if (providerState != StateType.uninitialized)
          Column(
            children: [
              ListTile(
                title: Text(
                  'backup.refetch_backups'.tr(),
                ),
                subtitle: Text(
                  'backup.refetch_backups_subtitle'.tr(),
                ),
                leading: const Icon(
                  Icons.cached_outlined,
                ),
                onTap: preventActions
                    ? null
                    : () => {context.read<BackupsCubit>().forceUpdateBackups()},
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              ListTile(
                title: Text(
                  'backup.reupload_key'.tr(),
                ),
                subtitle: Text(
                  'backup.reupload_key_subtitle'.tr(),
                ),
                leading: const Icon(
                  Icons.warning_amber_outlined,
                ),
                onTap: preventActions
                    ? null
                    : () => {context.read<BackupsCubit>().reuploadKey()},
              ),
            ],
          ),
      ],
    );
  }
}
