import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:selfprivacy/utils/color_utils.dart';
import 'package:hive/hive.dart';
import 'package:selfprivacy/utils/crypto.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends Equatable {
  User({
    @required this.login,
    @required this.password,
  });

  @HiveField(0)
  final String login;
  
  @HiveField(1)
  final String password;

  @override
  List<Object> get props => [login, password];

  Color get color => stringToColor(login);

  String get hashPassword => convertToSha512Hash(password);

  String toString() {
    return login;
  }
}
