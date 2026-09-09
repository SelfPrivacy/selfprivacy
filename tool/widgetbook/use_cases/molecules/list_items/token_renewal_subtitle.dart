import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/list_items/token_renewal_subtitle.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(
  name: 'No token',
  type: TokenRenewalSubtitle,
  path: '[Molecules]/list_items',
)
Widget tokenRenewalSubtitleNoToken(final BuildContext context) => CatalogCase(
  key: const ValueKey('TokenRenewalSubtitle/No token'),
  id: 'TokenRenewalSubtitle/No token',
  variant: 'No token',
  host: PreviewHost.content,
  width: 560,
  height: 140,
  builder: (final context, final fixtures, final controller, final update) =>
      TokenRenewalSubtitle(resourcesModel: fixtures.resources, now: fixedNow),
);

@UseCase(
  name: 'Due now',
  type: TokenRenewalSubtitle,
  path: '[Molecules]/list_items',
)
Widget tokenRenewalSubtitleDueNow(final BuildContext context) => CatalogCase(
  key: const ValueKey('TokenRenewalSubtitle/Due now'),
  id: 'TokenRenewalSubtitle/Due now',
  variant: 'Due now',
  host: PreviewHost.content,
  width: 560,
  height: 140,
  builder: (final context, final fixtures, final controller, final update) =>
      TokenRenewalSubtitle(resourcesModel: fixtures.resources, now: fixedNow),
);

@UseCase(
  name: 'Scheduled',
  type: TokenRenewalSubtitle,
  path: '[Molecules]/list_items',
)
Widget tokenRenewalSubtitleScheduled(final BuildContext context) => CatalogCase(
  key: const ValueKey('TokenRenewalSubtitle/Scheduled'),
  id: 'TokenRenewalSubtitle/Scheduled',
  variant: 'Scheduled',
  host: PreviewHost.content,
  width: 560,
  height: 140,
  builder: (final context, final fixtures, final controller, final update) =>
      TokenRenewalSubtitle(resourcesModel: fixtures.resources, now: fixedNow),
);

@UseCase(
  name: 'Overdue',
  type: TokenRenewalSubtitle,
  path: '[Molecules]/list_items',
)
Widget tokenRenewalSubtitleOverdue(final BuildContext context) => CatalogCase(
  key: const ValueKey('TokenRenewalSubtitle/Overdue'),
  id: 'TokenRenewalSubtitle/Overdue',
  variant: 'Overdue',
  host: PreviewHost.content,
  width: 560,
  height: 140,
  builder: (final context, final fixtures, final controller, final update) =>
      TokenRenewalSubtitle(resourcesModel: fixtures.resources, now: fixedNow),
);
