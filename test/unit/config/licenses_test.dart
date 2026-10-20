import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/config/licenses.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'Unicons license and icon attribution are available to LicensePage',
    () async {
      LicenseRegistry.reset();
      addTearDown(LicenseRegistry.reset);
      registerAppLicenses();

      final entries = await LicenseRegistry.licenses.toList();
      expect(entries, hasLength(1));
      expect(entries.single.packages, contains('Unicons Outline'));
      final text = entries.single.paragraphs
          .map((final p) => p.text)
          .join('\n');
      expect(text, contains('Apache License'));
      expect(text, contains('Version 2.0, January 2004'));
      expect(text, contains('IconScout'));
      expect(text, contains('server.svg'));
    },
  );
}
