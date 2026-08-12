import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/backblaze_form.dart';
import 'package:selfprivacy/logic/forms/credential_checks/credential_check_state.dart';
import 'package:selfprivacy/logic/forms/credential_checks/credential_validation_result.dart';
import 'package:selfprivacy/ui/forms/backblaze_form_view.dart';

import '../../helpers/widget_harness.dart';

FilledButton _submitButton(final WidgetTester tester) =>
    tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Connect'));

Future<void> _fill(final WidgetTester tester) async {
  final fields = find.byType(ReactiveTextField<String>);
  await tester.enterText(fields.at(0), 'key-id');
  await tester.enterText(fields.at(1), 'application-key');
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(setUpWidgetTestHarness);

  group('BackblazeFormView', () {
    testWidgets('renders both credential fields', (final tester) async {
      final form = BackblazeForm(
        validateCredentials: (final _) async =>
            const CredentialValidationValid(),
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);

      await pumpForTest(tester, BackblazeFormView(backblazeForm: form));

      expect(find.text('Key ID'), findsOneWidget);
      expect(find.text('Master Application Key'), findsOneWidget);
      expect(find.byType(ReactiveTextField<String>), findsNWidgets(2));
    });

    testWidgets('shows required errors after invalid submit', (
      final tester,
    ) async {
      final form = BackblazeForm(
        validateCredentials: (final _) async =>
            const CredentialValidationValid(),
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);
      await pumpForTest(tester, BackblazeFormView(backblazeForm: form));

      await form.submit();
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsNWidgets(2));
      expect(_submitButton(tester).onPressed, isNull);
    });

    testWidgets('shows a rejected message and safe provider detail', (
      final tester,
    ) async {
      final form = BackblazeForm(
        validateCredentials: (final _) async =>
            const CredentialValidationRejected(
              providerMessage: 'Account is disabled',
            ),
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);
      await pumpForTest(tester, BackblazeFormView(backblazeForm: form));
      await _fill(tester);

      await tester.tap(find.widgetWithText(FilledButton, 'Connect'));
      await tester.pumpAndSettle();

      expect(
        find.text('Backblaze storage information is invalid'),
        findsOneWidget,
      );
      expect(find.text('Account is disabled'), findsOneWidget);
      expect(_submitButton(tester).onPressed, isNotNull);
    });

    testWidgets('translates and suppresses a duplicate provider detail', (
      final tester,
    ) async {
      final form = BackblazeForm(
        validateCredentials: (final _) async =>
            const CredentialValidationRejected(
              providerMessage: 'initializing.backblaze_bad_key_error',
            ),
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);
      await pumpForTest(tester, BackblazeFormView(backblazeForm: form));
      await _fill(tester);

      await tester.tap(find.widgetWithText(FilledButton, 'Connect'));
      await tester.pumpAndSettle();

      expect(
        find.text('Backblaze storage information is invalid'),
        findsOneWidget,
      );
      expect(find.text('initializing.backblaze_bad_key_error'), findsNothing);
    });

    testWidgets('disables fields during a check and permits retry afterward', (
      final tester,
    ) async {
      final validation = Completer<CredentialValidationResult>();
      final form = BackblazeForm(
        validateCredentials: (final _) => validation.future,
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);
      await pumpForTest(tester, BackblazeFormView(backblazeForm: form));
      await _fill(tester);

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

    testWidgets('times out a stalled credential check', (final tester) async {
      final form = BackblazeForm(
        validateCredentials: (final _) =>
            Completer<CredentialValidationResult>().future,
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);
      await pumpForTest(tester, BackblazeFormView(backblazeForm: form));
      await _fill(tester);

      await tester.tap(find.widgetWithText(FilledButton, 'Connect'));
      await tester.pump(const Duration(seconds: 31));
      await tester.pump();

      expect(form.credentialCheckState.value, isA<CredentialCheckFailed>());
      expect(find.text("Couldn't connect to the provider."), findsOneWidget);
      expect(_submitButton(tester).onPressed, isNotNull);
    });
  });
}
