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
  CopyWith$Fragment$basicMutationReturnFields<
          Fragment$basicMutationReturnFields>
      get copyWith =>
          CopyWith$Fragment$basicMutationReturnFields(this, (i) => i);
}

abstract class CopyWith$Fragment$basicMutationReturnFields<TRes> {
  factory CopyWith$Fragment$basicMutationReturnFields(
          Fragment$basicMutationReturnFields instance,
          TRes Function(Fragment$basicMutationReturnFields) then) =
      _CopyWithImpl$Fragment$basicMutationReturnFields;

  factory CopyWith$Fragment$basicMutationReturnFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$basicMutationReturnFields;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Fragment$basicMutationReturnFields<TRes>
    implements CopyWith$Fragment$basicMutationReturnFields<TRes> {
  _CopyWithImpl$Fragment$basicMutationReturnFields(this._instance, this._then);

  final Fragment$basicMutationReturnFields _instance;

  final TRes Function(Fragment$basicMutationReturnFields) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Fragment$basicMutationReturnFields(
          code: code == _undefined || code == null
              ? _instance.code
              : (code as int),
          message: message == _undefined || message == null
              ? _instance.message
              : (message as String),
          success: success == _undefined || success == null
              ? _instance.success
              : (success as bool),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
}

class _CopyWithStubImpl$Fragment$basicMutationReturnFields<TRes>
    implements CopyWith$Fragment$basicMutationReturnFields<TRes> {
  _CopyWithStubImpl$Fragment$basicMutationReturnFields(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
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
class Fragment$userFields {
  Fragment$userFields(
      {required this.username,
      required this.userType,
      required this.sshKeys,
      required this.$__typename});

  @override
  factory Fragment$userFields.fromJson(Map<String, dynamic> json) =>
      _$Fragment$userFieldsFromJson(json);

  final String username;

  @JsonKey(unknownEnumValue: Enum$UserType.$unknown)
  final Enum$UserType userType;

  final List<String> sshKeys;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Fragment$userFieldsToJson(this);
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
    if (!(other is Fragment$userFields) || runtimeType != other.runtimeType)
      return false;
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

extension UtilityExtension$Fragment$userFields on Fragment$userFields {
  CopyWith$Fragment$userFields<Fragment$userFields> get copyWith =>
      CopyWith$Fragment$userFields(this, (i) => i);
}

abstract class CopyWith$Fragment$userFields<TRes> {
  factory CopyWith$Fragment$userFields(Fragment$userFields instance,
          TRes Function(Fragment$userFields) then) =
      _CopyWithImpl$Fragment$userFields;

  factory CopyWith$Fragment$userFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$userFields;

  TRes call(
      {String? username,
      Enum$UserType? userType,
      List<String>? sshKeys,
      String? $__typename});
}

class _CopyWithImpl$Fragment$userFields<TRes>
    implements CopyWith$Fragment$userFields<TRes> {
  _CopyWithImpl$Fragment$userFields(this._instance, this._then);

  final Fragment$userFields _instance;

  final TRes Function(Fragment$userFields) _then;

  static const _undefined = {};

  TRes call(
          {Object? username = _undefined,
          Object? userType = _undefined,
          Object? sshKeys = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Fragment$userFields(
          username: username == _undefined || username == null
              ? _instance.username
              : (username as String),
          userType: userType == _undefined || userType == null
              ? _instance.userType
              : (userType as Enum$UserType),
          sshKeys: sshKeys == _undefined || sshKeys == null
              ? _instance.sshKeys
              : (sshKeys as List<String>),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
}

class _CopyWithStubImpl$Fragment$userFields<TRes>
    implements CopyWith$Fragment$userFields<TRes> {
  _CopyWithStubImpl$Fragment$userFields(this._res);

  TRes _res;

  call(
          {String? username,
          Enum$UserType? userType,
          List<String>? sshKeys,
          String? $__typename}) =>
      _res;
}

const fragmentDefinitionuserFields = FragmentDefinitionNode(
    name: NameNode(value: 'userFields'),
    typeCondition: TypeConditionNode(
        on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false)),
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
    ]));
const documentNodeFragmentuserFields = DocumentNode(definitions: [
  fragmentDefinitionuserFields,
]);

extension ClientExtension$Fragment$userFields on graphql.GraphQLClient {
  void writeFragment$userFields(
          {required Fragment$userFields data,
          required Map<String, dynamic> idFields,
          bool broadcast = true}) =>
      this.writeFragment(
          graphql.FragmentRequest(
              idFields: idFields,
              fragment: const graphql.Fragment(
                  fragmentName: 'userFields',
                  document: documentNodeFragmentuserFields)),
          data: data.toJson(),
          broadcast: broadcast);
  Fragment$userFields? readFragment$userFields(
      {required Map<String, dynamic> idFields, bool optimistic = true}) {
    final result = this.readFragment(
        graphql.FragmentRequest(
            idFields: idFields,
            fragment: const graphql.Fragment(
                fragmentName: 'userFields',
                document: documentNodeFragmentuserFields)),
        optimistic: optimistic);
    return result == null ? null : Fragment$userFields.fromJson(result);
  }
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
  CopyWith$Query$AllUsers<Query$AllUsers> get copyWith =>
      CopyWith$Query$AllUsers(this, (i) => i);
}

abstract class CopyWith$Query$AllUsers<TRes> {
  factory CopyWith$Query$AllUsers(
          Query$AllUsers instance, TRes Function(Query$AllUsers) then) =
      _CopyWithImpl$Query$AllUsers;

  factory CopyWith$Query$AllUsers.stub(TRes res) =
      _CopyWithStubImpl$Query$AllUsers;

  TRes call({Query$AllUsers$users? users, String? $__typename});
  CopyWith$Query$AllUsers$users<TRes> get users;
}

class _CopyWithImpl$Query$AllUsers<TRes>
    implements CopyWith$Query$AllUsers<TRes> {
  _CopyWithImpl$Query$AllUsers(this._instance, this._then);

  final Query$AllUsers _instance;

  final TRes Function(Query$AllUsers) _then;

  static const _undefined = {};

  TRes call({Object? users = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$AllUsers(
          users: users == _undefined || users == null
              ? _instance.users
              : (users as Query$AllUsers$users),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Query$AllUsers$users<TRes> get users {
    final local$users = _instance.users;
    return CopyWith$Query$AllUsers$users(local$users, (e) => call(users: e));
  }
}

class _CopyWithStubImpl$Query$AllUsers<TRes>
    implements CopyWith$Query$AllUsers<TRes> {
  _CopyWithStubImpl$Query$AllUsers(this._res);

  TRes _res;

  call({Query$AllUsers$users? users, String? $__typename}) => _res;
  CopyWith$Query$AllUsers$users<TRes> get users =>
      CopyWith$Query$AllUsers$users.stub(_res);
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
                    FragmentSpreadNode(
                        name: NameNode(value: 'userFields'), directives: []),
                    FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'getUser'),
                  alias: NameNode(value: 'rootUser'),
                  arguments: [
                    ArgumentNode(
                        name: NameNode(value: 'username'),
                        value: StringValueNode(value: 'root', isBlock: false))
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'userFields'), directives: []),
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
  fragmentDefinitionuserFields,
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
  Query$AllUsers$users(
      {required this.allUsers, this.rootUser, required this.$__typename});

  @override
  factory Query$AllUsers$users.fromJson(Map<String, dynamic> json) =>
      _$Query$AllUsers$usersFromJson(json);

  final List<Fragment$userFields> allUsers;

  final Fragment$userFields? rootUser;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$AllUsers$usersToJson(this);
  int get hashCode {
    final l$allUsers = allUsers;
    final l$rootUser = rootUser;
    final l$$__typename = $__typename;
    return Object.hashAll(
        [Object.hashAll(l$allUsers.map((v) => v)), l$rootUser, l$$__typename]);
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

    final l$rootUser = rootUser;
    final lOther$rootUser = other.rootUser;
    if (l$rootUser != lOther$rootUser) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$AllUsers$users on Query$AllUsers$users {
  CopyWith$Query$AllUsers$users<Query$AllUsers$users> get copyWith =>
      CopyWith$Query$AllUsers$users(this, (i) => i);
}

abstract class CopyWith$Query$AllUsers$users<TRes> {
  factory CopyWith$Query$AllUsers$users(Query$AllUsers$users instance,
          TRes Function(Query$AllUsers$users) then) =
      _CopyWithImpl$Query$AllUsers$users;

  factory CopyWith$Query$AllUsers$users.stub(TRes res) =
      _CopyWithStubImpl$Query$AllUsers$users;

  TRes call(
      {List<Fragment$userFields>? allUsers,
      Fragment$userFields? rootUser,
      String? $__typename});
  TRes allUsers(
      Iterable<Fragment$userFields> Function(
              Iterable<CopyWith$Fragment$userFields<Fragment$userFields>>)
          _fn);
  CopyWith$Fragment$userFields<TRes> get rootUser;
}

class _CopyWithImpl$Query$AllUsers$users<TRes>
    implements CopyWith$Query$AllUsers$users<TRes> {
  _CopyWithImpl$Query$AllUsers$users(this._instance, this._then);

  final Query$AllUsers$users _instance;

  final TRes Function(Query$AllUsers$users) _then;

  static const _undefined = {};

  TRes call(
          {Object? allUsers = _undefined,
          Object? rootUser = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$AllUsers$users(
          allUsers: allUsers == _undefined || allUsers == null
              ? _instance.allUsers
              : (allUsers as List<Fragment$userFields>),
          rootUser: rootUser == _undefined
              ? _instance.rootUser
              : (rootUser as Fragment$userFields?),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  TRes allUsers(
          Iterable<Fragment$userFields> Function(
                  Iterable<CopyWith$Fragment$userFields<Fragment$userFields>>)
              _fn) =>
      call(
          allUsers: _fn(_instance.allUsers
              .map((e) => CopyWith$Fragment$userFields(e, (i) => i))).toList());
  CopyWith$Fragment$userFields<TRes> get rootUser {
    final local$rootUser = _instance.rootUser;
    return local$rootUser == null
        ? CopyWith$Fragment$userFields.stub(_then(_instance))
        : CopyWith$Fragment$userFields(
            local$rootUser, (e) => call(rootUser: e));
  }
}

class _CopyWithStubImpl$Query$AllUsers$users<TRes>
    implements CopyWith$Query$AllUsers$users<TRes> {
  _CopyWithStubImpl$Query$AllUsers$users(this._res);

  TRes _res;

  call(
          {List<Fragment$userFields>? allUsers,
          Fragment$userFields? rootUser,
          String? $__typename}) =>
      _res;
  allUsers(_fn) => _res;
  CopyWith$Fragment$userFields<TRes> get rootUser =>
      CopyWith$Fragment$userFields.stub(_res);
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

  CopyWith$Variables$Query$GetUser<Variables$Query$GetUser> get copyWith =>
      CopyWith$Variables$Query$GetUser(this, (i) => i);
}

abstract class CopyWith$Variables$Query$GetUser<TRes> {
  factory CopyWith$Variables$Query$GetUser(Variables$Query$GetUser instance,
          TRes Function(Variables$Query$GetUser) then) =
      _CopyWithImpl$Variables$Query$GetUser;

  factory CopyWith$Variables$Query$GetUser.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetUser;

  TRes call({String? username});
}

class _CopyWithImpl$Variables$Query$GetUser<TRes>
    implements CopyWith$Variables$Query$GetUser<TRes> {
  _CopyWithImpl$Variables$Query$GetUser(this._instance, this._then);

  final Variables$Query$GetUser _instance;

  final TRes Function(Variables$Query$GetUser) _then;

  static const _undefined = {};

  TRes call({Object? username = _undefined}) => _then(Variables$Query$GetUser(
      username: username == _undefined || username == null
          ? _instance.username
          : (username as String)));
}

class _CopyWithStubImpl$Variables$Query$GetUser<TRes>
    implements CopyWith$Variables$Query$GetUser<TRes> {
  _CopyWithStubImpl$Variables$Query$GetUser(this._res);

  TRes _res;

  call({String? username}) => _res;
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
  CopyWith$Query$GetUser<Query$GetUser> get copyWith =>
      CopyWith$Query$GetUser(this, (i) => i);
}

abstract class CopyWith$Query$GetUser<TRes> {
  factory CopyWith$Query$GetUser(
          Query$GetUser instance, TRes Function(Query$GetUser) then) =
      _CopyWithImpl$Query$GetUser;

  factory CopyWith$Query$GetUser.stub(TRes res) =
      _CopyWithStubImpl$Query$GetUser;

  TRes call({Query$GetUser$users? users, String? $__typename});
  CopyWith$Query$GetUser$users<TRes> get users;
}

class _CopyWithImpl$Query$GetUser<TRes>
    implements CopyWith$Query$GetUser<TRes> {
  _CopyWithImpl$Query$GetUser(this._instance, this._then);

  final Query$GetUser _instance;

  final TRes Function(Query$GetUser) _then;

  static const _undefined = {};

  TRes call({Object? users = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$GetUser(
          users: users == _undefined || users == null
              ? _instance.users
              : (users as Query$GetUser$users),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Query$GetUser$users<TRes> get users {
    final local$users = _instance.users;
    return CopyWith$Query$GetUser$users(local$users, (e) => call(users: e));
  }
}

class _CopyWithStubImpl$Query$GetUser<TRes>
    implements CopyWith$Query$GetUser<TRes> {
  _CopyWithStubImpl$Query$GetUser(this._res);

  TRes _res;

  call({Query$GetUser$users? users, String? $__typename}) => _res;
  CopyWith$Query$GetUser$users<TRes> get users =>
      CopyWith$Query$GetUser$users.stub(_res);
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
                    FragmentSpreadNode(
                        name: NameNode(value: 'userFields'), directives: []),
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
  fragmentDefinitionuserFields,
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

  final Fragment$userFields? getUser;

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
  CopyWith$Query$GetUser$users<Query$GetUser$users> get copyWith =>
      CopyWith$Query$GetUser$users(this, (i) => i);
}

abstract class CopyWith$Query$GetUser$users<TRes> {
  factory CopyWith$Query$GetUser$users(Query$GetUser$users instance,
          TRes Function(Query$GetUser$users) then) =
      _CopyWithImpl$Query$GetUser$users;

  factory CopyWith$Query$GetUser$users.stub(TRes res) =
      _CopyWithStubImpl$Query$GetUser$users;

  TRes call({Fragment$userFields? getUser, String? $__typename});
  CopyWith$Fragment$userFields<TRes> get getUser;
}

class _CopyWithImpl$Query$GetUser$users<TRes>
    implements CopyWith$Query$GetUser$users<TRes> {
  _CopyWithImpl$Query$GetUser$users(this._instance, this._then);

  final Query$GetUser$users _instance;

  final TRes Function(Query$GetUser$users) _then;

  static const _undefined = {};

  TRes call({Object? getUser = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$GetUser$users(
          getUser: getUser == _undefined
              ? _instance.getUser
              : (getUser as Fragment$userFields?),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Fragment$userFields<TRes> get getUser {
    final local$getUser = _instance.getUser;
    return local$getUser == null
        ? CopyWith$Fragment$userFields.stub(_then(_instance))
        : CopyWith$Fragment$userFields(local$getUser, (e) => call(getUser: e));
  }
}

class _CopyWithStubImpl$Query$GetUser$users<TRes>
    implements CopyWith$Query$GetUser$users<TRes> {
  _CopyWithStubImpl$Query$GetUser$users(this._res);

  TRes _res;

  call({Fragment$userFields? getUser, String? $__typename}) => _res;
  CopyWith$Fragment$userFields<TRes> get getUser =>
      CopyWith$Fragment$userFields.stub(_res);
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

  CopyWith$Variables$Mutation$CreateUser<Variables$Mutation$CreateUser>
      get copyWith => CopyWith$Variables$Mutation$CreateUser(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$CreateUser<TRes> {
  factory CopyWith$Variables$Mutation$CreateUser(
          Variables$Mutation$CreateUser instance,
          TRes Function(Variables$Mutation$CreateUser) then) =
      _CopyWithImpl$Variables$Mutation$CreateUser;

  factory CopyWith$Variables$Mutation$CreateUser.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CreateUser;

  TRes call({Input$UserMutationInput? user});
}

class _CopyWithImpl$Variables$Mutation$CreateUser<TRes>
    implements CopyWith$Variables$Mutation$CreateUser<TRes> {
  _CopyWithImpl$Variables$Mutation$CreateUser(this._instance, this._then);

  final Variables$Mutation$CreateUser _instance;

  final TRes Function(Variables$Mutation$CreateUser) _then;

  static const _undefined = {};

  TRes call({Object? user = _undefined}) => _then(Variables$Mutation$CreateUser(
      user: user == _undefined || user == null
          ? _instance.user
          : (user as Input$UserMutationInput)));
}

class _CopyWithStubImpl$Variables$Mutation$CreateUser<TRes>
    implements CopyWith$Variables$Mutation$CreateUser<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateUser(this._res);

  TRes _res;

  call({Input$UserMutationInput? user}) => _res;
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
  CopyWith$Mutation$CreateUser<Mutation$CreateUser> get copyWith =>
      CopyWith$Mutation$CreateUser(this, (i) => i);
}

abstract class CopyWith$Mutation$CreateUser<TRes> {
  factory CopyWith$Mutation$CreateUser(Mutation$CreateUser instance,
          TRes Function(Mutation$CreateUser) then) =
      _CopyWithImpl$Mutation$CreateUser;

  factory CopyWith$Mutation$CreateUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateUser;

  TRes call({Mutation$CreateUser$createUser? createUser, String? $__typename});
  CopyWith$Mutation$CreateUser$createUser<TRes> get createUser;
}

class _CopyWithImpl$Mutation$CreateUser<TRes>
    implements CopyWith$Mutation$CreateUser<TRes> {
  _CopyWithImpl$Mutation$CreateUser(this._instance, this._then);

  final Mutation$CreateUser _instance;

  final TRes Function(Mutation$CreateUser) _then;

  static const _undefined = {};

  TRes call(
          {Object? createUser = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$CreateUser(
          createUser: createUser == _undefined || createUser == null
              ? _instance.createUser
              : (createUser as Mutation$CreateUser$createUser),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$CreateUser$createUser<TRes> get createUser {
    final local$createUser = _instance.createUser;
    return CopyWith$Mutation$CreateUser$createUser(
        local$createUser, (e) => call(createUser: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateUser<TRes>
    implements CopyWith$Mutation$CreateUser<TRes> {
  _CopyWithStubImpl$Mutation$CreateUser(this._res);

  TRes _res;

  call({Mutation$CreateUser$createUser? createUser, String? $__typename}) =>
      _res;
  CopyWith$Mutation$CreateUser$createUser<TRes> get createUser =>
      CopyWith$Mutation$CreateUser$createUser.stub(_res);
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
                    FragmentSpreadNode(
                        name: NameNode(value: 'userFields'), directives: []),
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
  fragmentDefinitionuserFields,
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

  final Fragment$userFields? user;

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
  CopyWith$Mutation$CreateUser$createUser<Mutation$CreateUser$createUser>
      get copyWith => CopyWith$Mutation$CreateUser$createUser(this, (i) => i);
}

abstract class CopyWith$Mutation$CreateUser$createUser<TRes> {
  factory CopyWith$Mutation$CreateUser$createUser(
          Mutation$CreateUser$createUser instance,
          TRes Function(Mutation$CreateUser$createUser) then) =
      _CopyWithImpl$Mutation$CreateUser$createUser;

  factory CopyWith$Mutation$CreateUser$createUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateUser$createUser;

  TRes call(
      {int? code,
      String? message,
      bool? success,
      String? $__typename,
      Fragment$userFields? user});
  CopyWith$Fragment$userFields<TRes> get user;
}

class _CopyWithImpl$Mutation$CreateUser$createUser<TRes>
    implements CopyWith$Mutation$CreateUser$createUser<TRes> {
  _CopyWithImpl$Mutation$CreateUser$createUser(this._instance, this._then);

  final Mutation$CreateUser$createUser _instance;

  final TRes Function(Mutation$CreateUser$createUser) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined,
          Object? user = _undefined}) =>
      _then(Mutation$CreateUser$createUser(
          code: code == _undefined || code == null
              ? _instance.code
              : (code as int),
          message: message == _undefined || message == null
              ? _instance.message
              : (message as String),
          success: success == _undefined || success == null
              ? _instance.success
              : (success as bool),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
          user: user == _undefined
              ? _instance.user
              : (user as Fragment$userFields?)));
  CopyWith$Fragment$userFields<TRes> get user {
    final local$user = _instance.user;
    return local$user == null
        ? CopyWith$Fragment$userFields.stub(_then(_instance))
        : CopyWith$Fragment$userFields(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateUser$createUser<TRes>
    implements CopyWith$Mutation$CreateUser$createUser<TRes> {
  _CopyWithStubImpl$Mutation$CreateUser$createUser(this._res);

  TRes _res;

  call(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          Fragment$userFields? user}) =>
      _res;
  CopyWith$Fragment$userFields<TRes> get user =>
      CopyWith$Fragment$userFields.stub(_res);
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

  CopyWith$Variables$Mutation$DeleteUser<Variables$Mutation$DeleteUser>
      get copyWith => CopyWith$Variables$Mutation$DeleteUser(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$DeleteUser<TRes> {
  factory CopyWith$Variables$Mutation$DeleteUser(
          Variables$Mutation$DeleteUser instance,
          TRes Function(Variables$Mutation$DeleteUser) then) =
      _CopyWithImpl$Variables$Mutation$DeleteUser;

  factory CopyWith$Variables$Mutation$DeleteUser.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$DeleteUser;

  TRes call({String? username});
}

class _CopyWithImpl$Variables$Mutation$DeleteUser<TRes>
    implements CopyWith$Variables$Mutation$DeleteUser<TRes> {
  _CopyWithImpl$Variables$Mutation$DeleteUser(this._instance, this._then);

  final Variables$Mutation$DeleteUser _instance;

  final TRes Function(Variables$Mutation$DeleteUser) _then;

  static const _undefined = {};

  TRes call({Object? username = _undefined}) => _then(
      Variables$Mutation$DeleteUser(
          username: username == _undefined || username == null
              ? _instance.username
              : (username as String)));
}

class _CopyWithStubImpl$Variables$Mutation$DeleteUser<TRes>
    implements CopyWith$Variables$Mutation$DeleteUser<TRes> {
  _CopyWithStubImpl$Variables$Mutation$DeleteUser(this._res);

  TRes _res;

  call({String? username}) => _res;
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
  CopyWith$Mutation$DeleteUser<Mutation$DeleteUser> get copyWith =>
      CopyWith$Mutation$DeleteUser(this, (i) => i);
}

abstract class CopyWith$Mutation$DeleteUser<TRes> {
  factory CopyWith$Mutation$DeleteUser(Mutation$DeleteUser instance,
          TRes Function(Mutation$DeleteUser) then) =
      _CopyWithImpl$Mutation$DeleteUser;

  factory CopyWith$Mutation$DeleteUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DeleteUser;

  TRes call({Mutation$DeleteUser$deleteUser? deleteUser, String? $__typename});
  CopyWith$Mutation$DeleteUser$deleteUser<TRes> get deleteUser;
}

class _CopyWithImpl$Mutation$DeleteUser<TRes>
    implements CopyWith$Mutation$DeleteUser<TRes> {
  _CopyWithImpl$Mutation$DeleteUser(this._instance, this._then);

  final Mutation$DeleteUser _instance;

  final TRes Function(Mutation$DeleteUser) _then;

  static const _undefined = {};

  TRes call(
          {Object? deleteUser = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$DeleteUser(
          deleteUser: deleteUser == _undefined || deleteUser == null
              ? _instance.deleteUser
              : (deleteUser as Mutation$DeleteUser$deleteUser),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$DeleteUser$deleteUser<TRes> get deleteUser {
    final local$deleteUser = _instance.deleteUser;
    return CopyWith$Mutation$DeleteUser$deleteUser(
        local$deleteUser, (e) => call(deleteUser: e));
  }
}

class _CopyWithStubImpl$Mutation$DeleteUser<TRes>
    implements CopyWith$Mutation$DeleteUser<TRes> {
  _CopyWithStubImpl$Mutation$DeleteUser(this._res);

  TRes _res;

  call({Mutation$DeleteUser$deleteUser? deleteUser, String? $__typename}) =>
      _res;
  CopyWith$Mutation$DeleteUser$deleteUser<TRes> get deleteUser =>
      CopyWith$Mutation$DeleteUser$deleteUser.stub(_res);
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
  CopyWith$Mutation$DeleteUser$deleteUser<Mutation$DeleteUser$deleteUser>
      get copyWith => CopyWith$Mutation$DeleteUser$deleteUser(this, (i) => i);
}

abstract class CopyWith$Mutation$DeleteUser$deleteUser<TRes> {
  factory CopyWith$Mutation$DeleteUser$deleteUser(
          Mutation$DeleteUser$deleteUser instance,
          TRes Function(Mutation$DeleteUser$deleteUser) then) =
      _CopyWithImpl$Mutation$DeleteUser$deleteUser;

  factory CopyWith$Mutation$DeleteUser$deleteUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DeleteUser$deleteUser;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$DeleteUser$deleteUser<TRes>
    implements CopyWith$Mutation$DeleteUser$deleteUser<TRes> {
  _CopyWithImpl$Mutation$DeleteUser$deleteUser(this._instance, this._then);

  final Mutation$DeleteUser$deleteUser _instance;

  final TRes Function(Mutation$DeleteUser$deleteUser) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$DeleteUser$deleteUser(
          code: code == _undefined || code == null
              ? _instance.code
              : (code as int),
          message: message == _undefined || message == null
              ? _instance.message
              : (message as String),
          success: success == _undefined || success == null
              ? _instance.success
              : (success as bool),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
}

class _CopyWithStubImpl$Mutation$DeleteUser$deleteUser<TRes>
    implements CopyWith$Mutation$DeleteUser$deleteUser<TRes> {
  _CopyWithStubImpl$Mutation$DeleteUser$deleteUser(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
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

  CopyWith$Variables$Mutation$UpdateUser<Variables$Mutation$UpdateUser>
      get copyWith => CopyWith$Variables$Mutation$UpdateUser(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$UpdateUser<TRes> {
  factory CopyWith$Variables$Mutation$UpdateUser(
          Variables$Mutation$UpdateUser instance,
          TRes Function(Variables$Mutation$UpdateUser) then) =
      _CopyWithImpl$Variables$Mutation$UpdateUser;

  factory CopyWith$Variables$Mutation$UpdateUser.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UpdateUser;

  TRes call({Input$UserMutationInput? user});
}

class _CopyWithImpl$Variables$Mutation$UpdateUser<TRes>
    implements CopyWith$Variables$Mutation$UpdateUser<TRes> {
  _CopyWithImpl$Variables$Mutation$UpdateUser(this._instance, this._then);

  final Variables$Mutation$UpdateUser _instance;

  final TRes Function(Variables$Mutation$UpdateUser) _then;

  static const _undefined = {};

  TRes call({Object? user = _undefined}) => _then(Variables$Mutation$UpdateUser(
      user: user == _undefined || user == null
          ? _instance.user
          : (user as Input$UserMutationInput)));
}

class _CopyWithStubImpl$Variables$Mutation$UpdateUser<TRes>
    implements CopyWith$Variables$Mutation$UpdateUser<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UpdateUser(this._res);

  TRes _res;

  call({Input$UserMutationInput? user}) => _res;
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
  CopyWith$Mutation$UpdateUser<Mutation$UpdateUser> get copyWith =>
      CopyWith$Mutation$UpdateUser(this, (i) => i);
}

abstract class CopyWith$Mutation$UpdateUser<TRes> {
  factory CopyWith$Mutation$UpdateUser(Mutation$UpdateUser instance,
          TRes Function(Mutation$UpdateUser) then) =
      _CopyWithImpl$Mutation$UpdateUser;

  factory CopyWith$Mutation$UpdateUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateUser;

  TRes call({Mutation$UpdateUser$updateUser? updateUser, String? $__typename});
  CopyWith$Mutation$UpdateUser$updateUser<TRes> get updateUser;
}

class _CopyWithImpl$Mutation$UpdateUser<TRes>
    implements CopyWith$Mutation$UpdateUser<TRes> {
  _CopyWithImpl$Mutation$UpdateUser(this._instance, this._then);

  final Mutation$UpdateUser _instance;

  final TRes Function(Mutation$UpdateUser) _then;

  static const _undefined = {};

  TRes call(
          {Object? updateUser = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$UpdateUser(
          updateUser: updateUser == _undefined || updateUser == null
              ? _instance.updateUser
              : (updateUser as Mutation$UpdateUser$updateUser),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$UpdateUser$updateUser<TRes> get updateUser {
    final local$updateUser = _instance.updateUser;
    return CopyWith$Mutation$UpdateUser$updateUser(
        local$updateUser, (e) => call(updateUser: e));
  }
}

class _CopyWithStubImpl$Mutation$UpdateUser<TRes>
    implements CopyWith$Mutation$UpdateUser<TRes> {
  _CopyWithStubImpl$Mutation$UpdateUser(this._res);

  TRes _res;

  call({Mutation$UpdateUser$updateUser? updateUser, String? $__typename}) =>
      _res;
  CopyWith$Mutation$UpdateUser$updateUser<TRes> get updateUser =>
      CopyWith$Mutation$UpdateUser$updateUser.stub(_res);
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
                    FragmentSpreadNode(
                        name: NameNode(value: 'userFields'), directives: []),
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
  fragmentDefinitionuserFields,
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

  final Fragment$userFields? user;

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
  CopyWith$Mutation$UpdateUser$updateUser<Mutation$UpdateUser$updateUser>
      get copyWith => CopyWith$Mutation$UpdateUser$updateUser(this, (i) => i);
}

abstract class CopyWith$Mutation$UpdateUser$updateUser<TRes> {
  factory CopyWith$Mutation$UpdateUser$updateUser(
          Mutation$UpdateUser$updateUser instance,
          TRes Function(Mutation$UpdateUser$updateUser) then) =
      _CopyWithImpl$Mutation$UpdateUser$updateUser;

  factory CopyWith$Mutation$UpdateUser$updateUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateUser$updateUser;

  TRes call(
      {int? code,
      String? message,
      bool? success,
      String? $__typename,
      Fragment$userFields? user});
  CopyWith$Fragment$userFields<TRes> get user;
}

class _CopyWithImpl$Mutation$UpdateUser$updateUser<TRes>
    implements CopyWith$Mutation$UpdateUser$updateUser<TRes> {
  _CopyWithImpl$Mutation$UpdateUser$updateUser(this._instance, this._then);

  final Mutation$UpdateUser$updateUser _instance;

  final TRes Function(Mutation$UpdateUser$updateUser) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined,
          Object? user = _undefined}) =>
      _then(Mutation$UpdateUser$updateUser(
          code: code == _undefined || code == null
              ? _instance.code
              : (code as int),
          message: message == _undefined || message == null
              ? _instance.message
              : (message as String),
          success: success == _undefined || success == null
              ? _instance.success
              : (success as bool),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
          user: user == _undefined
              ? _instance.user
              : (user as Fragment$userFields?)));
  CopyWith$Fragment$userFields<TRes> get user {
    final local$user = _instance.user;
    return local$user == null
        ? CopyWith$Fragment$userFields.stub(_then(_instance))
        : CopyWith$Fragment$userFields(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Mutation$UpdateUser$updateUser<TRes>
    implements CopyWith$Mutation$UpdateUser$updateUser<TRes> {
  _CopyWithStubImpl$Mutation$UpdateUser$updateUser(this._res);

  TRes _res;

  call(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          Fragment$userFields? user}) =>
      _res;
  CopyWith$Fragment$userFields<TRes> get user =>
      CopyWith$Fragment$userFields.stub(_res);
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

  CopyWith$Variables$Mutation$AddSshKey<Variables$Mutation$AddSshKey>
      get copyWith => CopyWith$Variables$Mutation$AddSshKey(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$AddSshKey<TRes> {
  factory CopyWith$Variables$Mutation$AddSshKey(
          Variables$Mutation$AddSshKey instance,
          TRes Function(Variables$Mutation$AddSshKey) then) =
      _CopyWithImpl$Variables$Mutation$AddSshKey;

  factory CopyWith$Variables$Mutation$AddSshKey.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$AddSshKey;

  TRes call({Input$SshMutationInput? sshInput});
}

class _CopyWithImpl$Variables$Mutation$AddSshKey<TRes>
    implements CopyWith$Variables$Mutation$AddSshKey<TRes> {
  _CopyWithImpl$Variables$Mutation$AddSshKey(this._instance, this._then);

  final Variables$Mutation$AddSshKey _instance;

  final TRes Function(Variables$Mutation$AddSshKey) _then;

  static const _undefined = {};

  TRes call({Object? sshInput = _undefined}) =>
      _then(Variables$Mutation$AddSshKey(
          sshInput: sshInput == _undefined || sshInput == null
              ? _instance.sshInput
              : (sshInput as Input$SshMutationInput)));
}

class _CopyWithStubImpl$Variables$Mutation$AddSshKey<TRes>
    implements CopyWith$Variables$Mutation$AddSshKey<TRes> {
  _CopyWithStubImpl$Variables$Mutation$AddSshKey(this._res);

  TRes _res;

  call({Input$SshMutationInput? sshInput}) => _res;
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
  CopyWith$Mutation$AddSshKey<Mutation$AddSshKey> get copyWith =>
      CopyWith$Mutation$AddSshKey(this, (i) => i);
}

abstract class CopyWith$Mutation$AddSshKey<TRes> {
  factory CopyWith$Mutation$AddSshKey(
          Mutation$AddSshKey instance, TRes Function(Mutation$AddSshKey) then) =
      _CopyWithImpl$Mutation$AddSshKey;

  factory CopyWith$Mutation$AddSshKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$AddSshKey;

  TRes call({Mutation$AddSshKey$addSshKey? addSshKey, String? $__typename});
  CopyWith$Mutation$AddSshKey$addSshKey<TRes> get addSshKey;
}

class _CopyWithImpl$Mutation$AddSshKey<TRes>
    implements CopyWith$Mutation$AddSshKey<TRes> {
  _CopyWithImpl$Mutation$AddSshKey(this._instance, this._then);

  final Mutation$AddSshKey _instance;

  final TRes Function(Mutation$AddSshKey) _then;

  static const _undefined = {};

  TRes call(
          {Object? addSshKey = _undefined, Object? $__typename = _undefined}) =>
      _then(Mutation$AddSshKey(
          addSshKey: addSshKey == _undefined || addSshKey == null
              ? _instance.addSshKey
              : (addSshKey as Mutation$AddSshKey$addSshKey),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$AddSshKey$addSshKey<TRes> get addSshKey {
    final local$addSshKey = _instance.addSshKey;
    return CopyWith$Mutation$AddSshKey$addSshKey(
        local$addSshKey, (e) => call(addSshKey: e));
  }
}

class _CopyWithStubImpl$Mutation$AddSshKey<TRes>
    implements CopyWith$Mutation$AddSshKey<TRes> {
  _CopyWithStubImpl$Mutation$AddSshKey(this._res);

  TRes _res;

  call({Mutation$AddSshKey$addSshKey? addSshKey, String? $__typename}) => _res;
  CopyWith$Mutation$AddSshKey$addSshKey<TRes> get addSshKey =>
      CopyWith$Mutation$AddSshKey$addSshKey.stub(_res);
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
                    FragmentSpreadNode(
                        name: NameNode(value: 'userFields'), directives: []),
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
  fragmentDefinitionuserFields,
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

  final Fragment$userFields? user;

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
  CopyWith$Mutation$AddSshKey$addSshKey<Mutation$AddSshKey$addSshKey>
      get copyWith => CopyWith$Mutation$AddSshKey$addSshKey(this, (i) => i);
}

abstract class CopyWith$Mutation$AddSshKey$addSshKey<TRes> {
  factory CopyWith$Mutation$AddSshKey$addSshKey(
          Mutation$AddSshKey$addSshKey instance,
          TRes Function(Mutation$AddSshKey$addSshKey) then) =
      _CopyWithImpl$Mutation$AddSshKey$addSshKey;

  factory CopyWith$Mutation$AddSshKey$addSshKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$AddSshKey$addSshKey;

  TRes call(
      {int? code,
      String? message,
      bool? success,
      String? $__typename,
      Fragment$userFields? user});
  CopyWith$Fragment$userFields<TRes> get user;
}

class _CopyWithImpl$Mutation$AddSshKey$addSshKey<TRes>
    implements CopyWith$Mutation$AddSshKey$addSshKey<TRes> {
  _CopyWithImpl$Mutation$AddSshKey$addSshKey(this._instance, this._then);

  final Mutation$AddSshKey$addSshKey _instance;

  final TRes Function(Mutation$AddSshKey$addSshKey) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined,
          Object? user = _undefined}) =>
      _then(Mutation$AddSshKey$addSshKey(
          code: code == _undefined || code == null
              ? _instance.code
              : (code as int),
          message: message == _undefined || message == null
              ? _instance.message
              : (message as String),
          success: success == _undefined || success == null
              ? _instance.success
              : (success as bool),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
          user: user == _undefined
              ? _instance.user
              : (user as Fragment$userFields?)));
  CopyWith$Fragment$userFields<TRes> get user {
    final local$user = _instance.user;
    return local$user == null
        ? CopyWith$Fragment$userFields.stub(_then(_instance))
        : CopyWith$Fragment$userFields(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Mutation$AddSshKey$addSshKey<TRes>
    implements CopyWith$Mutation$AddSshKey$addSshKey<TRes> {
  _CopyWithStubImpl$Mutation$AddSshKey$addSshKey(this._res);

  TRes _res;

  call(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          Fragment$userFields? user}) =>
      _res;
  CopyWith$Fragment$userFields<TRes> get user =>
      CopyWith$Fragment$userFields.stub(_res);
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

  CopyWith$Variables$Mutation$RemoveSshKey<Variables$Mutation$RemoveSshKey>
      get copyWith => CopyWith$Variables$Mutation$RemoveSshKey(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$RemoveSshKey<TRes> {
  factory CopyWith$Variables$Mutation$RemoveSshKey(
          Variables$Mutation$RemoveSshKey instance,
          TRes Function(Variables$Mutation$RemoveSshKey) then) =
      _CopyWithImpl$Variables$Mutation$RemoveSshKey;

  factory CopyWith$Variables$Mutation$RemoveSshKey.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$RemoveSshKey;

  TRes call({Input$SshMutationInput? sshInput});
}

class _CopyWithImpl$Variables$Mutation$RemoveSshKey<TRes>
    implements CopyWith$Variables$Mutation$RemoveSshKey<TRes> {
  _CopyWithImpl$Variables$Mutation$RemoveSshKey(this._instance, this._then);

  final Variables$Mutation$RemoveSshKey _instance;

  final TRes Function(Variables$Mutation$RemoveSshKey) _then;

  static const _undefined = {};

  TRes call({Object? sshInput = _undefined}) =>
      _then(Variables$Mutation$RemoveSshKey(
          sshInput: sshInput == _undefined || sshInput == null
              ? _instance.sshInput
              : (sshInput as Input$SshMutationInput)));
}

class _CopyWithStubImpl$Variables$Mutation$RemoveSshKey<TRes>
    implements CopyWith$Variables$Mutation$RemoveSshKey<TRes> {
  _CopyWithStubImpl$Variables$Mutation$RemoveSshKey(this._res);

  TRes _res;

  call({Input$SshMutationInput? sshInput}) => _res;
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
  CopyWith$Mutation$RemoveSshKey<Mutation$RemoveSshKey> get copyWith =>
      CopyWith$Mutation$RemoveSshKey(this, (i) => i);
}

abstract class CopyWith$Mutation$RemoveSshKey<TRes> {
  factory CopyWith$Mutation$RemoveSshKey(Mutation$RemoveSshKey instance,
          TRes Function(Mutation$RemoveSshKey) then) =
      _CopyWithImpl$Mutation$RemoveSshKey;

  factory CopyWith$Mutation$RemoveSshKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RemoveSshKey;

  TRes call(
      {Mutation$RemoveSshKey$removeSshKey? removeSshKey, String? $__typename});
  CopyWith$Mutation$RemoveSshKey$removeSshKey<TRes> get removeSshKey;
}

class _CopyWithImpl$Mutation$RemoveSshKey<TRes>
    implements CopyWith$Mutation$RemoveSshKey<TRes> {
  _CopyWithImpl$Mutation$RemoveSshKey(this._instance, this._then);

  final Mutation$RemoveSshKey _instance;

  final TRes Function(Mutation$RemoveSshKey) _then;

  static const _undefined = {};

  TRes call(
          {Object? removeSshKey = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$RemoveSshKey(
          removeSshKey: removeSshKey == _undefined || removeSshKey == null
              ? _instance.removeSshKey
              : (removeSshKey as Mutation$RemoveSshKey$removeSshKey),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$RemoveSshKey$removeSshKey<TRes> get removeSshKey {
    final local$removeSshKey = _instance.removeSshKey;
    return CopyWith$Mutation$RemoveSshKey$removeSshKey(
        local$removeSshKey, (e) => call(removeSshKey: e));
  }
}

class _CopyWithStubImpl$Mutation$RemoveSshKey<TRes>
    implements CopyWith$Mutation$RemoveSshKey<TRes> {
  _CopyWithStubImpl$Mutation$RemoveSshKey(this._res);

  TRes _res;

  call(
          {Mutation$RemoveSshKey$removeSshKey? removeSshKey,
          String? $__typename}) =>
      _res;
  CopyWith$Mutation$RemoveSshKey$removeSshKey<TRes> get removeSshKey =>
      CopyWith$Mutation$RemoveSshKey$removeSshKey.stub(_res);
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
                    FragmentSpreadNode(
                        name: NameNode(value: 'userFields'), directives: []),
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
  fragmentDefinitionuserFields,
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

  final Fragment$userFields? user;

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
  CopyWith$Mutation$RemoveSshKey$removeSshKey<
          Mutation$RemoveSshKey$removeSshKey>
      get copyWith =>
          CopyWith$Mutation$RemoveSshKey$removeSshKey(this, (i) => i);
}

abstract class CopyWith$Mutation$RemoveSshKey$removeSshKey<TRes> {
  factory CopyWith$Mutation$RemoveSshKey$removeSshKey(
          Mutation$RemoveSshKey$removeSshKey instance,
          TRes Function(Mutation$RemoveSshKey$removeSshKey) then) =
      _CopyWithImpl$Mutation$RemoveSshKey$removeSshKey;

  factory CopyWith$Mutation$RemoveSshKey$removeSshKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RemoveSshKey$removeSshKey;

  TRes call(
      {int? code,
      String? message,
      bool? success,
      String? $__typename,
      Fragment$userFields? user});
  CopyWith$Fragment$userFields<TRes> get user;
}

class _CopyWithImpl$Mutation$RemoveSshKey$removeSshKey<TRes>
    implements CopyWith$Mutation$RemoveSshKey$removeSshKey<TRes> {
  _CopyWithImpl$Mutation$RemoveSshKey$removeSshKey(this._instance, this._then);

  final Mutation$RemoveSshKey$removeSshKey _instance;

  final TRes Function(Mutation$RemoveSshKey$removeSshKey) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined,
          Object? user = _undefined}) =>
      _then(Mutation$RemoveSshKey$removeSshKey(
          code: code == _undefined || code == null
              ? _instance.code
              : (code as int),
          message: message == _undefined || message == null
              ? _instance.message
              : (message as String),
          success: success == _undefined || success == null
              ? _instance.success
              : (success as bool),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
          user: user == _undefined
              ? _instance.user
              : (user as Fragment$userFields?)));
  CopyWith$Fragment$userFields<TRes> get user {
    final local$user = _instance.user;
    return local$user == null
        ? CopyWith$Fragment$userFields.stub(_then(_instance))
        : CopyWith$Fragment$userFields(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Mutation$RemoveSshKey$removeSshKey<TRes>
    implements CopyWith$Mutation$RemoveSshKey$removeSshKey<TRes> {
  _CopyWithStubImpl$Mutation$RemoveSshKey$removeSshKey(this._res);

  TRes _res;

  call(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          Fragment$userFields? user}) =>
      _res;
  CopyWith$Fragment$userFields<TRes> get user =>
      CopyWith$Fragment$userFields.stub(_res);
}
