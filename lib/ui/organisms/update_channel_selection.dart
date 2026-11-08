import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/models/update_channels.dart';
import 'package:selfprivacy/ui/atoms/not_applied_label.dart';
import 'package:selfprivacy/ui/molecules/cards/radio_selection_card.dart';
import 'package:selfprivacy/ui/molecules/cards/status_card.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UpdateChannelSelection extends StatefulWidget {
  const UpdateChannelSelection({
    required this.snapshot,
    required this.onAdd,
    required this.onRefresh,
    this.pendingChannelId,
    this.enabled = true,
    this.applying = false,
    this.onShowOperation,
    super.key,
  });

  final CachedValue<UpdateChannels>? snapshot;
  final void Function(UpdateChannel) onAdd;
  final VoidCallback onRefresh;
  final String? pendingChannelId;
  final bool enabled;
  final bool applying;
  final VoidCallback? onShowOperation;

  @override
  State<UpdateChannelSelection> createState() => _UpdateChannelSelectionState();
}

class _UpdateChannelSelectionState extends State<UpdateChannelSelection> {
  String? _selectedId;
  bool _edited = false;
  bool _confirming = false;

  @override
  void initState() {
    super.initState();
    _updateSelection();
  }

  @override
  void didUpdateWidget(final UpdateChannelSelection oldWidget) {
    super.didUpdateWidget(oldWidget);
    final data = widget.snapshot?.data;
    if (oldWidget.pendingChannelId != null &&
        oldWidget.pendingChannelId != widget.pendingChannelId &&
        _selectedId == oldWidget.pendingChannelId &&
        data != null &&
        (data.currentChannel.id == _selectedId ||
            data.channels.any((final channel) => channel.id == _selectedId))) {
      _edited = false;
    }
    _updateSelection();
  }

  void _updateSelection() {
    final data = widget.snapshot?.data;
    if (data == null) {
      return;
    }
    if (!_edited) {
      _selectedId = widget.pendingChannelId ?? data.currentChannel.id;
      _edited = widget.pendingChannelId != null;
    }
  }

  UpdateChannel? get _selection {
    final snapshot = widget.snapshot;
    if (!widget.enabled || snapshot?.support != DomainSupport.supported) {
      return null;
    }
    final data = snapshot?.data;
    if (data == null ||
        _selectedId == (widget.pendingChannelId ?? data.currentChannel.id)) {
      return null;
    }
    if (_selectedId == data.currentChannel.id) {
      return data.currentChannel;
    }
    return data.channels
        .where((final channel) => channel.id == _selectedId)
        .firstOrNull;
  }

  Future<void> _add() async {
    final selected = _selection;
    if (selected == null || _confirming) {
      return;
    }
    if (widget.snapshot?.data?.currentChannel.id == 'custom' &&
        selected.id != 'custom') {
      setState(() => _confirming = true);
      final confirmed = await showDialog<bool>(
        context: context,
        useRootNavigator: false,
        builder: (final dialogContext) => AlertDialog(
          constraints: const BoxConstraints(maxWidth: 560),
          title: Text(
            'server.update_channel.confirm_switch'.tr(
              namedArgs: {'channel': selected.name},
            ),
          ),
          content: Text('server.update_channel.custom_warning'.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text('basis.cancel'.tr()),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text('service_page.create_job'.tr()),
            ),
          ],
        ),
      );
      if (!mounted) {
        return;
      }
      setState(() => _confirming = false);
      if (confirmed != true) {
        return;
      }
    }
    final currentSelection = _selection;
    if (currentSelection?.id == selected.id) {
      widget.onAdd(currentSelection!);
    }
  }

  @override
  Widget build(final BuildContext context) {
    final snapshot = widget.snapshot;
    final data = snapshot?.data;
    if (snapshot?.support == DomainSupport.unsupported) {
      return StatusCard(
        icon: Icons.info_outline,
        message: 'basis.feature_unsupported'.tr(),
      );
    }
    final error = snapshot?.lastError != null;
    final noAlternatives =
        data != null &&
        !data.channels.any(
          (final channel) => channel.id != data.currentChannel.id,
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!noAlternatives) ...[
          Text('server.update_channel.hint'.tr()),
          const SizedBox(height: 16),
        ],
        if (widget.applying)
          StatusCard(
            icon: Icons.pending_actions_outlined,
            message: 'data_status.applying'.tr(),
            onTap: widget.onShowOperation,
            isNavigation: true,
          ),
        if (data == null && !error)
          Skeletonizer(
            child: Column(
              children: List.generate(
                2,
                (final index) => const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: RadioSelectionCard(
                    isSelected: false,
                    title: 'Update channel',
                    subtitle: 'System updates for your server',
                    onTap: null,
                  ),
                ),
              ),
            ),
          ),
        if (error && data == null)
          StatusCard.loadError(
            title: 'server.update_channel.error'.tr(),
            onRetry: widget.onRefresh,
            retrying: snapshot?.isRefreshing ?? false,
          ),
        if (data != null && (snapshot?.freshness == Freshness.stale || error))
          StatusCard.stale(
            onRefresh: widget.onRefresh,
            refreshing: snapshot?.isRefreshing ?? false,
          ),
        if (widget.pendingChannelId != null)
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: NotAppliedLabel(),
          ),
        if (data != null &&
            _selectedId != data.currentChannel.id &&
            !data.channels.any((final channel) => channel.id == _selectedId))
          StatusCard(
            icon: Icons.warning_amber_outlined,
            message: 'server.update_channel.unavailable'.tr(),
          ),
        for (final channel in [
          if (data != null &&
              !data.channels.any(
                (final channel) => channel.id == data.currentChannel.id,
              ))
            data.currentChannel,
          ...?data?.channels,
        ]) ...[
          RadioSelectionCard(
            isSelected: _selectedId == channel.id,
            title: channel.id == 'custom'
                ? 'server.update_channel.custom'.tr()
                : channel.name,
            subtitle: channel.id == 'custom'
                ? channel.updateUrl
                : channel.description,
            onTap: !widget.enabled
                ? null
                : () => setState(() {
                    _selectedId = channel.id;
                    _edited = true;
                  }),
          ),
        ],
        const SizedBox(height: 24),
        if (noAlternatives)
          InfoBox(text: 'server.update_channel.empty'.tr())
        else
          FilledButton(
            onPressed: _selection == null || _confirming ? null : _add,
            child: Text(
              (widget.pendingChannelId == null
                      ? 'service_page.create_job'
                      : 'service_page.update_job')
                  .tr(),
            ),
          ),
      ],
    );
  }
}
