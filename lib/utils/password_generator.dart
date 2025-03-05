import 'dart:math';

Random _rnd = Random.secure();

typedef StringGeneratorFunction = String Function();

class StringGenerators {
  static final List<String> letters = 'abcdefghijklmnopqrstuvwxyz'.split('');
  static final List<String> upperCaseLetters =
      'abcdefghijklmnopqrstuvwxyz'.toUpperCase().split('');
  static final List<String> numbers = '1234567890'.split('');
  static const List<String> symbols = ['_'];

  static String getRandomString(
    final int length, {
    hasLowercaseLetters = false,
    hasUppercaseLetters = false,
    hasNumbers = false,
    hasSymbols = false,
    final isStrict = false,
  }) {
    final List<String> chars = [
      if (hasLowercaseLetters) ...letters,
      if (hasUppercaseLetters) ...upperCaseLetters,
      if (hasNumbers) ...numbers,
      if (hasSymbols) ...symbols,
    ];

    assert(chars.isNotEmpty, 'chart empty');
    late List<String> res;

    if (!isStrict) {
      res = genString(length, chars);
    } else {
      int sum = (hasLowercaseLetters ? 1 : 0) +
          (hasUppercaseLetters ? 1 : 0) +
          (hasNumbers ? 1 : 0) +
          (hasSymbols ? 1 : 0);

      /// disable flags one by one when the len of generated string is less
      /// than count of flags
      /// so we wouldn't generate 4 len string when we need 2 or 3 symbols
      while (sum > length) {
        final int step = _rnd.nextInt(4);

        switch (step) {
          case 0:
            if (hasLowercaseLetters) {
              hasLowercaseLetters = false;
              sum--;
              continue;
            }
          case 1:
            if (hasUppercaseLetters) {
              hasUppercaseLetters = false;
              sum--;
              continue;
            }
          case 2:
            if (hasNumbers) {
              hasNumbers = false;
              sum--;
              continue;
            }
          case 3: // symbols
            if (hasSymbols) {
              hasSymbols = false;
              sum--;
              continue;
            }
        }
      }

      res = [
        if (hasLowercaseLetters) ...genString(1, letters),
        if (hasUppercaseLetters) ...genString(1, upperCaseLetters),
        if (hasNumbers) ...genString(1, numbers),
        if (hasSymbols) ...genString(1, symbols),
        ...genString(
          length - sum,
          chars,
        ),
      ];
    }
    res.shuffle();
    return res.join();
  }

  static List<String> genString(final int length, final List<String> chars) => [
        for (int i = 0; i < length; i++) chars[_rnd.nextInt(chars.length)],
      ];

  static StringGeneratorFunction simpleId = () => getRandomString(
        5,
        hasLowercaseLetters: true,
      );

  static StringGeneratorFunction dbPassword = () => getRandomString(
        40,
        hasLowercaseLetters: true,
        hasUppercaseLetters: true,
        hasNumbers: true,
        hasSymbols: true,
      );

  static StringGeneratorFunction storageName = () => getRandomString(
        6,
        hasLowercaseLetters: true,
        hasUppercaseLetters: false,
        hasNumbers: true,
      );

  static StringGeneratorFunction apiToken = () => getRandomString(
        64,
        hasLowercaseLetters: true,
        hasUppercaseLetters: true,
        hasNumbers: true,
      );
}
