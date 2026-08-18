import 'dart:async';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/forms/recovery_device_form.dart';

String _validMnemonic(final int entropyBytes) =>
    Mnemonic(List<int>.filled(entropyBytes, 0), Language.english).sentence;

void main() {
  group('RecoveryDeviceForm', () {
    test('requires a token', () async {
      final form = RecoveryDeviceForm(
        tokenType: RecoveryDeviceTokenType.oldToken,
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);

      await form.submit();

      expect(form.form.valid, isFalse);
      expect(
        form.form.control(RecoveryDeviceForm.tokenControlName).touched,
        isTrue,
      );
    });

    test('rejects a whitespace-only old token', () async {
      final submitted = <String>[];
      final form = RecoveryDeviceForm(
        tokenType: RecoveryDeviceTokenType.oldToken,
        onSubmit: (final token) async => submitted.add(token),
      );
      addTearDown(form.dispose);
      form.form.control(RecoveryDeviceForm.tokenControlName).value = ' \t\n ';

      await form.submit();

      expect(form.form.valid, isFalse);
      expect(submitted, isEmpty);
    });

    test('accepts and normalizes an 18-word recovery key', () async {
      final submitted = <String>[];
      final form = RecoveryDeviceForm(
        tokenType: RecoveryDeviceTokenType.recoveryKey,
        onSubmit: (final token) async => submitted.add(token),
      );
      addTearDown(form.dispose);
      final phrase = _validMnemonic(24);

      form.form.control(RecoveryDeviceForm.tokenControlName).value =
          '  ${phrase.toUpperCase().replaceAll(' ', '  ')}  ';
      await form.submit();

      expect(form.form.valid, isTrue);
      expect(submitted, equals([phrase]));
    });

    test('accepts a 12-word new-device key', () async {
      final submitted = <String>[];
      final form = RecoveryDeviceForm(
        tokenType: RecoveryDeviceTokenType.newDeviceKey,
        onSubmit: (final token) async => submitted.add(token),
      );
      addTearDown(form.dispose);
      final phrase = _validMnemonic(16);

      form.form.control(RecoveryDeviceForm.tokenControlName).value = phrase;
      await form.submit();

      expect(form.form.valid, isTrue);
      expect(submitted, equals([phrase]));
    });

    test('rejects a mnemonic with an unexpected word count', () {
      final form = RecoveryDeviceForm(
        tokenType: RecoveryDeviceTokenType.recoveryKey,
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);

      form.form.control(RecoveryDeviceForm.tokenControlName).value =
          _validMnemonic(16);

      expect(form.form.valid, isFalse);
      expect(
        form.form
            .control(RecoveryDeviceForm.tokenControlName)
            .errors
            .containsKey(RecoveryDeviceForm.errInvalidMnemonic),
        isTrue,
      );
    });

    test('rejects a mnemonic with an invalid checksum', () {
      final form = RecoveryDeviceForm(
        tokenType: RecoveryDeviceTokenType.newDeviceKey,
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);

      form.form.control(RecoveryDeviceForm.tokenControlName).value =
          List<String>.filled(12, 'abandon').join(' ');

      expect(form.form.valid, isFalse);
      expect(
        form.form
            .control(RecoveryDeviceForm.tokenControlName)
            .errors
            .containsKey(RecoveryDeviceForm.errInvalidMnemonic),
        isTrue,
      );
    });

    test('rejects an unknown mnemonic word', () {
      final form = RecoveryDeviceForm(
        tokenType: RecoveryDeviceTokenType.newDeviceKey,
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);
      final words = _validMnemonic(16).split(' ');
      words[0] = 'notaword';

      form.form.control(RecoveryDeviceForm.tokenControlName).value = words.join(
        ' ',
      );

      expect(form.form.valid, isFalse);
    });

    test(
      'preserves an old token case and prevents concurrent submission',
      () async {
        final submitted = <String>[];
        final completer = Completer<void>();
        final form = RecoveryDeviceForm(
          tokenType: RecoveryDeviceTokenType.oldToken,
          onSubmit: (final token) {
            submitted.add(token);
            return completer.future;
          },
        );
        addTearDown(form.dispose);

        form.form.control(RecoveryDeviceForm.tokenControlName).value =
            ' Token-AbC ';
        final firstSubmit = form.submit();
        final secondSubmit = form.submit();

        expect(form.isSubmitting.value, isTrue);
        expect(submitted, equals(['Token-AbC']));

        completer.complete();
        await Future.wait([firstSubmit, secondSubmit]);

        expect(form.isSubmitting.value, isFalse);
        expect(submitted, hasLength(1));
      },
    );
  });
}
