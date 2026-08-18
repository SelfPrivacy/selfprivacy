import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RecoveryDomainForm {
  RecoveryDomainForm({required this.validateDomain, required this.onSubmit});

  static const domainControlName = 'domain';
  static const errDomainNotFound = 'domainNotFound';

  final Future<bool> Function(String domain) validateDomain;
  final Future<void> Function(String domain) onSubmit;
  final ValueNotifier<bool> _isSubmitting = ValueNotifier(false);
  bool _isDisposed = false;
  bool _domainNotFound = false;

  ValueListenable<bool> get isSubmitting => _isSubmitting;

  late final FormGroup form = FormGroup({
    domainControlName: FormControl<String>(validators: [Validators.required]),
  });

  Future<void> submit() async {
    if (_isSubmitting.value) {
      return;
    }
    if (!form.valid) {
      form.markAllAsTouched();
      return;
    }

    final String domain = form.control(domainControlName).value as String;
    _isSubmitting.value = true;
    form.markAsDisabled();
    try {
      if (!await validateDomain(domain)) {
        showDomainNotFoundError();
        return;
      }
      await onSubmit(domain.toLowerCase());
    } finally {
      if (!_isDisposed) {
        form.markAsEnabled();
        _isSubmitting.value = false;
        if (_domainNotFound) {
          _setDomainNotFoundError();
        }
      }
    }
  }

  void showDomainNotFoundError() {
    _domainNotFound = true;
    if (!_isSubmitting.value) {
      _setDomainNotFoundError();
    }
  }

  void clearDomainNotFoundError() {
    _domainNotFound = false;
    form.control(domainControlName)
      ..removeError(errDomainNotFound)
      ..updateValueAndValidity();
  }

  void _setDomainNotFoundError() {
    form.control(domainControlName)
      ..setErrors({errDomainNotFound: true})
      ..markAsTouched();
  }

  void dispose() {
    _isDisposed = true;
    form.dispose();
    _isSubmitting.dispose();
  }
}
