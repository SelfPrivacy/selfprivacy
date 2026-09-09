import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/jobs/jobs_content.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Empty', type: JobsContent, path: '[Organisms]/jobs')
Widget jobsContentEmpty(final BuildContext context) => CatalogCase(
  key: const ValueKey('JobsContent/Empty'),
  id: 'JobsContent/Empty',
  variant: 'Empty',
  host: PreviewHost.sheet,
  width: 560,
  height: 800,
  builder: (final context, final fixtures, final controller, final update) =>
      JobsContent(controller: controller),
);

@UseCase(name: 'Loading', type: JobsContent, path: '[Organisms]/jobs')
Widget jobsContentLoading(final BuildContext context) => CatalogCase(
  key: const ValueKey('JobsContent/Loading'),
  id: 'JobsContent/Loading',
  variant: 'Loading',
  host: PreviewHost.sheet,
  width: 560,
  height: 800,
  builder: (final context, final fixtures, final controller, final update) =>
      JobsContent(controller: controller),
);

@UseCase(name: 'Finished', type: JobsContent, path: '[Organisms]/jobs')
Widget jobsContentFinished(final BuildContext context) => CatalogCase(
  key: const ValueKey('JobsContent/Finished'),
  id: 'JobsContent/Finished',
  variant: 'Finished',
  host: PreviewHost.sheet,
  width: 560,
  height: 800,
  builder: (final context, final fixtures, final controller, final update) =>
      JobsContent(controller: controller),
);

@UseCase(name: 'Blocked', type: JobsContent, path: '[Organisms]/jobs')
Widget jobsContentBlocked(final BuildContext context) => CatalogCase(
  key: const ValueKey('JobsContent/Blocked'),
  id: 'JobsContent/Blocked',
  variant: 'Blocked',
  host: PreviewHost.sheet,
  width: 560,
  height: 800,
  builder: (final context, final fixtures, final controller, final update) =>
      JobsContent(controller: controller),
);

@UseCase(name: 'Queued', type: JobsContent, path: '[Organisms]/jobs')
Widget jobsContentQueued(final BuildContext context) => CatalogCase(
  key: const ValueKey('JobsContent/Queued'),
  id: 'JobsContent/Queued',
  variant: 'Queued',
  host: PreviewHost.sheet,
  width: 560,
  height: 800,
  builder: (final context, final fixtures, final controller, final update) =>
      JobsContent(controller: controller),
);

@UseCase(name: 'Failed', type: JobsContent, path: '[Organisms]/jobs')
Widget jobsContentFailed(final BuildContext context) => CatalogCase(
  key: const ValueKey('JobsContent/Failed'),
  id: 'JobsContent/Failed',
  variant: 'Failed',
  host: PreviewHost.sheet,
  width: 560,
  height: 800,
  builder: (final context, final fixtures, final controller, final update) =>
      JobsContent(controller: controller),
);

@UseCase(name: 'Postponed', type: JobsContent, path: '[Organisms]/jobs')
Widget jobsContentPostponed(final BuildContext context) => CatalogCase(
  key: const ValueKey('JobsContent/Postponed'),
  id: 'JobsContent/Postponed',
  variant: 'Postponed',
  host: PreviewHost.sheet,
  width: 560,
  height: 800,
  builder: (final context, final fixtures, final controller, final update) =>
      JobsContent(controller: controller),
);

@UseCase(name: 'Not configured', type: JobsContent, path: '[Organisms]/jobs')
Widget jobsContentNotconfigured(final BuildContext context) => CatalogCase(
  key: const ValueKey('JobsContent/Not configured'),
  id: 'JobsContent/Not configured',
  variant: 'Not configured',
  host: PreviewHost.sheet,
  width: 560,
  height: 800,
  builder: (final context, final fixtures, final controller, final update) =>
      JobsContent(controller: controller),
);
