import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/ui/organisms/update_channel_selection.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';
import '../../fixtures/models.dart';

@UseCase(name: 'Current', type: UpdateChannelSelection, path: '[Organisms]')
Widget updateChannelCurrent(final BuildContext context) => _example('Current');

@UseCase(name: 'Custom', type: UpdateChannelSelection, path: '[Organisms]')
Widget updateChannelCustom(final BuildContext context) => _example('Custom');

@UseCase(name: 'Empty', type: UpdateChannelSelection, path: '[Organisms]')
Widget updateChannelEmpty(final BuildContext context) => _example('Empty');

@UseCase(name: 'Loading', type: UpdateChannelSelection, path: '[Organisms]')
Widget updateChannelLoading(final BuildContext context) => _example('Loading');

@UseCase(name: 'Error', type: UpdateChannelSelection, path: '[Organisms]')
Widget updateChannelError(final BuildContext context) => _example('Error');

@UseCase(name: 'Stale', type: UpdateChannelSelection, path: '[Organisms]')
Widget updateChannelStale(final BuildContext context) => _example('Stale');

@UseCase(name: 'Queued', type: UpdateChannelSelection, path: '[Organisms]')
Widget updateChannelQueued(final BuildContext context) => _example('Queued');

@UseCase(name: 'Applying', type: UpdateChannelSelection, path: '[Organisms]')
Widget updateChannelApplying(final BuildContext context) =>
    _example('Applying');

CatalogCase _example(final String variant) => CatalogCase(
  id: 'UpdateChannelSelection/$variant',
  variant: variant,
  width: 360,
  builder: (final context, final fixtures, final controller, final update) =>
      UpdateChannelSelection(
        pendingChannelId: variant == 'Queued' ? 'stable' : null,
        enabled: variant != 'Applying',
        onRefresh: () => catalogActions.record('Refresh channels'),
        applying: variant == 'Applying',
        onShowOperation: () => catalogActions.record('Show operation'),
        snapshot: CachedValue(
          support: DomainSupport.supported,
          data: variant == 'Loading' || variant == 'Error'
              ? null
              : demoUpdateChannels(
                  custom: variant == 'Custom' || variant == 'Queued',
                  empty: variant == 'Empty',
                ),
          isRefreshing: variant == 'Loading',
          freshness: variant == 'Stale' ? Freshness.stale : Freshness.fresh,
          lastError: variant == 'Error' || variant == 'Stale'
              ? StateError('offline')
              : null,
        ),
        onAdd: (final channel) =>
            catalogActions.record('Queue channel: ${channel.id}'),
      ),
);
