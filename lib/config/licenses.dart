import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

void registerAppLicenses() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/icons/brand/LICENSE');
    final attribution = await rootBundle.loadString(
      'lib/generated/brand_icons/ATTRIBUTION.md',
    );
    yield LicenseEntryWithLineBreaks([
      'Unicons Outline',
    ], '$license\n\n$attribution');
  });
}
