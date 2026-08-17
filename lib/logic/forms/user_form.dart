import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

class UserForm {
  UserForm({
    required this.initialUser,
    required this.isLoginRegistered,
    required this.onSubmit,
  });

  static const loginControlName = 'login';
  static const displayNameControlName = 'displayName';
  static const groupsControlName = 'groups';
  static const errReservedLogin = 'reservedLogin';
  static const errLoginTaken = 'loginTaken';

  static const _reservedLogins = {'root', 'admin', 'idm_admin', 'anonymous'};
  static final _loginPattern = RegExp(r'^[a-z_][a-z0-9_]+$');

  final User? initialUser;
  final bool Function(String login) isLoginRegistered;
  final Future<void> Function(User user) onSubmit;
  final ValueNotifier<bool> _isSubmitting = ValueNotifier(false);
  bool _isDisposed = false;

  bool get isEdit => initialUser != null;
  ValueListenable<bool> get isSubmitting => _isSubmitting;

  late final FormGroup form = FormGroup({
    loginControlName: FormControl<String>(
      value: initialUser?.login ?? '',
      disabled: isEdit,
      validators: [
        Validators.required,
        Validators.maxLength(31),
        Validators.pattern(_loginPattern),
        Validators.delegate(_isReservedLogin),
        if (!isEdit) Validators.delegate(_isLoginRegistered),
      ],
    ),
    displayNameControlName: FormControl<String>(
      value: initialUser?.displayName ?? '',
      validators: [Validators.maxLength(255)],
    ),
    groupsControlName: FormControl<List<String>>(
      value: initialUser?.directmemberof ?? const ['sp.full_users'],
    ),
  });

  Map<String, Object?>? _isReservedLogin(
    final AbstractControl<dynamic> control,
  ) {
    final value = control.value as String? ?? '';
    return _reservedLogins.contains(value.toLowerCase())
        ? {errReservedLogin: true}
        : null;
  }

  Map<String, Object?>? _isLoginRegistered(
    final AbstractControl<dynamic> control,
  ) {
    final value = control.value as String? ?? '';
    return isLoginRegistered(value) ? {errLoginTaken: true} : null;
  }

  Future<void> submit() async {
    if (_isSubmitting.value) {
      return;
    }
    if (!form.valid) {
      form.markAllAsTouched();
      return;
    }

    _isSubmitting.value = true;
    try {
      await onSubmit(
        User(
          login:
              initialUser?.login ??
              form.control(loginControlName).value as String,
          type: UserType.normal,
          displayName: _emptyToNull(
            form.control(displayNameControlName).value as String? ?? '',
          ),
          directmemberof:
              form.control(groupsControlName).value as List<String>? ??
              const [],
        ),
      );
    } finally {
      if (!_isDisposed) {
        _isSubmitting.value = false;
      }
    }
  }

  void dispose() {
    _isDisposed = true;
    form.dispose();
    _isSubmitting.dispose();
  }

  String? _emptyToNull(final String value) => value.isEmpty ? null : value;
}
