import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum RecoveryDeviceTokenType { recoveryKey, newDeviceKey, oldToken }

class RecoveryDeviceForm {
  RecoveryDeviceForm({required this.tokenType, required this.onSubmit});

  static const tokenControlName = 'token';
  static const errInvalidMnemonic = 'invalidMnemonic';

  final RecoveryDeviceTokenType tokenType;
  final Future<void> Function(String token) onSubmit;
  final ValueNotifier<bool> _isSubmitting = ValueNotifier(false);
  bool _isDisposed = false;

  ValueListenable<bool> get isSubmitting => _isSubmitting;

  late final FormGroup form = FormGroup({
    tokenControlName: FormControl<String>(
      validators: [Validators.required, Validators.delegate(_isValidToken)],
    ),
  });

  Map<String, Object?>? _isValidToken(final AbstractControl<dynamic> control) {
    if (tokenType == RecoveryDeviceTokenType.oldToken) {
      return (control.value as String? ?? '').trim().isEmpty
          ? {ValidationMessage.required: true}
          : null;
    }

    final String token = _normalizedMnemonic(control.value as String? ?? '');
    final int expectedWordCount =
        tokenType == RecoveryDeviceTokenType.recoveryKey ? 18 : 12;
    final List<String> words = token.split(' ');

    if (words.length != expectedWordCount) {
      return {errInvalidMnemonic: true};
    }

    try {
      Mnemonic.fromSentence(token, Language.english);
      return null;
    } on MnemonicException {
      return {errInvalidMnemonic: true};
    }
  }

  Future<void> submit() async {
    if (_isSubmitting.value) {
      return;
    }
    if (!form.valid) {
      form.markAllAsTouched();
      return;
    }

    _isSubmitting.value = true;
    try {
      await onSubmit(_submittedToken);
    } finally {
      if (!_isDisposed) {
        _isSubmitting.value = false;
      }
    }
  }

  void dispose() {
    _isDisposed = true;
    form.dispose();
    _isSubmitting.dispose();
  }

  String get _submittedToken {
    final String token = form.control(tokenControlName).value as String? ?? '';
    return tokenType == RecoveryDeviceTokenType.oldToken
        ? token.trim()
        : _normalizedMnemonic(token);
  }

  String _normalizedMnemonic(final String value) =>
      value.trim().toLowerCase().split(RegExp(r'\s+')).join(' ');
}
