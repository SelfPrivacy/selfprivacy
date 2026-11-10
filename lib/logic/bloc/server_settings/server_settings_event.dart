part of 'server_settings_bloc.dart';

sealed class ServerSettingsEvent {
  const ServerSettingsEvent();
}

class _SettingsObserved extends ServerSettingsEvent {
  const _SettingsObserved();
}

class SshSettingChanged extends ServerSettingsEvent {
  const SshSettingChanged({required this.enabled});
  final bool enabled;
}

class AutoUpgradeChanged extends ServerSettingsEvent {
  const AutoUpgradeChanged({required this.enabled});
  final bool enabled;
}

class RebootAfterUpgradeChanged extends ServerSettingsEvent {
  const RebootAfterUpgradeChanged({required this.enabled});
  final bool enabled;
}

class TimezoneSelected extends ServerSettingsEvent {
  const TimezoneSelected(this.timezone);
  final String timezone;
}

class UpdateChannelSelected extends ServerSettingsEvent {
  const UpdateChannelSelected(this.channel);
  final UpdateChannel channel;
}

class CredentialPolicySelected extends ServerSettingsEvent {
  const CredentialPolicySelected(this.policy);
  final CredentialPolicy policy;
}
