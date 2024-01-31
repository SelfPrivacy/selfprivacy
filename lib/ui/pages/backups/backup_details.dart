import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/components/jobs_content/server_job_card.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/backups/change_period_modal.dart';
import 'package:selfprivacy/ui/pages/backups/change_rotation_quotas_modal.dart';
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
    final BackupsState backupsState = context.watch<BackupsBloc>().state;
    final bool isBackupInitialized = backupsState.isInitialized;
    final StateType providerState = isReady && isBackupInitialized
        ? StateType.stable
        : StateType.uninitialized;
    final bool preventActions = backupsState.preventActions;
    final List<Backup> backups = backupsState.backups;
    final List<Service> services =
        context.watch<ServicesBloc>().state.servicesThatCanBeBackedUp;
    final Duration? autobackupPeriod = backupsState.autobackupPeriod;
    final List<ServerJob> backupJobs = context
        .watch<ServerJobsBloc>()
        .state
        .backupJobList
        .where((final job) => job.status != JobStatusEnum.finished)
        .toList();

    if (!isReady) {
      return BrandHeroScreen(
        heroIcon: BrandIcons.save,
        heroTitle: 'backup.card_title'.tr(),
        heroSubtitle: 'not_ready_card.in_menu'.tr(),
        children: const [],
      );
    }

    if (!isBackupInitialized) {
      return BrandHeroScreen(
        heroIcon: BrandIcons.save,
        heroTitle: 'backup.card_title'.tr(),
        heroSubtitle: 'backup.description'.tr(),
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
                  : () {
                      context
                          .read<BackupsBloc>()
                          .add(const InitializeBackupsRepository());
                    },
              text: 'backup.initialize'.tr(),
            ),
        ],
      );
    }

    final Color? overrideColor =
        preventActions ? Theme.of(context).colorScheme.secondary : null;

    return BrandHeroScreen(
      heroIcon: BrandIcons.save,
      heroTitle: 'backup.card_title'.tr(),
      heroSubtitle: 'backup.description'.tr(),
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
          leading: Icon(
            Icons.add_circle_outline_rounded,
            color: overrideColor,
          ),
          title: Text(
            'backup.create_new'.tr(),
            style: TextStyle(
              color: overrideColor,
            ),
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
          leading: Icon(
            Icons.manage_history_outlined,
            color: overrideColor,
          ),
          title: Text(
            'backup.autobackup_period_title'.tr(),
            style: TextStyle(
              color: overrideColor,
            ),
          ),
          subtitle: Text(
            style: TextStyle(
              color: overrideColor,
            ),
            autobackupPeriod != null
                ? 'backup.autobackup_period_subtitle'.tr(
                    namedArgs: {
                      'period': autobackupPeriod.toPrettyString(context.locale),
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
                      minChildSize: 0.4,
                      initialChildSize: 0.6,
                      builder: (final context, final scrollController) =>
                          ChangeRotationQuotasModal(
                        scrollController: scrollController,
                      ),
                    ),
                  );
                },
          leading: Icon(
            Icons.auto_delete_outlined,
            color: overrideColor,
          ),
          title: Text(
            'backup.rotation_quotas_title'.tr(),
            style: TextStyle(
              color: overrideColor,
            ),
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
          leading: Icon(
            Icons.key_outlined,
            color: overrideColor,
          ),
          title: Text(
            'backup.backups_encryption_key'.tr(),
            style: TextStyle(
              color: overrideColor,
            ),
          ),
          subtitle: Text(
            'backup.backups_encryption_key_subtitle'.tr(),
            style: TextStyle(
              color: overrideColor,
            ),
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
                  leading: Icon(
                    Icons.error_outline,
                    color: overrideColor,
                  ),
                  title: Text(
                    'backup.no_backups'.tr(),
                    style: TextStyle(
                      color: overrideColor,
                    ),
                  ),
                ),
              if (backups.isNotEmpty)
                Column(
                  children: backups.take(15).map(
                    (final Backup backup) {
                      final service = context
                          .read<ServicesBloc>()
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
                                    context.read<BackupsBloc>().add(
                                          ForgetSnapshot(
                                            backup.id,
                                          ),
                                        ),
                                  },
                                );
                              },
                        title: Text(
                          style: TextStyle(
                            color: overrideColor,
                          ),
                          '${MaterialLocalizations.of(context).formatShortDate(backup.time)} ${TimeOfDay.fromDateTime(backup.time).format(context)}',
                        ),
                        subtitle: Text(
                          style: TextStyle(
                            color: overrideColor,
                          ),
                          service?.displayName ?? backup.fallbackServiceName,
                        ),
                        leading: service != null
                            ? SvgPicture.string(
                                service.svgIcon,
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                  overrideColor ??
                                      Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                  BlendMode.srcIn,
                                ),
                              )
                            : Icon(
                                Icons.question_mark_outlined,
                                color: overrideColor,
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
                ),
            ],
          ),
        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),
        if (providerState != StateType.uninitialized)
          Column(
            children: [
              ListTile(
                title: Text(
                  'backup.refetch_backups'.tr(),
                  style: TextStyle(
                    color: overrideColor,
                  ),
                ),
                subtitle: Text(
                  'backup.refetch_backups_subtitle'.tr(),
                  style: TextStyle(
                    color: overrideColor,
                  ),
                ),
                leading: Icon(
                  Icons.cached_outlined,
                  color: overrideColor,
                ),
                onTap: preventActions
                    ? null
                    : () => {
                          context
                              .read<BackupsBloc>()
                              .add(const ForceSnapshotListUpdate()),
                        },
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              ListTile(
                title: Text(
                  'backup.reupload_key'.tr(),
                  style: TextStyle(
                    color: overrideColor,
                  ),
                ),
                subtitle: Text(
                  'backup.reupload_key_subtitle'.tr(),
                  style: TextStyle(
                    color: overrideColor,
                  ),
                ),
                leading: Icon(
                  Icons.warning_amber_outlined,
                  color: overrideColor,
                ),
                // onTap: preventActions
                //     ? null
                //     : () => {context.read<BackupsCubit>().reuploadKey()},
              ),
            ],
          ),
      ],
    );
  }
}
