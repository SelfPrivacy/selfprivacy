import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/icons/job_icon.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'created', type: Icon, path: '[Atoms]/icons')
Widget iconCreated(final BuildContext context) => CatalogCase(
  key: const ValueKey('Icon/created'),
  id: 'Icon/created',
  variant: 'created',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      Icon(
        getJobIcon(JobStatusEnum.created),
        color: getJobColor(JobStatusEnum.created, context),
        size: 32,
      ),
);

@UseCase(name: 'running', type: Icon, path: '[Atoms]/icons')
Widget iconRunning(final BuildContext context) => CatalogCase(
  key: const ValueKey('Icon/running'),
  id: 'Icon/running',
  variant: 'running',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      Icon(
        getJobIcon(JobStatusEnum.running),
        color: getJobColor(JobStatusEnum.running, context),
        size: 32,
      ),
);

@UseCase(name: 'finished', type: Icon, path: '[Atoms]/icons')
Widget iconFinished(final BuildContext context) => CatalogCase(
  key: const ValueKey('Icon/finished'),
  id: 'Icon/finished',
  variant: 'finished',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      Icon(
        getJobIcon(JobStatusEnum.finished),
        color: getJobColor(JobStatusEnum.finished, context),
        size: 32,
      ),
);

@UseCase(name: 'error', type: Icon, path: '[Atoms]/icons')
Widget iconError(final BuildContext context) => CatalogCase(
  key: const ValueKey('Icon/error'),
  id: 'Icon/error',
  variant: 'error',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      Icon(
        getJobIcon(JobStatusEnum.error),
        color: getJobColor(JobStatusEnum.error, context),
        size: 32,
      ),
);
