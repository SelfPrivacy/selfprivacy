import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/recovery_domain_form.dart';
import 'package:selfprivacy/ui/forms/recovery_domain_form_view.dart';

import '../../helpers/widget_harness.dart';

FilledButton _submitButton(final WidgetTester tester) =>
    tester.widget(find.widgetWithText(FilledButton, 'Continue'));

void main() {
  setUpAll(setUpWidgetTestHarness);

  group('RecoveryDomainFormView', () {
    testWidgets('shows the required error after submission', (
      final tester,
    ) async {
      final form = RecoveryDomainForm(
        validateDomain: (final _) async => true,
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);

      await pumpForTest(
        tester,
        RecoveryDomainFormView(recoveryDomainForm: form),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsOneWidget);
    });

    testWidgets('shows the server-not-found error', (final tester) async {
      final form = RecoveryDomainForm(
        validateDomain: (final _) async => false,
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);

      await pumpForTest(
        tester,
        RecoveryDomainFormView(recoveryDomainForm: form),
      );
      await tester.enterText(
        find.byType(ReactiveTextField<String>),
        'example.com',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
      await tester.pumpAndSettle();

      expect(
        find.text('Server with such domain was not found'),
        findsOneWidget,
      );
    });

    testWidgets('disables controls during submission', (final tester) async {
      final completer = Completer<void>();
      final form = RecoveryDomainForm(
        validateDomain: (final _) async => true,
        onSubmit: (final _) => completer.future,
      );
      addTearDown(form.dispose);

      await pumpForTest(
        tester,
        RecoveryDomainFormView(recoveryDomainForm: form),
      );
      await tester.enterText(
        find.byType(ReactiveTextField<String>),
        'example.com',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
      await tester.pump();

      expect(_submitButton(tester).onPressed, isNull);
      expect(
        form.form.control(RecoveryDomainForm.domainControlName).disabled,
        isTrue,
      );

      completer.complete();
      await tester.pumpAndSettle();

      expect(_submitButton(tester).onPressed, isNotNull);
    });
  });
}
