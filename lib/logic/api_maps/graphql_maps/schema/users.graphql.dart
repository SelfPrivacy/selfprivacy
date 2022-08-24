import 'dart:async';
import 'disk_volumes.graphql.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:json_annotation/json_annotation.dart';
import 'schema.graphql.dart';
part 'users.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Fragment$basicMutationReturnFields {
  Fragment$basicMutationReturnFields(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Fragment$basicMutationReturnFields.fromJson(
          Map<String, dynamic> json) =>
      _$Fragment$basicMutationReturnFieldsFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Fragment$basicMutationReturnFieldsToJson(this);
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Fragment$basicMutationReturnFields) ||
        runtimeType != other.runtimeType) return false;
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) return false;
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) return false;
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Fragment$basicMutationReturnFields
    on Fragment$basicMutationReturnFields {
  Fragment$basicMutationReturnFields copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Fragment$basicMutationReturnFields(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const fragmentDefinitionbasicMutationReturnFields = FragmentDefinitionNode(
    name: NameNode(value: 'basicMutationReturnFields'),
    typeCondition: TypeConditionNode(
        on: NamedTypeNode(
            name: NameNode(value: 'MutationReturnInterface'),
            isNonNull: false)),
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
          name: NameNode(value: 'code'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null),
      FieldNode(
          name: NameNode(value: 'message'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null),
      FieldNode(
          name: NameNode(value: 'success'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null),
      FieldNode(
          name: NameNode(value: '__typename'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null)
    ]));
const documentNodeFragmentbasicMutationReturnFields =
    DocumentNode(definitions: [
  fragmentDefinitionbasicMutationReturnFields,
]);

extension ClientExtension$Fragment$basicMutationReturnFields
    on graphql.GraphQLClient {
  void writeFragment$basicMutationReturnFields(
          {required Fragment$basicMutationReturnFields data,
          required Map<String, dynamic> idFields,
          bool broadcast = true}) =>
      this.writeFragment(
          graphql.FragmentRequest(
              idFields: idFields,
              fragment: const graphql.Fragment(
                  fragmentName: 'basicMutationReturnFields',
                  document: documentNodeFragmentbasicMutationReturnFields)),
          data: data.toJson(),
          broadcast: broadcast);
  Fragment$basicMutationReturnFields? readFragment$basicMutationReturnFields(
      {required Map<String, dynamic> idFields, bool optimistic = true}) {
    final result = this.readFragment(
        graphql.FragmentRequest(
            idFields: idFields,
            fragment: const graphql.Fragment(
                fragmentName: 'basicMutationReturnFields',
                document: documentNodeFragmentbasicMutationReturnFields)),
        optimistic: optimistic);
    return result == null
        ? null
        : Fragment$basicMutationReturnFields.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$CreateUser {
  Variables$Mutation$CreateUser({required this.user});

  @override
  factory Variables$Mutation$CreateUser.fromJson(Map<String, dynamic> json) =>
      _$Variables$Mutation$CreateUserFromJson(json);

  final Input$UserMutationInput user;

  Map<String, dynamic> toJson() => _$Variables$Mutation$CreateUserToJson(this);
  int get hashCode {
    final l$user = user;
    return Object.hashAll([l$user]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$CreateUser) ||
        runtimeType != other.runtimeType) return false;
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) return false;
    return true;
  }

  Variables$Mutation$CreateUser copyWith({Input$UserMutationInput? user}) =>
      Variables$Mutation$CreateUser(user: user == null ? this.user : user);
}

@JsonSerializable(explicitToJson: true)
class Mutation$CreateUser {
  Mutation$CreateUser({required this.createUser, required this.$__typename});

  @override
  factory Mutation$CreateUser.fromJson(Map<String, dynamic> json) =>
      _$Mutation$CreateUserFromJson(json);

  final Mutation$CreateUser$createUser createUser;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$CreateUserToJson(this);
  int get hashCode {
    final l$createUser = createUser;
    final l$$__typename = $__typename;
    return Object.hashAll([l$createUser, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$CreateUser) || runtimeType != other.runtimeType)
      return false;
    final l$createUser = createUser;
    final lOther$createUser = other.createUser;
    if (l$createUser != lOther$createUser) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$CreateUser on Mutation$CreateUser {
  Mutation$CreateUser copyWith(
          {Mutation$CreateUser$createUser? createUser, String? $__typename}) =>
      Mutation$CreateUser(
          createUser: createUser == null ? this.createUser : createUser,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationCreateUser = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'CreateUser'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'user')),
            type: NamedTypeNode(
                name: NameNode(value: 'UserMutationInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createUser'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'user'),
                  value: VariableNode(name: NameNode(value: 'user')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'userType'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'sshKeys'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$CreateUser _parserFn$Mutation$CreateUser(Map<String, dynamic> data) =>
    Mutation$CreateUser.fromJson(data);
typedef OnMutationCompleted$Mutation$CreateUser = FutureOr<void> Function(
    dynamic, Mutation$CreateUser?);

class Options$Mutation$CreateUser
    extends graphql.MutationOptions<Mutation$CreateUser> {
  Options$Mutation$CreateUser(
      {String? operationName,
      required Variables$Mutation$CreateUser variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$CreateUser? onCompleted,
      graphql.OnMutationUpdate<Mutation$CreateUser>? update,
      graphql.OnError? onError})
      : onCompletedWithParsed = onCompleted,
        super(
            variables: variables.toJson(),
            operationName: operationName,
            fetchPolicy: fetchPolicy,
            errorPolicy: errorPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            optimisticResult: optimisticResult,
            context: context,
            onCompleted: onCompleted == null
                ? null
                : (data) => onCompleted(data,
                    data == null ? null : _parserFn$Mutation$CreateUser(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationCreateUser,
            parserFn: _parserFn$Mutation$CreateUser);

  final OnMutationCompleted$Mutation$CreateUser? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$CreateUser
    extends graphql.WatchQueryOptions<Mutation$CreateUser> {
  WatchOptions$Mutation$CreateUser(
      {String? operationName,
      required Variables$Mutation$CreateUser variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      Duration? pollInterval,
      bool? eagerlyFetchResults,
      bool carryForwardDataOnException = true,
      bool fetchResults = false})
      : super(
            variables: variables.toJson(),
            operationName: operationName,
            fetchPolicy: fetchPolicy,
            errorPolicy: errorPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            optimisticResult: optimisticResult,
            context: context,
            document: documentNodeMutationCreateUser,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$CreateUser);
}

extension ClientExtension$Mutation$CreateUser on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$CreateUser>> mutate$CreateUser(
          Options$Mutation$CreateUser options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$CreateUser> watchMutation$CreateUser(
          WatchOptions$Mutation$CreateUser options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$CreateUser$createUser
    implements Fragment$basicMutationReturnFields {
  Mutation$CreateUser$createUser(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename,
      this.user});

  @override
  factory Mutation$CreateUser$createUser.fromJson(Map<String, dynamic> json) =>
      _$Mutation$CreateUser$createUserFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  final Mutation$CreateUser$createUser$user? user;

  Map<String, dynamic> toJson() => _$Mutation$CreateUser$createUserToJson(this);
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$user = user;
    return Object.hashAll(
        [l$code, l$message, l$success, l$$__typename, l$user]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$CreateUser$createUser) ||
        runtimeType != other.runtimeType) return false;
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) return false;
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) return false;
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$CreateUser$createUser
    on Mutation$CreateUser$createUser {
  Mutation$CreateUser$createUser copyWith(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          Mutation$CreateUser$createUser$user? Function()? user}) =>
      Mutation$CreateUser$createUser(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename,
          user: user == null ? this.user : user());
}

@JsonSerializable(explicitToJson: true)
class Mutation$CreateUser$createUser$user {
  Mutation$CreateUser$createUser$user(
      {required this.username,
      required this.userType,
      required this.sshKeys,
      required this.$__typename});

  @override
  factory Mutation$CreateUser$createUser$user.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$CreateUser$createUser$userFromJson(json);

  final String username;

  @JsonKey(unknownEnumValue: Enum$UserType.$unknown)
  final Enum$UserType userType;

  final List<String> sshKeys;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$CreateUser$createUser$userToJson(this);
  int get hashCode {
    final l$username = username;
    final l$userType = userType;
    final l$sshKeys = sshKeys;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$username,
      l$userType,
      Object.hashAll(l$sshKeys.map((v) => v)),
      l$$__typename
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$CreateUser$createUser$user) ||
        runtimeType != other.runtimeType) return false;
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) return false;
    final l$userType = userType;
    final lOther$userType = other.userType;
    if (l$userType != lOther$userType) return false;
    final l$sshKeys = sshKeys;
    final lOther$sshKeys = other.sshKeys;
    if (l$sshKeys.length != lOther$sshKeys.length) return false;
    for (int i = 0; i < l$sshKeys.length; i++) {
      final l$sshKeys$entry = l$sshKeys[i];
      final lOther$sshKeys$entry = lOther$sshKeys[i];
      if (l$sshKeys$entry != lOther$sshKeys$entry) return false;
    }

    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$CreateUser$createUser$user
    on Mutation$CreateUser$createUser$user {
  Mutation$CreateUser$createUser$user copyWith(
          {String? username,
          Enum$UserType? userType,
          List<String>? sshKeys,
          String? $__typename}) =>
      Mutation$CreateUser$createUser$user(
          username: username == null ? this.username : username,
          userType: userType == null ? this.userType : userType,
          sshKeys: sshKeys == null ? this.sshKeys : sshKeys,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Query$AllUsers {
  Query$AllUsers({required this.users, required this.$__typename});

  @override
  factory Query$AllUsers.fromJson(Map<String, dynamic> json) =>
      _$Query$AllUsersFromJson(json);

  final Query$AllUsers$users users;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$AllUsersToJson(this);
  int get hashCode {
    final l$users = users;
    final l$$__typename = $__typename;
    return Object.hashAll([l$users, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$AllUsers) || runtimeType != other.runtimeType)
      return false;
    final l$users = users;
    final lOther$users = other.users;
    if (l$users != lOther$users) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$AllUsers on Query$AllUsers {
  Query$AllUsers copyWith({Query$AllUsers$users? users, String? $__typename}) =>
      Query$AllUsers(
          users: users == null ? this.users : users,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeQueryAllUsers = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'AllUsers'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'users'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'allUsers'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'userType'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'sshKeys'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
]);
Query$AllUsers _parserFn$Query$AllUsers(Map<String, dynamic> data) =>
    Query$AllUsers.fromJson(data);

class Options$Query$AllUsers extends graphql.QueryOptions<Query$AllUsers> {
  Options$Query$AllUsers(
      {String? operationName,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      Duration? pollInterval,
      graphql.Context? context})
      : super(
            operationName: operationName,
            fetchPolicy: fetchPolicy,
            errorPolicy: errorPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            optimisticResult: optimisticResult,
            pollInterval: pollInterval,
            context: context,
            document: documentNodeQueryAllUsers,
            parserFn: _parserFn$Query$AllUsers);
}

class WatchOptions$Query$AllUsers
    extends graphql.WatchQueryOptions<Query$AllUsers> {
  WatchOptions$Query$AllUsers(
      {String? operationName,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      Duration? pollInterval,
      bool? eagerlyFetchResults,
      bool carryForwardDataOnException = true,
      bool fetchResults = false})
      : super(
            operationName: operationName,
            fetchPolicy: fetchPolicy,
            errorPolicy: errorPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            optimisticResult: optimisticResult,
            context: context,
            document: documentNodeQueryAllUsers,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Query$AllUsers);
}

class FetchMoreOptions$Query$AllUsers extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$AllUsers({required graphql.UpdateQuery updateQuery})
      : super(updateQuery: updateQuery, document: documentNodeQueryAllUsers);
}

extension ClientExtension$Query$AllUsers on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$AllUsers>> query$AllUsers(
          [Options$Query$AllUsers? options]) async =>
      await this.query(options ?? Options$Query$AllUsers());
  graphql.ObservableQuery<Query$AllUsers> watchQuery$AllUsers(
          [WatchOptions$Query$AllUsers? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$AllUsers());
  void writeQuery$AllUsers(
          {required Query$AllUsers data, bool broadcast = true}) =>
      this.writeQuery(
          graphql.Request(
              operation:
                  graphql.Operation(document: documentNodeQueryAllUsers)),
          data: data.toJson(),
          broadcast: broadcast);
  Query$AllUsers? readQuery$AllUsers({bool optimistic = true}) {
    final result = this.readQuery(
        graphql.Request(
            operation: graphql.Operation(document: documentNodeQueryAllUsers)),
        optimistic: optimistic);
    return result == null ? null : Query$AllUsers.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Query$AllUsers$users {
  Query$AllUsers$users({required this.allUsers, required this.$__typename});

  @override
  factory Query$AllUsers$users.fromJson(Map<String, dynamic> json) =>
      _$Query$AllUsers$usersFromJson(json);

  final List<Query$AllUsers$users$allUsers> allUsers;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$AllUsers$usersToJson(this);
  int get hashCode {
    final l$allUsers = allUsers;
    final l$$__typename = $__typename;
    return Object.hashAll(
        [Object.hashAll(l$allUsers.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$AllUsers$users) || runtimeType != other.runtimeType)
      return false;
    final l$allUsers = allUsers;
    final lOther$allUsers = other.allUsers;
    if (l$allUsers.length != lOther$allUsers.length) return false;
    for (int i = 0; i < l$allUsers.length; i++) {
      final l$allUsers$entry = l$allUsers[i];
      final lOther$allUsers$entry = lOther$allUsers[i];
      if (l$allUsers$entry != lOther$allUsers$entry) return false;
    }

    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$AllUsers$users on Query$AllUsers$users {
  Query$AllUsers$users copyWith(
          {List<Query$AllUsers$users$allUsers>? allUsers,
          String? $__typename}) =>
      Query$AllUsers$users(
          allUsers: allUsers == null ? this.allUsers : allUsers,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Query$AllUsers$users$allUsers {
  Query$AllUsers$users$allUsers(
      {required this.userType,
      required this.username,
      required this.sshKeys,
      required this.$__typename});

  @override
  factory Query$AllUsers$users$allUsers.fromJson(Map<String, dynamic> json) =>
      _$Query$AllUsers$users$allUsersFromJson(json);

  @JsonKey(unknownEnumValue: Enum$UserType.$unknown)
  final Enum$UserType userType;

  final String username;

  final List<String> sshKeys;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$AllUsers$users$allUsersToJson(this);
  int get hashCode {
    final l$userType = userType;
    final l$username = username;
    final l$sshKeys = sshKeys;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$userType,
      l$username,
      Object.hashAll(l$sshKeys.map((v) => v)),
      l$$__typename
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$AllUsers$users$allUsers) ||
        runtimeType != other.runtimeType) return false;
    final l$userType = userType;
    final lOther$userType = other.userType;
    if (l$userType != lOther$userType) return false;
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) return false;
    final l$sshKeys = sshKeys;
    final lOther$sshKeys = other.sshKeys;
    if (l$sshKeys.length != lOther$sshKeys.length) return false;
    for (int i = 0; i < l$sshKeys.length; i++) {
      final l$sshKeys$entry = l$sshKeys[i];
      final lOther$sshKeys$entry = lOther$sshKeys[i];
      if (l$sshKeys$entry != lOther$sshKeys$entry) return false;
    }

    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$AllUsers$users$allUsers
    on Query$AllUsers$users$allUsers {
  Query$AllUsers$users$allUsers copyWith(
          {Enum$UserType? userType,
          String? username,
          List<String>? sshKeys,
          String? $__typename}) =>
      Query$AllUsers$users$allUsers(
          userType: userType == null ? this.userType : userType,
          username: username == null ? this.username : username,
          sshKeys: sshKeys == null ? this.sshKeys : sshKeys,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$AddSshKey {
  Variables$Mutation$AddSshKey({required this.sshInput});

  @override
  factory Variables$Mutation$AddSshKey.fromJson(Map<String, dynamic> json) =>
      _$Variables$Mutation$AddSshKeyFromJson(json);

  final Input$SshMutationInput sshInput;

  Map<String, dynamic> toJson() => _$Variables$Mutation$AddSshKeyToJson(this);
  int get hashCode {
    final l$sshInput = sshInput;
    return Object.hashAll([l$sshInput]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$AddSshKey) ||
        runtimeType != other.runtimeType) return false;
    final l$sshInput = sshInput;
    final lOther$sshInput = other.sshInput;
    if (l$sshInput != lOther$sshInput) return false;
    return true;
  }

  Variables$Mutation$AddSshKey copyWith({Input$SshMutationInput? sshInput}) =>
      Variables$Mutation$AddSshKey(
          sshInput: sshInput == null ? this.sshInput : sshInput);
}

@JsonSerializable(explicitToJson: true)
class Mutation$AddSshKey {
  Mutation$AddSshKey({required this.addSshKey, required this.$__typename});

  @override
  factory Mutation$AddSshKey.fromJson(Map<String, dynamic> json) =>
      _$Mutation$AddSshKeyFromJson(json);

  final Mutation$AddSshKey$addSshKey addSshKey;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$AddSshKeyToJson(this);
  int get hashCode {
    final l$addSshKey = addSshKey;
    final l$$__typename = $__typename;
    return Object.hashAll([l$addSshKey, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$AddSshKey) || runtimeType != other.runtimeType)
      return false;
    final l$addSshKey = addSshKey;
    final lOther$addSshKey = other.addSshKey;
    if (l$addSshKey != lOther$addSshKey) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$AddSshKey on Mutation$AddSshKey {
  Mutation$AddSshKey copyWith(
          {Mutation$AddSshKey$addSshKey? addSshKey, String? $__typename}) =>
      Mutation$AddSshKey(
          addSshKey: addSshKey == null ? this.addSshKey : addSshKey,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationAddSshKey = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AddSshKey'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'sshInput')),
            type: NamedTypeNode(
                name: NameNode(value: 'SshMutationInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'addSshKey'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'sshInput'),
                  value: VariableNode(name: NameNode(value: 'sshInput')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'sshKeys'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'userType'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$AddSshKey _parserFn$Mutation$AddSshKey(Map<String, dynamic> data) =>
    Mutation$AddSshKey.fromJson(data);
typedef OnMutationCompleted$Mutation$AddSshKey = FutureOr<void> Function(
    dynamic, Mutation$AddSshKey?);

class Options$Mutation$AddSshKey
    extends graphql.MutationOptions<Mutation$AddSshKey> {
  Options$Mutation$AddSshKey(
      {String? operationName,
      required Variables$Mutation$AddSshKey variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$AddSshKey? onCompleted,
      graphql.OnMutationUpdate<Mutation$AddSshKey>? update,
      graphql.OnError? onError})
      : onCompletedWithParsed = onCompleted,
        super(
            variables: variables.toJson(),
            operationName: operationName,
            fetchPolicy: fetchPolicy,
            errorPolicy: errorPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            optimisticResult: optimisticResult,
            context: context,
            onCompleted: onCompleted == null
                ? null
                : (data) => onCompleted(data,
                    data == null ? null : _parserFn$Mutation$AddSshKey(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationAddSshKey,
            parserFn: _parserFn$Mutation$AddSshKey);

  final OnMutationCompleted$Mutation$AddSshKey? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$AddSshKey
    extends graphql.WatchQueryOptions<Mutation$AddSshKey> {
  WatchOptions$Mutation$AddSshKey(
      {String? operationName,
      required Variables$Mutation$AddSshKey variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      Duration? pollInterval,
      bool? eagerlyFetchResults,
      bool carryForwardDataOnException = true,
      bool fetchResults = false})
      : super(
            variables: variables.toJson(),
            operationName: operationName,
            fetchPolicy: fetchPolicy,
            errorPolicy: errorPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            optimisticResult: optimisticResult,
            context: context,
            document: documentNodeMutationAddSshKey,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$AddSshKey);
}

extension ClientExtension$Mutation$AddSshKey on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$AddSshKey>> mutate$AddSshKey(
          Options$Mutation$AddSshKey options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$AddSshKey> watchMutation$AddSshKey(
          WatchOptions$Mutation$AddSshKey options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$AddSshKey$addSshKey
    implements Fragment$basicMutationReturnFields {
  Mutation$AddSshKey$addSshKey(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename,
      this.user});

  @override
  factory Mutation$AddSshKey$addSshKey.fromJson(Map<String, dynamic> json) =>
      _$Mutation$AddSshKey$addSshKeyFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  final Mutation$AddSshKey$addSshKey$user? user;

  Map<String, dynamic> toJson() => _$Mutation$AddSshKey$addSshKeyToJson(this);
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$user = user;
    return Object.hashAll(
        [l$code, l$message, l$success, l$$__typename, l$user]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$AddSshKey$addSshKey) ||
        runtimeType != other.runtimeType) return false;
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) return false;
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) return false;
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$AddSshKey$addSshKey
    on Mutation$AddSshKey$addSshKey {
  Mutation$AddSshKey$addSshKey copyWith(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          Mutation$AddSshKey$addSshKey$user? Function()? user}) =>
      Mutation$AddSshKey$addSshKey(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename,
          user: user == null ? this.user : user());
}

@JsonSerializable(explicitToJson: true)
class Mutation$AddSshKey$addSshKey$user {
  Mutation$AddSshKey$addSshKey$user(
      {required this.sshKeys,
      required this.userType,
      required this.username,
      required this.$__typename});

  @override
  factory Mutation$AddSshKey$addSshKey$user.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$AddSshKey$addSshKey$userFromJson(json);

  final List<String> sshKeys;

  @JsonKey(unknownEnumValue: Enum$UserType.$unknown)
  final Enum$UserType userType;

  final String username;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$AddSshKey$addSshKey$userToJson(this);
  int get hashCode {
    final l$sshKeys = sshKeys;
    final l$userType = userType;
    final l$username = username;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$sshKeys.map((v) => v)),
      l$userType,
      l$username,
      l$$__typename
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$AddSshKey$addSshKey$user) ||
        runtimeType != other.runtimeType) return false;
    final l$sshKeys = sshKeys;
    final lOther$sshKeys = other.sshKeys;
    if (l$sshKeys.length != lOther$sshKeys.length) return false;
    for (int i = 0; i < l$sshKeys.length; i++) {
      final l$sshKeys$entry = l$sshKeys[i];
      final lOther$sshKeys$entry = lOther$sshKeys[i];
      if (l$sshKeys$entry != lOther$sshKeys$entry) return false;
    }

    final l$userType = userType;
    final lOther$userType = other.userType;
    if (l$userType != lOther$userType) return false;
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$AddSshKey$addSshKey$user
    on Mutation$AddSshKey$addSshKey$user {
  Mutation$AddSshKey$addSshKey$user copyWith(
          {List<String>? sshKeys,
          Enum$UserType? userType,
          String? username,
          String? $__typename}) =>
      Mutation$AddSshKey$addSshKey$user(
          sshKeys: sshKeys == null ? this.sshKeys : sshKeys,
          userType: userType == null ? this.userType : userType,
          username: username == null ? this.username : username,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Variables$Query$GetUser {
  Variables$Query$GetUser({required this.username});

  @override
  factory Variables$Query$GetUser.fromJson(Map<String, dynamic> json) =>
      _$Variables$Query$GetUserFromJson(json);

  final String username;

  Map<String, dynamic> toJson() => _$Variables$Query$GetUserToJson(this);
  int get hashCode {
    final l$username = username;
    return Object.hashAll([l$username]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Query$GetUser) || runtimeType != other.runtimeType)
      return false;
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) return false;
    return true;
  }

  Variables$Query$GetUser copyWith({String? username}) =>
      Variables$Query$GetUser(
          username: username == null ? this.username : username);
}

@JsonSerializable(explicitToJson: true)
class Query$GetUser {
  Query$GetUser({required this.users, required this.$__typename});

  @override
  factory Query$GetUser.fromJson(Map<String, dynamic> json) =>
      _$Query$GetUserFromJson(json);

  final Query$GetUser$users users;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetUserToJson(this);
  int get hashCode {
    final l$users = users;
    final l$$__typename = $__typename;
    return Object.hashAll([l$users, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetUser) || runtimeType != other.runtimeType)
      return false;
    final l$users = users;
    final lOther$users = other.users;
    if (l$users != lOther$users) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetUser on Query$GetUser {
  Query$GetUser copyWith({Query$GetUser$users? users, String? $__typename}) =>
      Query$GetUser(
          users: users == null ? this.users : users,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeQueryGetUser = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetUser'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'username')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'users'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'getUser'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                        name: NameNode(value: 'username'),
                        value: VariableNode(name: NameNode(value: 'username')))
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'sshKeys'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'userType'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
]);
Query$GetUser _parserFn$Query$GetUser(Map<String, dynamic> data) =>
    Query$GetUser.fromJson(data);

class Options$Query$GetUser extends graphql.QueryOptions<Query$GetUser> {
  Options$Query$GetUser(
      {String? operationName,
      required Variables$Query$GetUser variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      Duration? pollInterval,
      graphql.Context? context})
      : super(
            variables: variables.toJson(),
            operationName: operationName,
            fetchPolicy: fetchPolicy,
            errorPolicy: errorPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            optimisticResult: optimisticResult,
            pollInterval: pollInterval,
            context: context,
            document: documentNodeQueryGetUser,
            parserFn: _parserFn$Query$GetUser);
}

class WatchOptions$Query$GetUser
    extends graphql.WatchQueryOptions<Query$GetUser> {
  WatchOptions$Query$GetUser(
      {String? operationName,
      required Variables$Query$GetUser variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      Duration? pollInterval,
      bool? eagerlyFetchResults,
      bool carryForwardDataOnException = true,
      bool fetchResults = false})
      : super(
            variables: variables.toJson(),
            operationName: operationName,
            fetchPolicy: fetchPolicy,
            errorPolicy: errorPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            optimisticResult: optimisticResult,
            context: context,
            document: documentNodeQueryGetUser,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Query$GetUser);
}

class FetchMoreOptions$Query$GetUser extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetUser(
      {required graphql.UpdateQuery updateQuery,
      required Variables$Query$GetUser variables})
      : super(
            updateQuery: updateQuery,
            variables: variables.toJson(),
            document: documentNodeQueryGetUser);
}

extension ClientExtension$Query$GetUser on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetUser>> query$GetUser(
          Options$Query$GetUser options) async =>
      await this.query(options);
  graphql.ObservableQuery<Query$GetUser> watchQuery$GetUser(
          WatchOptions$Query$GetUser options) =>
      this.watchQuery(options);
  void writeQuery$GetUser(
          {required Query$GetUser data,
          required Variables$Query$GetUser variables,
          bool broadcast = true}) =>
      this.writeQuery(
          graphql.Request(
              operation: graphql.Operation(document: documentNodeQueryGetUser),
              variables: variables.toJson()),
          data: data.toJson(),
          broadcast: broadcast);
  Query$GetUser? readQuery$GetUser(
      {required Variables$Query$GetUser variables, bool optimistic = true}) {
    final result = this.readQuery(
        graphql.Request(
            operation: graphql.Operation(document: documentNodeQueryGetUser),
            variables: variables.toJson()),
        optimistic: optimistic);
    return result == null ? null : Query$GetUser.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Query$GetUser$users {
  Query$GetUser$users({this.getUser, required this.$__typename});

  @override
  factory Query$GetUser$users.fromJson(Map<String, dynamic> json) =>
      _$Query$GetUser$usersFromJson(json);

  final Query$GetUser$users$getUser? getUser;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetUser$usersToJson(this);
  int get hashCode {
    final l$getUser = getUser;
    final l$$__typename = $__typename;
    return Object.hashAll([l$getUser, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetUser$users) || runtimeType != other.runtimeType)
      return false;
    final l$getUser = getUser;
    final lOther$getUser = other.getUser;
    if (l$getUser != lOther$getUser) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetUser$users on Query$GetUser$users {
  Query$GetUser$users copyWith(
          {Query$GetUser$users$getUser? Function()? getUser,
          String? $__typename}) =>
      Query$GetUser$users(
          getUser: getUser == null ? this.getUser : getUser(),
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Query$GetUser$users$getUser {
  Query$GetUser$users$getUser(
      {required this.sshKeys,
      required this.userType,
      required this.username,
      required this.$__typename});

  @override
  factory Query$GetUser$users$getUser.fromJson(Map<String, dynamic> json) =>
      _$Query$GetUser$users$getUserFromJson(json);

  final List<String> sshKeys;

  @JsonKey(unknownEnumValue: Enum$UserType.$unknown)
  final Enum$UserType userType;

  final String username;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetUser$users$getUserToJson(this);
  int get hashCode {
    final l$sshKeys = sshKeys;
    final l$userType = userType;
    final l$username = username;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$sshKeys.map((v) => v)),
      l$userType,
      l$username,
      l$$__typename
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetUser$users$getUser) ||
        runtimeType != other.runtimeType) return false;
    final l$sshKeys = sshKeys;
    final lOther$sshKeys = other.sshKeys;
    if (l$sshKeys.length != lOther$sshKeys.length) return false;
    for (int i = 0; i < l$sshKeys.length; i++) {
      final l$sshKeys$entry = l$sshKeys[i];
      final lOther$sshKeys$entry = lOther$sshKeys[i];
      if (l$sshKeys$entry != lOther$sshKeys$entry) return false;
    }

    final l$userType = userType;
    final lOther$userType = other.userType;
    if (l$userType != lOther$userType) return false;
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetUser$users$getUser
    on Query$GetUser$users$getUser {
  Query$GetUser$users$getUser copyWith(
          {List<String>? sshKeys,
          Enum$UserType? userType,
          String? username,
          String? $__typename}) =>
      Query$GetUser$users$getUser(
          sshKeys: sshKeys == null ? this.sshKeys : sshKeys,
          userType: userType == null ? this.userType : userType,
          username: username == null ? this.username : username,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$RemoveSshKey {
  Variables$Mutation$RemoveSshKey({required this.sshInput});

  @override
  factory Variables$Mutation$RemoveSshKey.fromJson(Map<String, dynamic> json) =>
      _$Variables$Mutation$RemoveSshKeyFromJson(json);

  final Input$SshMutationInput sshInput;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$RemoveSshKeyToJson(this);
  int get hashCode {
    final l$sshInput = sshInput;
    return Object.hashAll([l$sshInput]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$RemoveSshKey) ||
        runtimeType != other.runtimeType) return false;
    final l$sshInput = sshInput;
    final lOther$sshInput = other.sshInput;
    if (l$sshInput != lOther$sshInput) return false;
    return true;
  }

  Variables$Mutation$RemoveSshKey copyWith(
          {Input$SshMutationInput? sshInput}) =>
      Variables$Mutation$RemoveSshKey(
          sshInput: sshInput == null ? this.sshInput : sshInput);
}

@JsonSerializable(explicitToJson: true)
class Mutation$RemoveSshKey {
  Mutation$RemoveSshKey(
      {required this.removeSshKey, required this.$__typename});

  @override
  factory Mutation$RemoveSshKey.fromJson(Map<String, dynamic> json) =>
      _$Mutation$RemoveSshKeyFromJson(json);

  final Mutation$RemoveSshKey$removeSshKey removeSshKey;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$RemoveSshKeyToJson(this);
  int get hashCode {
    final l$removeSshKey = removeSshKey;
    final l$$__typename = $__typename;
    return Object.hashAll([l$removeSshKey, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$RemoveSshKey) || runtimeType != other.runtimeType)
      return false;
    final l$removeSshKey = removeSshKey;
    final lOther$removeSshKey = other.removeSshKey;
    if (l$removeSshKey != lOther$removeSshKey) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$RemoveSshKey on Mutation$RemoveSshKey {
  Mutation$RemoveSshKey copyWith(
          {Mutation$RemoveSshKey$removeSshKey? removeSshKey,
          String? $__typename}) =>
      Mutation$RemoveSshKey(
          removeSshKey: removeSshKey == null ? this.removeSshKey : removeSshKey,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationRemoveSshKey = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RemoveSshKey'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'sshInput')),
            type: NamedTypeNode(
                name: NameNode(value: 'SshMutationInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'removeSshKey'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'sshInput'),
                  value: VariableNode(name: NameNode(value: 'sshInput')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'sshKeys'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'userType'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$RemoveSshKey _parserFn$Mutation$RemoveSshKey(
        Map<String, dynamic> data) =>
    Mutation$RemoveSshKey.fromJson(data);
typedef OnMutationCompleted$Mutation$RemoveSshKey = FutureOr<void> Function(
    dynamic, Mutation$RemoveSshKey?);

class Options$Mutation$RemoveSshKey
    extends graphql.MutationOptions<Mutation$RemoveSshKey> {
  Options$Mutation$RemoveSshKey(
      {String? operationName,
      required Variables$Mutation$RemoveSshKey variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$RemoveSshKey? onCompleted,
      graphql.OnMutationUpdate<Mutation$RemoveSshKey>? update,
      graphql.OnError? onError})
      : onCompletedWithParsed = onCompleted,
        super(
            variables: variables.toJson(),
            operationName: operationName,
            fetchPolicy: fetchPolicy,
            errorPolicy: errorPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            optimisticResult: optimisticResult,
            context: context,
            onCompleted: onCompleted == null
                ? null
                : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$RemoveSshKey(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationRemoveSshKey,
            parserFn: _parserFn$Mutation$RemoveSshKey);

  final OnMutationCompleted$Mutation$RemoveSshKey? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$RemoveSshKey
    extends graphql.WatchQueryOptions<Mutation$RemoveSshKey> {
  WatchOptions$Mutation$RemoveSshKey(
      {String? operationName,
      required Variables$Mutation$RemoveSshKey variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      Duration? pollInterval,
      bool? eagerlyFetchResults,
      bool carryForwardDataOnException = true,
      bool fetchResults = false})
      : super(
            variables: variables.toJson(),
            operationName: operationName,
            fetchPolicy: fetchPolicy,
            errorPolicy: errorPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            optimisticResult: optimisticResult,
            context: context,
            document: documentNodeMutationRemoveSshKey,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$RemoveSshKey);
}

extension ClientExtension$Mutation$RemoveSshKey on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RemoveSshKey>> mutate$RemoveSshKey(
          Options$Mutation$RemoveSshKey options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$RemoveSshKey> watchMutation$RemoveSshKey(
          WatchOptions$Mutation$RemoveSshKey options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$RemoveSshKey$removeSshKey
    implements Fragment$basicMutationReturnFields {
  Mutation$RemoveSshKey$removeSshKey(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename,
      this.user});

  @override
  factory Mutation$RemoveSshKey$removeSshKey.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$RemoveSshKey$removeSshKeyFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  final Mutation$RemoveSshKey$removeSshKey$user? user;

  Map<String, dynamic> toJson() =>
      _$Mutation$RemoveSshKey$removeSshKeyToJson(this);
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$user = user;
    return Object.hashAll(
        [l$code, l$message, l$success, l$$__typename, l$user]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$RemoveSshKey$removeSshKey) ||
        runtimeType != other.runtimeType) return false;
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) return false;
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) return false;
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$RemoveSshKey$removeSshKey
    on Mutation$RemoveSshKey$removeSshKey {
  Mutation$RemoveSshKey$removeSshKey copyWith(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          Mutation$RemoveSshKey$removeSshKey$user? Function()? user}) =>
      Mutation$RemoveSshKey$removeSshKey(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename,
          user: user == null ? this.user : user());
}

@JsonSerializable(explicitToJson: true)
class Mutation$RemoveSshKey$removeSshKey$user {
  Mutation$RemoveSshKey$removeSshKey$user(
      {required this.sshKeys,
      required this.userType,
      required this.username,
      required this.$__typename});

  @override
  factory Mutation$RemoveSshKey$removeSshKey$user.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$RemoveSshKey$removeSshKey$userFromJson(json);

  final List<String> sshKeys;

  @JsonKey(unknownEnumValue: Enum$UserType.$unknown)
  final Enum$UserType userType;

  final String username;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$RemoveSshKey$removeSshKey$userToJson(this);
  int get hashCode {
    final l$sshKeys = sshKeys;
    final l$userType = userType;
    final l$username = username;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$sshKeys.map((v) => v)),
      l$userType,
      l$username,
      l$$__typename
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$RemoveSshKey$removeSshKey$user) ||
        runtimeType != other.runtimeType) return false;
    final l$sshKeys = sshKeys;
    final lOther$sshKeys = other.sshKeys;
    if (l$sshKeys.length != lOther$sshKeys.length) return false;
    for (int i = 0; i < l$sshKeys.length; i++) {
      final l$sshKeys$entry = l$sshKeys[i];
      final lOther$sshKeys$entry = lOther$sshKeys[i];
      if (l$sshKeys$entry != lOther$sshKeys$entry) return false;
    }

    final l$userType = userType;
    final lOther$userType = other.userType;
    if (l$userType != lOther$userType) return false;
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$RemoveSshKey$removeSshKey$user
    on Mutation$RemoveSshKey$removeSshKey$user {
  Mutation$RemoveSshKey$removeSshKey$user copyWith(
          {List<String>? sshKeys,
          Enum$UserType? userType,
          String? username,
          String? $__typename}) =>
      Mutation$RemoveSshKey$removeSshKey$user(
          sshKeys: sshKeys == null ? this.sshKeys : sshKeys,
          userType: userType == null ? this.userType : userType,
          username: username == null ? this.username : username,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$DeleteUser {
  Variables$Mutation$DeleteUser({required this.username});

  @override
  factory Variables$Mutation$DeleteUser.fromJson(Map<String, dynamic> json) =>
      _$Variables$Mutation$DeleteUserFromJson(json);

  final String username;

  Map<String, dynamic> toJson() => _$Variables$Mutation$DeleteUserToJson(this);
  int get hashCode {
    final l$username = username;
    return Object.hashAll([l$username]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$DeleteUser) ||
        runtimeType != other.runtimeType) return false;
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) return false;
    return true;
  }

  Variables$Mutation$DeleteUser copyWith({String? username}) =>
      Variables$Mutation$DeleteUser(
          username: username == null ? this.username : username);
}

@JsonSerializable(explicitToJson: true)
class Mutation$DeleteUser {
  Mutation$DeleteUser({required this.deleteUser, required this.$__typename});

  @override
  factory Mutation$DeleteUser.fromJson(Map<String, dynamic> json) =>
      _$Mutation$DeleteUserFromJson(json);

  final Mutation$DeleteUser$deleteUser deleteUser;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$DeleteUserToJson(this);
  int get hashCode {
    final l$deleteUser = deleteUser;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deleteUser, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$DeleteUser) || runtimeType != other.runtimeType)
      return false;
    final l$deleteUser = deleteUser;
    final lOther$deleteUser = other.deleteUser;
    if (l$deleteUser != lOther$deleteUser) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$DeleteUser on Mutation$DeleteUser {
  Mutation$DeleteUser copyWith(
          {Mutation$DeleteUser$deleteUser? deleteUser, String? $__typename}) =>
      Mutation$DeleteUser(
          deleteUser: deleteUser == null ? this.deleteUser : deleteUser,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationDeleteUser = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteUser'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'username')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'deleteUser'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'username'),
                  value: VariableNode(name: NameNode(value: 'username')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$DeleteUser _parserFn$Mutation$DeleteUser(Map<String, dynamic> data) =>
    Mutation$DeleteUser.fromJson(data);
typedef OnMutationCompleted$Mutation$DeleteUser = FutureOr<void> Function(
    dynamic, Mutation$DeleteUser?);

class Options$Mutation$DeleteUser
    extends graphql.MutationOptions<Mutation$DeleteUser> {
  Options$Mutation$DeleteUser(
      {String? operationName,
      required Variables$Mutation$DeleteUser variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$DeleteUser? onCompleted,
      graphql.OnMutationUpdate<Mutation$DeleteUser>? update,
      graphql.OnError? onError})
      : onCompletedWithParsed = onCompleted,
        super(
            variables: variables.toJson(),
            operationName: operationName,
            fetchPolicy: fetchPolicy,
            errorPolicy: errorPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            optimisticResult: optimisticResult,
            context: context,
            onCompleted: onCompleted == null
                ? null
                : (data) => onCompleted(data,
                    data == null ? null : _parserFn$Mutation$DeleteUser(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationDeleteUser,
            parserFn: _parserFn$Mutation$DeleteUser);

  final OnMutationCompleted$Mutation$DeleteUser? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$DeleteUser
    extends graphql.WatchQueryOptions<Mutation$DeleteUser> {
  WatchOptions$Mutation$DeleteUser(
      {String? operationName,
      required Variables$Mutation$DeleteUser variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      Duration? pollInterval,
      bool? eagerlyFetchResults,
      bool carryForwardDataOnException = true,
      bool fetchResults = false})
      : super(
            variables: variables.toJson(),
            operationName: operationName,
            fetchPolicy: fetchPolicy,
            errorPolicy: errorPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            optimisticResult: optimisticResult,
            context: context,
            document: documentNodeMutationDeleteUser,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$DeleteUser);
}

extension ClientExtension$Mutation$DeleteUser on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$DeleteUser>> mutate$DeleteUser(
          Options$Mutation$DeleteUser options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$DeleteUser> watchMutation$DeleteUser(
          WatchOptions$Mutation$DeleteUser options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$DeleteUser$deleteUser
    implements Fragment$basicMutationReturnFields {
  Mutation$DeleteUser$deleteUser(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$DeleteUser$deleteUser.fromJson(Map<String, dynamic> json) =>
      _$Mutation$DeleteUser$deleteUserFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$DeleteUser$deleteUserToJson(this);
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$DeleteUser$deleteUser) ||
        runtimeType != other.runtimeType) return false;
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) return false;
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) return false;
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$DeleteUser$deleteUser
    on Mutation$DeleteUser$deleteUser {
  Mutation$DeleteUser$deleteUser copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$DeleteUser$deleteUser(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$UpdateUser {
  Variables$Mutation$UpdateUser({required this.user});

  @override
  factory Variables$Mutation$UpdateUser.fromJson(Map<String, dynamic> json) =>
      _$Variables$Mutation$UpdateUserFromJson(json);

  final Input$UserMutationInput user;

  Map<String, dynamic> toJson() => _$Variables$Mutation$UpdateUserToJson(this);
  int get hashCode {
    final l$user = user;
    return Object.hashAll([l$user]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$UpdateUser) ||
        runtimeType != other.runtimeType) return false;
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) return false;
    return true;
  }

  Variables$Mutation$UpdateUser copyWith({Input$UserMutationInput? user}) =>
      Variables$Mutation$UpdateUser(user: user == null ? this.user : user);
}

@JsonSerializable(explicitToJson: true)
class Mutation$UpdateUser {
  Mutation$UpdateUser({required this.updateUser, required this.$__typename});

  @override
  factory Mutation$UpdateUser.fromJson(Map<String, dynamic> json) =>
      _$Mutation$UpdateUserFromJson(json);

  final Mutation$UpdateUser$updateUser updateUser;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$UpdateUserToJson(this);
  int get hashCode {
    final l$updateUser = updateUser;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateUser, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$UpdateUser) || runtimeType != other.runtimeType)
      return false;
    final l$updateUser = updateUser;
    final lOther$updateUser = other.updateUser;
    if (l$updateUser != lOther$updateUser) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$UpdateUser on Mutation$UpdateUser {
  Mutation$UpdateUser copyWith(
          {Mutation$UpdateUser$updateUser? updateUser, String? $__typename}) =>
      Mutation$UpdateUser(
          updateUser: updateUser == null ? this.updateUser : updateUser,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationUpdateUser = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateUser'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'user')),
            type: NamedTypeNode(
                name: NameNode(value: 'UserMutationInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateUser'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'user'),
                  value: VariableNode(name: NameNode(value: 'user')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'sshKeys'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'userType'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$UpdateUser _parserFn$Mutation$UpdateUser(Map<String, dynamic> data) =>
    Mutation$UpdateUser.fromJson(data);
typedef OnMutationCompleted$Mutation$UpdateUser = FutureOr<void> Function(
    dynamic, Mutation$UpdateUser?);

class Options$Mutation$UpdateUser
    extends graphql.MutationOptions<Mutation$UpdateUser> {
  Options$Mutation$UpdateUser(
      {String? operationName,
      required Variables$Mutation$UpdateUser variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$UpdateUser? onCompleted,
      graphql.OnMutationUpdate<Mutation$UpdateUser>? update,
      graphql.OnError? onError})
      : onCompletedWithParsed = onCompleted,
        super(
            variables: variables.toJson(),
            operationName: operationName,
            fetchPolicy: fetchPolicy,
            errorPolicy: errorPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            optimisticResult: optimisticResult,
            context: context,
            onCompleted: onCompleted == null
                ? null
                : (data) => onCompleted(data,
                    data == null ? null : _parserFn$Mutation$UpdateUser(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationUpdateUser,
            parserFn: _parserFn$Mutation$UpdateUser);

  final OnMutationCompleted$Mutation$UpdateUser? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$UpdateUser
    extends graphql.WatchQueryOptions<Mutation$UpdateUser> {
  WatchOptions$Mutation$UpdateUser(
      {String? operationName,
      required Variables$Mutation$UpdateUser variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      Duration? pollInterval,
      bool? eagerlyFetchResults,
      bool carryForwardDataOnException = true,
      bool fetchResults = false})
      : super(
            variables: variables.toJson(),
            operationName: operationName,
            fetchPolicy: fetchPolicy,
            errorPolicy: errorPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            optimisticResult: optimisticResult,
            context: context,
            document: documentNodeMutationUpdateUser,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$UpdateUser);
}

extension ClientExtension$Mutation$UpdateUser on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UpdateUser>> mutate$UpdateUser(
          Options$Mutation$UpdateUser options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$UpdateUser> watchMutation$UpdateUser(
          WatchOptions$Mutation$UpdateUser options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$UpdateUser$updateUser
    implements Fragment$basicMutationReturnFields {
  Mutation$UpdateUser$updateUser(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename,
      this.user});

  @override
  factory Mutation$UpdateUser$updateUser.fromJson(Map<String, dynamic> json) =>
      _$Mutation$UpdateUser$updateUserFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  final Mutation$UpdateUser$updateUser$user? user;

  Map<String, dynamic> toJson() => _$Mutation$UpdateUser$updateUserToJson(this);
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$user = user;
    return Object.hashAll(
        [l$code, l$message, l$success, l$$__typename, l$user]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$UpdateUser$updateUser) ||
        runtimeType != other.runtimeType) return false;
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) return false;
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) return false;
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$UpdateUser$updateUser
    on Mutation$UpdateUser$updateUser {
  Mutation$UpdateUser$updateUser copyWith(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          Mutation$UpdateUser$updateUser$user? Function()? user}) =>
      Mutation$UpdateUser$updateUser(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename,
          user: user == null ? this.user : user());
}

@JsonSerializable(explicitToJson: true)
class Mutation$UpdateUser$updateUser$user {
  Mutation$UpdateUser$updateUser$user(
      {required this.sshKeys,
      required this.userType,
      required this.username,
      required this.$__typename});

  @override
  factory Mutation$UpdateUser$updateUser$user.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$UpdateUser$updateUser$userFromJson(json);

  final List<String> sshKeys;

  @JsonKey(unknownEnumValue: Enum$UserType.$unknown)
  final Enum$UserType userType;

  final String username;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$UpdateUser$updateUser$userToJson(this);
  int get hashCode {
    final l$sshKeys = sshKeys;
    final l$userType = userType;
    final l$username = username;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$sshKeys.map((v) => v)),
      l$userType,
      l$username,
      l$$__typename
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$UpdateUser$updateUser$user) ||
        runtimeType != other.runtimeType) return false;
    final l$sshKeys = sshKeys;
    final lOther$sshKeys = other.sshKeys;
    if (l$sshKeys.length != lOther$sshKeys.length) return false;
    for (int i = 0; i < l$sshKeys.length; i++) {
      final l$sshKeys$entry = l$sshKeys[i];
      final lOther$sshKeys$entry = lOther$sshKeys[i];
      if (l$sshKeys$entry != lOther$sshKeys$entry) return false;
    }

    final l$userType = userType;
    final lOther$userType = other.userType;
    if (l$userType != lOther$userType) return false;
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$UpdateUser$updateUser$user
    on Mutation$UpdateUser$updateUser$user {
  Mutation$UpdateUser$updateUser$user copyWith(
          {List<String>? sshKeys,
          Enum$UserType? userType,
          String? username,
          String? $__typename}) =>
      Mutation$UpdateUser$updateUser$user(
          sshKeys: sshKeys == null ? this.sshKeys : sshKeys,
          userType: userType == null ? this.userType : userType,
          username: username == null ? this.username : username,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}
