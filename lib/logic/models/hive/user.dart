// ignore_for_file: always_specify_types

import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:selfprivacy/utils/color_utils.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends Equatable {
  const User({
    required this.login,
    this.password,
    this.sshKeys = const [],
    this.isFoundOnServer = true,
    this.note,
  });

  @HiveField(0)
  final String login;

  @HiveField(1)
  final String? password;

  @HiveField(2, defaultValue: [])
  final List<String> sshKeys;

  @HiveField(3, defaultValue: true)
  final bool isFoundOnServer;

  @HiveField(4)
  final String? note;

  @override
  List<Object?> get props => [login, password, sshKeys, isFoundOnServer, note];

  Color get color => stringToColor(login);

  @override
  String toString() => '$login, ${isFoundOnServer ? 'found' : 'not found'}, ${sshKeys.length} ssh keys, note: $note';
}
