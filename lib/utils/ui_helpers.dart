import 'package:easy_localization/easy_localization.dart';

/// it's ui helpers use only for ui components, don't use for logic components.

class UiHelpers {
  static final _formatter = NumberFormat()..minimumFractionDigits = 0;

  static String formatWithPrecision(
    final double value, {
    final int fraction = 2,
  }) {
    _formatter.maximumFractionDigits = fraction;
    return _formatter.format(value);
  }

  static String permissionTitle(
    final String permissionType,
    final String serviceName,
  ) {
    if (permissionType == 'users') {
      return 'users.permission_description_user_access'.tr(
        namedArgs: {'serviceName': serviceName},
      );
    }
    if (permissionType == 'admins') {
      return 'users.permission_description_admin_access'.tr(
        namedArgs: {'serviceName': serviceName},
      );
    }
    return 'users.permission_description_fallback'.tr(
      namedArgs: {'permissionType': permissionType, 'serviceName': serviceName},
    );
  }
}
