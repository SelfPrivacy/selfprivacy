import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/models/credential_policy.dart';
import 'package:selfprivacy/ui/atoms/not_applied_label.dart';
import 'package:selfprivacy/ui/molecules/cards/radio_selection_card.dart';
import 'package:selfprivacy/ui/molecules/cards/status_card.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CredentialPolicySelection extends StatefulWidget {
  const CredentialPolicySelection({
    required this.snapshot,
    required this.onAdd,
    required this.onRefresh,
    this.pendingPolicy,
    this.enabled = true,
    this.applying = false,
    this.onShowOperation,
    super.key,
  });

  final CachedValue<CredentialPolicy> snapshot;
  final ValueChanged<CredentialPolicy> onAdd;
  final VoidCallback onRefresh;
  final CredentialPolicy? pendingPolicy;
  final bool enabled;
  final bool applying;
  final VoidCallback? onShowOperation;

  @override
  State<CredentialPolicySelection> createState() =>
      _CredentialPolicySelectionState();
}

class _CredentialPolicySelectionState extends State<CredentialPolicySelection> {
  CredentialPolicy? _selected;

  CredentialPolicy? get _selection {
    final selected = _selected ?? widget.pendingPolicy ?? widget.snapshot.data;
    return selected == CredentialPolicy.attestedPasskey &&
            widget.snapshot.data != CredentialPolicy.attestedPasskey
        ? widget.snapshot.data
        : selected;
  }

  String get _actionKey => widget.pendingPolicy == null
      ? 'service_page.create_job'
      : 'service_page.update_job';
  bool get _canQueue =>
      widget.enabled &&
      widget.snapshot.support == DomainSupport.supported &&
      widget.snapshot.data != null &&
      _selection != null &&
      _selection != CredentialPolicy.unknown &&
      _selection != (widget.pendingPolicy ?? widget.snapshot.data);

  @override
  void didUpdateWidget(final CredentialPolicySelection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pendingPolicy != widget.pendingPolicy &&
        _selected == oldWidget.pendingPolicy) {
      _selected = null;
    }
  }

  void _queue() {
    if (_canQueue) {
      widget.onAdd(_selection!);
    }
  }

  @override
  Widget build(final BuildContext context) {
    final snapshot = widget.snapshot;
    if (snapshot.support == DomainSupport.unsupported) {
      return StatusCard(
        icon: Icons.info_outline,
        message: 'basis.feature_unsupported'.tr(),
      );
    }
    final current = snapshot.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('server.credential_policy.hint'.tr()),
        const SizedBox(height: 16),
        if (widget.applying)
          StatusCard(
            icon: Icons.pending_actions_outlined,
            message: 'data_status.applying'.tr(),
            onTap: widget.onShowOperation,
            isNavigation: true,
          ),
        if (current != null &&
            (snapshot.freshness == Freshness.stale ||
                snapshot.lastError != null))
          StatusCard.stale(
            onRefresh: widget.onRefresh,
            refreshing: snapshot.isRefreshing,
          ),
        if (current == null && snapshot.lastError != null)
          StatusCard.loadError(
            title: 'server.credential_policy.error'.tr(),
            onRetry: widget.onRefresh,
            retrying: snapshot.isRefreshing,
          ),
        if (current == CredentialPolicy.unknown)
          StatusCard(
            icon: Icons.info_outline,
            title: 'server.credential_policy.unknown'.tr(),
            message: 'server.credential_policy.unknown_hint'.tr(),
          ),
        if (widget.pendingPolicy != null)
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: NotAppliedLabel(),
          ),
        if (current != null || snapshot.lastError == null)
          Skeletonizer(
            enabled: current == null,
            child: Column(
              children: [
                for (final policy in CredentialPolicy.values.where(
                  (final value) =>
                      value != CredentialPolicy.unknown &&
                      (value != CredentialPolicy.attestedPasskey ||
                          current == CredentialPolicy.attestedPasskey),
                ))
                  RadioSelectionCard(
                    title: policy.translationKey.tr(),
                    subtitle: '${policy.translationKey}_hint'.tr(),
                    isSelected: _selection == policy,
                    onTap: widget.enabled && current != null
                        ? () => setState(() => _selected = policy)
                        : null,
                  ),
              ],
            ),
          ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: _canQueue ? _queue : null,
          child: Text(_actionKey.tr()),
        ),
        const SizedBox(height: 24),
        InfoBox(text: 'server.credential_policy.warning'.tr(), isWarning: true),
      ],
    );
  }
}
