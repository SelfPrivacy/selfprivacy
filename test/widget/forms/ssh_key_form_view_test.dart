import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/ssh_key_form.dart';
import 'package:selfprivacy/ui/forms/ssh_key_form_view.dart';

import '../../helpers/widget_harness.dart';

const _validKey =
    'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+y1mUS1rFbuy2V5ndMWBwS4AavxjSt0JQGwUhddu1h user@host';

FilledButton _submitButton(final WidgetTester tester) => tester
    .widget<FilledButton>(find.widgetWithText(FilledButton, 'Add an SSH key'));

void main() {
  setUpAll(setUpWidgetTestHarness);

  group('SshKeyFormView', () {
    testWidgets('renders the key text field', (final tester) async {
      final form = SshKeyForm(onSubmit: (final _) async {});
      addTearDown(form.form.dispose);

      await pumpForTest(tester, SshKeyFormView(sshKeyForm: form));

      expect(find.byType(ReactiveTextField<String>), findsOneWidget);
    });

    testWidgets('submit button is disabled when the form is invalid', (
      final tester,
    ) async {
      final form = SshKeyForm(onSubmit: (final _) async {});
      addTearDown(form.form.dispose);

      await pumpForTest(tester, SshKeyFormView(sshKeyForm: form));

      expect(_submitButton(tester).onPressed, isNull);
    });

    testWidgets('renders the "Required" error in English on touch', (
      final tester,
    ) async {
      final form = SshKeyForm(onSubmit: (final _) async {});
      addTearDown(form.form.dispose);

      await pumpForTest(tester, SshKeyFormView(sshKeyForm: form));

      form.form.control('key').markAsTouched();
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsOneWidget);
    });

    testWidgets('renders the invalid-format error in English', (
      final tester,
    ) async {
      final form = SshKeyForm(onSubmit: (final _) async {});
      addTearDown(form.form.dispose);

      await pumpForTest(tester, SshKeyFormView(sshKeyForm: form));

      await tester.enterText(
        find.byType(ReactiveTextField<String>),
        'not-an-ssh-key',
      );
      form.form.control('key').markAsTouched();
      await tester.pumpAndSettle();

      expect(find.text('Must follow the SSH key format'), findsOneWidget);
    });

    testWidgets('renders the duplicate error in English', (final tester) async {
      final form = SshKeyForm(
        onSubmit: (final _) async {},
        existingKeys: const [_validKey],
      );
      addTearDown(form.form.dispose);

      await pumpForTest(tester, SshKeyFormView(sshKeyForm: form));

      await tester.enterText(find.byType(ReactiveTextField<String>), _validKey);
      form.form.control('key').markAsTouched();
      await tester.pumpAndSettle();

      expect(find.text('Already exists'), findsOneWidget);
    });

    testWidgets(
      'submit button enables on valid input and invokes onSubmit on tap',
      (final tester) async {
        final submitted = <String>[];
        final form = SshKeyForm(
          onSubmit: (final key) async => submitted.add(key),
        );
        addTearDown(form.form.dispose);

        await pumpForTest(tester, SshKeyFormView(sshKeyForm: form));

        await tester.enterText(
          find.byType(ReactiveTextField<String>),
          _validKey,
        );
        await tester.pumpAndSettle();

        expect(_submitButton(tester).onPressed, isNotNull);

        await tester.tap(find.widgetWithText(FilledButton, 'Add an SSH key'));
        await tester.pumpAndSettle();

        expect(submitted, equals([_validKey]));
      },
    );
  });
}
