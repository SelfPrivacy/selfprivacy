import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/backblaze_form.dart';
import 'package:selfprivacy/logic/forms/checks/credential_check_state.dart';
import 'package:selfprivacy/logic/forms/checks/credential_validation_result.dart';

const _credentials = (keyId: ' key-id ', applicationKey: ' application-key ');

void _fill(final BackblazeForm form) {
  form.form.control(BackblazeForm.keyIdControlName).value = _credentials.keyId;
  form.form.control(BackblazeForm.applicationKeyControlName).value =
      _credentials.applicationKey;
}

void main() {
  group('BackblazeForm', () {
    test('requires both credential fields', () {
      final form = BackblazeForm(
        validateCredentials: (final _) async =>
            const CredentialValidationValid(),
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);

      expect(
        form.form
            .control(BackblazeForm.keyIdControlName)
            .hasError(ValidationMessage.required),
        isTrue,
      );
      expect(
        form.form
            .control(BackblazeForm.applicationKeyControlName)
            .hasError(ValidationMessage.required),
        isTrue,
      );
    });

    test(
      'invalid submit touches fields without checking credentials',
      () async {
        var validationCalls = 0;
        final form = BackblazeForm(
          validateCredentials: (final _) async {
            validationCalls++;
            return const CredentialValidationValid();
          },
          onSubmit: (final _) async {},
        );
        addTearDown(form.dispose);

        await form.submit();

        expect(validationCalls, 0);
        expect(
          form.form.control(BackblazeForm.keyIdControlName).touched,
          isTrue,
        );
        expect(
          form.form.control(BackblazeForm.applicationKeyControlName).touched,
          isTrue,
        );
      },
    );

    test('valid submit checks and submits the same exact snapshot', () async {
      BackblazeCredentials? checked;
      BackblazeCredentials? submitted;
      final form = BackblazeForm(
        validateCredentials: (final credentials) async {
          checked = credentials;
          return const CredentialValidationValid();
        },
        onSubmit: (final credentials) async => submitted = credentials,
      );
      addTearDown(form.dispose);
      _fill(form);

      await form.submit();

      expect(checked, _credentials);
      expect(submitted, _credentials);
      expect(form.credentialCheckState.value, isA<CredentialCheckIdle>());
      expect(form.form.enabled, isTrue);
    });

    test('rejected credentials do not call onSubmit', () async {
      var submitCalls = 0;
      final form = BackblazeForm(
        validateCredentials: (final _) async =>
            const CredentialValidationRejected(
              providerMessage: 'Account is disabled',
            ),
        onSubmit: (final _) async => submitCalls++,
      );
      addTearDown(form.dispose);
      _fill(form);

      await form.submit();

      expect(submitCalls, 0);
      expect(form.credentialCheckState.value, isA<CredentialCheckFailed>());
      expect(
        (form.credentialCheckState.value as CredentialCheckFailed)
            .failure
            .providerMessage,
        'Account is disabled',
      );
      expect(form.form.valid, isTrue);
    });

    test('unavailable provider permits an unchanged retry', () async {
      var validationCalls = 0;
      final form = BackblazeForm(
        validateCredentials: (final _) async {
          validationCalls++;
          return const CredentialValidationUnavailable();
        },
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);
      _fill(form);

      await form.submit();
      await form.submit();

      expect(validationCalls, 2);
      expect(form.form.valid, isTrue);
      expect(form.credentialCheckState.value, isA<CredentialCheckFailed>());
    });

    test('editing credentials clears the remote failure', () async {
      final form = BackblazeForm(
        validateCredentials: (final _) async =>
            const CredentialValidationRejected(),
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);
      _fill(form);
      await form.submit();

      form.form.control(BackblazeForm.keyIdControlName).value = 'new-key-id';
      await Future<void>.delayed(Duration.zero);

      expect(form.credentialCheckState.value, isA<CredentialCheckIdle>());
    });

    test('ignores duplicate submits while a check is running', () async {
      final validation = Completer<CredentialValidationResult>();
      var validationCalls = 0;
      var submitCalls = 0;
      final form = BackblazeForm(
        validateCredentials: (final _) {
          validationCalls++;
          return validation.future;
        },
        onSubmit: (final _) async => submitCalls++,
      );
      addTearDown(form.dispose);
      _fill(form);

      final firstSubmit = form.submit();
      final secondSubmit = form.submit();
      validation.complete(const CredentialValidationValid());
      await Future.wait([firstSubmit, secondSubmit]);

      expect(validationCalls, 1);
      expect(submitCalls, 1);
    });

    test('turns an unexpected exception into unavailable', () async {
      final form = BackblazeForm(
        validateCredentials: (final _) => Future.error(StateError('failed')),
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);
      _fill(form);

      await form.submit();

      expect(
        (form.credentialCheckState.value as CredentialCheckFailed).failure,
        isA<CredentialValidationUnavailable>(),
      );
      expect(form.form.enabled, isTrue);
    });

    test('ignores a validation result after disposal', () async {
      final validation = Completer<CredentialValidationResult>();
      var submitCalls = 0;
      final form = BackblazeForm(
        validateCredentials: (final _) => validation.future,
        onSubmit: (final _) async => submitCalls++,
      );
      _fill(form);

      final submission = form.submit();
      form.dispose();
      validation.complete(const CredentialValidationValid());
      await submission;

      expect(submitCalls, 0);
    });
  });
}
