import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/checks/credential_check_state.dart';
import 'package:selfprivacy/logic/forms/checks/credential_validation_result.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/utils/app_logger.dart';

typedef DnsProviderCredentials = ({
  String token,
  String? tokenId,
  String? url,
  String? tenant,
  String? secondaryToken,
});

class DnsProviderForm {
  DnsProviderForm({
    required this.providerType,
    required this.validateCredential,
    required this.onSubmit,
  }) {
    _valueSubscription = form.valueChanges.listen((final _) {
      final failedCredentials = _failedCredentials;
      if (_credentialCheckState.value is CredentialCheckFailed &&
          failedCredentials != null &&
          _credentials != failedCredentials) {
        _credentialCheckState.value = const CredentialCheckIdle();
        _failedCredentials = null;
      }
    });
  }

  static const tokenControlName = 'token';
  static const tokenIdControlName = 'tokenId';
  static const urlControlName = 'url';
  static const tenantControlName = 'tenant';
  static const secondaryTokenControlName = 'secondaryToken';
  static const validationTimeout = Duration(seconds: 30);

  static final _logger = const AppLogger(name: 'dns_provider_form').log;

  final DnsProviderType providerType;
  final Future<CredentialValidationResult> Function(
    DnsProviderCredential credential,
  )
  validateCredential;
  final Future<void> Function(DnsProviderCredential credential) onSubmit;

  late final FormGroup form = FormGroup({
    tokenControlName: FormControl<String>(validators: [Validators.required]),
    if (providerType.requiredCredentials.requiresTokenId)
      tokenIdControlName: FormControl<String>(
        validators: [Validators.required],
      ),
    if (providerType.requiredCredentials.requiresUrl)
      urlControlName: FormControl<String>(validators: [Validators.required]),
    if (providerType.requiredCredentials.requiresTenant)
      tenantControlName: FormControl<String>(validators: [Validators.required]),
    if (providerType.requiredCredentials.requiresSecondaryToken)
      secondaryTokenControlName: FormControl<String>(
        validators: [Validators.required],
      ),
  });

  late final StreamSubscription<Map<String, Object?>?> _valueSubscription;

  final ValueNotifier<CredentialCheckState> _credentialCheckState =
      ValueNotifier(const CredentialCheckIdle());
  DnsProviderCredentials? _failedCredentials;
  bool _isDisposed = false;

  ValueListenable<CredentialCheckState> get credentialCheckState =>
      _credentialCheckState;

  DnsProviderCredential get credential => DnsProviderCredential.create(
    provider: providerType,
    token: _credentials.token,
    tokenId: _credentials.tokenId,
    url: _credentials.url,
    tenant: _credentials.tenant,
    secondaryToken: _credentials.secondaryToken,
    associatedDomainNames: [],
  );

  DnsProviderCredentials get _credentials => (
    token: form.control(tokenControlName).value as String,
    tokenId: _optionalValue(tokenIdControlName),
    url: _optionalValue(urlControlName),
    tenant: _optionalValue(tenantControlName),
    secondaryToken: _optionalValue(secondaryTokenControlName),
  );

  String? _optionalValue(final String controlName) => form.contains(controlName)
      ? form.control(controlName).value as String
      : null;

  Future<void> submit() async {
    if (_credentialCheckState.value is CredentialCheckRunning) {
      return;
    }
    if (!form.valid) {
      form.markAllAsTouched();
      return;
    }

    final credentials = _credentials;
    final submittedCredential = credential;
    _credentialCheckState.value = const CredentialCheckRunning();
    _failedCredentials = null;
    form.markAsDisabled();

    try {
      final result = await validateCredential(
        submittedCredential,
      ).timeout(validationTimeout);
      if (_isDisposed) {
        return;
      }

      switch (result) {
        case CredentialValidationValid():
          await onSubmit(submittedCredential);
        case CredentialValidationFailure():
          _credentialCheckState.value = CredentialCheckFailed(result);
          _failedCredentials = credentials;
      }
    } on TimeoutException catch (error, stackTrace) {
      _handleUnexpectedFailure(error, stackTrace, credentials);
    } catch (error, stackTrace) {
      _handleUnexpectedFailure(error, stackTrace, credentials);
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
    final DnsProviderCredentials credentials,
  ) {
    if (_isDisposed) {
      return;
    }
    _logger(
      'DNS provider credential check failed',
      error: error,
      stackTrace: stackTrace,
    );
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
