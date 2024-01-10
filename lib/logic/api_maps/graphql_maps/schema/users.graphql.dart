import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'schema.graphql.dart';
import 'server_api.graphql.dart';

class Fragment$userFields {
  Fragment$userFields({
    required this.username,
    required this.userType,
    required this.sshKeys,
    this.$__typename = 'User',
  });

  factory Fragment$userFields.fromJson(Map<String, dynamic> json) {
    final l$username = json['username'];
    final l$userType = json['userType'];
    final l$sshKeys = json['sshKeys'];
    final l$$__typename = json['__typename'];
    return Fragment$userFields(
      username: (l$username as String),
      userType: fromJson$Enum$UserType((l$userType as String)),
      sshKeys: (l$sshKeys as List<dynamic>).map((e) => (e as String)).toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String username;

  final Enum$UserType userType;

  final List<String> sshKeys;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$username = username;
    _resultData['username'] = l$username;
    final l$userType = userType;
    _resultData['userType'] = toJson$Enum$UserType(l$userType);
    final l$sshKeys = sshKeys;
    _resultData['sshKeys'] = l$sshKeys.map((e) => e).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$username = username;
    final l$userType = userType;
    final l$sshKeys = sshKeys;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$username,
      l$userType,
      Object.hashAll(l$sshKeys.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$userFields) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) {
      return false;
    }
    final l$userType = userType;
    final lOther$userType = other.userType;
    if (l$userType != lOther$userType) {
      return false;
    }
    final l$sshKeys = sshKeys;
    final lOther$sshKeys = other.sshKeys;
    if (l$sshKeys.length != lOther$sshKeys.length) {
      return false;
    }
    for (int i = 0; i < l$sshKeys.length; i++) {
      final l$sshKeys$entry = l$sshKeys[i];
      final lOther$sshKeys$entry = lOther$sshKeys[i];
      if (l$sshKeys$entry != lOther$sshKeys$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$userFields on Fragment$userFields {
  CopyWith$Fragment$userFields<Fragment$userFields> get copyWith =>
      CopyWith$Fragment$userFields(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Fragment$userFields<TRes> {
  factory CopyWith$Fragment$userFields(
    Fragment$userFields instance,
    TRes Function(Fragment$userFields) then,
  ) = _CopyWithImpl$Fragment$userFields;

  factory CopyWith$Fragment$userFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$userFields;

  TRes call({
    String? username,
    Enum$UserType? userType,
    List<String>? sshKeys,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$userFields<TRes>
    implements CopyWith$Fragment$userFields<TRes> {
  _CopyWithImpl$Fragment$userFields(
    this._instance,
    this._then,
  );

  final Fragment$userFields _instance;

  final TRes Function(Fragment$userFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? username = _undefined,
    Object? userType = _undefined,
    Object? sshKeys = _undefined,
    Object? $__typename = _undefined,
  }) =>
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
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$userFields<TRes>
    implements CopyWith$Fragment$userFields<TRes> {
  _CopyWithStubImpl$Fragment$userFields(this._res);

  TRes _res;

  call({
    String? username,
    Enum$UserType? userType,
    List<String>? sshKeys,
    String? $__typename,
  }) =>
      _res;
}

const fragmentDefinitionuserFields = FragmentDefinitionNode(
  name: NameNode(value: 'userFields'),
  typeCondition: TypeConditionNode(
      on: NamedTypeNode(
    name: NameNode(value: 'User'),
    isNonNull: false,
  )),
  directives: [],
  selectionSet: SelectionSetNode(selections: [
    FieldNode(
      name: NameNode(value: 'username'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'userType'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'sshKeys'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: '__typename'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
  ]),
);
const documentNodeFragmentuserFields = DocumentNode(definitions: [
  fragmentDefinitionuserFields,
]);

extension ClientExtension$Fragment$userFields on graphql.GraphQLClient {
  void writeFragment$userFields({
    required Fragment$userFields data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) =>
      this.writeFragment(
        graphql.FragmentRequest(
          idFields: idFields,
          fragment: const graphql.Fragment(
            fragmentName: 'userFields',
            document: documentNodeFragmentuserFields,
          ),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Fragment$userFields? readFragment$userFields({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'userFields',
          document: documentNodeFragmentuserFields,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$userFields.fromJson(result);
  }
}

class Query$AllUsers {
  Query$AllUsers({
    required this.users,
    this.$__typename = 'Query',
  });

  factory Query$AllUsers.fromJson(Map<String, dynamic> json) {
    final l$users = json['users'];
    final l$$__typename = json['__typename'];
    return Query$AllUsers(
      users: Query$AllUsers$users.fromJson((l$users as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$AllUsers$users users;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$users = users;
    _resultData['users'] = l$users.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$users = users;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$users,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$AllUsers) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$users = users;
    final lOther$users = other.users;
    if (l$users != lOther$users) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$AllUsers on Query$AllUsers {
  CopyWith$Query$AllUsers<Query$AllUsers> get copyWith =>
      CopyWith$Query$AllUsers(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$AllUsers<TRes> {
  factory CopyWith$Query$AllUsers(
    Query$AllUsers instance,
    TRes Function(Query$AllUsers) then,
  ) = _CopyWithImpl$Query$AllUsers;

  factory CopyWith$Query$AllUsers.stub(TRes res) =
      _CopyWithStubImpl$Query$AllUsers;

  TRes call({
    Query$AllUsers$users? users,
    String? $__typename,
  });
  CopyWith$Query$AllUsers$users<TRes> get users;
}

class _CopyWithImpl$Query$AllUsers<TRes>
    implements CopyWith$Query$AllUsers<TRes> {
  _CopyWithImpl$Query$AllUsers(
    this._instance,
    this._then,
  );

  final Query$AllUsers _instance;

  final TRes Function(Query$AllUsers) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? users = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$AllUsers(
        users: users == _undefined || users == null
            ? _instance.users
            : (users as Query$AllUsers$users),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$AllUsers$users<TRes> get users {
    final local$users = _instance.users;
    return CopyWith$Query$AllUsers$users(local$users, (e) => call(users: e));
  }
}

class _CopyWithStubImpl$Query$AllUsers<TRes>
    implements CopyWith$Query$AllUsers<TRes> {
  _CopyWithStubImpl$Query$AllUsers(this._res);

  TRes _res;

  call({
    Query$AllUsers$users? users,
    String? $__typename,
  }) =>
      _res;

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
                name: NameNode(value: 'userFields'),
                directives: [],
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: 'getUser'),
            alias: NameNode(value: 'rootUser'),
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'username'),
                value: StringValueNode(
                  value: 'root',
                  isBlock: false,
                ),
              )
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                name: NameNode(value: 'userFields'),
                directives: [],
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionuserFields,
]);
Query$AllUsers _parserFn$Query$AllUsers(Map<String, dynamic> data) =>
    Query$AllUsers.fromJson(data);
typedef OnQueryComplete$Query$AllUsers = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$AllUsers?,
);

class Options$Query$AllUsers extends graphql.QueryOptions<Query$AllUsers> {
  Options$Query$AllUsers({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$AllUsers? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$AllUsers? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$AllUsers(data),
                  ),
          onError: onError,
          document: documentNodeQueryAllUsers,
          parserFn: _parserFn$Query$AllUsers,
        );

  final OnQueryComplete$Query$AllUsers? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$AllUsers
    extends graphql.WatchQueryOptions<Query$AllUsers> {
  WatchOptions$Query$AllUsers({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$AllUsers? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryAllUsers,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$AllUsers,
        );
}

class FetchMoreOptions$Query$AllUsers extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$AllUsers({required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryAllUsers,
        );
}

extension ClientExtension$Query$AllUsers on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$AllUsers>> query$AllUsers(
          [Options$Query$AllUsers? options]) async =>
      await this.query(options ?? Options$Query$AllUsers());
  graphql.ObservableQuery<Query$AllUsers> watchQuery$AllUsers(
          [WatchOptions$Query$AllUsers? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$AllUsers());
  void writeQuery$AllUsers({
    required Query$AllUsers data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation: graphql.Operation(document: documentNodeQueryAllUsers)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$AllUsers? readQuery$AllUsers({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryAllUsers)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$AllUsers.fromJson(result);
  }
}

class Query$AllUsers$users {
  Query$AllUsers$users({
    required this.allUsers,
    this.rootUser,
    this.$__typename = 'Users',
  });

  factory Query$AllUsers$users.fromJson(Map<String, dynamic> json) {
    final l$allUsers = json['allUsers'];
    final l$rootUser = json['rootUser'];
    final l$$__typename = json['__typename'];
    return Query$AllUsers$users(
      allUsers: (l$allUsers as List<dynamic>)
          .map((e) => Fragment$userFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      rootUser: l$rootUser == null
          ? null
          : Fragment$userFields.fromJson((l$rootUser as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$userFields> allUsers;

  final Fragment$userFields? rootUser;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$allUsers = allUsers;
    _resultData['allUsers'] = l$allUsers.map((e) => e.toJson()).toList();
    final l$rootUser = rootUser;
    _resultData['rootUser'] = l$rootUser?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$allUsers = allUsers;
    final l$rootUser = rootUser;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$allUsers.map((v) => v)),
      l$rootUser,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$AllUsers$users) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$allUsers = allUsers;
    final lOther$allUsers = other.allUsers;
    if (l$allUsers.length != lOther$allUsers.length) {
      return false;
    }
    for (int i = 0; i < l$allUsers.length; i++) {
      final l$allUsers$entry = l$allUsers[i];
      final lOther$allUsers$entry = lOther$allUsers[i];
      if (l$allUsers$entry != lOther$allUsers$entry) {
        return false;
      }
    }
    final l$rootUser = rootUser;
    final lOther$rootUser = other.rootUser;
    if (l$rootUser != lOther$rootUser) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$AllUsers$users on Query$AllUsers$users {
  CopyWith$Query$AllUsers$users<Query$AllUsers$users> get copyWith =>
      CopyWith$Query$AllUsers$users(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$AllUsers$users<TRes> {
  factory CopyWith$Query$AllUsers$users(
    Query$AllUsers$users instance,
    TRes Function(Query$AllUsers$users) then,
  ) = _CopyWithImpl$Query$AllUsers$users;

  factory CopyWith$Query$AllUsers$users.stub(TRes res) =
      _CopyWithStubImpl$Query$AllUsers$users;

  TRes call({
    List<Fragment$userFields>? allUsers,
    Fragment$userFields? rootUser,
    String? $__typename,
  });
  TRes allUsers(
      Iterable<Fragment$userFields> Function(
              Iterable<CopyWith$Fragment$userFields<Fragment$userFields>>)
          _fn);
  CopyWith$Fragment$userFields<TRes> get rootUser;
}

class _CopyWithImpl$Query$AllUsers$users<TRes>
    implements CopyWith$Query$AllUsers$users<TRes> {
  _CopyWithImpl$Query$AllUsers$users(
    this._instance,
    this._then,
  );

  final Query$AllUsers$users _instance;

  final TRes Function(Query$AllUsers$users) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? allUsers = _undefined,
    Object? rootUser = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$AllUsers$users(
        allUsers: allUsers == _undefined || allUsers == null
            ? _instance.allUsers
            : (allUsers as List<Fragment$userFields>),
        rootUser: rootUser == _undefined
            ? _instance.rootUser
            : (rootUser as Fragment$userFields?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes allUsers(
          Iterable<Fragment$userFields> Function(
                  Iterable<CopyWith$Fragment$userFields<Fragment$userFields>>)
              _fn) =>
      call(
          allUsers:
              _fn(_instance.allUsers.map((e) => CopyWith$Fragment$userFields(
                    e,
                    (i) => i,
                  ))).toList());

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

  call({
    List<Fragment$userFields>? allUsers,
    Fragment$userFields? rootUser,
    String? $__typename,
  }) =>
      _res;

  allUsers(_fn) => _res;

  CopyWith$Fragment$userFields<TRes> get rootUser =>
      CopyWith$Fragment$userFields.stub(_res);
}

class Variables$Query$GetUser {
  factory Variables$Query$GetUser({required String username}) =>
      Variables$Query$GetUser._({
        r'username': username,
      });

  Variables$Query$GetUser._(this._$data);

  factory Variables$Query$GetUser.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$username = data['username'];
    result$data['username'] = (l$username as String);
    return Variables$Query$GetUser._(result$data);
  }

  Map<String, dynamic> _$data;

  String get username => (_$data['username'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$username = username;
    result$data['username'] = l$username;
    return result$data;
  }

  CopyWith$Variables$Query$GetUser<Variables$Query$GetUser> get copyWith =>
      CopyWith$Variables$Query$GetUser(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetUser) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$username = username;
    return Object.hashAll([l$username]);
  }
}

abstract class CopyWith$Variables$Query$GetUser<TRes> {
  factory CopyWith$Variables$Query$GetUser(
    Variables$Query$GetUser instance,
    TRes Function(Variables$Query$GetUser) then,
  ) = _CopyWithImpl$Variables$Query$GetUser;

  factory CopyWith$Variables$Query$GetUser.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetUser;

  TRes call({String? username});
}

class _CopyWithImpl$Variables$Query$GetUser<TRes>
    implements CopyWith$Variables$Query$GetUser<TRes> {
  _CopyWithImpl$Variables$Query$GetUser(
    this._instance,
    this._then,
  );

  final Variables$Query$GetUser _instance;

  final TRes Function(Variables$Query$GetUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? username = _undefined}) =>
      _then(Variables$Query$GetUser._({
        ..._instance._$data,
        if (username != _undefined && username != null)
          'username': (username as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetUser<TRes>
    implements CopyWith$Variables$Query$GetUser<TRes> {
  _CopyWithStubImpl$Variables$Query$GetUser(this._res);

  TRes _res;

  call({String? username}) => _res;
}

class Query$GetUser {
  Query$GetUser({
    required this.users,
    this.$__typename = 'Query',
  });

  factory Query$GetUser.fromJson(Map<String, dynamic> json) {
    final l$users = json['users'];
    final l$$__typename = json['__typename'];
    return Query$GetUser(
      users: Query$GetUser$users.fromJson((l$users as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetUser$users users;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$users = users;
    _resultData['users'] = l$users.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$users = users;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$users,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetUser) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$users = users;
    final lOther$users = other.users;
    if (l$users != lOther$users) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetUser on Query$GetUser {
  CopyWith$Query$GetUser<Query$GetUser> get copyWith => CopyWith$Query$GetUser(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetUser<TRes> {
  factory CopyWith$Query$GetUser(
    Query$GetUser instance,
    TRes Function(Query$GetUser) then,
  ) = _CopyWithImpl$Query$GetUser;

  factory CopyWith$Query$GetUser.stub(TRes res) =
      _CopyWithStubImpl$Query$GetUser;

  TRes call({
    Query$GetUser$users? users,
    String? $__typename,
  });
  CopyWith$Query$GetUser$users<TRes> get users;
}

class _CopyWithImpl$Query$GetUser<TRes>
    implements CopyWith$Query$GetUser<TRes> {
  _CopyWithImpl$Query$GetUser(
    this._instance,
    this._then,
  );

  final Query$GetUser _instance;

  final TRes Function(Query$GetUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? users = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetUser(
        users: users == _undefined || users == null
            ? _instance.users
            : (users as Query$GetUser$users),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetUser$users<TRes> get users {
    final local$users = _instance.users;
    return CopyWith$Query$GetUser$users(local$users, (e) => call(users: e));
  }
}

class _CopyWithStubImpl$Query$GetUser<TRes>
    implements CopyWith$Query$GetUser<TRes> {
  _CopyWithStubImpl$Query$GetUser(this._res);

  TRes _res;

  call({
    Query$GetUser$users? users,
    String? $__typename,
  }) =>
      _res;

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
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
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
                value: VariableNode(name: NameNode(value: 'username')),
              )
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                name: NameNode(value: 'userFields'),
                directives: [],
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionuserFields,
]);
Query$GetUser _parserFn$Query$GetUser(Map<String, dynamic> data) =>
    Query$GetUser.fromJson(data);
typedef OnQueryComplete$Query$GetUser = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetUser?,
);

class Options$Query$GetUser extends graphql.QueryOptions<Query$GetUser> {
  Options$Query$GetUser({
    String? operationName,
    required Variables$Query$GetUser variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetUser? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetUser? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetUser(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetUser,
          parserFn: _parserFn$Query$GetUser,
        );

  final OnQueryComplete$Query$GetUser? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetUser
    extends graphql.WatchQueryOptions<Query$GetUser> {
  WatchOptions$Query$GetUser({
    String? operationName,
    required Variables$Query$GetUser variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetUser? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetUser,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetUser,
        );
}

class FetchMoreOptions$Query$GetUser extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetUser({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetUser variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetUser,
        );
}

extension ClientExtension$Query$GetUser on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetUser>> query$GetUser(
          Options$Query$GetUser options) async =>
      await this.query(options);
  graphql.ObservableQuery<Query$GetUser> watchQuery$GetUser(
          WatchOptions$Query$GetUser options) =>
      this.watchQuery(options);
  void writeQuery$GetUser({
    required Query$GetUser data,
    required Variables$Query$GetUser variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryGetUser),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetUser? readQuery$GetUser({
    required Variables$Query$GetUser variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryGetUser),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetUser.fromJson(result);
  }
}

class Query$GetUser$users {
  Query$GetUser$users({
    this.getUser,
    this.$__typename = 'Users',
  });

  factory Query$GetUser$users.fromJson(Map<String, dynamic> json) {
    final l$getUser = json['getUser'];
    final l$$__typename = json['__typename'];
    return Query$GetUser$users(
      getUser: l$getUser == null
          ? null
          : Fragment$userFields.fromJson((l$getUser as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$userFields? getUser;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getUser = getUser;
    _resultData['getUser'] = l$getUser?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getUser = getUser;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getUser,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetUser$users) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getUser = getUser;
    final lOther$getUser = other.getUser;
    if (l$getUser != lOther$getUser) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetUser$users on Query$GetUser$users {
  CopyWith$Query$GetUser$users<Query$GetUser$users> get copyWith =>
      CopyWith$Query$GetUser$users(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetUser$users<TRes> {
  factory CopyWith$Query$GetUser$users(
    Query$GetUser$users instance,
    TRes Function(Query$GetUser$users) then,
  ) = _CopyWithImpl$Query$GetUser$users;

  factory CopyWith$Query$GetUser$users.stub(TRes res) =
      _CopyWithStubImpl$Query$GetUser$users;

  TRes call({
    Fragment$userFields? getUser,
    String? $__typename,
  });
  CopyWith$Fragment$userFields<TRes> get getUser;
}

class _CopyWithImpl$Query$GetUser$users<TRes>
    implements CopyWith$Query$GetUser$users<TRes> {
  _CopyWithImpl$Query$GetUser$users(
    this._instance,
    this._then,
  );

  final Query$GetUser$users _instance;

  final TRes Function(Query$GetUser$users) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getUser = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetUser$users(
        getUser: getUser == _undefined
            ? _instance.getUser
            : (getUser as Fragment$userFields?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

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

  call({
    Fragment$userFields? getUser,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$userFields<TRes> get getUser =>
      CopyWith$Fragment$userFields.stub(_res);
}

class Variables$Mutation$CreateUser {
  factory Variables$Mutation$CreateUser(
          {required Input$UserMutationInput user}) =>
      Variables$Mutation$CreateUser._({
        r'user': user,
      });

  Variables$Mutation$CreateUser._(this._$data);

  factory Variables$Mutation$CreateUser.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$user = data['user'];
    result$data['user'] =
        Input$UserMutationInput.fromJson((l$user as Map<String, dynamic>));
    return Variables$Mutation$CreateUser._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$UserMutationInput get user =>
      (_$data['user'] as Input$UserMutationInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$user = user;
    result$data['user'] = l$user.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$CreateUser<Variables$Mutation$CreateUser>
      get copyWith => CopyWith$Variables$Mutation$CreateUser(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$CreateUser) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$user = user;
    return Object.hashAll([l$user]);
  }
}

abstract class CopyWith$Variables$Mutation$CreateUser<TRes> {
  factory CopyWith$Variables$Mutation$CreateUser(
    Variables$Mutation$CreateUser instance,
    TRes Function(Variables$Mutation$CreateUser) then,
  ) = _CopyWithImpl$Variables$Mutation$CreateUser;

  factory CopyWith$Variables$Mutation$CreateUser.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CreateUser;

  TRes call({Input$UserMutationInput? user});
}

class _CopyWithImpl$Variables$Mutation$CreateUser<TRes>
    implements CopyWith$Variables$Mutation$CreateUser<TRes> {
  _CopyWithImpl$Variables$Mutation$CreateUser(
    this._instance,
    this._then,
  );

  final Variables$Mutation$CreateUser _instance;

  final TRes Function(Variables$Mutation$CreateUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? user = _undefined}) =>
      _then(Variables$Mutation$CreateUser._({
        ..._instance._$data,
        if (user != _undefined && user != null)
          'user': (user as Input$UserMutationInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$CreateUser<TRes>
    implements CopyWith$Variables$Mutation$CreateUser<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateUser(this._res);

  TRes _res;

  call({Input$UserMutationInput? user}) => _res;
}

class Mutation$CreateUser {
  Mutation$CreateUser({
    required this.createUser,
    this.$__typename = 'Mutation',
  });

  factory Mutation$CreateUser.fromJson(Map<String, dynamic> json) {
    final l$createUser = json['createUser'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateUser(
      createUser: Mutation$CreateUser$createUser.fromJson(
          (l$createUser as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  @Deprecated('Use `users.create_user` instead')
  final Mutation$CreateUser$createUser createUser;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createUser = createUser;
    _resultData['createUser'] = l$createUser.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createUser = createUser;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createUser,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateUser) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$createUser = createUser;
    final lOther$createUser = other.createUser;
    if (l$createUser != lOther$createUser) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$CreateUser on Mutation$CreateUser {
  CopyWith$Mutation$CreateUser<Mutation$CreateUser> get copyWith =>
      CopyWith$Mutation$CreateUser(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$CreateUser<TRes> {
  factory CopyWith$Mutation$CreateUser(
    Mutation$CreateUser instance,
    TRes Function(Mutation$CreateUser) then,
  ) = _CopyWithImpl$Mutation$CreateUser;

  factory CopyWith$Mutation$CreateUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateUser;

  TRes call({
    Mutation$CreateUser$createUser? createUser,
    String? $__typename,
  });
  CopyWith$Mutation$CreateUser$createUser<TRes> get createUser;
}

class _CopyWithImpl$Mutation$CreateUser<TRes>
    implements CopyWith$Mutation$CreateUser<TRes> {
  _CopyWithImpl$Mutation$CreateUser(
    this._instance,
    this._then,
  );

  final Mutation$CreateUser _instance;

  final TRes Function(Mutation$CreateUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createUser = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateUser(
        createUser: createUser == _undefined || createUser == null
            ? _instance.createUser
            : (createUser as Mutation$CreateUser$createUser),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

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

  call({
    Mutation$CreateUser$createUser? createUser,
    String? $__typename,
  }) =>
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
          name: NameNode(value: 'UserMutationInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'createUser'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'user'),
            value: VariableNode(name: NameNode(value: 'user')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'basicMutationReturnFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                name: NameNode(value: 'userFields'),
                directives: [],
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
  fragmentDefinitionuserFields,
]);
Mutation$CreateUser _parserFn$Mutation$CreateUser(Map<String, dynamic> data) =>
    Mutation$CreateUser.fromJson(data);
typedef OnMutationCompleted$Mutation$CreateUser = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$CreateUser?,
);

class Options$Mutation$CreateUser
    extends graphql.MutationOptions<Mutation$CreateUser> {
  Options$Mutation$CreateUser({
    String? operationName,
    required Variables$Mutation$CreateUser variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateUser? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateUser? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateUser>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$CreateUser(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateUser,
          parserFn: _parserFn$Mutation$CreateUser,
        );

  final OnMutationCompleted$Mutation$CreateUser? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$CreateUser
    extends graphql.WatchQueryOptions<Mutation$CreateUser> {
  WatchOptions$Mutation$CreateUser({
    String? operationName,
    required Variables$Mutation$CreateUser variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateUser? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeMutationCreateUser,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$CreateUser,
        );
}

extension ClientExtension$Mutation$CreateUser on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$CreateUser>> mutate$CreateUser(
          Options$Mutation$CreateUser options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$CreateUser> watchMutation$CreateUser(
          WatchOptions$Mutation$CreateUser options) =>
      this.watchMutation(options);
}

class Mutation$CreateUser$createUser
    implements Fragment$basicMutationReturnFields$$UserMutationReturn {
  Mutation$CreateUser$createUser({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'UserMutationReturn',
    this.user,
  });

  factory Mutation$CreateUser$createUser.fromJson(Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$user = json['user'];
    return Mutation$CreateUser$createUser(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      user: l$user == null
          ? null
          : Fragment$userFields.fromJson((l$user as Map<String, dynamic>)),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final Fragment$userFields? user;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    final l$user = user;
    _resultData['user'] = l$user?.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$user = user;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$user,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateUser$createUser) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$CreateUser$createUser
    on Mutation$CreateUser$createUser {
  CopyWith$Mutation$CreateUser$createUser<Mutation$CreateUser$createUser>
      get copyWith => CopyWith$Mutation$CreateUser$createUser(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$CreateUser$createUser<TRes> {
  factory CopyWith$Mutation$CreateUser$createUser(
    Mutation$CreateUser$createUser instance,
    TRes Function(Mutation$CreateUser$createUser) then,
  ) = _CopyWithImpl$Mutation$CreateUser$createUser;

  factory CopyWith$Mutation$CreateUser$createUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateUser$createUser;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  });
  CopyWith$Fragment$userFields<TRes> get user;
}

class _CopyWithImpl$Mutation$CreateUser$createUser<TRes>
    implements CopyWith$Mutation$CreateUser$createUser<TRes> {
  _CopyWithImpl$Mutation$CreateUser$createUser(
    this._instance,
    this._then,
  );

  final Mutation$CreateUser$createUser _instance;

  final TRes Function(Mutation$CreateUser$createUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? user = _undefined,
  }) =>
      _then(Mutation$CreateUser$createUser(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
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
            : (user as Fragment$userFields?),
      ));

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

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  }) =>
      _res;

  CopyWith$Fragment$userFields<TRes> get user =>
      CopyWith$Fragment$userFields.stub(_res);
}

class Variables$Mutation$DeleteUser {
  factory Variables$Mutation$DeleteUser({required String username}) =>
      Variables$Mutation$DeleteUser._({
        r'username': username,
      });

  Variables$Mutation$DeleteUser._(this._$data);

  factory Variables$Mutation$DeleteUser.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$username = data['username'];
    result$data['username'] = (l$username as String);
    return Variables$Mutation$DeleteUser._(result$data);
  }

  Map<String, dynamic> _$data;

  String get username => (_$data['username'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$username = username;
    result$data['username'] = l$username;
    return result$data;
  }

  CopyWith$Variables$Mutation$DeleteUser<Variables$Mutation$DeleteUser>
      get copyWith => CopyWith$Variables$Mutation$DeleteUser(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$DeleteUser) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$username = username;
    return Object.hashAll([l$username]);
  }
}

abstract class CopyWith$Variables$Mutation$DeleteUser<TRes> {
  factory CopyWith$Variables$Mutation$DeleteUser(
    Variables$Mutation$DeleteUser instance,
    TRes Function(Variables$Mutation$DeleteUser) then,
  ) = _CopyWithImpl$Variables$Mutation$DeleteUser;

  factory CopyWith$Variables$Mutation$DeleteUser.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$DeleteUser;

  TRes call({String? username});
}

class _CopyWithImpl$Variables$Mutation$DeleteUser<TRes>
    implements CopyWith$Variables$Mutation$DeleteUser<TRes> {
  _CopyWithImpl$Variables$Mutation$DeleteUser(
    this._instance,
    this._then,
  );

  final Variables$Mutation$DeleteUser _instance;

  final TRes Function(Variables$Mutation$DeleteUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? username = _undefined}) =>
      _then(Variables$Mutation$DeleteUser._({
        ..._instance._$data,
        if (username != _undefined && username != null)
          'username': (username as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$DeleteUser<TRes>
    implements CopyWith$Variables$Mutation$DeleteUser<TRes> {
  _CopyWithStubImpl$Variables$Mutation$DeleteUser(this._res);

  TRes _res;

  call({String? username}) => _res;
}

class Mutation$DeleteUser {
  Mutation$DeleteUser({
    required this.deleteUser,
    this.$__typename = 'Mutation',
  });

  factory Mutation$DeleteUser.fromJson(Map<String, dynamic> json) {
    final l$deleteUser = json['deleteUser'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteUser(
      deleteUser: Mutation$DeleteUser$deleteUser.fromJson(
          (l$deleteUser as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  @Deprecated('Use `users.delete_user` instead')
  final Mutation$DeleteUser$deleteUser deleteUser;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteUser = deleteUser;
    _resultData['deleteUser'] = l$deleteUser.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteUser = deleteUser;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$deleteUser,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$DeleteUser) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteUser = deleteUser;
    final lOther$deleteUser = other.deleteUser;
    if (l$deleteUser != lOther$deleteUser) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$DeleteUser on Mutation$DeleteUser {
  CopyWith$Mutation$DeleteUser<Mutation$DeleteUser> get copyWith =>
      CopyWith$Mutation$DeleteUser(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$DeleteUser<TRes> {
  factory CopyWith$Mutation$DeleteUser(
    Mutation$DeleteUser instance,
    TRes Function(Mutation$DeleteUser) then,
  ) = _CopyWithImpl$Mutation$DeleteUser;

  factory CopyWith$Mutation$DeleteUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DeleteUser;

  TRes call({
    Mutation$DeleteUser$deleteUser? deleteUser,
    String? $__typename,
  });
  CopyWith$Mutation$DeleteUser$deleteUser<TRes> get deleteUser;
}

class _CopyWithImpl$Mutation$DeleteUser<TRes>
    implements CopyWith$Mutation$DeleteUser<TRes> {
  _CopyWithImpl$Mutation$DeleteUser(
    this._instance,
    this._then,
  );

  final Mutation$DeleteUser _instance;

  final TRes Function(Mutation$DeleteUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? deleteUser = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$DeleteUser(
        deleteUser: deleteUser == _undefined || deleteUser == null
            ? _instance.deleteUser
            : (deleteUser as Mutation$DeleteUser$deleteUser),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

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

  call({
    Mutation$DeleteUser$deleteUser? deleteUser,
    String? $__typename,
  }) =>
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
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'deleteUser'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'username'),
            value: VariableNode(name: NameNode(value: 'username')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'basicMutationReturnFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$DeleteUser _parserFn$Mutation$DeleteUser(Map<String, dynamic> data) =>
    Mutation$DeleteUser.fromJson(data);
typedef OnMutationCompleted$Mutation$DeleteUser = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$DeleteUser?,
);

class Options$Mutation$DeleteUser
    extends graphql.MutationOptions<Mutation$DeleteUser> {
  Options$Mutation$DeleteUser({
    String? operationName,
    required Variables$Mutation$DeleteUser variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DeleteUser? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$DeleteUser? onCompleted,
    graphql.OnMutationUpdate<Mutation$DeleteUser>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$DeleteUser(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationDeleteUser,
          parserFn: _parserFn$Mutation$DeleteUser,
        );

  final OnMutationCompleted$Mutation$DeleteUser? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$DeleteUser
    extends graphql.WatchQueryOptions<Mutation$DeleteUser> {
  WatchOptions$Mutation$DeleteUser({
    String? operationName,
    required Variables$Mutation$DeleteUser variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DeleteUser? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeMutationDeleteUser,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$DeleteUser,
        );
}

extension ClientExtension$Mutation$DeleteUser on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$DeleteUser>> mutate$DeleteUser(
          Options$Mutation$DeleteUser options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$DeleteUser> watchMutation$DeleteUser(
          WatchOptions$Mutation$DeleteUser options) =>
      this.watchMutation(options);
}

class Mutation$DeleteUser$deleteUser
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$DeleteUser$deleteUser({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$DeleteUser$deleteUser.fromJson(Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteUser$deleteUser(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$DeleteUser$deleteUser) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$DeleteUser$deleteUser
    on Mutation$DeleteUser$deleteUser {
  CopyWith$Mutation$DeleteUser$deleteUser<Mutation$DeleteUser$deleteUser>
      get copyWith => CopyWith$Mutation$DeleteUser$deleteUser(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$DeleteUser$deleteUser<TRes> {
  factory CopyWith$Mutation$DeleteUser$deleteUser(
    Mutation$DeleteUser$deleteUser instance,
    TRes Function(Mutation$DeleteUser$deleteUser) then,
  ) = _CopyWithImpl$Mutation$DeleteUser$deleteUser;

  factory CopyWith$Mutation$DeleteUser$deleteUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DeleteUser$deleteUser;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$DeleteUser$deleteUser<TRes>
    implements CopyWith$Mutation$DeleteUser$deleteUser<TRes> {
  _CopyWithImpl$Mutation$DeleteUser$deleteUser(
    this._instance,
    this._then,
  );

  final Mutation$DeleteUser$deleteUser _instance;

  final TRes Function(Mutation$DeleteUser$deleteUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$DeleteUser$deleteUser(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$DeleteUser$deleteUser<TRes>
    implements CopyWith$Mutation$DeleteUser$deleteUser<TRes> {
  _CopyWithStubImpl$Mutation$DeleteUser$deleteUser(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$UpdateUser {
  factory Variables$Mutation$UpdateUser(
          {required Input$UserMutationInput user}) =>
      Variables$Mutation$UpdateUser._({
        r'user': user,
      });

  Variables$Mutation$UpdateUser._(this._$data);

  factory Variables$Mutation$UpdateUser.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$user = data['user'];
    result$data['user'] =
        Input$UserMutationInput.fromJson((l$user as Map<String, dynamic>));
    return Variables$Mutation$UpdateUser._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$UserMutationInput get user =>
      (_$data['user'] as Input$UserMutationInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$user = user;
    result$data['user'] = l$user.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$UpdateUser<Variables$Mutation$UpdateUser>
      get copyWith => CopyWith$Variables$Mutation$UpdateUser(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$UpdateUser) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$user = user;
    return Object.hashAll([l$user]);
  }
}

abstract class CopyWith$Variables$Mutation$UpdateUser<TRes> {
  factory CopyWith$Variables$Mutation$UpdateUser(
    Variables$Mutation$UpdateUser instance,
    TRes Function(Variables$Mutation$UpdateUser) then,
  ) = _CopyWithImpl$Variables$Mutation$UpdateUser;

  factory CopyWith$Variables$Mutation$UpdateUser.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UpdateUser;

  TRes call({Input$UserMutationInput? user});
}

class _CopyWithImpl$Variables$Mutation$UpdateUser<TRes>
    implements CopyWith$Variables$Mutation$UpdateUser<TRes> {
  _CopyWithImpl$Variables$Mutation$UpdateUser(
    this._instance,
    this._then,
  );

  final Variables$Mutation$UpdateUser _instance;

  final TRes Function(Variables$Mutation$UpdateUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? user = _undefined}) =>
      _then(Variables$Mutation$UpdateUser._({
        ..._instance._$data,
        if (user != _undefined && user != null)
          'user': (user as Input$UserMutationInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$UpdateUser<TRes>
    implements CopyWith$Variables$Mutation$UpdateUser<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UpdateUser(this._res);

  TRes _res;

  call({Input$UserMutationInput? user}) => _res;
}

class Mutation$UpdateUser {
  Mutation$UpdateUser({
    required this.updateUser,
    this.$__typename = 'Mutation',
  });

  factory Mutation$UpdateUser.fromJson(Map<String, dynamic> json) {
    final l$updateUser = json['updateUser'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateUser(
      updateUser: Mutation$UpdateUser$updateUser.fromJson(
          (l$updateUser as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  @Deprecated('Use `users.update_user` instead')
  final Mutation$UpdateUser$updateUser updateUser;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateUser = updateUser;
    _resultData['updateUser'] = l$updateUser.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateUser = updateUser;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$updateUser,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$UpdateUser) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateUser = updateUser;
    final lOther$updateUser = other.updateUser;
    if (l$updateUser != lOther$updateUser) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$UpdateUser on Mutation$UpdateUser {
  CopyWith$Mutation$UpdateUser<Mutation$UpdateUser> get copyWith =>
      CopyWith$Mutation$UpdateUser(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$UpdateUser<TRes> {
  factory CopyWith$Mutation$UpdateUser(
    Mutation$UpdateUser instance,
    TRes Function(Mutation$UpdateUser) then,
  ) = _CopyWithImpl$Mutation$UpdateUser;

  factory CopyWith$Mutation$UpdateUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateUser;

  TRes call({
    Mutation$UpdateUser$updateUser? updateUser,
    String? $__typename,
  });
  CopyWith$Mutation$UpdateUser$updateUser<TRes> get updateUser;
}

class _CopyWithImpl$Mutation$UpdateUser<TRes>
    implements CopyWith$Mutation$UpdateUser<TRes> {
  _CopyWithImpl$Mutation$UpdateUser(
    this._instance,
    this._then,
  );

  final Mutation$UpdateUser _instance;

  final TRes Function(Mutation$UpdateUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? updateUser = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$UpdateUser(
        updateUser: updateUser == _undefined || updateUser == null
            ? _instance.updateUser
            : (updateUser as Mutation$UpdateUser$updateUser),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

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

  call({
    Mutation$UpdateUser$updateUser? updateUser,
    String? $__typename,
  }) =>
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
          name: NameNode(value: 'UserMutationInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'updateUser'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'user'),
            value: VariableNode(name: NameNode(value: 'user')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'basicMutationReturnFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                name: NameNode(value: 'userFields'),
                directives: [],
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
  fragmentDefinitionuserFields,
]);
Mutation$UpdateUser _parserFn$Mutation$UpdateUser(Map<String, dynamic> data) =>
    Mutation$UpdateUser.fromJson(data);
typedef OnMutationCompleted$Mutation$UpdateUser = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$UpdateUser?,
);

class Options$Mutation$UpdateUser
    extends graphql.MutationOptions<Mutation$UpdateUser> {
  Options$Mutation$UpdateUser({
    String? operationName,
    required Variables$Mutation$UpdateUser variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateUser? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateUser? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateUser>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$UpdateUser(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationUpdateUser,
          parserFn: _parserFn$Mutation$UpdateUser,
        );

  final OnMutationCompleted$Mutation$UpdateUser? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$UpdateUser
    extends graphql.WatchQueryOptions<Mutation$UpdateUser> {
  WatchOptions$Mutation$UpdateUser({
    String? operationName,
    required Variables$Mutation$UpdateUser variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateUser? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeMutationUpdateUser,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$UpdateUser,
        );
}

extension ClientExtension$Mutation$UpdateUser on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UpdateUser>> mutate$UpdateUser(
          Options$Mutation$UpdateUser options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$UpdateUser> watchMutation$UpdateUser(
          WatchOptions$Mutation$UpdateUser options) =>
      this.watchMutation(options);
}

class Mutation$UpdateUser$updateUser
    implements Fragment$basicMutationReturnFields$$UserMutationReturn {
  Mutation$UpdateUser$updateUser({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'UserMutationReturn',
    this.user,
  });

  factory Mutation$UpdateUser$updateUser.fromJson(Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$user = json['user'];
    return Mutation$UpdateUser$updateUser(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      user: l$user == null
          ? null
          : Fragment$userFields.fromJson((l$user as Map<String, dynamic>)),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final Fragment$userFields? user;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    final l$user = user;
    _resultData['user'] = l$user?.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$user = user;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$user,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$UpdateUser$updateUser) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$UpdateUser$updateUser
    on Mutation$UpdateUser$updateUser {
  CopyWith$Mutation$UpdateUser$updateUser<Mutation$UpdateUser$updateUser>
      get copyWith => CopyWith$Mutation$UpdateUser$updateUser(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$UpdateUser$updateUser<TRes> {
  factory CopyWith$Mutation$UpdateUser$updateUser(
    Mutation$UpdateUser$updateUser instance,
    TRes Function(Mutation$UpdateUser$updateUser) then,
  ) = _CopyWithImpl$Mutation$UpdateUser$updateUser;

  factory CopyWith$Mutation$UpdateUser$updateUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateUser$updateUser;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  });
  CopyWith$Fragment$userFields<TRes> get user;
}

class _CopyWithImpl$Mutation$UpdateUser$updateUser<TRes>
    implements CopyWith$Mutation$UpdateUser$updateUser<TRes> {
  _CopyWithImpl$Mutation$UpdateUser$updateUser(
    this._instance,
    this._then,
  );

  final Mutation$UpdateUser$updateUser _instance;

  final TRes Function(Mutation$UpdateUser$updateUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? user = _undefined,
  }) =>
      _then(Mutation$UpdateUser$updateUser(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
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
            : (user as Fragment$userFields?),
      ));

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

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  }) =>
      _res;

  CopyWith$Fragment$userFields<TRes> get user =>
      CopyWith$Fragment$userFields.stub(_res);
}

class Variables$Mutation$AddSshKey {
  factory Variables$Mutation$AddSshKey(
          {required Input$SshMutationInput sshInput}) =>
      Variables$Mutation$AddSshKey._({
        r'sshInput': sshInput,
      });

  Variables$Mutation$AddSshKey._(this._$data);

  factory Variables$Mutation$AddSshKey.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$sshInput = data['sshInput'];
    result$data['sshInput'] =
        Input$SshMutationInput.fromJson((l$sshInput as Map<String, dynamic>));
    return Variables$Mutation$AddSshKey._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$SshMutationInput get sshInput =>
      (_$data['sshInput'] as Input$SshMutationInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$sshInput = sshInput;
    result$data['sshInput'] = l$sshInput.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$AddSshKey<Variables$Mutation$AddSshKey>
      get copyWith => CopyWith$Variables$Mutation$AddSshKey(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$AddSshKey) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$sshInput = sshInput;
    final lOther$sshInput = other.sshInput;
    if (l$sshInput != lOther$sshInput) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$sshInput = sshInput;
    return Object.hashAll([l$sshInput]);
  }
}

abstract class CopyWith$Variables$Mutation$AddSshKey<TRes> {
  factory CopyWith$Variables$Mutation$AddSshKey(
    Variables$Mutation$AddSshKey instance,
    TRes Function(Variables$Mutation$AddSshKey) then,
  ) = _CopyWithImpl$Variables$Mutation$AddSshKey;

  factory CopyWith$Variables$Mutation$AddSshKey.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$AddSshKey;

  TRes call({Input$SshMutationInput? sshInput});
}

class _CopyWithImpl$Variables$Mutation$AddSshKey<TRes>
    implements CopyWith$Variables$Mutation$AddSshKey<TRes> {
  _CopyWithImpl$Variables$Mutation$AddSshKey(
    this._instance,
    this._then,
  );

  final Variables$Mutation$AddSshKey _instance;

  final TRes Function(Variables$Mutation$AddSshKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? sshInput = _undefined}) =>
      _then(Variables$Mutation$AddSshKey._({
        ..._instance._$data,
        if (sshInput != _undefined && sshInput != null)
          'sshInput': (sshInput as Input$SshMutationInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$AddSshKey<TRes>
    implements CopyWith$Variables$Mutation$AddSshKey<TRes> {
  _CopyWithStubImpl$Variables$Mutation$AddSshKey(this._res);

  TRes _res;

  call({Input$SshMutationInput? sshInput}) => _res;
}

class Mutation$AddSshKey {
  Mutation$AddSshKey({
    required this.addSshKey,
    this.$__typename = 'Mutation',
  });

  factory Mutation$AddSshKey.fromJson(Map<String, dynamic> json) {
    final l$addSshKey = json['addSshKey'];
    final l$$__typename = json['__typename'];
    return Mutation$AddSshKey(
      addSshKey: Mutation$AddSshKey$addSshKey.fromJson(
          (l$addSshKey as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  @Deprecated('Use `users.add_ssh_key` instead')
  final Mutation$AddSshKey$addSshKey addSshKey;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$addSshKey = addSshKey;
    _resultData['addSshKey'] = l$addSshKey.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$addSshKey = addSshKey;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$addSshKey,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$AddSshKey) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$addSshKey = addSshKey;
    final lOther$addSshKey = other.addSshKey;
    if (l$addSshKey != lOther$addSshKey) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$AddSshKey on Mutation$AddSshKey {
  CopyWith$Mutation$AddSshKey<Mutation$AddSshKey> get copyWith =>
      CopyWith$Mutation$AddSshKey(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$AddSshKey<TRes> {
  factory CopyWith$Mutation$AddSshKey(
    Mutation$AddSshKey instance,
    TRes Function(Mutation$AddSshKey) then,
  ) = _CopyWithImpl$Mutation$AddSshKey;

  factory CopyWith$Mutation$AddSshKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$AddSshKey;

  TRes call({
    Mutation$AddSshKey$addSshKey? addSshKey,
    String? $__typename,
  });
  CopyWith$Mutation$AddSshKey$addSshKey<TRes> get addSshKey;
}

class _CopyWithImpl$Mutation$AddSshKey<TRes>
    implements CopyWith$Mutation$AddSshKey<TRes> {
  _CopyWithImpl$Mutation$AddSshKey(
    this._instance,
    this._then,
  );

  final Mutation$AddSshKey _instance;

  final TRes Function(Mutation$AddSshKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? addSshKey = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$AddSshKey(
        addSshKey: addSshKey == _undefined || addSshKey == null
            ? _instance.addSshKey
            : (addSshKey as Mutation$AddSshKey$addSshKey),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

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

  call({
    Mutation$AddSshKey$addSshKey? addSshKey,
    String? $__typename,
  }) =>
      _res;

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
          name: NameNode(value: 'SshMutationInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'addSshKey'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'sshInput'),
            value: VariableNode(name: NameNode(value: 'sshInput')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'basicMutationReturnFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                name: NameNode(value: 'userFields'),
                directives: [],
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
  fragmentDefinitionuserFields,
]);
Mutation$AddSshKey _parserFn$Mutation$AddSshKey(Map<String, dynamic> data) =>
    Mutation$AddSshKey.fromJson(data);
typedef OnMutationCompleted$Mutation$AddSshKey = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$AddSshKey?,
);

class Options$Mutation$AddSshKey
    extends graphql.MutationOptions<Mutation$AddSshKey> {
  Options$Mutation$AddSshKey({
    String? operationName,
    required Variables$Mutation$AddSshKey variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$AddSshKey? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$AddSshKey? onCompleted,
    graphql.OnMutationUpdate<Mutation$AddSshKey>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$AddSshKey(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationAddSshKey,
          parserFn: _parserFn$Mutation$AddSshKey,
        );

  final OnMutationCompleted$Mutation$AddSshKey? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$AddSshKey
    extends graphql.WatchQueryOptions<Mutation$AddSshKey> {
  WatchOptions$Mutation$AddSshKey({
    String? operationName,
    required Variables$Mutation$AddSshKey variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$AddSshKey? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeMutationAddSshKey,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$AddSshKey,
        );
}

extension ClientExtension$Mutation$AddSshKey on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$AddSshKey>> mutate$AddSshKey(
          Options$Mutation$AddSshKey options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$AddSshKey> watchMutation$AddSshKey(
          WatchOptions$Mutation$AddSshKey options) =>
      this.watchMutation(options);
}

class Mutation$AddSshKey$addSshKey
    implements Fragment$basicMutationReturnFields$$UserMutationReturn {
  Mutation$AddSshKey$addSshKey({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'UserMutationReturn',
    this.user,
  });

  factory Mutation$AddSshKey$addSshKey.fromJson(Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$user = json['user'];
    return Mutation$AddSshKey$addSshKey(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      user: l$user == null
          ? null
          : Fragment$userFields.fromJson((l$user as Map<String, dynamic>)),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final Fragment$userFields? user;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    final l$user = user;
    _resultData['user'] = l$user?.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$user = user;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$user,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$AddSshKey$addSshKey) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$AddSshKey$addSshKey
    on Mutation$AddSshKey$addSshKey {
  CopyWith$Mutation$AddSshKey$addSshKey<Mutation$AddSshKey$addSshKey>
      get copyWith => CopyWith$Mutation$AddSshKey$addSshKey(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$AddSshKey$addSshKey<TRes> {
  factory CopyWith$Mutation$AddSshKey$addSshKey(
    Mutation$AddSshKey$addSshKey instance,
    TRes Function(Mutation$AddSshKey$addSshKey) then,
  ) = _CopyWithImpl$Mutation$AddSshKey$addSshKey;

  factory CopyWith$Mutation$AddSshKey$addSshKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$AddSshKey$addSshKey;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  });
  CopyWith$Fragment$userFields<TRes> get user;
}

class _CopyWithImpl$Mutation$AddSshKey$addSshKey<TRes>
    implements CopyWith$Mutation$AddSshKey$addSshKey<TRes> {
  _CopyWithImpl$Mutation$AddSshKey$addSshKey(
    this._instance,
    this._then,
  );

  final Mutation$AddSshKey$addSshKey _instance;

  final TRes Function(Mutation$AddSshKey$addSshKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? user = _undefined,
  }) =>
      _then(Mutation$AddSshKey$addSshKey(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
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
            : (user as Fragment$userFields?),
      ));

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

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  }) =>
      _res;

  CopyWith$Fragment$userFields<TRes> get user =>
      CopyWith$Fragment$userFields.stub(_res);
}

class Variables$Mutation$RemoveSshKey {
  factory Variables$Mutation$RemoveSshKey(
          {required Input$SshMutationInput sshInput}) =>
      Variables$Mutation$RemoveSshKey._({
        r'sshInput': sshInput,
      });

  Variables$Mutation$RemoveSshKey._(this._$data);

  factory Variables$Mutation$RemoveSshKey.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$sshInput = data['sshInput'];
    result$data['sshInput'] =
        Input$SshMutationInput.fromJson((l$sshInput as Map<String, dynamic>));
    return Variables$Mutation$RemoveSshKey._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$SshMutationInput get sshInput =>
      (_$data['sshInput'] as Input$SshMutationInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$sshInput = sshInput;
    result$data['sshInput'] = l$sshInput.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$RemoveSshKey<Variables$Mutation$RemoveSshKey>
      get copyWith => CopyWith$Variables$Mutation$RemoveSshKey(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$RemoveSshKey) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$sshInput = sshInput;
    final lOther$sshInput = other.sshInput;
    if (l$sshInput != lOther$sshInput) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$sshInput = sshInput;
    return Object.hashAll([l$sshInput]);
  }
}

abstract class CopyWith$Variables$Mutation$RemoveSshKey<TRes> {
  factory CopyWith$Variables$Mutation$RemoveSshKey(
    Variables$Mutation$RemoveSshKey instance,
    TRes Function(Variables$Mutation$RemoveSshKey) then,
  ) = _CopyWithImpl$Variables$Mutation$RemoveSshKey;

  factory CopyWith$Variables$Mutation$RemoveSshKey.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$RemoveSshKey;

  TRes call({Input$SshMutationInput? sshInput});
}

class _CopyWithImpl$Variables$Mutation$RemoveSshKey<TRes>
    implements CopyWith$Variables$Mutation$RemoveSshKey<TRes> {
  _CopyWithImpl$Variables$Mutation$RemoveSshKey(
    this._instance,
    this._then,
  );

  final Variables$Mutation$RemoveSshKey _instance;

  final TRes Function(Variables$Mutation$RemoveSshKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? sshInput = _undefined}) =>
      _then(Variables$Mutation$RemoveSshKey._({
        ..._instance._$data,
        if (sshInput != _undefined && sshInput != null)
          'sshInput': (sshInput as Input$SshMutationInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$RemoveSshKey<TRes>
    implements CopyWith$Variables$Mutation$RemoveSshKey<TRes> {
  _CopyWithStubImpl$Variables$Mutation$RemoveSshKey(this._res);

  TRes _res;

  call({Input$SshMutationInput? sshInput}) => _res;
}

class Mutation$RemoveSshKey {
  Mutation$RemoveSshKey({
    required this.removeSshKey,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RemoveSshKey.fromJson(Map<String, dynamic> json) {
    final l$removeSshKey = json['removeSshKey'];
    final l$$__typename = json['__typename'];
    return Mutation$RemoveSshKey(
      removeSshKey: Mutation$RemoveSshKey$removeSshKey.fromJson(
          (l$removeSshKey as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  @Deprecated('Use `users.remove_ssh_key` instead')
  final Mutation$RemoveSshKey$removeSshKey removeSshKey;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$removeSshKey = removeSshKey;
    _resultData['removeSshKey'] = l$removeSshKey.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$removeSshKey = removeSshKey;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$removeSshKey,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RemoveSshKey) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$removeSshKey = removeSshKey;
    final lOther$removeSshKey = other.removeSshKey;
    if (l$removeSshKey != lOther$removeSshKey) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$RemoveSshKey on Mutation$RemoveSshKey {
  CopyWith$Mutation$RemoveSshKey<Mutation$RemoveSshKey> get copyWith =>
      CopyWith$Mutation$RemoveSshKey(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$RemoveSshKey<TRes> {
  factory CopyWith$Mutation$RemoveSshKey(
    Mutation$RemoveSshKey instance,
    TRes Function(Mutation$RemoveSshKey) then,
  ) = _CopyWithImpl$Mutation$RemoveSshKey;

  factory CopyWith$Mutation$RemoveSshKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RemoveSshKey;

  TRes call({
    Mutation$RemoveSshKey$removeSshKey? removeSshKey,
    String? $__typename,
  });
  CopyWith$Mutation$RemoveSshKey$removeSshKey<TRes> get removeSshKey;
}

class _CopyWithImpl$Mutation$RemoveSshKey<TRes>
    implements CopyWith$Mutation$RemoveSshKey<TRes> {
  _CopyWithImpl$Mutation$RemoveSshKey(
    this._instance,
    this._then,
  );

  final Mutation$RemoveSshKey _instance;

  final TRes Function(Mutation$RemoveSshKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? removeSshKey = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RemoveSshKey(
        removeSshKey: removeSshKey == _undefined || removeSshKey == null
            ? _instance.removeSshKey
            : (removeSshKey as Mutation$RemoveSshKey$removeSshKey),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

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

  call({
    Mutation$RemoveSshKey$removeSshKey? removeSshKey,
    String? $__typename,
  }) =>
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
          name: NameNode(value: 'SshMutationInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'removeSshKey'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'sshInput'),
            value: VariableNode(name: NameNode(value: 'sshInput')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'basicMutationReturnFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                name: NameNode(value: 'userFields'),
                directives: [],
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
  fragmentDefinitionuserFields,
]);
Mutation$RemoveSshKey _parserFn$Mutation$RemoveSshKey(
        Map<String, dynamic> data) =>
    Mutation$RemoveSshKey.fromJson(data);
typedef OnMutationCompleted$Mutation$RemoveSshKey = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$RemoveSshKey?,
);

class Options$Mutation$RemoveSshKey
    extends graphql.MutationOptions<Mutation$RemoveSshKey> {
  Options$Mutation$RemoveSshKey({
    String? operationName,
    required Variables$Mutation$RemoveSshKey variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RemoveSshKey? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$RemoveSshKey? onCompleted,
    graphql.OnMutationUpdate<Mutation$RemoveSshKey>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$RemoveSshKey(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationRemoveSshKey,
          parserFn: _parserFn$Mutation$RemoveSshKey,
        );

  final OnMutationCompleted$Mutation$RemoveSshKey? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$RemoveSshKey
    extends graphql.WatchQueryOptions<Mutation$RemoveSshKey> {
  WatchOptions$Mutation$RemoveSshKey({
    String? operationName,
    required Variables$Mutation$RemoveSshKey variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RemoveSshKey? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeMutationRemoveSshKey,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$RemoveSshKey,
        );
}

extension ClientExtension$Mutation$RemoveSshKey on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RemoveSshKey>> mutate$RemoveSshKey(
          Options$Mutation$RemoveSshKey options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$RemoveSshKey> watchMutation$RemoveSshKey(
          WatchOptions$Mutation$RemoveSshKey options) =>
      this.watchMutation(options);
}

class Mutation$RemoveSshKey$removeSshKey
    implements Fragment$basicMutationReturnFields$$UserMutationReturn {
  Mutation$RemoveSshKey$removeSshKey({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'UserMutationReturn',
    this.user,
  });

  factory Mutation$RemoveSshKey$removeSshKey.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$user = json['user'];
    return Mutation$RemoveSshKey$removeSshKey(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      user: l$user == null
          ? null
          : Fragment$userFields.fromJson((l$user as Map<String, dynamic>)),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final Fragment$userFields? user;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    final l$user = user;
    _resultData['user'] = l$user?.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$user = user;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$user,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RemoveSshKey$removeSshKey) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$RemoveSshKey$removeSshKey
    on Mutation$RemoveSshKey$removeSshKey {
  CopyWith$Mutation$RemoveSshKey$removeSshKey<
          Mutation$RemoveSshKey$removeSshKey>
      get copyWith => CopyWith$Mutation$RemoveSshKey$removeSshKey(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$RemoveSshKey$removeSshKey<TRes> {
  factory CopyWith$Mutation$RemoveSshKey$removeSshKey(
    Mutation$RemoveSshKey$removeSshKey instance,
    TRes Function(Mutation$RemoveSshKey$removeSshKey) then,
  ) = _CopyWithImpl$Mutation$RemoveSshKey$removeSshKey;

  factory CopyWith$Mutation$RemoveSshKey$removeSshKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RemoveSshKey$removeSshKey;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  });
  CopyWith$Fragment$userFields<TRes> get user;
}

class _CopyWithImpl$Mutation$RemoveSshKey$removeSshKey<TRes>
    implements CopyWith$Mutation$RemoveSshKey$removeSshKey<TRes> {
  _CopyWithImpl$Mutation$RemoveSshKey$removeSshKey(
    this._instance,
    this._then,
  );

  final Mutation$RemoveSshKey$removeSshKey _instance;

  final TRes Function(Mutation$RemoveSshKey$removeSshKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? user = _undefined,
  }) =>
      _then(Mutation$RemoveSshKey$removeSshKey(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
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
            : (user as Fragment$userFields?),
      ));

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

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  }) =>
      _res;

  CopyWith$Fragment$userFields<TRes> get user =>
      CopyWith$Fragment$userFields.stub(_res);
}
