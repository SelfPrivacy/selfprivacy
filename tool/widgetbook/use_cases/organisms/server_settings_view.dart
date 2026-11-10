import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/server_settings/server_settings_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/models/credential_policy.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/ui/organisms/server_settings_view.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../../../test/helpers/fixtures/system_settings_fixtures.dart';
import '../../catalog_case.dart';
import '../../fixtures/models.dart';

@UseCase(name: 'Current', type: ServerSettingsView, path: '[Organisms]')
Widget settingsCurrent(final BuildContext context) => _example('Current');

@UseCase(
  name: 'Auto upgrade off',
  type: ServerSettingsView,
  path: '[Organisms]',
)
Widget settingsAutoUpgradeOff(final BuildContext context) =>
    _example('Auto upgrade off');

@UseCase(name: 'Modified', type: ServerSettingsView, path: '[Organisms]')
Widget settingsModified(final BuildContext context) => _example('Modified');

@UseCase(name: 'Applying', type: ServerSettingsView, path: '[Organisms]')
Widget settingsApplying(final BuildContext context) => _example('Applying');

@UseCase(name: 'Loading', type: ServerSettingsView, path: '[Organisms]')
Widget settingsLoading(final BuildContext context) => _example('Loading');

@UseCase(name: 'Stale', type: ServerSettingsView, path: '[Organisms]')
Widget settingsStale(final BuildContext context) => _example('Stale');

@UseCase(name: 'Partial', type: ServerSettingsView, path: '[Organisms]')
Widget settingsPartial(final BuildContext context) => _example('Partial');

@UseCase(name: 'Unsupported', type: ServerSettingsView, path: '[Organisms]')
Widget settingsUnsupported(final BuildContext context) =>
    _example('Unsupported');

@UseCase(name: 'Wide', type: ServerSettingsView, path: '[Organisms]')
Widget settingsWide(final BuildContext context) => _example('Wide');

CatalogCase _example(final String variant) => CatalogCase(
  id: 'ServerSettingsView/$variant',
  variant: variant,
  width: variant == 'Wide' ? 800 : 360,
  builder: (final context, final fixtures, final controller, final update) {
    final createState = switch (variant) {
      'Loading' => ServerSettingsLoading.new,
      'Applying' => ServerSettingsApplying.new,
      _ => ServerSettingsReady.new,
    };
    return ServerSettingsView(
      state: createState(
        settings: CachedValue(
          support: DomainSupport.supported,
          data: variant == 'Loading' || variant == 'Partial'
              ? null
              : aSystemSettings(
                  autoUpgrade: variant != 'Auto upgrade off',
                  allowReboot: variant == 'Auto upgrade off',
                ),
          freshness: variant == 'Stale' ? Freshness.stale : Freshness.fresh,
          isRefreshing: variant == 'Loading',
          lastError: variant == 'Partial' || variant == 'Stale'
              ? StateError('offline')
              : null,
        ),
        channels: CachedValue(
          support: variant == 'Unsupported'
              ? DomainSupport.unsupported
              : DomainSupport.supported,
          data: variant == 'Loading' || variant == 'Unsupported'
              ? null
              : demoUpdateChannels(),
          freshness: variant == 'Stale' ? Freshness.stale : Freshness.fresh,
          isRefreshing: variant == 'Loading',
        ),
        policy: CachedValue(
          support: variant == 'Unsupported'
              ? DomainSupport.unsupported
              : DomainSupport.supported,
          data: variant == 'Loading' || variant == 'Unsupported'
              ? null
              : CredentialPolicy.any,
          freshness: variant == 'Stale' ? Freshness.stale : Freshness.fresh,
          isRefreshing: variant == 'Loading',
        ),
        draft: [
          if (variant == 'Modified') ...[
            ChangeSshSettingsJob(enable: false, id: 'ssh'),
            ChangeServerTimezoneJob(timezone: 'UTC', id: 'timezone'),
            ChangeCredentialPolicyJob(
              policy: CredentialPolicy.mfa,
              id: 'policy',
            ),
          ],
        ],
      ),
      onEvent: (final event) =>
          catalogActions.record(event.runtimeType.toString()),
      onChannel: () => catalogActions.record('Open channel editor'),
      onRefresh: () => catalogActions.record('Refresh settings'),
      onTimezone: () => catalogActions.record('Open timezone editor'),
      onCredentialPolicy: () =>
          catalogActions.record('Open credential policy editor'),
      onShowOperation: () => catalogActions.record('Show operation'),
    );
  },
);
