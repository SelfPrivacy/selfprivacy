import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/forms/telemetry_form.dart';
import 'package:selfprivacy/ui/forms/telemetry_form_view.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../../../test/helpers/fixtures/telemetry_fixtures.dart';
import '../../catalog_case.dart';
import '../../form_preview.dart';

@UseCase(name: 'Disabled', type: TelemetryFormView, path: '[Forms]')
Widget telemetryDisabled(final BuildContext context) => _example('Disabled');

@UseCase(name: 'Enabled', type: TelemetryFormView, path: '[Forms]')
Widget telemetryEnabled(final BuildContext context) => _example('Enabled');

@UseCase(name: 'No headers', type: TelemetryFormView, path: '[Forms]')
Widget telemetryNoHeaders(final BuildContext context) => _example('No headers');

@UseCase(name: 'Memory tracing', type: TelemetryFormView, path: '[Forms]')
Widget telemetryMemoryTracing(final BuildContext context) =>
    _example('Memory tracing');

@UseCase(name: 'Invalid endpoint', type: TelemetryFormView, path: '[Forms]')
Widget telemetryInvalidEndpoint(final BuildContext context) =>
    _example('Invalid endpoint');

@UseCase(name: 'Header replacement', type: TelemetryFormView, path: '[Forms]')
Widget telemetryHeaderreplacement(final BuildContext context) =>
    _example('Header replacement');

@UseCase(name: 'Header removal', type: TelemetryFormView, path: '[Forms]')
Widget telemetryHeaderRemoval(final BuildContext context) =>
    _example('Header removal');

@UseCase(name: 'Queued', type: TelemetryFormView, path: '[Forms]')
Widget telemetryQueued(final BuildContext context) => _example('Queued');

@UseCase(name: 'Applying', type: TelemetryFormView, path: '[Forms]')
Widget telemetryApplying(final BuildContext context) => _example('Applying');

@UseCase(name: 'Loading', type: TelemetryFormView, path: '[Forms]')
Widget telemetryLoading(final BuildContext context) => _example('Loading');

@UseCase(name: 'Error', type: TelemetryFormView, path: '[Forms]')
Widget telemetryError(final BuildContext context) => _example('Error');

@UseCase(name: 'Stale', type: TelemetryFormView, path: '[Forms]')
Widget telemetryStale(final BuildContext context) => _example('Stale');

@UseCase(name: 'Unsupported', type: TelemetryFormView, path: '[Forms]')
Widget telemetryUnsupported(final BuildContext context) =>
    _example('Unsupported');

@UseCase(name: 'Wide', type: TelemetryFormView, path: '[Forms]')
Widget telemetryWide(final BuildContext context) => _example('Wide');

CatalogCase _example(final String variant) => CatalogCase(
  id: 'TelemetryFormView/$variant',
  variant: variant,
  width: variant == 'Wide' ? 640 : 360,
  builder: (final context, final fixtures, final controller, final update) {
    final settings = aTelemetrySettings(
      enable: variant != 'Disabled',
      headerNames: variant == 'No headers'
          ? const []
          : const ['authorization', 'obsolete'],
      memoryTracingEnabled: variant == 'Memory tracing',
    );
    final loaded = !['Loading', 'Error', 'Unsupported'].contains(variant);
    return FormPreview<TelemetryForm>(
      create: (final scope) {
        final form = TelemetryForm(
          settings,
          pending: variant == 'Queued' ? aTelemetryUpdate() : null,
        );
        scope.onDispose(form.dispose);
        if (variant == 'Invalid endpoint') {
          form.form.control('endpoint').value =
              'http://collector.example.org:4317';
          form.form.markAsDirty();
        }
        if (variant == 'Header replacement') {
          form.headers.first.control('value').value = 'preview-only-secret';
          form.form.markAsDirty();
        }
        if (variant == 'Header removal') {
          form.removeHeader(0);
        }
        return form;
      },
      builder: (final context, final form) => TelemetryFormView(
        form: loaded ? form : null,
        snapshot: CachedValue(
          data: loaded ? settings : null,
          support: variant == 'Unsupported'
              ? DomainSupport.unsupported
              : DomainSupport.supported,
          freshness: variant == 'Stale' ? Freshness.stale : Freshness.fresh,
          lastError: variant == 'Error' ? StateError('offline') : null,
          isRefreshing: variant == 'Loading',
        ),
        pending: variant == 'Queued',
        applying: variant == 'Applying',
        enabled: variant != 'Applying',
        onAdd: (_) => catalogActions.record('Queue telemetry settings'),
        onRefresh: () => catalogActions.record('Refresh telemetry settings'),
        onShowOperation: () => catalogActions.record('Show operation'),
      ),
    );
  },
);
