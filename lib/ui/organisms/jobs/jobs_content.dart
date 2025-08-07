import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/atoms/icons/job_icon.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';
import 'package:selfprivacy/ui/molecules/cards/server_job_card.dart';

class JobsContent extends StatelessWidget {
  const JobsContent({required this.controller, super.key});

  final ScrollController controller;

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
            const Gap(64),
            const _JobsEmptyContent(),
            const Gap(64),
            if (installationState is ServerInstallationFinished)
              const _JobsEmptyActions(),
          ];
        } else if (state is JobsStateLoading) {
          widgets = [
            ...state.clientJobList.map(
              (final j) =>
                  _ClientJobStatusCard(clientJob: j, key: ValueKey(j.id)),
            ),
            if (state.rebuildRequired)
              Builder(
                builder: (final context) {
                  final rebuildJob = serverJobs.firstWhereOrNull(
                    (final job) => job.uid == state.rebuildJobUid,
                  );
                  return _ServerJobStatusCardInClientJobs(
                    serverJob: rebuildJob,
                  );
                },
              ),
          ];
        } else if (state is JobsStateFinished) {
          widgets = [
            ...state.clientJobList.map(
              (final j) => _ClientJobStatusCard(clientJob: j),
            ),
            if (state.rebuildRequired)
              Builder(
                builder: (final context) {
                  final rebuildJob = serverJobs.firstWhereOrNull(
                    (final job) => job.uid == state.rebuildJobUid,
                  );
                  if (rebuildJob == null) {
                    return const SizedBox.shrink();
                  }
                  return _ServerJobStatusCardInClientJobs(
                    serverJob: rebuildJob,
                  );
                },
              ),
            const Gap(16),
            BrandButton.filled(
              onPressed: () => context.read<JobsCubit>().acknowledgeFinished(),
              title: 'basis.done'.tr(),
            ),
          ];
        } else if (state is JobsStateWithJobs) {
          widgets = [
            ...state.clientJobList.map(
              (final j) =>
                  _ClientJobStatusCard(clientJob: j, showRemoveButton: true),
            ),
            const Gap(16),
            BrandButton.filled(
              onPressed:
                  hasBlockingJobs
                      ? null
                      : () => context.read<JobsCubit>().applyAll(),
              title: 'jobs.start'.tr(),
            ),
          ];
        }
        return ListView(
          controller: controller,
          padding: paddingH16V0,
          children: [
            const Gap(16),
            Center(
              child: Text(
                'jobs.title'.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const Gap(16),
            ...widgets,
            const Gap(16),
            const Divider(height: 0),
            const Gap(16),
            if (serverJobs.isNotEmpty)
              _ServerJobsListTitle(hasRemovableJobs: hasRemovableJobs),
            ...serverJobs
                .whereNot((final job) => job.uid == state.rebuildJobUid)
                .map(
                  (final job) => Dismissible(
                    key: ValueKey(job.uid),
                    direction:
                        job.status == JobStatusEnum.finished ||
                                job.status == JobStatusEnum.error
                            ? DismissDirection.horizontal
                            : DismissDirection.none,
                    child: ServerJobCard(serverJob: job),
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

class _JobsEmptyContent extends StatelessWidget {
  const _JobsEmptyContent();

  @override
  Widget build(final BuildContext context) => Center(
    child: Text(
      'jobs.empty'.tr(),
      style: Theme.of(context).textTheme.bodyLarge,
    ),
  );
}

class _JobsEmptyActions extends StatelessWidget {
  const _JobsEmptyActions();

  @override
  Widget build(final BuildContext context) => Column(
    children: [
      BrandButton.filled(
        onPressed: () => context.read<JobsCubit>().upgradeServer(),
        title: 'jobs.upgrade_server'.tr(),
      ),
      const Gap(8),
      BrandButton.text(
        title: 'jobs.reboot_server'.tr(),
        onPressed: () {
          showPopUpAlert(
            alertTitle: 'jobs.reboot_server'.tr(),
            description: 'modals.are_you_sure'.tr(),
            actionButtonTitle: 'modals.reboot'.tr(),
            actionButtonOnPressed:
                () => {context.read<JobsCubit>().rebootServer()},
          );
        },
      ),
    ],
  );
}

class _ClientJobStatusCard extends StatelessWidget {
  const _ClientJobStatusCard({
    required this.clientJob,
    this.showRemoveButton = false,
    super.key,
  });

  final ClientJob clientJob;
  final bool showRemoveButton;

  @override
  Widget build(final BuildContext context) => Row(
    children: [
      if (!showRemoveButton)
        Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            getJobIcon(clientJob.status),
            color: getJobColor(clientJob.status, context),
          ),
        ),
      Expanded(
        child: Card(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clientJob.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                if (clientJob.message != null)
                  Text(
                    clientJob.message!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          ),
        ),
      ),
      if (showRemoveButton) const Gap(8),
      if (showRemoveButton)
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
          onPressed: () => context.read<JobsCubit>().removeJob(clientJob.id),
          child: Text(
            'basis.remove'.tr(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
        ),
    ],
  );
}

class _ServerJobStatusCardInClientJobs extends StatelessWidget {
  const _ServerJobStatusCardInClientJobs({this.serverJob});

  final ServerJob? serverJob;

  @override
  Widget build(final BuildContext context) => Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          getJobIcon(serverJob?.status ?? JobStatusEnum.created),
          color: getJobColor(
            serverJob?.status ?? JobStatusEnum.created,
            context,
          ),
        ),
      ),
      Expanded(
        child: Card(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serverJob?.name ?? 'jobs.rebuild_system'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                if (serverJob?.description != null)
                  Text(
                    serverJob!.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                const Gap(8),
                LinearProgressIndicator(
                  value:
                      serverJob?.progress == null
                          ? 0.0
                          : ((serverJob?.progress ?? 0) < 1)
                          ? null
                          : serverJob!.progress! / 100.0,
                  color: getJobColor(
                    serverJob?.status ?? JobStatusEnum.created,
                    context,
                  ),
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(8),
                ),
                const Gap(8),
                if (serverJob?.error != null ||
                    serverJob?.result != null ||
                    serverJob?.statusText != null)
                  Text(
                    serverJob?.error ??
                        serverJob?.result ??
                        serverJob?.statusText ??
                        '',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

class _ServerJobsListTitle extends StatelessWidget {
  const _ServerJobsListTitle({required this.hasRemovableJobs});

  final bool hasRemovableJobs;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.all(8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'jobs.server_jobs'.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        IconButton(
          onPressed:
              hasRemovableJobs
                  ? () => context.read<ServerJobsBloc>().add(
                    RemoveAllFinishedJobs(),
                  )
                  : null,
          icon: const Icon(Icons.clear_all),
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ],
    ),
  );
}
