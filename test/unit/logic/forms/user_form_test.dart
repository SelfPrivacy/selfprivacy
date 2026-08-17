import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/user_form.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

void main() {
  group('UserForm', () {
    group('validators', () {
      test('requires a login', () {
        final form = _form();
        addTearDown(form.dispose);

        expect(
          form.form
              .control(UserForm.loginControlName)
              .hasError(ValidationMessage.required),
          isTrue,
        );
      });

      test('rejects a login longer than 31 characters', () {
        final form = _form();
        addTearDown(form.dispose);

        form.form.control(UserForm.loginControlName).value = 'a' * 32;

        expect(
          form.form
              .control(UserForm.loginControlName)
              .hasError(ValidationMessage.maxLength),
          isTrue,
        );
      });

      test('rejects a login with unsupported characters', () {
        final form = _form();
        addTearDown(form.dispose);

        form.form.control(UserForm.loginControlName).value = 'Alice';

        expect(
          form.form
              .control(UserForm.loginControlName)
              .hasError(ValidationMessage.pattern),
          isTrue,
        );
      });

      test('rejects reserved logins without regard to case', () {
        final form = _form();
        addTearDown(form.dispose);

        form.form.control(UserForm.loginControlName).value = 'Admin';

        expect(
          form.form
              .control(UserForm.loginControlName)
              .hasError(UserForm.errReservedLogin),
          isTrue,
        );
      });

      test('rejects a login reported by the injected predicate', () {
        final form = _form(
          isLoginRegistered: (final login) => login == 'alice',
        );
        addTearDown(form.dispose);

        form.form.control(UserForm.loginControlName).value = 'alice';

        expect(
          form.form
              .control(UserForm.loginControlName)
              .hasError(UserForm.errLoginTaken),
          isTrue,
        );
      });

      test('rejects a display name longer than 255 characters', () {
        final form = _form();
        addTearDown(form.dispose);

        form.form.control(UserForm.displayNameControlName).value = 'a' * 256;

        expect(
          form.form
              .control(UserForm.displayNameControlName)
              .hasError(ValidationMessage.maxLength),
          isTrue,
        );
      });
    });

    group('submit', () {
      test('submits a new normal user with default groups', () async {
        User? submitted;
        final form = _form(onSubmit: (final user) async => submitted = user);
        addTearDown(form.dispose);
        form.form.control(UserForm.loginControlName).value = 'alice';

        await form.submit();

        expect(submitted?.login, 'alice');
        expect(submitted?.type, UserType.normal);
        expect(submitted?.displayName, isNull);
        expect(submitted?.directmemberof, const ['sp.full_users']);
      });

      test('submits the editable fields of an existing user', () async {
        User? submitted;
        final form = _form(
          initialUser: const User.fake(
            login: 'alice',
            displayName: 'Alice',
            directmemberof: ['sp.admins', 'service.group'],
          ),
          onSubmit: (final user) async => submitted = user,
        );
        addTearDown(form.dispose);

        form.form.control(UserForm.displayNameControlName).value = 'Alicia';
        form.form.control(UserForm.groupsControlName).value = ['service.group'];

        await form.submit();

        expect(form.form.control(UserForm.loginControlName).disabled, isTrue);
        expect(submitted?.login, 'alice');
        expect(submitted?.displayName, 'Alicia');
        expect(submitted?.directmemberof, ['service.group']);
      });

      test('does not submit an invalid form and marks it as touched', () async {
        var submitCalls = 0;
        final form = _form(onSubmit: (final _) async => submitCalls++);
        addTearDown(form.dispose);

        await form.submit();

        expect(submitCalls, 0);
        expect(form.form.control(UserForm.loginControlName).touched, isTrue);
      });

      test(
        'ignores duplicate submissions while the callback is running',
        () async {
          final callback = Completer<void>();
          var submitCalls = 0;
          final form = _form(
            onSubmit: (final _) {
              submitCalls++;
              return callback.future;
            },
          );
          addTearDown(form.dispose);
          form.form.control(UserForm.loginControlName).value = 'alice';

          final firstSubmit = form.submit();
          final secondSubmit = form.submit();

          expect(submitCalls, 1);
          expect(form.isSubmitting.value, isTrue);

          callback.complete();
          await Future.wait([firstSubmit, secondSubmit]);

          expect(form.isSubmitting.value, isFalse);
        },
      );
    });
  });
}

UserForm _form({
  final User? initialUser,
  final bool Function(String login)? isLoginRegistered,
  final Future<void> Function(User user)? onSubmit,
}) => UserForm(
  initialUser: initialUser,
  isLoginRegistered: isLoginRegistered ?? (final _) => false,
  onSubmit: onSubmit ?? (final _) async {},
);
