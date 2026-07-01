import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/ssh_key_form.dart';

const _validKey =
    'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+y1mUS1rFbuy2V5ndMWBwS4AavxjSt0JQGwUhddu1h user@host';

void main() {
  group('SshKeyForm', () {
    group('validators', () {
      test('required fires when the key is empty', () {
        final form = SshKeyForm(onSubmit: (final _) async {});

        final control = form.form.control('key');
        expect(control.hasError(ValidationMessage.required), isTrue);
      });

      test('invalid-format error fires for malformed input', () {
        final form = SshKeyForm(onSubmit: (final _) async {});

        form.form.control('key').value = 'not-an-ssh-key';

        expect(
          form.form.control('key').hasError(SshKeyForm.errInvalidSshKey),
          isTrue,
        );
      });

      test('invalid-format error does not fire for a valid key', () {
        final form = SshKeyForm(onSubmit: (final _) async {});

        form.form.control('key').value = _validKey;

        expect(
          form.form.control('key').hasError(SshKeyForm.errInvalidSshKey),
          isFalse,
        );
      });

      test('duplicate error fires when existingKeys contains the value', () {
        final form = SshKeyForm(
          onSubmit: (final _) async {},
          existingKeys: const [_validKey],
        );

        form.form.control('key').value = _validKey;

        expect(
          form.form.control('key').hasError(SshKeyForm.errDuplicateSshKey),
          isTrue,
        );
      });

      test('duplicate validator is absent when existingKeys is empty', () {
        final form = SshKeyForm(onSubmit: (final _) async {});

        form.form.control('key').value = _validKey;

        expect(
          form.form.control('key').hasError(SshKeyForm.errDuplicateSshKey),
          isFalse,
        );
        expect(form.form.valid, isTrue);
      });

      test('duplicate detection is whitespace-insensitive', () {
        final form = SshKeyForm(
          onSubmit: (final _) async {},
          existingKeys: const [_validKey],
        );

        form.form.control('key').value = '  $_validKey  ';

        expect(
          form.form.control('key').hasError(SshKeyForm.errDuplicateSshKey),
          isTrue,
        );
      });
    });

    group('submit', () {
      test('calls onSubmit with the trimmed key on valid input', () async {
        final submitted = <String>[];
        final form = SshKeyForm(
          onSubmit: (final key) async => submitted.add(key),
        );

        form.form.control('key').value = '  $_validKey  ';
        await form.submit();

        expect(submitted, equals([_validKey]));
      });

      test(
        'is a no-op on invalid input and marks the key control as touched',
        () async {
          var calls = 0;
          final form = SshKeyForm(onSubmit: (final _) async => calls++);

          await form.submit();

          expect(calls, equals(0));
          expect(form.form.control('key').touched, isTrue);
        },
      );
    });
  });
}
