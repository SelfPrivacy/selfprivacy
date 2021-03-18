import 'dart:math';

var generator = PasswordGenerator();

String genPass() {
  generator.generate(8);
  return generator.getGeneratedValue();
}

///Generates a password.
///
///The password [_generatedValue] is of a specified length, including letters [_letterGen] of mixed cases,
///numbers [_numGen], and symbols[_symGen] depending on user choice.
class PasswordGenerator {
  late bool _letterGen;
  late bool _numGen;
  late bool _symGen;
  late String _generatedValue;

  ///Constructor.
  ///
  ///[_letterGen] is true to make password generation possible from the opening of the application, and
  ///[_generatedValue] is intialized to the value below so the text containing it can be first generated
  ///upon users request
  PasswordGenerator() {
    _letterGen = true;
    _numGen = true;
    _symGen = false;
    _generatedValue = "Press Generate";
  }

  ///Call to generate a value, of [n] length
  void generate(int n) {
    //Discards the old value
    _generatedValue = "";

    ///Cannot generate a value without any character types selected
    if (!_letterGen && !_numGen && !_symGen) {
      _generatedValue = "No character type selected";
      return;
    }

    ///'Randomly' selectes caracter type to generate and append [toAppend] to [_generatedValue]
    // ignore: unnecessary_statements
    for (n; n > 0; n--) {
      String? toAppend;
      var random = new Random();

      ///loops until a valid character is generated, meaning the user has to check the character value
      ///to be generated. 'Randomly' picks a character type.
      while (toAppend == null) {
        int selector = random.nextInt(3);

        if (selector == 0) {
          toAppend = _generateLetter();
        } else if (selector == 1) {
          toAppend = _generateNumber();
        } else {
          toAppend = _generateSymbol();
        }
      }

      _generatedValue += toAppend;
      toAppend = null;
    }
  }

  ///Generates a letter when called.
  String _generateLetter() {
    if (!_letterGen) return '';

    ///Finds the integer value for the range between a-z and A-Z, with [base] UTF-16 value for lowercase letters and
    ///[baseUpper] UTF-16 value for uppercase letters
    int base = "a".codeUnitAt(0);
    int baseUpper = "A".codeUnitAt(0);
    int maxRand = ("z".codeUnitAt(0) - base) + 1;
    Random random = new Random();

    ///Randomly selects between upper and lower case generation, randomly generates value from [maxRand], then adding base,
    ///which creates a UTF-16 encoded character to be converted into a string of one character between a-z/A-Z.
    ///This string is then returned.
    if (random.nextInt(2) == 0) {
      return String.fromCharCodes([random.nextInt(maxRand) + base]);
    } else {
      return String.fromCharCodes([random.nextInt(maxRand) + baseUpper]);
    }
  }

  ///Generates a number when called
  String? _generateNumber() {
    if (!_numGen) return null;

    ///Finds the integer value for the range between 0-9
    int base = "0".codeUnitAt(0);
    int maxRand = ("9".codeUnitAt(0) - base) + 1;
    Random random = new Random();

    ///Randomly generates value from [maxRand], then adding base, which creates a UTF-16 encoded character to be converted into a
    ///string of one character between 0-9. This string is then returned.
    return String.fromCharCodes([random.nextInt(maxRand) + base]);
  }

  ///Generates a symbol when called
  String? _generateSymbol() {
    if (!_symGen) return null;

    ///Finds the integer value for the range between symbols !-.

    ///(note) which includes symbols !"#$%&'()*+,=.
    int base = "!".codeUnitAt(0);
    int maxRand = (".".codeUnitAt(0) - base) + 1;
    Random random = new Random();

    ///Randomly generates value from [maxRand], then adding base, which creates a UTF-16 encoded character to be
    ///converted into a string of one character between !-. . This string is then returned.
    return String.fromCharCodes([random.nextInt(maxRand) + base]);
  }

  ///Toggles letter generation
  void checkLetterGen(bool value) {
    _letterGen = value;
  }

  ///Toggles number generation
  void checkNumGen(bool value) {
    _numGen = value;
  }

  ///Toggles symbol generation
  void checkSymGen(bool value) {
    _symGen = value;
  }

  ///Returns the generated value to be used by generator app
  String getGeneratedValue() {
    return _generatedValue;
  }
}
