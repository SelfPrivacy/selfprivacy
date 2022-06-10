import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class LengthStringValidation extends ValidationModel<String> {
  LengthStringValidation(super.predicate, super.errorMessage);

  @override
  String? check(final String val) {
    final int length = val.length;
    final String errorMessage =
        errorMassage.replaceAll('[]', length.toString());
    return test(val) ? errorMessage : null;
  }
}

class LengthStringNotEqualValidation extends LengthStringValidation {
  /// String must be equal to [length]
  LengthStringNotEqualValidation(final int length)
      : super(
          (final n) => n.length != length,
          'validations.length_not_equal'.tr(args: [length.toString()]),
        );
}

class LengthStringLongerValidation extends LengthStringValidation {
  /// String must be shorter than or equal to [length]
  LengthStringLongerValidation(final int length)
      : super(
          (final n) => n.length > length,
          'validations.length_longer'.tr(args: [length.toString()]),
        );
}
