import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/checks/credential_check_state.dart';
import 'package:selfprivacy/logic/forms/checks/credential_validation_result.dart';

typedef BackblazeCredentials = ({String keyId, String applicationKey});

class BackblazeForm {
  BackblazeForm({required this.validateCredentials, required this.onSubmit}) {
    _valueSubscription = form.valueChanges.listen((final _) {
      final failedCredentials = _failedCredentials;
      if (_credentialCheckState.value is CredentialCheckFailed &&
          failedCredentials != null &&
          (form.control(keyIdControlName).value != failedCredentials.keyId ||
              form.control(applicationKeyControlName).value !=
                  failedCredentials.applicationKey)) {
        _credentialCheckState.value = const CredentialCheckIdle();
        _failedCredentials = null;
      }
    });
  }

  static const keyIdControlName = 'keyId';
  static const applicationKeyControlName = 'applicationKey';
  static const validationTimeout = Duration(seconds: 30);

  final Future<CredentialValidationResult> Function(
    BackblazeCredentials credentials,
  )
  validateCredentials;
  final Future<void> Function(BackblazeCredentials credentials) onSubmit;

  late final FormGroup form = FormGroup({
    keyIdControlName: FormControl<String>(validators: [Validators.required]),
    applicationKeyControlName: FormControl<String>(
      validators: [Validators.required],
    ),
  });

  late final StreamSubscription<Map<String, Object?>?> _valueSubscription;

  final ValueNotifier<CredentialCheckState> _credentialCheckState =
      ValueNotifier(const CredentialCheckIdle());
  BackblazeCredentials? _failedCredentials;
  bool _isDisposed = false;

  ValueListenable<CredentialCheckState> get credentialCheckState =>
      _credentialCheckState;

  Future<void> submit() async {
    if (_credentialCheckState.value is CredentialCheckRunning) {
      return;
    }
    if (!form.valid) {
      form.markAllAsTouched();
      return;
    }

    final BackblazeCredentials credentials = (
      keyId: form.control(keyIdControlName).value as String,
      applicationKey: form.control(applicationKeyControlName).value as String,
    );

    _credentialCheckState.value = const CredentialCheckRunning();
    _failedCredentials = null;
    form.markAsDisabled();

    try {
      final result = await validateCredentials(
        credentials,
      ).timeout(validationTimeout);
      if (_isDisposed) {
        return;
      }

      switch (result) {
        case CredentialValidationValid():
          await onSubmit(credentials);
        case CredentialValidationFailure():
          _credentialCheckState.value = CredentialCheckFailed(result);
          _failedCredentials = credentials;
      }
    } catch (_) {
      _handleUnexpectedFailure(credentials);
    } finally {
      if (!_isDisposed) {
        form.markAsEnabled();
        if (_credentialCheckState.value is CredentialCheckRunning) {
          _credentialCheckState.value = const CredentialCheckIdle();
        }
      }
    }
  }

  void _handleUnexpectedFailure(final BackblazeCredentials credentials) {
    if (_isDisposed) {
      return;
    }

    _credentialCheckState.value = const CredentialCheckFailed(
      CredentialValidationUnavailable(),
    );
    _failedCredentials = credentials;
  }

  void dispose() {
    _isDisposed = true;
    unawaited(_valueSubscription.cancel());
    form.dispose();
    _credentialCheckState.dispose();
  }
}
