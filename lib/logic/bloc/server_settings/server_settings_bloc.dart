import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/credential_policy.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';
import 'package:selfprivacy/logic/models/update_channels.dart';

part 'server_settings_event.dart';
part 'server_settings_state.dart';

class ServerSettingsBloc
    extends Bloc<ServerSettingsEvent, ServerSettingsState> {
  ServerSettingsBloc({
    required final ServerConnection connection,
    required final void Function(String) showMessage,
  }) : _connection = connection,
       _showMessage = showMessage,
       super(ServerSettingsState.fromConnection(connection)) {
    on<ServerSettingsEvent>(_handle, transformer: sequential());
    _subscriptions.addAll([
      connection.changes
          .where((_) => !connection.isAttached)
          .listen((_) => add(const _SettingsObserved())),
      connection.settings.changes.listen((_) => add(const _SettingsObserved())),
      connection.updateChannels.changes.listen(
        (_) => add(const _SettingsObserved()),
      ),
      connection.credentialPolicy.changes.listen(
        (_) => add(const _SettingsObserved()),
      ),
      connection.changeDraft.changes.listen(
        (_) => add(const _SettingsObserved()),
      ),
      connection.operations.changes.listen(
        (_) => add(const _SettingsObserved()),
      ),
      connection.updateChannels.notices.listen(
        (final key) => _showMessage(key.tr()),
      ),
    ]);
  }

  final ServerConnection _connection;
  final void Function(String) _showMessage;
  final _subscriptions = <StreamSubscription<Object?>>[];

  void _handle(
    final ServerSettingsEvent event,
    final Emitter<ServerSettingsState> emit,
  ) {
    final current = ServerSettingsState.fromConnection(_connection);
    final JobDraft? change = switch (event) {
      SshSettingChanged(:final enabled) when current.canEditSettings =>
        ChangeSshSettingsJob(enable: enabled),
      AutoUpgradeChanged(:final enabled) when current.canEditSettings =>
        ChangeAutoUpgradeSettingsJob(
          enable: enabled,
          allowReboot: current.allowReboot!,
        ),
      RebootAfterUpgradeChanged(:final enabled) when current.canEditSettings =>
        ChangeAutoUpgradeSettingsJob(
          enable: current.autoUpgrade!,
          allowReboot: enabled,
        ),
      TimezoneSelected(:final timezone) when current.canEditSettings =>
        ChangeServerTimezoneJob(timezone: timezone),
      UpdateChannelSelected(:final channel) when current.canEditChannels =>
        ChangeUpdateChannelJob(
          channelId: channel.id,
          channelName: channel.name,
        ),
      CredentialPolicySelected(:final policy) when current.canEditPolicy =>
        ChangeCredentialPolicyJob(policy: policy),
      _ => null,
    };
    final staged = switch (change) {
      ServerSettingsJob() => _connection.settings.stageChange(change),
      ChangeUpdateChannelJob() => _connection.updateChannels.stageChange(
        change,
      ),
      ChangeCredentialPolicyJob() => _connection.credentialPolicy.stageChange(
        change,
      ),
      _ => false,
    };
    if (staged) {
      _showMessage(
        (_connection.changeDraft.value.contains(change)
                ? 'jobs.job_added'
                : 'jobs.job_removed')
            .tr(),
      );
    }
    emit(ServerSettingsState.fromConnection(_connection));
  }

  Future<void> refresh() async {
    if (!_connection.isAttached || isClosed) {
      return;
    }
    await Future.wait([
      _connection.settings.refresh(force: true),
      _connection.updateChannels.refresh(force: true),
      _connection.credentialPolicy.refresh(force: true),
    ]);
  }

  @override
  Future<void> close() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    return super.close();
  }
}
