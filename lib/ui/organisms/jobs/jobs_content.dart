import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/cubit/app_readiness/app_readiness_cubit.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/operations_cubit.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/operations/operation.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';
import 'package:selfprivacy/ui/molecules/cards/server_job_card.dart';
import 'package:selfprivacy/ui/organisms/jobs/operation_card.dart';

class JobsContent extends StatefulWidget {
  const JobsContent({required this.controller, super.key});
  final ScrollController controller;

  @override
  State<JobsContent> createState() => _JobsContentState();
}

class _JobsContentState extends State<JobsContent> {
  final _focusedCard = GlobalKey();
  int? _focusId;

  @override
  Widget build(final BuildContext context) {
    final jobs = context.watch<ServerJobsBloc>().state;
    final draft = context.watch<JobsCubit>().state.draft;
    final history = context.watch<OperationsCubit>().state;
    if (_focusId != history.focusId) {
      _focusId = history.focusId;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final target = _focusedCard.currentContext;
        if (mounted && target != null) {
          unawaited(Scrollable.ensureVisible(target));
        }
      });
    }
    final operations = history.operations.reversed.toList();
    final grouped = {for (final operation in operations) ...operation.jobIds};
    final standalone = jobs.serverJobList.where(
      (final job) => !grouped.contains(job.uid),
    );
    final busy = operations.any(
      (final operation) =>
          operation.status.isPending &&
          switch (operation.kind) {
            OperationKind.applyChanges ||
            OperationKind.rebootServer ||
            OperationKind.upgradeServer ||
            OperationKind.collectGarbage => true,
            _ => false,
          },
    );
    return ListView(
      controller: widget.controller,
      padding: paddingH16V0,
      children: [
        const Gap(16),
        Center(
          child: Text(
            'jobs.title'.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        if (draft.isNotEmpty) ...[
          const Gap(16),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'operations.drafts'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          for (final job in draft)
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Text(job.title),
                trailing: IconButton(
                  tooltip: 'basis.remove'.tr(),
                  icon: const Icon(Icons.close),
                  onPressed: () => context.read<JobsCubit>().removeJob(job.id),
                ),
              ),
            ),
          const Gap(16),
          BrandButton.filled(
            title: 'jobs.start'.tr(),
            onPressed: busy || jobs.hasJobsBlockingRebuild
                ? null
                : () => context.read<JobsCubit>().applyAll(),
          ),
        ],
        if (operations.isNotEmpty) ...[
          const Gap(16),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'operations.title'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          for (final operation in operations)
            KeyedSubtree(
              key: history.focusId == operation.id
                  ? _focusedCard
                  : ValueKey(operation.id),
              child: OperationCard(
                key: ValueKey(
                  '${operation.id}/${history.focusId == operation.id}',
                ),
                operation: operation,
                expanded: history.focusId == operation.id,
                removing: history.removing.contains(operation.id),
                jobs: jobs.serverJobList
                    .where((final job) => operation.jobIds.contains(job.uid))
                    .toList(),
                onCancel: () =>
                    context.read<OperationsCubit>().cancel(operation.id),
                onRemove: () =>
                    context.read<OperationsCubit>().remove(operation.id),
              ),
            ),
        ],
        if (standalone.isNotEmpty) ...[
          const Gap(16),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'jobs.server_jobs'.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  tooltip: 'operations.remove_finished_jobs'.tr(),
                  icon: const Icon(Icons.clear_all),
                  onPressed: standalone.any(_finished)
                      ? () {
                          for (final job in standalone.where(_finished)) {
                            context.read<ServerJobsBloc>().add(
                              RemoveServerJob(job.uid),
                            );
                          }
                        }
                      : null,
                ),
              ],
            ),
          ),
          for (final job in standalone)
            Dismissible(
              key: ValueKey(job.uid),
              direction: _finished(job)
                  ? DismissDirection.endToStart
                  : DismissDirection.none,
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                padding: const EdgeInsets.all(24),
                color: Theme.of(context).colorScheme.errorContainer,
                child: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
              confirmDismiss: (_) async {
                context.read<ServerJobsBloc>().add(RemoveServerJob(job.uid));
                return false;
              },
              child: ServerJobCard(
                serverJob: job,
                onRemove: _finished(job)
                    ? () => context.read<ServerJobsBloc>().add(
                        RemoveServerJob(job.uid),
                      )
                    : null,
              ),
            ),
        ],
        if (draft.isEmpty && operations.isEmpty && standalone.isEmpty) ...[
          const Gap(64),
          Center(child: Text('jobs.empty'.tr())),
          const Gap(64),
        ],
        if (draft.isEmpty &&
            !busy &&
            context.watch<AppReadinessCubit>().state is ServerConfigured) ...[
          const Gap(16),
          BrandButton.filled(
            onPressed: () => context.read<JobsCubit>().upgradeServer(),
            title: 'jobs.upgrade_server'.tr(),
          ),
          const Gap(8),
          BrandButton.text(
            title: 'jobs.reboot_server'.tr(),
            onPressed: () => showPopUpAlert(
              alertTitle: 'jobs.reboot_server'.tr(),
              description: 'modals.are_you_sure'.tr(),
              actionButtonTitle: 'modals.reboot'.tr(),
              actionButtonOnPressed: () =>
                  context.read<JobsCubit>().rebootServer(),
            ),
          ),
        ],
        const Gap(24),
      ],
    );
  }
}

bool _finished(final ServerJob job) =>
    job.status == JobStatusEnum.finished || job.status == JobStatusEnum.error;
