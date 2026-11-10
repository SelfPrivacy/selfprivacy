part of 'server_settings_bloc.dart';

sealed class ServerSettingsState extends Equatable {
  ServerSettingsState({
    this.settings = const CachedValue(),
    this.channels = const CachedValue(),
    this.policy = const CachedValue(),
    final List<JobDraft> draft = const [],
  }) : draft = List.unmodifiable(draft);

  factory ServerSettingsState.fromConnection(
    final ServerConnection connection,
  ) {
    if (!connection.isAttached) {
      return ServerSettingsDetached();
    }
    final settings = connection.settings.value;
    final channels = connection.updateChannels.value;
    final policy = connection.credentialPolicy.value;
    final draft = connection.changeDraft.value;
    if (connection.operations.hasPendingConfiguration) {
      return ServerSettingsApplying(
        settings: settings,
        channels: channels,
        policy: policy,
        draft: draft,
      );
    }
    final snapshots = <CachedValue<Object>>[settings, channels, policy];
    if (snapshots.any(
      (final snapshot) =>
          snapshot.support == DomainSupport.supported && snapshot.data != null,
    )) {
      return ServerSettingsReady(
        settings: settings,
        channels: channels,
        policy: policy,
        draft: draft,
      );
    }
    if (snapshots.any(
      (final snapshot) =>
          snapshot.support != DomainSupport.unsupported &&
          snapshot.lastError == null,
    )) {
      return ServerSettingsLoading(
        settings: settings,
        channels: channels,
        policy: policy,
        draft: draft,
      );
    }
    return ServerSettingsUnavailable(
      settings: settings,
      channels: channels,
      policy: policy,
      draft: draft,
    );
  }

  final CachedValue<SystemSettings> settings;
  final CachedValue<UpdateChannels> channels;
  final CachedValue<CredentialPolicy> policy;
  final List<JobDraft> draft;

  bool get canEditSettings =>
      this is ServerSettingsReady &&
      settings.support == DomainSupport.supported &&
      settings.data != null;
  bool get canEditChannels =>
      this is ServerSettingsReady &&
      channels.support == DomainSupport.supported &&
      channels.data != null;
  bool get canEditPolicy =>
      this is ServerSettingsReady &&
      policy.support == DomainSupport.supported &&
      policy.data != null;
  CredentialPolicy? get credentialPolicy =>
      pending<ChangeCredentialPolicyJob>()?.policy ?? policy.data;
  T? pending<T extends JobDraft>() => draft.whereType<T>().firstOrNull;
  bool? get sshEnabled =>
      pending<ChangeSshSettingsJob>()?.enable ??
      settings.data?.sshSettings.enable;
  bool? get autoUpgrade =>
      pending<ChangeAutoUpgradeSettingsJob>()?.enable ??
      settings.data?.autoUpgradeSettings.enable;
  bool? get allowReboot =>
      pending<ChangeAutoUpgradeSettingsJob>()?.allowReboot ??
      settings.data?.autoUpgradeSettings.allowReboot;
  String? get timezone =>
      pending<ChangeServerTimezoneJob>()?.timezone ?? settings.data?.timezone;
  String? get channelName =>
      pending<ChangeUpdateChannelJob>()?.channelName ??
      channels.data?.currentChannel.name;

  @override
  List<Object?> get props => [settings, channels, policy, draft];
}

final class ServerSettingsLoading extends ServerSettingsState {
  ServerSettingsLoading({
    required super.settings,
    required super.channels,
    super.policy,
    super.draft,
  });
}

final class ServerSettingsReady extends ServerSettingsState {
  ServerSettingsReady({
    required super.settings,
    required super.channels,
    super.policy,
    super.draft,
  });
}

final class ServerSettingsApplying extends ServerSettingsState {
  ServerSettingsApplying({
    required super.settings,
    required super.channels,
    super.policy,
    super.draft,
  });
}

final class ServerSettingsUnavailable extends ServerSettingsState {
  ServerSettingsUnavailable({
    required super.settings,
    required super.channels,
    super.policy,
    super.draft,
  });
}

final class ServerSettingsDetached extends ServerSettingsState {
  ServerSettingsDetached();
}
