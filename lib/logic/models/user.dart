import 'dart:ui';

import 'package:crypt/crypt.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/utils/color_utils.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends Equatable {
  User({
    required this.login,
    required this.password,
  });

  @HiveField(0)
  final String login;

  @HiveField(1)
  final String password;

  @override
  List<Object?> get props => [login, password];

  Color get color => stringToColor(login);

  Crypt get hashPassword => Crypt.sha512(password);

  String toString() {
    return login;
  }
}
