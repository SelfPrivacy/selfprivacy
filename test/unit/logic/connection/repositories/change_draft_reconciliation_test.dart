import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/credential_policy.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/models/update_channels.dart';

import '../../../../helpers/fixtures/system_settings_fixtures.dart';
import '../../../../helpers/fixtures/update_channels_fixtures.dart';
import '../../../../helpers/widget_harness.dart';

class _Api extends Mock implements ServerApi {}

void main() {
  setUpAll(setUpWidgetTestHarness);
  late ServerConnection connection;
  late _Api api;
  setUp(() {
    api = _Api();
    connection = ServerConnection(
      api: api,
      serverId: 'server',
      isAttached: () => true,
    )..cache.setVersion(Version(3, 9, 0));
    connection.cache.settings.push(aSystemSettings());
    connection.cache.updateChannels.push(anUpdateChannels());
  });
  tearDown(() => connection.dispose());

  test('all server settings changes share staging and replacement', () {
    final changes = <ServerSettingsJob>[
      ChangeAutoUpgradeSettingsJob(enable: false, allowReboot: true),
      ChangeServerTimezoneJob(timezone: 'UTC'),
      ChangeSshSettingsJob(enable: false),
    ];
    for (final change in changes) {
      expect(connection.settings.stageChange(change), isTrue);
    }
    expect(connection.changeDraft.value, changes);
    connection.settings
      ..stageChange(
        ChangeAutoUpgradeSettingsJob(enable: true, allowReboot: false),
      )
      ..stageChange(ChangeServerTimezoneJob(timezone: 'Europe/Helsinki'))
      ..stageChange(ChangeSshSettingsJob(enable: true));
    expect(connection.changeDraft.value, isEmpty);
  });

  test('fresh settings do not reconcile a stale credential policy', () async {
    connection.cache.credentialPolicy.push(CredentialPolicy.any);
    final policy = ChangeCredentialPolicyJob(policy: CredentialPolicy.mfa);
    connection.credentialPolicy.stageChange(policy);
    connection.settings.stageChange(ChangeSshSettingsJob(enable: false));
    connection.cache.credentialPolicy
      ..push(CredentialPolicy.mfa)
      ..invalidate();
    connection.cache.settings.push(aSystemSettings(ssh: false));
    await pumpEventQueue();
    expect(connection.changeDraft.value, [policy]);

    connection.cache.credentialPolicy.push(CredentialPolicy.mfa);
    await pumpEventQueue();
    expect(connection.changeDraft.value, isEmpty);
  });

  test('fresh credential policy does not reconcile stale settings', () async {
    connection.cache.credentialPolicy.push(CredentialPolicy.any);
    final ssh = ChangeSshSettingsJob(enable: false);
    connection.settings.stageChange(ssh);
    connection.credentialPolicy.stageChange(
      ChangeCredentialPolicyJob(policy: CredentialPolicy.mfa),
    );
    connection.cache.settings
      ..push(aSystemSettings(ssh: false))
      ..invalidate();
    connection.cache.credentialPolicy.push(CredentialPolicy.mfa);
    await pumpEventQueue();
    expect(connection.changeDraft.value, [ssh]);

    connection.cache.settings.push(aSystemSettings(ssh: false));
    await pumpEventQueue();
    expect(connection.changeDraft.value, isEmpty);
  });

  test('settings reconciliation retains prepared service changes', () async {
    final serviceChange = ChangeServiceConfiguration(
      serviceId: 'nextcloud',
      serviceDisplayName: 'Nextcloud',
      settings: const {'subdomain': 'files'},
    );
    connection.changeDraft.add(serviceChange);
    connection.settings.stageChange(ChangeSshSettingsJob(enable: false));
    connection.cache.settings.push(aSystemSettings(ssh: false));
    await pumpEventQueue();
    expect(connection.changeDraft.value, [serviceChange]);
  });

  test('channel staging rejects an unavailable selection', () {
    final staged = connection.updateChannels.stageChange(
      ChangeUpdateChannelJob(channelId: 'missing', channelName: 'Missing'),
    );
    expect(staged, isFalse);
    expect(connection.changeDraft.value, isEmpty);
  });

  test('returning to the current channel removes only its queued change', () {
    final data = anUpdateChannels(custom: true);
    connection.cache.updateChannels.push(data);
    final timezone = ChangeServerTimezoneJob(timezone: 'UTC');
    connection.changeDraft.add(timezone);
    connection.updateChannels
      ..stageChange(
        ChangeUpdateChannelJob(channelId: 'stable', channelName: 'Stable'),
      )
      ..stageChange(
        ChangeUpdateChannelJob(channelId: 'custom', channelName: 'Custom'),
      );
    expect(connection.changeDraft.value, [timezone]);
  });

  test(
    'refresh retains choices and removes only settings already confirmed',
    () async {
      final draft = connection.changeDraft
        ..add(ChangeSshSettingsJob(enable: false))
        ..add(ChangeServerTimezoneJob(timezone: 'UTC'));
      connection.cache.settings.push(aSystemSettings(ssh: false));
      await pumpEventQueue();
      expect(draft.value.single, isA<ChangeServerTimezoneJob>());
      expect((draft.value.single as ChangeServerTimezoneJob).timezone, 'UTC');
      connection.settings.stageChange(
        ChangeServerTimezoneJob(timezone: 'Europe/Helsinki'),
      );
      expect(draft.value, isEmpty);
    },
  );

  test(
    'fresh registry removes unavailable channel and emits a notice',
    () async {
      final data = anUpdateChannels(custom: true);
      connection.cache.updateChannels.push(data);
      final selected = data.channels.firstWhere(
        (final channel) => channel.id != data.currentChannel.id,
      );
      final draft = connection.changeDraft
        ..add(
          ChangeUpdateChannelJob(
            channelId: selected.id,
            channelName: selected.name,
          ),
        );
      final notice = connection.updateChannels.notices.first;
      connection.cache.updateChannels.push(
        UpdateChannels(
          currentChannel: data.currentChannel,
          channels: [data.currentChannel],
        ),
      );
      expect(await notice, 'server.update_channel.removed');
      expect(draft.value, isEmpty);
    },
  );

  test('offline and failed reads do not remove queued channel', () async {
    final data = anUpdateChannels(custom: true);
    connection.cache.updateChannels.push(data);
    final selected = data.channels.firstWhere(
      (final channel) => channel.id != data.currentChannel.id,
    );
    final draft = connection.changeDraft;
    connection.cache.updateChannels.invalidate();
    draft.add(
      ChangeUpdateChannelJob(
        channelId: selected.id,
        channelName: selected.name,
      ),
    );
    when(api.getUpdateChannels).thenThrow(StateError('offline'));
    await connection.updateChannels.refresh(force: true);
    await pumpEventQueue();
    expect(
      (draft.value.single as ChangeUpdateChannelJob).channelId,
      selected.id,
    );
  });
}
