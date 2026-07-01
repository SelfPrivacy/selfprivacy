import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/validators/ssh_validator.dart';

class SshKeyForm {
  SshKeyForm({required this.onSubmit, this.existingKeys = const []});

  static const errInvalidSshKey = 'invalidSshKey';
  static const errDuplicateSshKey = 'duplicateSshKey';

  final Future<void> Function(String key) onSubmit;
  final List<String> existingKeys;

  late final FormGroup form = FormGroup({
    'key': FormControl<String>(
      validators: [
        Validators.required,
        Validators.delegate(_isValidKey),
        Validators.delegate(_notDuplicate),
      ],
    ),
  });

  Map<String, dynamic>? _notDuplicate(final AbstractControl<dynamic> control) =>
      existingKeys.isNotEmpty &&
          control.value is String &&
          existingKeys.contains((control.value as String?)?.trim() ?? '')
      ? {errDuplicateSshKey: true}
      : null;

  Map<String, dynamic>? _isValidKey(final AbstractControl<dynamic> control) =>
      control.isNotNull &&
          control.value is String &&
          SshValidator.validate(control.value)
      ? null
      : {errInvalidSshKey: true};

  Future<void> submit() async {
    if (!form.valid) {
      form.markAllAsTouched();
      return;
    }
    await onSubmit((form.control('key').value as String).trim());
  }
}
