import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/credential_checks/credential_check_state.dart';
import 'package:selfprivacy/logic/forms/credential_checks/credential_validation_result.dart';
import 'package:selfprivacy/logic/forms/dns_provider_form.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

void main() {
  group('DnsProviderForm', () {
    test('requires only the credentials for the selected provider', () {
      final cloudflareForm = _form(DnsProviderType.cloudflare);
      final porkbunForm = _form(DnsProviderType.porkbun);
      addTearDown(cloudflareForm.dispose);
      addTearDown(porkbunForm.dispose);

      expect(
        cloudflareForm.form
            .control(DnsProviderForm.tokenControlName)
            .hasError(ValidationMessage.required),
        isTrue,
      );
      expect(
        cloudflareForm.form.contains(DnsProviderForm.tokenIdControlName),
        isFalse,
      );
      expect(
        porkbunForm.form.contains(DnsProviderForm.tokenIdControlName),
        isTrue,
      );
      expect(
        porkbunForm.form
            .control(DnsProviderForm.tokenIdControlName)
            .hasError(ValidationMessage.required),
        isTrue,
      );
    });

    test(
      'invalid submit touches controls without checking credentials',
      () async {
        var validationCalls = 0;
        final form = DnsProviderForm(
          providerType: DnsProviderType.porkbun,
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
          form.form.control(DnsProviderForm.tokenControlName).touched,
          isTrue,
        );
        expect(
          form.form.control(DnsProviderForm.tokenIdControlName).touched,
          isTrue,
        );
      },
    );

    test('checks and submits the selected credential snapshot', () async {
      DnsProviderCredential? checked;
      DnsProviderCredential? submitted;
      final form = DnsProviderForm(
        providerType: DnsProviderType.porkbun,
        validateCredential: (final credential) async {
          checked = credential;
          return const CredentialValidationValid();
        },
        onSubmit: (final credential) async => submitted = credential,
      );
      addTearDown(form.dispose);
      form.form.control(DnsProviderForm.tokenControlName).value = 'secret';
      form.form.control(DnsProviderForm.tokenIdControlName).value = 'public';

      await form.submit();

      expect(checked?.provider, DnsProviderType.porkbun);
      expect(checked?.token, 'secret');
      expect(checked?.tokenId, 'public');
      expect(checked?.url, isNull);
      expect(checked?.tenant, isNull);
      expect(checked?.secondaryToken, isNull);
      expect(submitted?.token, 'secret');
      expect(form.credentialCheckState.value, isA<CredentialCheckIdle>());
    });

    test('rejected credentials permit retry', () async {
      var validationCalls = 0;
      final form = _form(
        DnsProviderType.cloudflare,
        validateCredential: (final _) async {
          validationCalls++;
          return const CredentialValidationRejected();
        },
      );
      addTearDown(form.dispose);
      form.form.control(DnsProviderForm.tokenControlName).value = 'token';

      await form.submit();
      await form.submit();

      expect(validationCalls, 2);
      expect(form.credentialCheckState.value, isA<CredentialCheckFailed>());
      expect(form.form.valid, isTrue);
    });

    test('editing any credential clears a remote failure', () async {
      final form = _form(
        DnsProviderType.porkbun,
        validateCredential: (final _) async =>
            const CredentialValidationUnavailable(),
      );
      addTearDown(form.dispose);
      form.form.control(DnsProviderForm.tokenControlName).value = 'token';
      form.form.control(DnsProviderForm.tokenIdControlName).value = 'token-id';
      await form.submit();

      form.form.control(DnsProviderForm.tokenIdControlName).value = 'new-id';
      await Future<void>.delayed(Duration.zero);

      expect(form.credentialCheckState.value, isA<CredentialCheckIdle>());
    });

    test('ignores duplicate submits while checking', () async {
      final validation = Completer<CredentialValidationResult>();
      var validationCalls = 0;
      var submitCalls = 0;
      final form = _form(
        DnsProviderType.cloudflare,
        validateCredential: (final _) {
          validationCalls++;
          return validation.future;
        },
        onSubmit: (final _) async => submitCalls++,
      );
      addTearDown(form.dispose);
      form.form.control(DnsProviderForm.tokenControlName).value = 'token';

      final firstSubmit = form.submit();
      final secondSubmit = form.submit();
      validation.complete(const CredentialValidationValid());
      await Future.wait([firstSubmit, secondSubmit]);

      expect(validationCalls, 1);
      expect(submitCalls, 1);
    });

    test('turns exceptions into unavailable failures', () async {
      final form = _form(
        DnsProviderType.cloudflare,
        validateCredential: (final _) => Future.error(StateError('failed')),
      );
      addTearDown(form.dispose);
      form.form.control(DnsProviderForm.tokenControlName).value = 'token';

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
      final form = _form(
        DnsProviderType.cloudflare,
        validateCredential: (final _) => validation.future,
        onSubmit: (final _) async => submitCalls++,
      );
      form.form.control(DnsProviderForm.tokenControlName).value = 'token';

      final submission = form.submit();
      form.dispose();
      validation.complete(const CredentialValidationValid());
      await submission;

      expect(submitCalls, 0);
    });
  });
}

DnsProviderForm _form(
  final DnsProviderType providerType, {
  final Future<CredentialValidationResult> Function(
    DnsProviderCredential credential,
  )?
  validateCredential,
  final Future<void> Function(DnsProviderCredential credential)? onSubmit,
}) => DnsProviderForm(
  providerType: providerType,
  validateCredential:
      validateCredential ??
      (final _) async => const CredentialValidationValid(),
  onSubmit: onSubmit ?? (final _) async {},
);
