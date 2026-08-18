import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/checks/credential_check_state.dart';
import 'package:selfprivacy/logic/forms/checks/credential_validation_result.dart';
import 'package:selfprivacy/logic/forms/server_provider_form.dart';

void main() {
  group('ServerProviderForm', () {
    test('requires an API key', () {
      final form = ServerProviderForm(
        validateCredential: (final _) async =>
            const CredentialValidationValid(),
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);

      expect(
        form.form
            .control(ServerProviderForm.apiKeyControlName)
            .hasError(ValidationMessage.required),
        isTrue,
      );
    });

    test('invalid submit touches the field without checking the key', () async {
      var validationCalls = 0;
      final form = ServerProviderForm(
        validateCredential: (final _) async {
          validationCalls++;
          return const CredentialValidationValid();
        },
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);

      await form.submit();

      expect(validationCalls, 0);
      expect(
        form.form.control(ServerProviderForm.apiKeyControlName).touched,
        isTrue,
      );
    });

    test('checks and submits the exact key', () async {
      const credential = ' API key ';
      String? checked;
      String? submitted;
      final form = ServerProviderForm(
        validateCredential: (final value) async {
          checked = value;
          return const CredentialValidationValid();
        },
        onSubmit: (final value) async => submitted = value,
      );
      addTearDown(form.dispose);
      form.form.control(ServerProviderForm.apiKeyControlName).value =
          credential;

      await form.submit();

      expect(checked, credential);
      expect(submitted, credential);
      expect(form.credentialCheckState.value, isA<CredentialCheckIdle>());
      expect(form.form.enabled, isTrue);
    });

    test('rejected key does not submit and permits retry', () async {
      var validationCalls = 0;
      var submitCalls = 0;
      final form = ServerProviderForm(
        validateCredential: (final _) async {
          validationCalls++;
          return const CredentialValidationRejected();
        },
        onSubmit: (final _) async => submitCalls++,
      );
      addTearDown(form.dispose);
      form.form.control(ServerProviderForm.apiKeyControlName).value = 'key';

      await form.submit();
      await form.submit();

      expect(validationCalls, 2);
      expect(submitCalls, 0);
      expect(form.credentialCheckState.value, isA<CredentialCheckFailed>());
      expect(form.form.valid, isTrue);
    });

    test('editing the key clears the remote failure', () async {
      final form = ServerProviderForm(
        validateCredential: (final _) async =>
            const CredentialValidationUnavailable(),
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);
      form.form.control(ServerProviderForm.apiKeyControlName).value = 'key';
      await form.submit();

      form.form.control(ServerProviderForm.apiKeyControlName).value = 'new-key';
      await Future<void>.delayed(Duration.zero);

      expect(form.credentialCheckState.value, isA<CredentialCheckIdle>());
    });

    test('ignores duplicate submits while checking', () async {
      final validation = Completer<CredentialValidationResult>();
      var validationCalls = 0;
      var submitCalls = 0;
      final form = ServerProviderForm(
        validateCredential: (final _) {
          validationCalls++;
          return validation.future;
        },
        onSubmit: (final _) async => submitCalls++,
      );
      addTearDown(form.dispose);
      form.form.control(ServerProviderForm.apiKeyControlName).value = 'key';

      final firstSubmit = form.submit();
      final secondSubmit = form.submit();
      validation.complete(const CredentialValidationValid());
      await Future.wait([firstSubmit, secondSubmit]);

      expect(validationCalls, 1);
      expect(submitCalls, 1);
    });

    test('turns an exception into unavailable', () async {
      final form = ServerProviderForm(
        validateCredential: (final _) => Future.error(StateError('failed')),
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);
      form.form.control(ServerProviderForm.apiKeyControlName).value = 'key';

      await form.submit();

      expect(
        (form.credentialCheckState.value as CredentialCheckFailed).failure,
        isA<CredentialValidationUnavailable>(),
      );
      expect(form.form.enabled, isTrue);
    });

    test('ignores a result after disposal', () async {
      final validation = Completer<CredentialValidationResult>();
      var submitCalls = 0;
      final form = ServerProviderForm(
        validateCredential: (final _) => validation.future,
        onSubmit: (final _) async => submitCalls++,
      );
      form.form.control(ServerProviderForm.apiKeyControlName).value = 'key';

      final submission = form.submit();
      form.dispose();
      validation.complete(const CredentialValidationValid());
      await submission;

      expect(submitCalls, 0);
    });
  });
}
