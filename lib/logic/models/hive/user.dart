import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/users.graphql.dart';
import 'package:selfprivacy/logic/models/hive/email_password_metadata.dart';
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
    this.email,
    this.displayName,
    this.directmemberof,
    this.memberof,
    this.emailPasswordMetadata,
  });

  User.fromGraphQL(final Fragment$userFields user)
    : this(
        login: user.username,
        type: UserType.fromGraphQL(user.userType),
        sshKeys: user.sshKeys ?? const [],
        isFoundOnServer: true,
        directmemberof: user.directmemberof,
        memberof: user.memberof,
        emailPasswordMetadata:
            user.emailPasswordMetadata
                ?.map(EmailPasswordMetadata.fromGraphQL)
                .toList(),
        displayName: user.displayName,
        email: user.email,
      );

  const User.fake({
    this.login = 'fake_username',
    this.type = UserType.normal,
    this.password = 'fake',
    this.sshKeys = const [],
    this.isFoundOnServer = true,
    this.note,
    this.email,
    this.displayName,
    this.directmemberof,
    this.memberof,
    this.emailPasswordMetadata,
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

  @HiveField(6)
  final String? email;

  @HiveField(7)
  final String? displayName;

  @HiveField(8)
  final List<String>? directmemberof;

  @HiveField(9)
  final List<String>? memberof;

  @HiveField(10)
  final List<EmailPasswordMetadata>? emailPasswordMetadata;

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

  User copyWith({
    final String? login,
    final String? password,
    final List<String>? sshKeys,
    final bool? isFoundOnServer,
    final String? note,
    final UserType? type,
    final String? email,
    final String? displayName,
    final List<String>? directmemberof,
    final List<String>? memberof,
    final List<EmailPasswordMetadata>? emailPasswordMetadata,
  }) => User(
    login: login ?? this.login,
    password: password ?? this.password,
    sshKeys: sshKeys ?? this.sshKeys,
    isFoundOnServer: isFoundOnServer ?? this.isFoundOnServer,
    note: note ?? this.note,
    type: type ?? this.type,
    email: email ?? this.email,
    displayName: displayName ?? this.displayName,
    directmemberof: directmemberof ?? this.directmemberof,
    memberof: memberof ?? this.memberof,
    emailPasswordMetadata: emailPasswordMetadata ?? this.emailPasswordMetadata,
  );
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
