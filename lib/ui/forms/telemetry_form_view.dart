import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/forms/telemetry_form.dart';
import 'package:selfprivacy/logic/models/telemetry_settings.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/section_title.dart';
import 'package:selfprivacy/ui/atoms/not_applied_label.dart';
import 'package:selfprivacy/ui/molecules/cards/status_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TelemetryFormView extends StatefulWidget {
  const TelemetryFormView({
    required this.form,
    required this.snapshot,
    required this.onAdd,
    required this.onRefresh,
    this.pending = false,
    this.enabled = true,
    this.applying = false,
    this.onShowOperation,
    super.key,
  });
  final TelemetryForm? form;
  final CachedValue<TelemetrySettings> snapshot;
  final ValueChanged<TelemetryUpdate> onAdd;
  final VoidCallback onRefresh;
  final bool pending;
  final bool enabled;
  final bool applying;
  final VoidCallback? onShowOperation;

  @override
  State<TelemetryFormView> createState() => _TelemetryFormViewState();
}

class _TelemetryFormViewState extends State<TelemetryFormView> {
  bool get _editable => widget.enabled && !widget.applying;

  @override
  void initState() {
    super.initState();
    widget.form?.setEditable(editable: _editable);
  }

  @override
  void didUpdateWidget(final TelemetryFormView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.form != widget.form ||
        oldWidget.enabled != widget.enabled ||
        oldWidget.applying != widget.applying) {
      widget.form?.setEditable(editable: _editable);
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('server.telemetry.hint'.tr()),
        const SizedBox(height: 16),
        if (widget.applying)
          StatusCard(
            icon: Icons.pending_actions_outlined,
            message: 'data_status.applying'.tr(),
            onTap: widget.onShowOperation,
            isNavigation: true,
          ),
        if (snapshot.data != null &&
            (snapshot.freshness == Freshness.stale ||
                snapshot.lastError != null))
          StatusCard.stale(
            onRefresh: widget.onRefresh,
            refreshing: snapshot.isRefreshing,
          ),
        if (snapshot.data == null && snapshot.lastError != null)
          StatusCard.loadError(
            title: 'server.telemetry.error'.tr(),
            onRetry: widget.onRefresh,
            retrying: snapshot.isRefreshing,
          ),
        if (widget.pending)
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: NotAppliedLabel(),
          ),
        if (widget.form case final form?)
          ReactiveForm(
            key: ObjectKey(form),
            formGroup: form.form,
            child: ReactiveFormConsumer(
              builder: (final context, final group, final child) =>
                  _fields(context, form),
            ),
          )
        else if (snapshot.lastError == null)
          Skeletonizer(
            child: Column(
              children: [
                for (final key in ['enable', 'endpoint', 'logs', 'metrics'])
                  ListTile(
                    title: Text('server.telemetry.fields.$key'.tr()),
                    subtitle: Text('basis.loading'.tr()),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _error(
    final TelemetryForm form,
    final String error,
    final String key,
  ) => form.form.hasError(error)
      ? Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            key.tr(),
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        )
      : const SizedBox.shrink();

  Widget _fields(final BuildContext context, final TelemetryForm form) {
    final dependent = _editable && form.form.control('enable').value == true;
    final theme = Theme.of(context);
    final warningColor = theme.colorScheme.onTertiaryContainer;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ReactiveSwitchListTile.adaptive(
          formControlName: 'enable',
          title: Text('server.telemetry.fields.enable'.tr()),
        ),
        FilledCard(
          tertiary: true,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber_outlined, color: warningColor),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'server.telemetry.warning.title'.tr(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: warningColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'server.telemetry.warning.description'.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SectionTitle(title: 'server.telemetry.sections.data'.tr()),
        ListTile(
          leading: const Icon(Icons.account_tree_outlined),
          title: Text('server.telemetry.fields.api_traces'.tr()),
          subtitle: Text('server.telemetry.fields.api_traces_description'.tr()),
          enabled: dependent,
          trailing: Switch.adaptive(
            value: form.form.control('enable').value == true,
            onChanged: null,
          ),
        ),
        ReactiveSwitchListTile.adaptive(
          formControlName: 'logs',
          secondary: const Icon(Icons.article_outlined),
          title: Text('server.telemetry.fields.logs'.tr()),
          subtitle: Text('server.telemetry.fields.logs_description'.tr()),
        ),
        ReactiveSwitchListTile.adaptive(
          formControlName: 'metrics',
          secondary: const Icon(Icons.analytics_outlined),
          title: Text('server.telemetry.fields.metrics'.tr()),
          subtitle: Text('server.telemetry.fields.metrics_description'.tr()),
        ),
        ListTile(
          leading: const Icon(Icons.memory_outlined),
          title: Text('server.telemetry.fields.memory_tracing'.tr()),
          enabled: dependent,
          trailing: Switch.adaptive(
            value: widget.snapshot.data?.memoryTracingEnabled ?? false,
            onChanged: null,
          ),
          subtitle: Text(
            'server.telemetry.fields.memory_tracing_description'.tr(),
          ),
        ),
        SectionTitle(title: 'server.telemetry.sections.connection'.tr()),
        const SizedBox(height: 16),
        ReactiveTextField<String>(
          formControlName: 'endpoint',
          autocorrect: false,
          enableSuggestions: false,
          keyboardType: TextInputType.url,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'server.telemetry.fields.endpoint'.tr(),
            helperText: 'server.telemetry.fields.endpoint_hint'.tr(),
            helperMaxLines: 3,
          ),
        ),
        _error(
          form,
          TelemetryForm.invalidEndpoint,
          'server.telemetry.validation.invalid_endpoint',
        ),
        const SizedBox(height: 16),
        for (var index = 0; index < form.headers.length; index++)
          _header(form, index, dependent),
        _error(
          form,
          TelemetryForm.invalidHeaderName,
          'server.telemetry.validation.invalid_header_name',
        ),
        _error(
          form,
          TelemetryForm.invalidHeaderValue,
          'server.telemetry.validation.invalid_header_value',
        ),
        OutlinedButton.icon(
          onPressed: dependent ? () => setState(form.addHeader) : null,
          icon: const Icon(Icons.add),
          label: Text('server.telemetry.headers.add'.tr()),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: _editable && form.form.valid && form.hasChanges
              ? () => widget.onAdd(form.value)
              : null,
          child: Text(
            (widget.pending
                    ? 'service_page.update_job'
                    : 'service_page.create_job')
                .tr(),
          ),
        ),
      ],
    );
  }

  Widget _header(
    final TelemetryForm form,
    final int index,
    final bool enabled,
  ) {
    final header = form.headers[index];
    final existing = header.control('existing').value == true;
    final removed = header.control('removed').value == true;
    return ReactiveForm(
      key: ObjectKey(header),
      formGroup: header,
      child: FilledCard(
        mergeSemantics: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: existing
                        ? Text(
                            header.control('name').value as String,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: enabled && !removed
                                      ? null
                                      : Theme.of(context).disabledColor,
                                  decoration: removed
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                          )
                        : ReactiveTextField<String>(
                            formControlName: 'name',
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'server.telemetry.headers.name'.tr(),
                            ),
                          ),
                  ),
                  IconButton(
                    onPressed: enabled
                        ? () => setState(
                            () => removed
                                ? form.restoreHeader(index)
                                : form.removeHeader(index),
                          )
                        : null,
                    tooltip:
                        (removed
                                ? 'server.telemetry.headers.undo_remove'
                                : 'server.telemetry.headers.remove')
                            .tr(),
                    icon: Icon(
                      removed
                          ? Icons.undo
                          : existing
                          ? Icons.delete_outline
                          : Icons.close,
                    ),
                  ),
                ],
              ),
              if (removed)
                Text('server.telemetry.headers.pending_removal'.tr())
              else ...[
                const SizedBox(height: 16),
                ReactiveTextField<String>(
                  formControlName: 'value',
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'server.telemetry.headers.value'.tr(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: existing
                        ? 'server.telemetry.headers.keep'.tr()
                        : null,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
