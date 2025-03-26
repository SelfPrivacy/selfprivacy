import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/users.graphql.dart';
import 'package:selfprivacy/utils/color_utils.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends Equatable {
  const User({
    required this.login,
    required this.type,
    this.password,
    this.sshKeys = const [],
    this.isFoundOnServer = true,
    this.note,
  });

  User.fromGraphQL(final Fragment$userFields user)
      : this(
          login: user.username,
          type: UserType.fromGraphQL(user.userType),
          sshKeys: user.sshKeys ?? const [],
          isFoundOnServer: true,
        );

  const User.fake({
    this.login = 'fake_username',
    this.type = UserType.normal,
    this.password = 'fake',
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

  @HiveField(5, defaultValue: UserType.normal)
  final UserType type;

  @override
  List<Object?> get props => [
        login,
        password,
        sshKeys,
        isFoundOnServer,
        note,
        type,
      ];

  Color get color => stringToColor(login);

  @override
  String toString() =>
      '$login, ${isFoundOnServer ? 'found' : 'not found'}, ${sshKeys.length} ssh keys, note: $note';
}

@HiveType(typeId: 102)
enum UserType {
  @HiveField(0)
  root,
  @HiveField(1)
  primary,
  @HiveField(2)
  normal;

  factory UserType.fromGraphQL(final Enum$UserType type) {
    switch (type) {
      case Enum$UserType.ROOT:
        return root;
      case Enum$UserType.PRIMARY:
        return primary;
      case Enum$UserType.NORMAL:
        return normal;
      case Enum$UserType.$unknown:
        return normal;
    }
  }
}
