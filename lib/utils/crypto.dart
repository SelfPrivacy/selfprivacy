import 'dart:convert';

import 'package:crypto/crypto.dart';

String convertToSha512Hash(String text) {
  var bytes = utf8.encode(text);

  var hash = sha512.convert(bytes);
  return hash.toString();
}
