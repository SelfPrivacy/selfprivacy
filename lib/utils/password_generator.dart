import 'dart:math';

Random _rnd = Random();

typedef StringGeneratorFunction = String Function();

class StringGenerators {
  static const letters = 'abcdefghijklmnopqrstuvwxyz';
  static const numbers = '1234567890';
  static const symbols = '_';

  static String getRandomString(
    int length, {
    hasLowercaseLetters = false,
    hasUppercaseLetters = false,
    hasNumbers = false,
    hasSymbols = false,
    isStrict = false,
  }) {
    var chars = '';
    if (hasLowercaseLetters) chars += letters;
    if (hasUppercaseLetters) chars += letters.toUpperCase();
    if (hasNumbers) chars += numbers;
    if (hasSymbols) chars += symbols;

    assert(chars.isNotEmpty, 'chart empty');

    if (!isStrict) {
      return genString(length, chars);
    }

    var res = '';
    var loose = length;
    if (hasLowercaseLetters) {
      loose -= 1;
      res += genString(1, letters);
    }
    if (hasUppercaseLetters) {
      loose -= 1;
      res += genString(1, letters.toUpperCase());
    }
    if (hasNumbers) {
      loose -= 1;
      res += genString(1, numbers.toUpperCase());
    }
    if (hasSymbols) {
      loose -= 1;
      res += genString(1, symbols);
    }
    res += genString(loose, chars);

    var shuffledlist = res.split('')..shuffle();
    return shuffledlist.join();
  }

  static String genString(int length, String chars) {
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(
          _rnd.nextInt(chars.length),
        ),
      ),
    );
  }

  static StringGeneratorFunction userPassword = () => getRandomString(
        8,
        hasLowercaseLetters: true,
        hasUppercaseLetters: true,
        hasNumbers: true,
        isStrict: true,
      );

  static StringGeneratorFunction passwordSalt = () => getRandomString(
        8,
        hasLowercaseLetters: true,
      );

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

  static StringGeneratorFunction dbStorageName = () => getRandomString(
        6,
        hasLowercaseLetters: true,
        hasUppercaseLetters: true,
        hasNumbers: true,
      );
}
