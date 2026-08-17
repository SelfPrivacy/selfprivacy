import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/user_form.dart';
import 'package:selfprivacy/ui/forms/user_form_view.dart';

import '../../helpers/widget_harness.dart';

FilledButton _submitButton(final WidgetTester tester) =>
    tester.widget<FilledButton>(find.byType(FilledButton));

void main() {
  setUpAll(setUpWidgetTestHarness);

  group('UserFormView', () {
    testWidgets('renders login and display name fields', (final tester) async {
      final form = _form();
      addTearDown(form.dispose);

      await pumpForTest(
        tester,
        UserFormView(
          userForm: form,
          domainName: 'example.com',
          groupsSelector: const SizedBox(),
        ),
      );

      expect(find.byType(ReactiveTextField<String>), findsNWidgets(2));
      expect(_submitButton(tester).onPressed, isNotNull);

      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsOneWidget);
    });

    testWidgets('renders the localized maximum-length error', (
      final tester,
    ) async {
      final form = _form();
      addTearDown(form.dispose);

      await pumpForTest(
        tester,
        UserFormView(
          userForm: form,
          domainName: 'example.com',
          groupsSelector: const SizedBox(),
        ),
      );

      form.form.control(UserForm.loginControlName).value = 'a' * 32;
      form.form.control(UserForm.loginControlName).markAsTouched();
      await tester.pumpAndSettle();

      expect(
        find.text('Length is 32, should be shorter than or equal to 31'),
        findsOneWidget,
      );
    });
  });
}

UserForm _form() => UserForm(
  initialUser: null,
  isLoginRegistered: (final _) => false,
  onSubmit: (final _) async {},
);
