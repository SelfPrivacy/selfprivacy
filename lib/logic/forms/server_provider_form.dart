import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/checks/credential_check_state.dart';
import 'package:selfprivacy/logic/forms/checks/credential_validation_result.dart';
import 'package:selfprivacy/utils/app_logger.dart';

class ServerProviderForm {
  ServerProviderForm({
    required this.validateCredential,
    required this.onSubmit,
  }) {
    _valueSubscription = form.valueChanges.listen((final _) {
      final failedCredential = _failedCredential;
      if (_credentialCheckState.value is CredentialCheckFailed &&
          failedCredential != null &&
          form.control(apiKeyControlName).value != failedCredential) {
        _credentialCheckState.value = const CredentialCheckIdle();
        _failedCredential = null;
      }
    });
  }

  static const apiKeyControlName = 'apiKey';
  static const validationTimeout = Duration(seconds: 30);

  static final _logger = const AppLogger(name: 'server_provider_form').log;

  final Future<CredentialValidationResult> Function(String credential)
  validateCredential;
  final Future<void> Function(String credential) onSubmit;

  late final FormGroup form = FormGroup({
    apiKeyControlName: FormControl<String>(validators: [Validators.required]),
  });

  late final StreamSubscription<Map<String, Object?>?> _valueSubscription;

  final ValueNotifier<CredentialCheckState> _credentialCheckState =
      ValueNotifier(const CredentialCheckIdle());
  String? _failedCredential;
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

    final credential = form.control(apiKeyControlName).value as String;
    _credentialCheckState.value = const CredentialCheckRunning();
    _failedCredential = null;
    form.markAsDisabled();

    try {
      final result = await validateCredential(
        credential,
      ).timeout(validationTimeout);
      if (_isDisposed) {
        return;
      }

      switch (result) {
        case CredentialValidationValid():
          await onSubmit(credential);
        case CredentialValidationFailure():
          _credentialCheckState.value = CredentialCheckFailed(result);
          _failedCredential = credential;
      }
    } on TimeoutException catch (error, stackTrace) {
      _handleUnexpectedFailure(error, stackTrace, credential);
    } catch (error, stackTrace) {
      _handleUnexpectedFailure(error, stackTrace, credential);
    } finally {
      if (!_isDisposed) {
        form.markAsEnabled();
        if (_credentialCheckState.value is CredentialCheckRunning) {
          _credentialCheckState.value = const CredentialCheckIdle();
        }
      }
    }
  }

  void _handleUnexpectedFailure(
    final Object error,
    final StackTrace stackTrace,
    final String credential,
  ) {
    if (_isDisposed) {
      return;
    }
    _logger(
      'Server provider credential check failed',
      error: error,
      stackTrace: stackTrace,
    );
    _credentialCheckState.value = const CredentialCheckFailed(
      CredentialValidationUnavailable(),
    );
    _failedCredential = credential;
  }

  void dispose() {
    _isDisposed = true;
    unawaited(_valueSubscription.cancel());
    form.dispose();
    _credentialCheckState.dispose();
  }
}
