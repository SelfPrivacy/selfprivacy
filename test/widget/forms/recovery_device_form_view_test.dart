import 'dart:async';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/recovery_device_form.dart';
import 'package:selfprivacy/ui/forms/recovery_device_form_view.dart';

import '../../helpers/widget_harness.dart';

String _validNewDeviceKey() =>
    Mnemonic(List<int>.filled(16, 0), Language.english).sentence;

FilledButton _submitButton(final WidgetTester tester) =>
    tester.widget(find.widgetWithText(FilledButton, 'Continue'));

void main() {
  setUpAll(setUpWidgetTestHarness);

  group('RecoveryDeviceFormView', () {
    testWidgets('shows the required error after submission', (
      final tester,
    ) async {
      final form = RecoveryDeviceForm(
        tokenType: RecoveryDeviceTokenType.oldToken,
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);

      await pumpForTest(
        tester,
        RecoveryDeviceFormView(recoveryDeviceForm: form),
      );

      await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsOneWidget);
    });

    testWidgets('shows the method-specific mnemonic error', (
      final tester,
    ) async {
      final form = RecoveryDeviceForm(
        tokenType: RecoveryDeviceTokenType.newDeviceKey,
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);

      await pumpForTest(
        tester,
        RecoveryDeviceFormView(recoveryDeviceForm: form),
      );
      await tester.enterText(
        find.byType(ReactiveTextField<String>),
        'invalid phrase',
      );
      form.form.control(RecoveryDeviceForm.tokenControlName).markAsTouched();
      await tester.pumpAndSettle();

      expect(find.text('Enter a valid 12-word new-device key'), findsOneWidget);
    });

    testWidgets('shows the recovery-key mnemonic error', (final tester) async {
      final form = RecoveryDeviceForm(
        tokenType: RecoveryDeviceTokenType.recoveryKey,
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);

      await pumpForTest(
        tester,
        RecoveryDeviceFormView(recoveryDeviceForm: form),
      );
      await tester.enterText(
        find.byType(ReactiveTextField<String>),
        'invalid phrase',
      );
      form.form.control(RecoveryDeviceForm.tokenControlName).markAsTouched();
      await tester.pumpAndSettle();

      expect(find.text('Enter a valid 18-word recovery key'), findsOneWidget);
    });

    testWidgets('submits a valid token and disables during submission', (
      final tester,
    ) async {
      final submitted = <String>[];
      final completer = Completer<void>();
      final form = RecoveryDeviceForm(
        tokenType: RecoveryDeviceTokenType.newDeviceKey,
        onSubmit: (final token) {
          submitted.add(token);
          return completer.future;
        },
      );
      addTearDown(form.dispose);

      await pumpForTest(
        tester,
        RecoveryDeviceFormView(recoveryDeviceForm: form),
      );
      final phrase = _validNewDeviceKey();
      await tester.enterText(find.byType(ReactiveTextField<String>), phrase);
      await tester.pumpAndSettle();

      expect(_submitButton(tester).onPressed, isNotNull);
      await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
      await tester.pump();

      expect(submitted, equals([phrase]));
      expect(_submitButton(tester).onPressed, isNull);

      completer.complete();
      await tester.pumpAndSettle();

      expect(_submitButton(tester).onPressed, isNotNull);
    });
  });
}
