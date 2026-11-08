import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/server_settings/server_settings_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/section_title.dart';
import 'package:selfprivacy/ui/atoms/not_applied_label.dart';
import 'package:selfprivacy/ui/molecules/cards/status_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ServerSettingsView extends StatelessWidget {
  const ServerSettingsView({
    required this.state,
    required this.onEvent,
    required this.onChannel,
    required this.onTimezone,
    required this.onShowOperation,
    required this.onRefresh,
    super.key,
  });

  final ServerSettingsState state;
  final ValueChanged<ServerSettingsEvent> onEvent;
  final VoidCallback onChannel;
  final VoidCallback onTimezone;
  final VoidCallback onShowOperation;
  final VoidCallback onRefresh;

  @override
  Widget build(final BuildContext context) {
    if (state is ServerSettingsDetached) {
      return Text('basis.no_data'.tr());
    }
    final data = state.settings.data;
    final staleSnapshots = [state.settings, state.channels].where(
      (final snapshot) =>
          snapshot.support != DomainSupport.unsupported &&
          snapshot.data != null &&
          (snapshot.freshness == Freshness.stale || snapshot.lastError != null),
    );
    Widget subtitle(final String text, {required final bool modified}) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(text), if (modified) const NotAppliedLabel()],
        );
    Widget settingsRow(final Widget child) => Skeletonizer(
      enabled:
          data == null &&
          state.settings.lastError == null &&
          state.settings.support != DomainSupport.unsupported,
      child: child,
    );
    Widget toggle({
      required final String title,
      required final String hint,
      required final bool? value,
      required final bool modified,
      required final ValueChanged<bool> onChanged,
      final bool enabled = true,
    }) => settingsRow(
      value == null
          ? ListTile(
              title: Text(title.tr()),
              subtitle: Text(hint.tr()),
              trailing: Text('basis.no_data'.tr()),
              enabled: false,
            )
          : SwitchListTile.adaptive(
              value: value,
              title: Text(title.tr()),
              subtitle: subtitle(hint.tr(), modified: modified),
              onChanged: state.canEditSettings && enabled ? onChanged : null,
            ),
    );
    Widget section(final String key) => SectionTitle(title: key.tr());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (state is ServerSettingsApplying)
          StatusCard(
            icon: Icons.pending_actions_outlined,
            message: 'data_status.applying'.tr(),
            onTap: onShowOperation,
            isNavigation: true,
          ),
        if (staleSnapshots.isNotEmpty)
          StatusCard.stale(
            onRefresh: onRefresh,
            refreshing: staleSnapshots.any(
              (final snapshot) => snapshot.isRefreshing,
            ),
          ),
        _SettingsStatus(
          snapshot: state.settings,
          title: 'server.settings'.tr(),
          errorTitle: 'server.settings_status.load_error'.tr(),
          onRefresh: onRefresh,
        ),
        section('server.settings_sections.updates'),
        if (state.channels.support != DomainSupport.unsupported) ...[
          Skeletonizer(
            enabled:
                state.channels.data == null && state.channels.lastError == null,
            child: ListTile(
              title: Text('server.update_channel.title'.tr()),
              subtitle: subtitle(
                state.channelName ?? 'basis.no_data'.tr(),
                modified: state.pending<ChangeUpdateChannelJob>() != null,
              ),
              trailing: const Icon(Icons.chevron_right),
              enabled: state.canEditChannels,
              onTap: onChannel,
            ),
          ),
          _SettingsStatus(
            snapshot: state.channels,
            title: 'server.update_channel.title'.tr(),
            errorTitle: 'server.update_channel.error'.tr(),
            onRefresh: onRefresh,
          ),
        ],
        toggle(
          title: 'server.allow_autoupgrade',
          hint: 'server.allow_autoupgrade_hint',
          value: state.autoUpgrade,
          modified:
              state.pending<ChangeAutoUpgradeSettingsJob>() != null &&
              state.autoUpgrade != data?.autoUpgradeSettings.enable,
          onChanged: (final value) =>
              onEvent(AutoUpgradeChanged(enabled: value)),
        ),
        toggle(
          title: 'server.reboot_after_upgrade',
          hint: 'server.reboot_after_upgrade_hint',
          value: state.allowReboot,
          enabled: state.autoUpgrade ?? false,
          modified:
              state.pending<ChangeAutoUpgradeSettingsJob>() != null &&
              state.allowReboot != data?.autoUpgradeSettings.allowReboot,
          onChanged: (final value) =>
              onEvent(RebootAfterUpgradeChanged(enabled: value)),
        ),
        section('server.settings_sections.access'),
        toggle(
          title: 'server.enable_ssh',
          hint: 'server.enable_ssh_hint',
          value: state.sshEnabled,
          modified: state.pending<ChangeSshSettingsJob>() != null,
          onChanged: (final value) =>
              onEvent(SshSettingChanged(enabled: value)),
        ),
        section('server.settings_sections.system'),
        settingsRow(
          ListTile(
            title: Text('server.server_timezone'.tr()),
            subtitle: subtitle(
              state.timezone ?? 'basis.no_data'.tr(),
              modified: state.pending<ChangeServerTimezoneJob>() != null,
            ),
            trailing: const Icon(Icons.chevron_right),
            enabled: state.canEditSettings,
            onTap: onTimezone,
          ),
        ),
      ],
    );
  }
}

class _SettingsStatus extends StatelessWidget {
  const _SettingsStatus({
    required this.snapshot,
    required this.title,
    required this.errorTitle,
    required this.onRefresh,
  });
  final CachedValue<Object> snapshot;
  final String title;
  final String errorTitle;
  final VoidCallback onRefresh;

  @override
  Widget build(final BuildContext context) {
    if (snapshot.support == DomainSupport.unsupported) {
      return StatusCard(
        icon: Icons.info_outline,
        title: title,
        message: 'basis.feature_unsupported'.tr(),
      );
    }
    if (snapshot.data == null && snapshot.lastError != null) {
      return StatusCard.loadError(
        title: errorTitle,
        onRetry: onRefresh,
        retrying: snapshot.isRefreshing,
      );
    }
    return const SizedBox.shrink();
  }
}
