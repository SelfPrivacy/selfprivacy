import 'dart:math';

const _chars =
    'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890_';
Random _rnd = Random();

String getRandomString(int length, [chars = _chars]) => String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(
          _rnd.nextInt(chars.length),
        ),
      ),
    );
