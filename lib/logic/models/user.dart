import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:selfprivacy/utils/color_utils.dart';

class User extends Equatable {
  User({
    @required this.login,
    @required this.password,
  });

  final String login;
  final String password;

  @override
  List<Object> get props => [login, password];

  Color get color => stringToColor(login);
}
