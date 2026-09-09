import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/cards/server_job_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'created', type: ServerJobCard, path: '[Molecules]/cards')
Widget serverJobCardCreated(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerJobCard/created'),
  id: 'ServerJobCard/created',
  variant: 'created',
  host: PreviewHost.content,
  width: 560,
  height: 250,
  builder: (final context, final fixtures, final controller, final update) =>
      ServerJobCard(serverJob: demoJob(JobStatusEnum.created)),
);

@UseCase(name: 'running', type: ServerJobCard, path: '[Molecules]/cards')
Widget serverJobCardRunning(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerJobCard/running'),
  id: 'ServerJobCard/running',
  variant: 'running',
  host: PreviewHost.content,
  width: 560,
  height: 250,
  builder: (final context, final fixtures, final controller, final update) =>
      ServerJobCard(serverJob: demoJob(JobStatusEnum.running)),
);

@UseCase(name: 'finished', type: ServerJobCard, path: '[Molecules]/cards')
Widget serverJobCardFinished(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerJobCard/finished'),
  id: 'ServerJobCard/finished',
  variant: 'finished',
  host: PreviewHost.content,
  width: 560,
  height: 250,
  builder: (final context, final fixtures, final controller, final update) =>
      ServerJobCard(serverJob: demoJob(JobStatusEnum.finished)),
);

@UseCase(name: 'error', type: ServerJobCard, path: '[Molecules]/cards')
Widget serverJobCardError(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerJobCard/error'),
  id: 'ServerJobCard/error',
  variant: 'error',
  host: PreviewHost.content,
  width: 560,
  height: 250,
  builder: (final context, final fixtures, final controller, final update) =>
      ServerJobCard(serverJob: demoJob(JobStatusEnum.error)),
);
