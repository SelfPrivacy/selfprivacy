import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/checks/credential_validation_result.dart';
import 'package:selfprivacy/logic/forms/server_provider_form.dart';
import 'package:selfprivacy/ui/forms/server_provider_form_view.dart';

import '../../helpers/widget_harness.dart';

FilledButton _submitButton(final WidgetTester tester) =>
    tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Continue'));

void main() {
  setUpAll(setUpWidgetTestHarness);

  group('ServerProviderFormView', () {
    testWidgets('renders the supplied labels', (final tester) async {
      final form = ServerProviderForm(
        validateCredential: (final _) async =>
            const CredentialValidationValid(),
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);

      await pumpForTest(
        tester,
        ServerProviderFormView(
          serverProviderForm: form,
          fieldLabel: 'Hetzner API token',
          submitLabel: 'Continue',
        ),
      );

      expect(find.text('Hetzner API token'), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('shows the required error after invalid submit', (
      final tester,
    ) async {
      final form = ServerProviderForm(
        validateCredential: (final _) async =>
            const CredentialValidationValid(),
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);
      await pumpForTest(
        tester,
        ServerProviderFormView(
          serverProviderForm: form,
          fieldLabel: 'API token',
          submitLabel: 'Continue',
        ),
      );

      await form.submit();
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsOneWidget);
      expect(_submitButton(tester).onPressed, isNull);
    });

    testWidgets('shows rejected key and provider messages', (
      final tester,
    ) async {
      final form = ServerProviderForm(
        validateCredential: (final _) async =>
            const CredentialValidationRejected(
              providerMessage: 'Account is disabled',
            ),
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);
      await pumpForTest(
        tester,
        ServerProviderFormView(
          serverProviderForm: form,
          fieldLabel: 'API token',
          submitLabel: 'Continue',
        ),
      );

      await tester.enterText(find.byType(ReactiveTextField<String>), 'key');
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
      await tester.pumpAndSettle();

      expect(find.text('Provider API key is invalid'), findsOneWidget);
      expect(find.text('Account is disabled'), findsOneWidget);
      expect(_submitButton(tester).onPressed, isNotNull);
    });

    testWidgets('disables the form while checking and permits retry', (
      final tester,
    ) async {
      final validation = Completer<CredentialValidationResult>();
      final form = ServerProviderForm(
        validateCredential: (final _) => validation.future,
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);
      await pumpForTest(
        tester,
        ServerProviderFormView(
          serverProviderForm: form,
          fieldLabel: 'API token',
          submitLabel: 'Continue',
        ),
      );
      await tester.enterText(find.byType(ReactiveTextField<String>), 'key');
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
      await tester.pump();

      expect(form.form.disabled, isTrue);
      expect(_submitButton(tester).onPressed, isNull);

      validation.complete(const CredentialValidationUnavailable());
      await tester.pumpAndSettle();

      expect(form.form.enabled, isTrue);
      expect(find.text("Couldn't connect to the provider."), findsOneWidget);
      expect(_submitButton(tester).onPressed, isNotNull);
    });

    testWidgets('times out a stalled credential check', (final tester) async {
      final form = ServerProviderForm(
        validateCredential: (final _) =>
            Completer<CredentialValidationResult>().future,
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);
      await pumpForTest(
        tester,
        ServerProviderFormView(
          serverProviderForm: form,
          fieldLabel: 'API token',
          submitLabel: 'Continue',
        ),
      );
      await tester.enterText(find.byType(ReactiveTextField<String>), 'key');
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
      await tester.pump(const Duration(seconds: 31));
      await tester.pump();

      expect(find.text("Couldn't connect to the provider."), findsOneWidget);
      expect(_submitButton(tester).onPressed, isNotNull);
    });
  });
}
