import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/ui/organisms/jobs/operation_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../../catalog_case.dart';
import '../../../fixtures/models.dart';

@UseCase(name: 'Queued', type: OperationCard, path: '[Organisms]/jobs')
Widget operationQueued(final BuildContext context) => CatalogCase(
  key: const ValueKey('OperationCard/Queued'),
  id: 'OperationCard/Queued',
  variant: 'Queued',
  builder: (final context, final fixtures, final controller, final update) =>
      OperationCard(
        operation: demoOperation('Queued'),
        expanded: true,
        removing: false,
        onCancel: () => fixtures.record('Cancel operation'),
        onRemove: () => fixtures.record('Remove operation history'),
      ),
);

@UseCase(name: 'Running', type: OperationCard, path: '[Organisms]/jobs')
Widget operationRunning(final BuildContext context) => CatalogCase(
  key: const ValueKey('OperationCard/Running'),
  id: 'OperationCard/Running',
  variant: 'Running',
  builder: (final context, final fixtures, final controller, final update) =>
      OperationCard(
        operation: demoOperation('Running'),
        expanded: true,
        removing: false,
        onCancel: () => fixtures.record('Cancel operation'),
        onRemove: () => fixtures.record('Remove operation history'),
      ),
);

@UseCase(name: 'Waiting', type: OperationCard, path: '[Organisms]/jobs')
Widget operationWaiting(final BuildContext context) => CatalogCase(
  key: const ValueKey('OperationCard/Waiting'),
  id: 'OperationCard/Waiting',
  variant: 'Waiting',
  builder: (final context, final fixtures, final controller, final update) =>
      OperationCard(
        operation: demoOperation('Waiting'),
        jobs: [demoJob(JobStatusEnum.running)],
        expanded: true,
        removing: false,
        onCancel: () => fixtures.record('Cancel operation'),
        onRemove: () => fixtures.record('Remove operation history'),
      ),
);

@UseCase(name: 'Finished', type: OperationCard, path: '[Organisms]/jobs')
Widget operationFinished(final BuildContext context) => CatalogCase(
  key: const ValueKey('OperationCard/Finished'),
  id: 'OperationCard/Finished',
  variant: 'Finished',
  builder: (final context, final fixtures, final controller, final update) =>
      OperationCard(
        operation: demoOperation('Finished'),
        expanded: true,
        removing: false,
        onCancel: () => fixtures.record('Cancel operation'),
        onRemove: () => fixtures.record('Remove operation history'),
      ),
);

@UseCase(name: 'Partial failure', type: OperationCard, path: '[Organisms]/jobs')
Widget operationPartialfailure(final BuildContext context) => CatalogCase(
  key: const ValueKey('OperationCard/Partial failure'),
  id: 'OperationCard/Partial failure',
  variant: 'Partial failure',
  builder: (final context, final fixtures, final controller, final update) =>
      OperationCard(
        operation: demoOperation('Partial failure'),
        expanded: true,
        removing: false,
        onCancel: () => fixtures.record('Cancel operation'),
        onRemove: () => fixtures.record('Remove operation history'),
      ),
);

@UseCase(name: 'Unknown', type: OperationCard, path: '[Organisms]/jobs')
Widget operationUnknown(final BuildContext context) => CatalogCase(
  key: const ValueKey('OperationCard/Unknown'),
  id: 'OperationCard/Unknown',
  variant: 'Unknown',
  builder: (final context, final fixtures, final controller, final update) =>
      OperationCard(
        operation: demoOperation('Unknown'),
        expanded: true,
        removing: false,
        onCancel: () => fixtures.record('Cancel operation'),
        onRemove: () => fixtures.record('Remove operation history'),
      ),
);

@UseCase(name: 'Cancelled', type: OperationCard, path: '[Organisms]/jobs')
Widget operationCancelled(final BuildContext context) => CatalogCase(
  key: const ValueKey('OperationCard/Cancelled'),
  id: 'OperationCard/Cancelled',
  variant: 'Cancelled',
  builder: (final context, final fixtures, final controller, final update) =>
      OperationCard(
        operation: demoOperation('Cancelled'),
        expanded: true,
        removing: false,
        onCancel: () => fixtures.record('Cancel operation'),
        onRemove: () => fixtures.record('Remove operation history'),
      ),
);

@UseCase(name: 'Resize', type: OperationCard, path: '[Organisms]/jobs')
Widget operationResize(final BuildContext context) => CatalogCase(
  key: const ValueKey('OperationCard/Resize'),
  id: 'OperationCard/Resize',
  variant: 'Resize',
  builder: (final context, final fixtures, final controller, final update) =>
      OperationCard(
        operation: demoOperation('Resize'),
        expanded: true,
        removing: false,
        onCancel: () => fixtures.record('Cancel operation'),
        onRemove: () => fixtures.record('Remove operation history'),
      ),
);

@UseCase(name: 'Removing', type: OperationCard, path: '[Organisms]/jobs')
Widget operationRemoving(final BuildContext context) => CatalogCase(
  key: const ValueKey('OperationCard/Removing'),
  id: 'OperationCard/Removing',
  variant: 'Removing',
  builder: (final context, final fixtures, final controller, final update) =>
      OperationCard(
        operation: demoOperation('Finished'),
        expanded: true,
        removing: true,
        onCancel: () => fixtures.record('Cancel operation'),
        onRemove: () => fixtures.record('Remove operation history'),
      ),
);

@UseCase(name: 'Collapsed', type: OperationCard, path: '[Organisms]/jobs')
Widget operationCollapsed(final BuildContext context) => CatalogCase(
  key: const ValueKey('OperationCard/Collapsed'),
  id: 'OperationCard/Collapsed',
  variant: 'Collapsed',
  builder: (final context, final fixtures, final controller, final update) =>
      OperationCard(
        operation: demoOperation('Collapsed'),
        expanded: false,
        removing: false,
        onCancel: () => fixtures.record('Cancel operation'),
        onRemove: () => fixtures.record('Remove operation history'),
      ),
);
