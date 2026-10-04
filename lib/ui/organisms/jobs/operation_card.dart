import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/operations/operation.dart';
import 'package:selfprivacy/ui/molecules/cards/server_job_card.dart';

class OperationCard extends StatelessWidget {
  const OperationCard({
    required this.operation,
    this.jobs = const [],
    this.expanded = false,
    this.removing = false,
    this.onCancel,
    this.onRemove,
    super.key,
  });

  final OperationSnapshot operation;
  final List<ServerJob> jobs;
  final bool expanded;
  final bool removing;
  final VoidCallback? onCancel;
  final VoidCallback? onRemove;

  @override
  Widget build(final BuildContext context) {
    final status = operation.status;
    final theme = Theme.of(context);
    final unverified =
        operation.kind == OperationKind.resizeVolume &&
        status == OperationStatus.succeeded;
    final reason = operation.events.last.reason;
    return Card(
      child: ExpansionTile(
        initiallyExpanded: expanded,
        shape: const Border(),
        collapsedShape: const Border(),
        tilePadding: const EdgeInsetsDirectional.fromSTEB(16, 8, 28, 8),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: Icon(_icon(status), color: _color(status, theme.colorScheme)),
        title: Text(operation.kind.translationKey.tr()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${DateFormat.Hm(context.locale.toString()).format(operation.events.first.at.toLocal())} · ${status.translationKey.tr()}',
            ),
            if (reason != null) Text(reason.translationKey.tr()),
            if (unverified) Text('operations.resize_unverified'.tr()),
          ],
        ),
        children: [
          for (final step in operation.steps)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                _icon(step.status),
                color: _color(step.status, theme.colorScheme),
              ),
              title: Text(_stepTitle(step)),
              subtitle: Text(
                (step.messageKey ?? step.status.translationKey).tr(),
              ),
            ),
          for (final job in jobs) ServerJobCard(serverJob: job),
          if (operation.canCancel || !status.isPending)
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: removing
                  ? const SizedBox.square(
                      dimension: 48,
                      child: Center(
                        child: SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    )
                  : IconButton(
                      tooltip:
                          (operation.canCancel
                                  ? 'basis.cancel'
                                  : 'operations.remove_history')
                              .tr(),
                      onPressed: operation.canCancel ? onCancel : onRemove,
                      icon: Icon(
                        operation.canCancel
                            ? Icons.cancel_outlined
                            : Icons.delete_outline,
                      ),
                    ),
            ),
        ],
      ),
    );
  }

  String _stepTitle(final OperationStep step) => switch (step.titleKey) {
    'jobs.create_ssh_key' ||
    'jobs.delete_ssh_key' ||
    'jobs.change_service_settings' => step.titleKey.tr(
      args: [step.target ?? ''],
    ),
    _ => [step.titleKey.tr(), if (step.target != null) step.target!].join(' '),
  };

  IconData _icon(final OperationStatus status) => switch (status) {
    OperationStatus.queued => Icons.schedule,
    OperationStatus.running ||
    OperationStatus.accepted => Icons.pending_outlined,
    OperationStatus.succeeded => Icons.check_circle_outline,
    OperationStatus.unknown => Icons.help_outline,
    OperationStatus.cancelled || OperationStatus.notSent => Icons.block,
    OperationStatus.rejected || OperationStatus.failed => Icons.error_outline,
  };

  Color _color(final OperationStatus status, final ColorScheme colors) =>
      switch (status) {
        OperationStatus.rejected || OperationStatus.failed => colors.error,
        OperationStatus.running || OperationStatus.accepted => colors.tertiary,
        OperationStatus.succeeded => colors.primary,
        _ => colors.onSurfaceVariant,
      };
}
