import 'dart:async';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/models/telemetry_settings.dart';

class TelemetryForm {
  TelemetryForm(
    final TelemetrySettings settings, {
    final TelemetryUpdate? pending,
    final bool editable = true,
  }) : _initial = pending ?? TelemetryUpdate.fromSettings(settings),
       _editable = editable {
    form = FormGroup(
      {
        'enable': FormControl<bool>(value: _initial.enable),
        'endpoint': FormControl<String>(value: _initial.endpoint),
        'logs': FormControl<bool>(value: _initial.uploadSystemLogs),
        'metrics': FormControl<bool>(value: _initial.uploadSystemMetrics),
        'headers': _headers,
      },
      validators: [Validators.delegate(_validate)],
    );
    for (final name in {...settings.headerNames, ..._initial.headers.keys}) {
      final existing =
          settings.headerNames.contains(name) ||
          (_initial.headers.containsKey(name) &&
              _initial.headers[name] == null);
      final header = _header(existing ? name : null);
      header.control('name').value = name;
      if (_initial.headers.containsKey(name)) {
        final secret = _initial.headers[name];
        header.control('removed').value = secret == null;
        header.control('value').value = secret;
      }
      _headers.add(header);
    }
    _subscription = form.valueChanges.listen((_) => _syncEnabled());
    _syncEnabled();
  }

  static const invalidEndpoint = 'invalidEndpoint';
  static const invalidHeaderName = 'invalidHeaderName';
  static const invalidHeaderValue = 'invalidHeaderValue';

  final TelemetryUpdate _initial;
  bool _editable;
  late final StreamSubscription<Object?> _subscription;

  bool get hasChanges => value != _initial;

  void setEditable({required final bool editable}) {
    _editable = editable;
    _syncEnabled();
  }

  void _syncEnabled() {
    void enabled(
      final AbstractControl<dynamic> control, {
      required final bool enable,
    }) {
      if (control.enabled == enable) {
        return;
      }
      enable
          ? control.markAsEnabled(emitEvent: false)
          : control.markAsDisabled(emitEvent: false);
    }

    enabled(form.control('enable'), enable: _editable);
    final dependent = _editable && form.control('enable').value == true;
    for (final name in ['endpoint', 'logs', 'metrics', 'headers']) {
      enabled(form.control(name), enable: dependent);
    }
    if (dependent) {
      for (final header in headers) {
        enabled(
          header.control('value'),
          enable: header.control('removed').value != true,
        );
      }
    }
    form.updateValueAndValidity(emitEvent: false);
  }

  void dispose() {
    unawaited(_subscription.cancel());
    form.dispose();
  }

  late final FormGroup form;
  final _headers = FormArray<Map<String, Object?>>([]);
  List<FormGroup> get headers => _headers.controls.cast<FormGroup>();

  FormGroup _header(final String? name) => FormGroup({
    'name': FormControl<String>(value: name),
    'existing': FormControl<bool>(value: name != null),
    'removed': FormControl<bool>(value: false),
    'value': FormControl<String>(),
  });

  void addHeader() {
    _headers.add(_header(null));
    form.markAsDirty();
    _syncEnabled();
  }

  void removeHeader(final int index) {
    final header = headers[index];
    if (header.control('existing').value == true) {
      header.control('removed').value = true;
    } else {
      _headers.removeAt(index);
    }
    form.markAsDirty();
    _syncEnabled();
  }

  void restoreHeader(final int index) {
    headers[index].control('removed').value = false;
    form.markAsDirty();
    _syncEnabled();
  }

  Map<String, dynamic>? _validate(final AbstractControl<dynamic> control) {
    final group = control as FormGroup;
    final endpoint = (group.control('endpoint').value as String? ?? '').trim();
    if ((group.control('enable').value == true || endpoint.isNotEmpty) &&
        !_validEndpoint(endpoint)) {
      return {invalidEndpoint: true};
    }
    final names = <String>{};
    for (final header in headers) {
      if (header.control('removed').value == true) {
        continue;
      }
      final name = (header.control('name').value as String? ?? '')
          .toLowerCase();
      if (!RegExp(r"^[!#$%&'*+\-.^_`|~0-9a-z]+$").hasMatch(name) ||
          !names.add(name)) {
        return {invalidHeaderName: true};
      }
      final value = header.control('value').value as String? ?? '';
      if ((value.isEmpty && header.control('existing').value != true) ||
          value.codeUnits.any(
            (final char) => char == 127 || (char < 32 && char != 9),
          )) {
        return {invalidHeaderValue: true};
      }
    }
    return null;
  }

  bool _validEndpoint(final String endpoint) {
    final uri = Uri.tryParse(endpoint);
    if (uri == null ||
        uri.scheme != 'https' ||
        !_validHost(uri.host) ||
        endpoint.contains('@') ||
        uri.path.isNotEmpty ||
        uri.hasQuery ||
        uri.hasFragment) {
      return false;
    }
    final port = RegExp(r':([0-9]+)$').firstMatch(endpoint)?.group(1);
    final number = int.tryParse(port ?? '');
    return number != null && number > 0 && number <= 65535;
  }

  bool _validHost(final String host) {
    if (host.contains(':')) {
      try {
        Uri.parseIPv6Address(host);
        return true;
      } on FormatException {
        return false;
      }
    }
    final hostname = host.replaceFirst(RegExp(r'\.+$'), '');
    final label = RegExp(r'^[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?$');
    return hostname.isNotEmpty &&
        hostname.length <= 253 &&
        hostname.split('.').every(label.hasMatch);
  }

  TelemetryUpdate get value {
    final endpoint = (form.control('endpoint').value as String? ?? '').trim();
    return TelemetryUpdate(
      enable: form.control('enable').value as bool,
      endpoint: endpoint.isEmpty ? null : endpoint,
      uploadSystemLogs: form.control('logs').value as bool,
      uploadSystemMetrics: form.control('metrics').value as bool,
      headers: {
        for (final header in headers)
          if (header.control('removed').value == true ||
              (header.control('value').value as String? ?? '').isNotEmpty)
            (header.control('name').value as String)
                .toLowerCase(): header.control('removed').value == true
                ? null
                : header.control('value').value as String,
      },
    );
  }
}
