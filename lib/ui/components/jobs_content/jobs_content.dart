import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/components/jobs_content/server_job_card.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';

class JobsContent extends StatelessWidget {
  const JobsContent({
    required this.controller,
    super.key,
  });

  final ScrollController controller;

  IconData _getIcon(final JobStatusEnum status) {
    switch (status) {
      case JobStatusEnum.created:
        return Icons.query_builder_outlined;
      case JobStatusEnum.running:
        return Icons.pending_outlined;
      case JobStatusEnum.finished:
        return Icons.check_circle_outline;
      case JobStatusEnum.error:
        return Icons.error_outline;
    }
  }

  Color _getColor(final JobStatusEnum status, final BuildContext context) {
    switch (status) {
      case JobStatusEnum.created:
        return Theme.of(context).colorScheme.secondary;
      case JobStatusEnum.running:
        return Theme.of(context).colorScheme.tertiary;
      case JobStatusEnum.finished:
        return Theme.of(context).colorScheme.primary;
      case JobStatusEnum.error:
        return Theme.of(context).colorScheme.error;
    }
  }

  @override
  Widget build(final BuildContext context) {
    final List<ServerJob> serverJobs =
        context.watch<ServerJobsBloc>().state.serverJobList;

    final bool hasRemovableJobs =
        context.watch<ServerJobsBloc>().state.hasRemovableJobs;

    final bool hasBlockingJobs =
        context.watch<ServerJobsBloc>().state.hasJobsBlockingRebuild;

    return BlocBuilder<JobsCubit, JobsState>(
      builder: (final context, final state) {
        late List<Widget> widgets;
        final ServerInstallationState installationState =
            context.read<ServerInstallationCubit>().state;
        if (state is JobsStateEmpty) {
          widgets = [
            const Gap(80),
            Center(
              child: Text(
                'jobs.empty'.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ];

          if (installationState is ServerInstallationFinished) {
            widgets = [
              ...widgets,
              const Gap(80),
              BrandButton.rised(
                onPressed: () => context.read<JobsCubit>().upgradeServer(),
                text: 'jobs.upgrade_server'.tr(),
              ),
              const Gap(10),
              BrandButton.text(
                title: 'jobs.reboot_server'.tr(),
                onPressed: () {
                  showPopUpAlert(
                    alertTitle: 'jobs.reboot_server'.tr(),
                    description: 'modals.are_you_sure'.tr(),
                    actionButtonTitle: 'modals.reboot'.tr(),
                    actionButtonOnPressed: () =>
                        {context.read<JobsCubit>().rebootServer()},
                  );
                },
              ),
            ];
          }
        } else if (state is JobsStateLoading) {
          widgets = [
            ...state.clientJobList.map(
              (final j) => Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      _getIcon(j.status),
                      color: _getColor(j.status, context),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              j.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                            if (j.message != null)
                              Text(
                                j.message!,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (state.rebuildRequired)
              Builder(
                builder: (final context) {
                  final rebuildJob = serverJobs.firstWhereOrNull(
                    (final job) => job.uid == state.rebuildJobUid,
                  );
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          _getIcon(rebuildJob?.status ?? JobStatusEnum.created),
                          color: _getColor(
                            rebuildJob?.status ?? JobStatusEnum.created,
                            context,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  rebuildJob?.name ??
                                      'jobs.rebuild_system'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                ),
                                if (rebuildJob?.description != null)
                                  Text(
                                    rebuildJob!.description,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                const Gap(8),
                                LinearProgressIndicator(
                                  value: rebuildJob?.progress == null
                                      ? 0.0
                                      : ((rebuildJob!.progress ?? 0) < 1)
                                          ? null
                                          : rebuildJob.progress! / 100.0,
                                  color: _getColor(
                                    rebuildJob?.status ?? JobStatusEnum.created,
                                    context,
                                  ),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                  minHeight: 7.0,
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                const Gap(8),
                                if (rebuildJob?.error != null ||
                                    rebuildJob?.result != null ||
                                    rebuildJob?.statusText != null)
                                  Text(
                                    rebuildJob?.error ??
                                        rebuildJob?.result ??
                                        rebuildJob?.statusText ??
                                        '',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
          ];
        } else if (state is JobsStateFinished) {
          widgets = [
            ...state.clientJobList.map(
              (final j) => Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      _getIcon(j.status),
                      color: _getColor(j.status, context),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              j.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                            if (j.message != null)
                              Text(
                                j.message!,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (state.rebuildRequired)
              Builder(
                builder: (final context) {
                  final rebuildJob = serverJobs.firstWhereOrNull(
                    (final job) => job.uid == state.rebuildJobUid,
                  );
                  if (rebuildJob == null) {
                    return const Gap(0);
                  }
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          _getIcon(rebuildJob.status),
                          color: _getColor(
                            rebuildJob.status,
                            context,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  rebuildJob.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                ),
                                Text(
                                  rebuildJob.description,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                const Gap(8),
                                LinearProgressIndicator(
                                  value: rebuildJob.progress == null
                                      ? 0.0
                                      : ((rebuildJob.progress ?? 0) < 1)
                                          ? null
                                          : rebuildJob.progress! / 100.0,
                                  color: _getColor(
                                    rebuildJob.status,
                                    context,
                                  ),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                  minHeight: 7.0,
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                const Gap(8),
                                if (rebuildJob.error != null ||
                                    rebuildJob.result != null ||
                                    rebuildJob.statusText != null)
                                  Text(
                                    rebuildJob.error ??
                                        rebuildJob.result ??
                                        rebuildJob.statusText ??
                                        '',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            const Gap(16),
            BrandButton.rised(
              onPressed: () => context.read<JobsCubit>().acknowledgeFinished(),
              text: 'basis.done'.tr(),
            ),
          ];
        } else if (state is JobsStateWithJobs) {
          widgets = [
            ...state.clientJobList.map(
              (final j) => Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              j.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                            if (j.message != null)
                              Text(
                                j.message!,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.errorContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => context.read<JobsCubit>().removeJob(j.id),
                    child: Text(
                      'basis.remove'.tr(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(16),
            BrandButton.rised(
              onPressed: hasBlockingJobs
                  ? null
                  : () => context.read<JobsCubit>().applyAll(),
              text: 'jobs.start'.tr(),
            ),
          ];
        }
        return ListView(
          controller: controller,
          padding: paddingH15V0,
          children: [
            const Gap(16),
            Center(
              child: Text(
                'jobs.title'.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const Gap(20),
            ...widgets,
            const Gap(8),
            const Divider(height: 0),
            const Gap(8),
            if (serverJobs.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'jobs.server_jobs'.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                      onPressed: hasRemovableJobs
                          ? () => context
                              .read<ServerJobsBloc>()
                              .add(RemoveAllFinishedJobs())
                          : null,
                      icon: const Icon(Icons.clear_all),
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ],
                ),
              ),
            ...serverJobs
                .whereNot((final job) => job.uid == state.rebuildJobUid)
                .map(
                  (final job) => Dismissible(
                    key: ValueKey(job.uid),
                    direction: job.status == JobStatusEnum.finished ||
                            job.status == JobStatusEnum.error
                        ? DismissDirection.horizontal
                        : DismissDirection.none,
                    child: ServerJobCard(
                      serverJob: job,
                    ),
                    onDismissed: (final direction) {
                      context.read<ServerJobsBloc>().add(
                            RemoveServerJob(job.uid),
                          );
                    },
                  ),
                ),
            const Gap(24),
          ],
        );
      },
    );
  }
}
