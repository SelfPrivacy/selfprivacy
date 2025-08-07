import 'package:flutter_test/flutter_test.dart';

import 'package:selfprivacy/utils/password_generator.dart';

void main() {
  group('StringGenerators', () {
    group('Basic', () {
      test('assert chart empty', () {
        expect(() {
          StringGenerators.getRandomString(8);
        }, throwsAssertionError);
      });

      test('only lowercase string', () {
        const int length = 8;
        final String generatedString = StringGenerators.getRandomString(
          length,
          hasLowercaseLetters: true,
        );

        expect(generatedString, isNot(matches(regExpNewLines)));
        expect(generatedString, isNot(matches(regExpWhiteSpaces)));
        expect(generatedString, isNot(matches(regExpNumbers)));
        expect(generatedString, isNot(matches(regExpUppercaseLetters)));
        expect(generatedString, isNot(matches(regExpSymbols)));
        expect(generatedString.length, equals(length));
        expect(generatedString, matches(regExpLowercaseLetters));
      });

      test('only uppercase string', () {
        const int length = 8;
        final String generatedString = StringGenerators.getRandomString(
          length,
          hasLowercaseLetters: false,
          hasUppercaseLetters: true,
        );

        expect(generatedString, isNot(matches(regExpNewLines)));
        expect(generatedString, isNot(matches(regExpWhiteSpaces)));
        expect(generatedString, isNot(matches(regExpNumbers)));
        expect(generatedString, isNot(matches(regExpLowercaseLetters)));
        expect(generatedString, isNot(matches(regExpSymbols)));
        expect(generatedString.length, equals(length));
        expect(generatedString, matches(regExpUppercaseLetters));
      });

      test('only numbers string', () {
        const int length = 8;
        final String generatedString = StringGenerators.getRandomString(
          length,
          hasLowercaseLetters: false,
          hasUppercaseLetters: false,
          hasNumbers: true,
        );

        expect(generatedString, isNot(matches(regExpNewLines)));
        expect(generatedString, isNot(matches(regExpWhiteSpaces)));
        expect(generatedString, isNot(matches(regExpUppercaseLetters)));
        expect(generatedString, isNot(matches(regExpLowercaseLetters)));
        expect(generatedString, isNot(matches(regExpSymbols)));
        expect(generatedString.length, equals(length));
        expect(generatedString, matches(regExpNumbers));
      });

      test('only symbols string', () {
        const int length = 8;
        final String generatedString = StringGenerators.getRandomString(
          length,
          hasLowercaseLetters: false,
          hasUppercaseLetters: false,
          hasNumbers: false,
          hasSymbols: true,
        );

        expect(generatedString, isNot(matches(regExpNewLines)));
        expect(generatedString, isNot(matches(regExpWhiteSpaces)));
        expect(generatedString, isNot(matches(regExpUppercaseLetters)));
        expect(generatedString, isNot(matches(regExpLowercaseLetters)));
        expect(generatedString, isNot(matches(regExpNumbers)));
        expect(generatedString.length, equals(length));
        expect(generatedString, matches(regExpSymbols));
      });
    });

    group('Strict mode', () {
      test('All', () {
        const int length = 5;
        final String generatedString = StringGenerators.getRandomString(
          length,
          hasLowercaseLetters: true,
          hasUppercaseLetters: true,
          hasNumbers: true,
          hasSymbols: true,
          isStrict: true,
        );

        expect(generatedString, isNot(matches(regExpNewLines)));
        expect(generatedString, isNot(matches(regExpWhiteSpaces)));
        expect(generatedString, matches(regExpLowercaseLetters));
        expect(generatedString, matches(regExpUppercaseLetters));
        expect(generatedString, matches(regExpNumbers));
        expect(generatedString, matches(regExpSymbols));
        expect(generatedString.length, equals(length));
      });
      test('Lowercase letters and numbers', () {
        const int length = 3;
        final String generatedString = StringGenerators.getRandomString(
          length,
          hasLowercaseLetters: true,
          hasUppercaseLetters: false,
          hasNumbers: true,
          hasSymbols: false,
          isStrict: true,
        );

        expect(generatedString, isNot(matches(regExpNewLines)));
        expect(generatedString, isNot(matches(regExpWhiteSpaces)));
        expect(generatedString, isNot(matches(regExpUppercaseLetters)));
        expect(generatedString, isNot(matches(regExpSymbols)));
        expect(generatedString, matches(regExpLowercaseLetters));
        expect(generatedString, matches(regExpNumbers));
        expect(generatedString.length, equals(length));
      });
    });
  });
}

RegExp regExpNewLines = RegExp(r'[\n\r]+');
RegExp regExpWhiteSpaces = RegExp(r'[\s]+');
RegExp regExpUppercaseLetters = RegExp('[A-Z]');
RegExp regExpLowercaseLetters = RegExp('[a-z]');
RegExp regExpNumbers = RegExp('[0-9]');
RegExp regExpSymbols = RegExp(r'(?:_|[^\w\s])+');
