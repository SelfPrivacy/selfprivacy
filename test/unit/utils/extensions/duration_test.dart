import 'dart:ui';

import 'package:duration/duration.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/utils/extensions/duration.dart';

void main() {
  test('formats a compact duration in the requested locale', () {
    expect(
      const Duration(days: 2).toPrettyString(
        const Locale('ru'),
        tersity: DurationTersity.minute,
        upperTersity: DurationTersity.day,
        maxUnits: 1,
      ),
      '2 дня',
    );
  });
}
