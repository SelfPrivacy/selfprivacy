import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/initializing/initializing_cubit.dart';

class HetznerFormCubit extends FormCubit {
  HetznerFormCubit(this.initializingCubit) {
    var regExp = RegExp(r"\s+|[-!$%^&*()_@+|~=`{}\[\]:" ";<>?,.\/]");
    apiKey = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('required'),
        ValidationModel<String>(
            (s) => regExp.hasMatch(s), 'invalid key format'),
        LegnthStringValidation(11, 'length is [] shoud be 11')
      ],
    );

    super.setFields([apiKey]);
  }

  @override
  FutureOr<void> onSubmit() async {
    print(apiKey.state.value);
    await Future.delayed(const Duration(milliseconds: 300));
    // initializingCubit.setHetznerKey(apiKey.state.value);
  }

  final InitializingCubit initializingCubit;

  FieldCubit<String> apiKey;
}

class LegnthStringValidation extends ValidationModel<String> {
  LegnthStringValidation(int length, String errorText)
      : super((n) => n.length != length, errorText);

  @override
  String check(String val) {
    var length = val.length;
    var errorMassage = this.errorMassage.replaceAll("[]", length.toString());
    return test(val) ? errorMassage : null;
  }
}
