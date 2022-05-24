import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class LengthStringValidation extends ValidationModel<String> {
  LengthStringValidation(bool Function(String) predicate, String errorMessage)
      : super(predicate, errorMessage);

  @override
  String? check(String value) {
    var length = value.length;
    var errorMessage = errorMassage.replaceAll('[]', length.toString());
    return test(value) ? errorMessage : null;
  }
}

class LengthStringNotEqualValidation extends LengthStringValidation {
  /// String must be equal to [length]
  LengthStringNotEqualValidation(int length)
      : super((n) => n.length != length,
            'validations.length_not_equal'.tr(args: [length.toString()]));
}

class LengthStringLongerValidation extends LengthStringValidation {
  /// String must be shorter than or equal to [length]
  LengthStringLongerValidation(int length)
      : super((n) => n.length > length,
            'validations.length_longer'.tr(args: [length.toString()]));
}
