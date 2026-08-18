import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/checks/credential_validation_result.dart';
import 'package:selfprivacy/logic/forms/dns_provider_form.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/ui/forms/dns_provider_form_view.dart';

import '../../helpers/widget_harness.dart';

FilledButton _submitButton(final WidgetTester tester) =>
    tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Connect'));

void main() {
  setUpAll(setUpWidgetTestHarness);

  group('DnsProviderFormView', () {
    testWidgets('renders only the fields required by the provider', (
      final tester,
    ) async {
      final cloudflareForm = _form(DnsProviderType.cloudflare);
      final porkbunForm = _form(DnsProviderType.porkbun);
      addTearDown(cloudflareForm.dispose);
      addTearDown(porkbunForm.dispose);

      await pumpForTest(tester, _view(cloudflareForm));
      expect(find.byType(ReactiveTextField<String>), findsOneWidget);

      await pumpForTest(tester, _view(porkbunForm));
      expect(find.byType(ReactiveTextField<String>), findsNWidgets(2));
      expect(find.text('Provider API Token ID'), findsOneWidget);
    });

    testWidgets('shows required errors after an invalid submit', (
      final tester,
    ) async {
      final form = _form(DnsProviderType.porkbun);
      addTearDown(form.dispose);
      await pumpForTest(tester, _view(form));

      await form.submit();
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsNWidgets(2));
      expect(_submitButton(tester).onPressed, isNull);
    });

    testWidgets('shows DNS rejection and provider detail', (
      final tester,
    ) async {
      final form = _form(
        DnsProviderType.cloudflare,
        validateCredential: (final _) async =>
            const CredentialValidationRejected(
              providerMessage: 'Account is disabled',
            ),
      );
      addTearDown(form.dispose);
      await pumpForTest(tester, _view(form));

      await tester.enterText(find.byType(ReactiveTextField<String>), 'token');
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Connect'));
      await tester.pumpAndSettle();

      expect(find.text('API key is invalid'), findsOneWidget);
      expect(find.text('Account is disabled'), findsOneWidget);
      expect(_submitButton(tester).onPressed, isNotNull);
    });

    testWidgets('disables the form while checking and permits retry', (
      final tester,
    ) async {
      final validation = Completer<CredentialValidationResult>();
      final form = _form(
        DnsProviderType.cloudflare,
        validateCredential: (final _) => validation.future,
      );
      addTearDown(form.dispose);
      await pumpForTest(tester, _view(form));
      await tester.enterText(find.byType(ReactiveTextField<String>), 'token');
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Connect'));
      await tester.pump();

      expect(form.form.disabled, isTrue);
      expect(_submitButton(tester).onPressed, isNull);

      validation.complete(const CredentialValidationUnavailable());
      await tester.pumpAndSettle();

      expect(form.form.enabled, isTrue);
      expect(find.text("Couldn't connect to the provider."), findsOneWidget);
      expect(_submitButton(tester).onPressed, isNotNull);
    });
  });
}

DnsProviderForm _form(
  final DnsProviderType providerType, {
  final Future<CredentialValidationResult> Function(Object credential)?
  validateCredential,
}) => DnsProviderForm(
  providerType: providerType,
  validateCredential: (final credential) =>
      validateCredential?.call(credential) ??
      Future.value(const CredentialValidationValid()),
  onSubmit: (final _) async {},
);

DnsProviderFormView _view(final DnsProviderForm form) => DnsProviderFormView(
  dnsProviderForm: form,
  tokenLabel: 'DNS API token',
  submitLabel: 'Connect',
);
