import 'package:cubit_form/cubit_form.dart';

class LengthStringValidationWithLengthShowing extends ValidationModel<String> {
  LengthStringValidationWithLengthShowing(int length, String errorText)
      : super((n) => n.length != length, errorText);

  @override
  String? check(String val) {
    var length = val.length;
    var errorMassage = this.errorMassage.replaceAll("[]", length.toString());
    return test(val) ? errorMassage : null;
  }
}
