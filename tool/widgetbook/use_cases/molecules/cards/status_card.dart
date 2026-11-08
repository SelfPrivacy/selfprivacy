import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/cards/status_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../../catalog_case.dart';

@UseCase(name: 'Stale', type: StatusCard, path: '[Molecules]/cards')
Widget statusStale(final BuildContext context) => _example('Stale');

@UseCase(name: 'Applying', type: StatusCard, path: '[Molecules]/cards')
Widget statusApplying(final BuildContext context) => _example('Applying');

@UseCase(name: 'Error', type: StatusCard, path: '[Molecules]/cards')
Widget statusError(final BuildContext context) => _example('Error');

@UseCase(name: 'Retrying', type: StatusCard, path: '[Molecules]/cards')
Widget statusRetrying(final BuildContext context) => _example('Retrying');

CatalogCase _example(final String variant) => CatalogCase(
  id: 'StatusCard/$variant',
  variant: variant,
  width: 360,
  builder: (final context, final fixtures, final controller, final update) =>
      switch (variant) {
        'Applying' => StatusCard(
          icon: Icons.pending_actions_outlined,
          message: 'data_status.applying'.tr(),
          onTap: () => catalogActions.record('Show operation'),
          isNavigation: true,
        ),
        'Error' || 'Retrying' => StatusCard.loadError(
          title: 'data_status.load_error'.tr(),
          onRetry: () => catalogActions.record('Refresh'),
          retrying: variant == 'Retrying',
        ),
        _ => StatusCard.stale(
          onRefresh: () => catalogActions.record('Refresh'),
        ),
      },
);
