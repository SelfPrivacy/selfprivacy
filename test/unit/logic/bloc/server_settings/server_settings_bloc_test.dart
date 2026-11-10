import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/bloc/server_settings/server_settings_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/credential_policy.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

import '../../../../helpers/fixtures/system_settings_fixtures.dart';
import '../../../../helpers/fixtures/telemetry_fixtures.dart';
import '../../../../helpers/fixtures/update_channels_fixtures.dart';
import '../../../../helpers/widget_harness.dart';

class _Api extends Mock implements ServerApi {}

void main() {
  setUpAll(setUpWidgetTestHarness);

  test(
    'telemetry queues locally, survives refresh, and follows draft removal',
    () async {
      final connection = ServerConnection(
        api: _Api(),
        serverId: 'server',
        isAttached: () => true,
      )..cache.setVersion(Version(3, 9, 0));
      connection.cache.telemetry.push(aTelemetrySettings());
      final bloc = ServerSettingsBloc(
        connection: connection,
        showMessage: (_) {},
      );
      addTearDown(() async {
        await bloc.close();
        connection.dispose();
      });
      expect(bloc.state.canEditTelemetry, true);
      final update = aTelemetryUpdate();
      bloc.add(TelemetrySettingsSelected(update));
      await pumpEventQueue();
      expect(
        bloc.state.pending<ChangeTelemetrySettingsJob>()!.settings,
        update,
      );
      expect(bloc.state.telemetry.data!.enable, false);
      connection.cache.telemetry.push(aTelemetrySettings());
      await pumpEventQueue();
      expect(
        bloc.state.pending<ChangeTelemetrySettingsJob>()!.settings,
        update,
      );
      connection.changeDraft.remove(connection.changeDraft.value.single.id);
      await pumpEventQueue();
      expect(bloc.state.pending<ChangeTelemetrySettingsJob>(), isNull);
      expect(bloc.state.telemetry.data!.enable, false);
    },
  );

  test(
    'policy draft survives refresh and resets when removed from the queue',
    () async {
      final connection = ServerConnection(
        api: _Api(),
        serverId: 'server',
        isAttached: () => true,
      )..cache.setVersion(Version(3, 9, 0));
      connection.cache.credentialPolicy.push(CredentialPolicy.any);
      final bloc = ServerSettingsBloc(
        connection: connection,
        showMessage: (_) {},
      );
      addTearDown(() async {
        await bloc.close();
        connection.dispose();
      });
      expect(bloc.state.canEditPolicy, true);
      expect(bloc.state.canEditSettings, false);
      bloc.add(const CredentialPolicySelected(CredentialPolicy.mfa));
      await pumpEventQueue();
      expect(bloc.state.credentialPolicy, CredentialPolicy.mfa);
      expect(bloc.state.policy.data, CredentialPolicy.any);
      connection.cache.credentialPolicy.push(CredentialPolicy.any);
      await pumpEventQueue();
      expect(bloc.state.credentialPolicy, CredentialPolicy.mfa);
      connection.changeDraft.remove(connection.changeDraft.value.single.id);
      await pumpEventQueue();
      expect(bloc.state.credentialPolicy, CredentialPolicy.any);
    },
  );

  test(
    'an applying or detached connection cannot queue a policy change',
    () async {
      final connection = ServerConnection(
        api: _Api(),
        serverId: 'server',
        isAttached: () => true,
      )..cache.setVersion(Version(3, 9, 0));
      connection.cache.credentialPolicy.push(CredentialPolicy.any);
      final bloc = ServerSettingsBloc(
        connection: connection,
        showMessage: (_) {},
      );
      addTearDown(() async {
        await bloc.close();
        connection.dispose();
      });
      final wait = Completer<void>();
      final handle = connection.submit<void>(
        OperationKind.applyChanges,
        (_) => wait.future,
      );
      await pumpEventQueue();
      expect(bloc.state, isA<ServerSettingsApplying>());
      bloc.add(const CredentialPolicySelected(CredentialPolicy.mfa));
      await pumpEventQueue();
      expect(connection.changeDraft.value, isEmpty);
      wait.complete();
      await handle.result;
      connection.dispose();
      await pumpEventQueue();
      bloc.add(const CredentialPolicySelected(CredentialPolicy.mfa));
      await pumpEventQueue();
      expect(bloc.state, isA<ServerSettingsDetached>());
      expect(connection.changeDraft.value, isEmpty);
    },
  );

  test(
    'settings observe queue removal and retain confirmed SSH separately',
    () async {
      final connection = ServerConnection(
        api: _Api(),
        serverId: 'server',
        isAttached: () => true,
      )..cache.setVersion(Version(3, 9, 0));
      connection.cache.settings.push(aSystemSettings());
      final bloc = ServerSettingsBloc(
        connection: connection,
        showMessage: (_) {},
      );
      addTearDown(() async {
        await bloc.close();
        connection.dispose();
      });
      bloc.add(const SshSettingChanged(enabled: false));
      await pumpEventQueue();
      expect(bloc.state.sshEnabled, false);
      expect(bloc.state.settings.data!.sshSettings.enable, true);
      final job = connection.changeDraft.value.single as ChangeSshSettingsJob;
      connection.changeDraft.remove(job.id);
      await pumpEventQueue();
      expect(bloc.state.sshEnabled, true);
    },
  );

  test(
    'auto-upgrade edits compose without overwriting the other choice',
    () async {
      final connection = ServerConnection(
        api: _Api(),
        serverId: 'server',
        isAttached: () => true,
      )..cache.setVersion(Version(3, 9, 0));
      connection.cache.settings.push(aSystemSettings());
      final bloc = ServerSettingsBloc(
        connection: connection,
        showMessage: (_) {},
      );
      addTearDown(() async {
        await bloc.close();
        connection.dispose();
      });
      bloc
        ..add(const AutoUpgradeChanged(enabled: false))
        ..add(const RebootAfterUpgradeChanged(enabled: true));
      await pumpEventQueue();
      final draft =
          connection.changeDraft.value.single as ChangeAutoUpgradeSettingsJob;
      expect(draft.enable, false);
      expect(draft.allowReboot, true);
    },
  );

  test(
    'stale settings remain editable but an active server job blocks edits',
    () async {
      final connection = ServerConnection(
        api: _Api(),
        serverId: 'server',
        isAttached: () => true,
      )..cache.setVersion(Version(3, 9, 0));
      connection.cache.settings.push(aSystemSettings());
      connection.cache.settings.invalidate();
      final bloc = ServerSettingsBloc(
        connection: connection,
        showMessage: (_) {},
      );
      addTearDown(() async {
        await bloc.close();
        connection.dispose();
      });
      expect(bloc.state.canEditSettings, true);
      expect(bloc.state, isA<ServerSettingsReady>());
      final handle = connection.submit<void>(
        OperationKind.applyChanges,
        (_) async {},
        describe: (_) =>
            OperationReport(OperationStatus.succeeded, jobIds: {'rebuild-1'}),
      );
      await handle.result;
      await pumpEventQueue();
      expect(bloc.state, isA<ServerSettingsApplying>());
      bloc.add(const SshSettingChanged(enabled: false));
      await pumpEventQueue();
      expect(connection.changeDraft.value, isEmpty);
      connection.operations.observeJob('rebuild-1', succeeded: true);
      await pumpEventQueue();
      expect(bloc.state.canEditSettings, true);
      expect(bloc.state, isA<ServerSettingsReady>());
    },
  );

  test(
    'missing settings do not block an independently loaded channel',
    () async {
      final connection = ServerConnection(
        api: _Api(),
        serverId: 'server',
        isAttached: () => true,
      )..cache.setVersion(Version(3, 9, 0));
      final bloc = ServerSettingsBloc(
        connection: connection,
        showMessage: (_) {},
      );
      addTearDown(() async {
        await bloc.close();
        connection.dispose();
      });
      expect(bloc.state, isA<ServerSettingsLoading>());
      expect(bloc.state.canEditChannels, false);
      connection.cache.updateChannels.push(anUpdateChannels(custom: true));
      await pumpEventQueue();
      expect(bloc.state, isA<ServerSettingsReady>());
      expect(bloc.state.canEditSettings, false);
      expect(bloc.state.canEditChannels, true);
      bloc.add(UpdateChannelSelected(anUpdateChannels().currentChannel));
      await pumpEventQueue();
      expect(
        connection.changeDraft.value.single,
        isA<ChangeUpdateChannelJob>(),
      );
    },
  );

  test('unavailable settings recover when one domain loads', () async {
    final api = _Api();
    when(
      api.getSystemSettings,
    ).thenAnswer((_) async => throw StateError('offline'));
    when(
      api.getUpdateChannels,
    ).thenAnswer((_) async => throw StateError('offline'));
    when(
      api.getCredentialPolicy,
    ).thenAnswer((_) async => throw StateError('offline'));
    when(
      api.getTelemetrySettings,
    ).thenAnswer((_) async => throw StateError('offline'));
    final connection = ServerConnection(
      api: api,
      serverId: 'server',
      isAttached: () => true,
    )..cache.setVersion(Version(3, 9, 0));
    final bloc = ServerSettingsBloc(
      connection: connection,
      showMessage: (_) {},
    );
    addTearDown(() async {
      await bloc.close();
      connection.dispose();
    });
    expect(bloc.state, isA<ServerSettingsLoading>());
    await Future.wait([
      connection.cache.settings.refresh(),
      connection.cache.updateChannels.refresh(),
      connection.cache.credentialPolicy.refresh(),
      connection.cache.telemetry.refresh(),
    ]);
    await pumpEventQueue();
    expect(bloc.state, isA<ServerSettingsUnavailable>());
    expect(bloc.state.canEditSettings, false);
    expect(bloc.state.canEditChannels, false);
    final retry = Completer<void>();
    when(api.getSystemSettings).thenAnswer((_) async {
      await retry.future;
      return aSystemSettings();
    });
    final reading = connection.cache.settings.refresh(force: true);
    await pumpEventQueue();
    expect(bloc.state, isA<ServerSettingsUnavailable>());
    expect(bloc.state.settings.isRefreshing, true);
    retry.complete();
    await reading;
    await pumpEventQueue();
    expect(bloc.state, isA<ServerSettingsReady>());
    expect(bloc.state.canEditSettings, true);
    expect(bloc.state.canEditChannels, false);
  });

  test('background refresh failure keeps cached settings editable', () async {
    final api = _Api();
    final read = Completer<void>();
    when(api.getSystemSettings).thenAnswer((_) async {
      await read.future;
      throw StateError('offline');
    });
    final connection = ServerConnection(
      api: api,
      serverId: 'server',
      isAttached: () => true,
    )..cache.setVersion(Version(3, 9, 0));
    connection.cache.settings.push(aSystemSettings());
    final bloc = ServerSettingsBloc(
      connection: connection,
      showMessage: (_) {},
    );
    addTearDown(() async {
      await bloc.close();
      connection.dispose();
    });
    final reading = connection.cache.settings.refresh(force: true);
    await pumpEventQueue();
    expect(bloc.state, isA<ServerSettingsReady>());
    expect(bloc.state.settings.isRefreshing, true);
    expect(bloc.state.canEditSettings, true);
    read.complete();
    await reading;
    await pumpEventQueue();
    expect(bloc.state, isA<ServerSettingsReady>());
    expect(bloc.state.settings.lastError, isA<StateError>());
    bloc.add(const SshSettingChanged(enabled: false));
    await pumpEventQueue();
    expect(bloc.state.sshEnabled, false);
    expect(connection.changeDraft.value, hasLength(1));
  });

  test('applying before data loads settles back into loading', () async {
    final connection = ServerConnection(
      api: _Api(),
      serverId: 'server',
      isAttached: () => true,
    )..cache.setVersion(Version(3, 9, 0));
    final handle = connection.submit<void>(
      OperationKind.applyChanges,
      (_) async {},
      describe: (_) =>
          OperationReport(OperationStatus.succeeded, jobIds: {'rebuild-1'}),
    );
    await handle.result;
    final bloc = ServerSettingsBloc(
      connection: connection,
      showMessage: (_) {},
    );
    addTearDown(() async {
      await bloc.close();
      connection.dispose();
    });
    expect(bloc.state, isA<ServerSettingsApplying>());
    expect(bloc.state.canEditSettings, false);
    connection.operations.observeJob('rebuild-1', succeeded: true);
    await pumpEventQueue();
    expect(bloc.state, isA<ServerSettingsLoading>());
  });

  test(
    'detachment takes priority over applying and blocks queued edits',
    () async {
      final connection = ServerConnection(
        api: _Api(),
        serverId: 'server',
        isAttached: () => true,
      )..cache.setVersion(Version(3, 9, 0));
      connection.cache.settings.push(aSystemSettings());
      final bloc = ServerSettingsBloc(
        connection: connection,
        showMessage: (_) {},
      );
      addTearDown(() async {
        await bloc.close();
        connection.dispose();
      });
      final handle = connection.submit<void>(
        OperationKind.applyChanges,
        (_) async {},
        describe: (_) =>
            OperationReport(OperationStatus.succeeded, jobIds: {'rebuild-1'}),
      );
      await handle.result;
      await pumpEventQueue();
      expect(bloc.state, isA<ServerSettingsApplying>());
      connection.dispose();
      await pumpEventQueue();
      expect(bloc.state, isA<ServerSettingsDetached>());
      expect(bloc.state.canEditSettings, false);
      expect(bloc.state.canEditChannels, false);
      bloc.add(const SshSettingChanged(enabled: false));
      await pumpEventQueue();
      expect(bloc.state, isA<ServerSettingsDetached>());
    },
  );

  test('unsupported domains are unavailable rather than loading forever', () {
    final connection = ServerConnection(
      api: _Api(),
      serverId: 'server',
      isAttached: () => true,
    )..cache.setVersion(Version(2, 2, 0));
    final bloc = ServerSettingsBloc(
      connection: connection,
      showMessage: (_) {},
    );
    addTearDown(() async {
      await bloc.close();
      connection.dispose();
    });
    expect(bloc.state, isA<ServerSettingsUnavailable>());
    expect(bloc.state.settings.support, DomainSupport.unsupported);
    expect(bloc.state.canEditSettings, false);
  });
}
