import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:selfprivacy/utils/scalars.dart';
import 'schema.graphql.dart';
import 'server_api.graphql.dart';

class Fragment$userFields {
  Fragment$userFields({
    required this.username,
    required this.userType,
    this.sshKeys,
    this.directmemberof,
    this.displayName,
    this.memberof,
    this.email,
    this.emailPasswordMetadata,
    this.$__typename = 'User',
  });

  factory Fragment$userFields.fromJson(Map<String, dynamic> json) {
    final l$username = json['username'];
    final l$userType = json['userType'];
    final l$sshKeys = json['sshKeys'];
    final l$directmemberof = json['directmemberof'];
    final l$displayName = json['displayName'];
    final l$memberof = json['memberof'];
    final l$email = json['email'];
    final l$emailPasswordMetadata = json['emailPasswordMetadata'];
    final l$$__typename = json['__typename'];
    return Fragment$userFields(
      username: (l$username as String),
      userType: fromJson$Enum$UserType((l$userType as String)),
      sshKeys:
          (l$sshKeys as List<dynamic>?)?.map((e) => (e as String)).toList(),
      directmemberof:
          (l$directmemberof as List<dynamic>?)
              ?.map((e) => (e as String))
              .toList(),
      displayName: (l$displayName as String?),
      memberof:
          (l$memberof as List<dynamic>?)?.map((e) => (e as String)).toList(),
      email: (l$email as String?),
      emailPasswordMetadata:
          (l$emailPasswordMetadata as List<dynamic>?)
              ?.map(
                (e) => Fragment$userFields$emailPasswordMetadata.fromJson(
                  (e as Map<String, dynamic>),
                ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String username;

  final Enum$UserType userType;

  final List<String>? sshKeys;

  final List<String>? directmemberof;

  final String? displayName;

  final List<String>? memberof;

  final String? email;

  final List<Fragment$userFields$emailPasswordMetadata>? emailPasswordMetadata;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$username = username;
    _resultData['username'] = l$username;
    final l$userType = userType;
    _resultData['userType'] = toJson$Enum$UserType(l$userType);
    final l$sshKeys = sshKeys;
    _resultData['sshKeys'] = l$sshKeys?.map((e) => e).toList();
    final l$directmemberof = directmemberof;
    _resultData['directmemberof'] = l$directmemberof?.map((e) => e).toList();
    final l$displayName = displayName;
    _resultData['displayName'] = l$displayName;
    final l$memberof = memberof;
    _resultData['memberof'] = l$memberof?.map((e) => e).toList();
    final l$email = email;
    _resultData['email'] = l$email;
    final l$emailPasswordMetadata = emailPasswordMetadata;
    _resultData['emailPasswordMetadata'] =
        l$emailPasswordMetadata?.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$username = username;
    final l$userType = userType;
    final l$sshKeys = sshKeys;
    final l$directmemberof = directmemberof;
    final l$displayName = displayName;
    final l$memberof = memberof;
    final l$email = email;
    final l$emailPasswordMetadata = emailPasswordMetadata;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$username,
      l$userType,
      l$sshKeys == null ? null : Object.hashAll(l$sshKeys.map((v) => v)),
      l$directmemberof == null
          ? null
          : Object.hashAll(l$directmemberof.map((v) => v)),
      l$displayName,
      l$memberof == null ? null : Object.hashAll(l$memberof.map((v) => v)),
      l$email,
      l$emailPasswordMetadata == null
          ? null
          : Object.hashAll(l$emailPasswordMetadata.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$userFields || runtimeType != other.runtimeType) {
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
    if (l$sshKeys != null && lOther$sshKeys != null) {
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
    } else if (l$sshKeys != lOther$sshKeys) {
      return false;
    }
    final l$directmemberof = directmemberof;
    final lOther$directmemberof = other.directmemberof;
    if (l$directmemberof != null && lOther$directmemberof != null) {
      if (l$directmemberof.length != lOther$directmemberof.length) {
        return false;
      }
      for (int i = 0; i < l$directmemberof.length; i++) {
        final l$directmemberof$entry = l$directmemberof[i];
        final lOther$directmemberof$entry = lOther$directmemberof[i];
        if (l$directmemberof$entry != lOther$directmemberof$entry) {
          return false;
        }
      }
    } else if (l$directmemberof != lOther$directmemberof) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) {
      return false;
    }
    final l$memberof = memberof;
    final lOther$memberof = other.memberof;
    if (l$memberof != null && lOther$memberof != null) {
      if (l$memberof.length != lOther$memberof.length) {
        return false;
      }
      for (int i = 0; i < l$memberof.length; i++) {
        final l$memberof$entry = l$memberof[i];
        final lOther$memberof$entry = lOther$memberof[i];
        if (l$memberof$entry != lOther$memberof$entry) {
          return false;
        }
      }
    } else if (l$memberof != lOther$memberof) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$emailPasswordMetadata = emailPasswordMetadata;
    final lOther$emailPasswordMetadata = other.emailPasswordMetadata;
    if (l$emailPasswordMetadata != null &&
        lOther$emailPasswordMetadata != null) {
      if (l$emailPasswordMetadata.length !=
          lOther$emailPasswordMetadata.length) {
        return false;
      }
      for (int i = 0; i < l$emailPasswordMetadata.length; i++) {
        final l$emailPasswordMetadata$entry = l$emailPasswordMetadata[i];
        final lOther$emailPasswordMetadata$entry =
            lOther$emailPasswordMetadata[i];
        if (l$emailPasswordMetadata$entry !=
            lOther$emailPasswordMetadata$entry) {
          return false;
        }
      }
    } else if (l$emailPasswordMetadata != lOther$emailPasswordMetadata) {
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

extension UtilityExtension$Fragment$userFields on Fragment$userFields {
  CopyWith$Fragment$userFields<Fragment$userFields> get copyWith =>
      CopyWith$Fragment$userFields(this, (i) => i);
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
    List<String>? directmemberof,
    String? displayName,
    List<String>? memberof,
    String? email,
    List<Fragment$userFields$emailPasswordMetadata>? emailPasswordMetadata,
    String? $__typename,
  });
  TRes emailPasswordMetadata(
    Iterable<Fragment$userFields$emailPasswordMetadata>? Function(
      Iterable<
        CopyWith$Fragment$userFields$emailPasswordMetadata<
          Fragment$userFields$emailPasswordMetadata
        >
      >?,
    )
    _fn,
  );
}

class _CopyWithImpl$Fragment$userFields<TRes>
    implements CopyWith$Fragment$userFields<TRes> {
  _CopyWithImpl$Fragment$userFields(this._instance, this._then);

  final Fragment$userFields _instance;

  final TRes Function(Fragment$userFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? username = _undefined,
    Object? userType = _undefined,
    Object? sshKeys = _undefined,
    Object? directmemberof = _undefined,
    Object? displayName = _undefined,
    Object? memberof = _undefined,
    Object? email = _undefined,
    Object? emailPasswordMetadata = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$userFields(
      username:
          username == _undefined || username == null
              ? _instance.username
              : (username as String),
      userType:
          userType == _undefined || userType == null
              ? _instance.userType
              : (userType as Enum$UserType),
      sshKeys:
          sshKeys == _undefined
              ? _instance.sshKeys
              : (sshKeys as List<String>?),
      directmemberof:
          directmemberof == _undefined
              ? _instance.directmemberof
              : (directmemberof as List<String>?),
      displayName:
          displayName == _undefined
              ? _instance.displayName
              : (displayName as String?),
      memberof:
          memberof == _undefined
              ? _instance.memberof
              : (memberof as List<String>?),
      email: email == _undefined ? _instance.email : (email as String?),
      emailPasswordMetadata:
          emailPasswordMetadata == _undefined
              ? _instance.emailPasswordMetadata
              : (emailPasswordMetadata
                  as List<Fragment$userFields$emailPasswordMetadata>?),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes emailPasswordMetadata(
    Iterable<Fragment$userFields$emailPasswordMetadata>? Function(
      Iterable<
        CopyWith$Fragment$userFields$emailPasswordMetadata<
          Fragment$userFields$emailPasswordMetadata
        >
      >?,
    )
    _fn,
  ) => call(
    emailPasswordMetadata:
        _fn(
          _instance.emailPasswordMetadata?.map(
            (e) =>
                CopyWith$Fragment$userFields$emailPasswordMetadata(e, (i) => i),
          ),
        )?.toList(),
  );
}

class _CopyWithStubImpl$Fragment$userFields<TRes>
    implements CopyWith$Fragment$userFields<TRes> {
  _CopyWithStubImpl$Fragment$userFields(this._res);

  TRes _res;

  call({
    String? username,
    Enum$UserType? userType,
    List<String>? sshKeys,
    List<String>? directmemberof,
    String? displayName,
    List<String>? memberof,
    String? email,
    List<Fragment$userFields$emailPasswordMetadata>? emailPasswordMetadata,
    String? $__typename,
  }) => _res;

  emailPasswordMetadata(_fn) => _res;
}

const fragmentDefinitionuserFields = FragmentDefinitionNode(
  name: NameNode(value: 'userFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
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
        name: NameNode(value: 'directmemberof'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'displayName'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'memberof'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'email'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'emailPasswordMetadata'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FieldNode(
              name: NameNode(value: 'createdAt'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'displayName'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'expiresAt'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'lastUsed'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'uuid'),
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
          ],
        ),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentuserFields = DocumentNode(
  definitions: [fragmentDefinitionuserFields],
);

extension ClientExtension$Fragment$userFields on graphql.GraphQLClient {
  void writeFragment$userFields({
    required Fragment$userFields data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
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

class Fragment$userFields$emailPasswordMetadata {
  Fragment$userFields$emailPasswordMetadata({
    this.createdAt,
    required this.displayName,
    this.expiresAt,
    this.lastUsed,
    required this.uuid,
    this.$__typename = 'EmailPasswordMetadata',
  });

  factory Fragment$userFields$emailPasswordMetadata.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$createdAt = json['createdAt'];
    final l$displayName = json['displayName'];
    final l$expiresAt = json['expiresAt'];
    final l$lastUsed = json['lastUsed'];
    final l$uuid = json['uuid'];
    final l$$__typename = json['__typename'];
    return Fragment$userFields$emailPasswordMetadata(
      createdAt: l$createdAt == null ? null : dateTimeFromJson(l$createdAt),
      displayName: (l$displayName as String),
      expiresAt: l$expiresAt == null ? null : dateTimeFromJson(l$expiresAt),
      lastUsed: l$lastUsed == null ? null : dateTimeFromJson(l$lastUsed),
      uuid: (l$uuid as String),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime? createdAt;

  final String displayName;

  final DateTime? expiresAt;

  final DateTime? lastUsed;

  final String uuid;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createdAt = createdAt;
    _resultData['createdAt'] =
        l$createdAt == null ? null : dateTimeToJson(l$createdAt);
    final l$displayName = displayName;
    _resultData['displayName'] = l$displayName;
    final l$expiresAt = expiresAt;
    _resultData['expiresAt'] =
        l$expiresAt == null ? null : dateTimeToJson(l$expiresAt);
    final l$lastUsed = lastUsed;
    _resultData['lastUsed'] =
        l$lastUsed == null ? null : dateTimeToJson(l$lastUsed);
    final l$uuid = uuid;
    _resultData['uuid'] = l$uuid;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createdAt = createdAt;
    final l$displayName = displayName;
    final l$expiresAt = expiresAt;
    final l$lastUsed = lastUsed;
    final l$uuid = uuid;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createdAt,
      l$displayName,
      l$expiresAt,
      l$lastUsed,
      l$uuid,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$userFields$emailPasswordMetadata ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) {
      return false;
    }
    final l$expiresAt = expiresAt;
    final lOther$expiresAt = other.expiresAt;
    if (l$expiresAt != lOther$expiresAt) {
      return false;
    }
    final l$lastUsed = lastUsed;
    final lOther$lastUsed = other.lastUsed;
    if (l$lastUsed != lOther$lastUsed) {
      return false;
    }
    final l$uuid = uuid;
    final lOther$uuid = other.uuid;
    if (l$uuid != lOther$uuid) {
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

extension UtilityExtension$Fragment$userFields$emailPasswordMetadata
    on Fragment$userFields$emailPasswordMetadata {
  CopyWith$Fragment$userFields$emailPasswordMetadata<
    Fragment$userFields$emailPasswordMetadata
  >
  get copyWith =>
      CopyWith$Fragment$userFields$emailPasswordMetadata(this, (i) => i);
}

abstract class CopyWith$Fragment$userFields$emailPasswordMetadata<TRes> {
  factory CopyWith$Fragment$userFields$emailPasswordMetadata(
    Fragment$userFields$emailPasswordMetadata instance,
    TRes Function(Fragment$userFields$emailPasswordMetadata) then,
  ) = _CopyWithImpl$Fragment$userFields$emailPasswordMetadata;

  factory CopyWith$Fragment$userFields$emailPasswordMetadata.stub(TRes res) =
      _CopyWithStubImpl$Fragment$userFields$emailPasswordMetadata;

  TRes call({
    DateTime? createdAt,
    String? displayName,
    DateTime? expiresAt,
    DateTime? lastUsed,
    String? uuid,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$userFields$emailPasswordMetadata<TRes>
    implements CopyWith$Fragment$userFields$emailPasswordMetadata<TRes> {
  _CopyWithImpl$Fragment$userFields$emailPasswordMetadata(
    this._instance,
    this._then,
  );

  final Fragment$userFields$emailPasswordMetadata _instance;

  final TRes Function(Fragment$userFields$emailPasswordMetadata) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createdAt = _undefined,
    Object? displayName = _undefined,
    Object? expiresAt = _undefined,
    Object? lastUsed = _undefined,
    Object? uuid = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$userFields$emailPasswordMetadata(
      createdAt:
          createdAt == _undefined
              ? _instance.createdAt
              : (createdAt as DateTime?),
      displayName:
          displayName == _undefined || displayName == null
              ? _instance.displayName
              : (displayName as String),
      expiresAt:
          expiresAt == _undefined
              ? _instance.expiresAt
              : (expiresAt as DateTime?),
      lastUsed:
          lastUsed == _undefined ? _instance.lastUsed : (lastUsed as DateTime?),
      uuid:
          uuid == _undefined || uuid == null
              ? _instance.uuid
              : (uuid as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$userFields$emailPasswordMetadata<TRes>
    implements CopyWith$Fragment$userFields$emailPasswordMetadata<TRes> {
  _CopyWithStubImpl$Fragment$userFields$emailPasswordMetadata(this._res);

  TRes _res;

  call({
    DateTime? createdAt,
    String? displayName,
    DateTime? expiresAt,
    DateTime? lastUsed,
    String? uuid,
    String? $__typename,
  }) => _res;
}

class Query$AllUsers {
  Query$AllUsers({required this.users, this.$__typename = 'Query'});

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
    return Object.hashAll([l$users, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$AllUsers || runtimeType != other.runtimeType) {
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
      CopyWith$Query$AllUsers(this, (i) => i);
}

abstract class CopyWith$Query$AllUsers<TRes> {
  factory CopyWith$Query$AllUsers(
    Query$AllUsers instance,
    TRes Function(Query$AllUsers) then,
  ) = _CopyWithImpl$Query$AllUsers;

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

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? users = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$AllUsers(
          users:
              users == _undefined || users == null
                  ? _instance.users
                  : (users as Query$AllUsers$users),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

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

const documentNodeQueryAllUsers = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'AllUsers'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'users'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'allUsers'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
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
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: 'getUser'),
                  alias: NameNode(value: 'rootUser'),
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'username'),
                      value: StringValueNode(value: 'root', isBlock: false),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
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
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionuserFields,
  ],
);
Query$AllUsers _parserFn$Query$AllUsers(Map<String, dynamic> data) =>
    Query$AllUsers.fromJson(data);
typedef OnQueryComplete$Query$AllUsers =
    FutureOr<void> Function(Map<String, dynamic>?, Query$AllUsers?);

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
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete:
             onComplete == null
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
    : super(updateQuery: updateQuery, document: documentNodeQueryAllUsers);
}

extension ClientExtension$Query$AllUsers on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$AllUsers>> query$AllUsers([
    Options$Query$AllUsers? options,
  ]) async => await this.query(options ?? Options$Query$AllUsers());
  graphql.ObservableQuery<Query$AllUsers> watchQuery$AllUsers([
    WatchOptions$Query$AllUsers? options,
  ]) => this.watchQuery(options ?? WatchOptions$Query$AllUsers());
  void writeQuery$AllUsers({
    required Query$AllUsers data,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryAllUsers),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Query$AllUsers? readQuery$AllUsers({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryAllUsers),
      ),
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
      allUsers:
          (l$allUsers as List<dynamic>)
              .map(
                (e) =>
                    Fragment$userFields.fromJson((e as Map<String, dynamic>)),
              )
              .toList(),
      rootUser:
          l$rootUser == null
              ? null
              : Fragment$userFields.fromJson(
                (l$rootUser as Map<String, dynamic>),
              ),
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
    if (other is! Query$AllUsers$users || runtimeType != other.runtimeType) {
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
      CopyWith$Query$AllUsers$users(this, (i) => i);
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
      Iterable<CopyWith$Fragment$userFields<Fragment$userFields>>,
    )
    _fn,
  );
  CopyWith$Fragment$userFields<TRes> get rootUser;
}

class _CopyWithImpl$Query$AllUsers$users<TRes>
    implements CopyWith$Query$AllUsers$users<TRes> {
  _CopyWithImpl$Query$AllUsers$users(this._instance, this._then);

  final Query$AllUsers$users _instance;

  final TRes Function(Query$AllUsers$users) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? allUsers = _undefined,
    Object? rootUser = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$AllUsers$users(
      allUsers:
          allUsers == _undefined || allUsers == null
              ? _instance.allUsers
              : (allUsers as List<Fragment$userFields>),
      rootUser:
          rootUser == _undefined
              ? _instance.rootUser
              : (rootUser as Fragment$userFields?),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes allUsers(
    Iterable<Fragment$userFields> Function(
      Iterable<CopyWith$Fragment$userFields<Fragment$userFields>>,
    )
    _fn,
  ) => call(
    allUsers:
        _fn(
          _instance.allUsers.map(
            (e) => CopyWith$Fragment$userFields(e, (i) => i),
          ),
        ).toList(),
  );

  CopyWith$Fragment$userFields<TRes> get rootUser {
    final local$rootUser = _instance.rootUser;
    return local$rootUser == null
        ? CopyWith$Fragment$userFields.stub(_then(_instance))
        : CopyWith$Fragment$userFields(
          local$rootUser,
          (e) => call(rootUser: e),
        );
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
  }) => _res;

  allUsers(_fn) => _res;

  CopyWith$Fragment$userFields<TRes> get rootUser =>
      CopyWith$Fragment$userFields.stub(_res);
}

class Query$AllGroups {
  Query$AllGroups({required this.groups, this.$__typename = 'Query'});

  factory Query$AllGroups.fromJson(Map<String, dynamic> json) {
    final l$groups = json['groups'];
    final l$$__typename = json['__typename'];
    return Query$AllGroups(
      groups: Query$AllGroups$groups.fromJson(
        (l$groups as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$AllGroups$groups groups;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$groups = groups;
    _resultData['groups'] = l$groups.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$groups = groups;
    final l$$__typename = $__typename;
    return Object.hashAll([l$groups, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$AllGroups || runtimeType != other.runtimeType) {
      return false;
    }
    final l$groups = groups;
    final lOther$groups = other.groups;
    if (l$groups != lOther$groups) {
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

extension UtilityExtension$Query$AllGroups on Query$AllGroups {
  CopyWith$Query$AllGroups<Query$AllGroups> get copyWith =>
      CopyWith$Query$AllGroups(this, (i) => i);
}

abstract class CopyWith$Query$AllGroups<TRes> {
  factory CopyWith$Query$AllGroups(
    Query$AllGroups instance,
    TRes Function(Query$AllGroups) then,
  ) = _CopyWithImpl$Query$AllGroups;

  factory CopyWith$Query$AllGroups.stub(TRes res) =
      _CopyWithStubImpl$Query$AllGroups;

  TRes call({Query$AllGroups$groups? groups, String? $__typename});
  CopyWith$Query$AllGroups$groups<TRes> get groups;
}

class _CopyWithImpl$Query$AllGroups<TRes>
    implements CopyWith$Query$AllGroups<TRes> {
  _CopyWithImpl$Query$AllGroups(this._instance, this._then);

  final Query$AllGroups _instance;

  final TRes Function(Query$AllGroups) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? groups = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$AllGroups(
          groups:
              groups == _undefined || groups == null
                  ? _instance.groups
                  : (groups as Query$AllGroups$groups),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Query$AllGroups$groups<TRes> get groups {
    final local$groups = _instance.groups;
    return CopyWith$Query$AllGroups$groups(
      local$groups,
      (e) => call(groups: e),
    );
  }
}

class _CopyWithStubImpl$Query$AllGroups<TRes>
    implements CopyWith$Query$AllGroups<TRes> {
  _CopyWithStubImpl$Query$AllGroups(this._res);

  TRes _res;

  call({Query$AllGroups$groups? groups, String? $__typename}) => _res;

  CopyWith$Query$AllGroups$groups<TRes> get groups =>
      CopyWith$Query$AllGroups$groups.stub(_res);
}

const documentNodeQueryAllGroups = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'AllGroups'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'groups'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'allGroups'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'name'),
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
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
  ],
);
Query$AllGroups _parserFn$Query$AllGroups(Map<String, dynamic> data) =>
    Query$AllGroups.fromJson(data);
typedef OnQueryComplete$Query$AllGroups =
    FutureOr<void> Function(Map<String, dynamic>?, Query$AllGroups?);

class Options$Query$AllGroups extends graphql.QueryOptions<Query$AllGroups> {
  Options$Query$AllGroups({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$AllGroups? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$AllGroups? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete:
             onComplete == null
                 ? null
                 : (data) => onComplete(
                   data,
                   data == null ? null : _parserFn$Query$AllGroups(data),
                 ),
         onError: onError,
         document: documentNodeQueryAllGroups,
         parserFn: _parserFn$Query$AllGroups,
       );

  final OnQueryComplete$Query$AllGroups? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$AllGroups
    extends graphql.WatchQueryOptions<Query$AllGroups> {
  WatchOptions$Query$AllGroups({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$AllGroups? typedOptimisticResult,
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
         document: documentNodeQueryAllGroups,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$AllGroups,
       );
}

class FetchMoreOptions$Query$AllGroups extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$AllGroups({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryAllGroups);
}

extension ClientExtension$Query$AllGroups on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$AllGroups>> query$AllGroups([
    Options$Query$AllGroups? options,
  ]) async => await this.query(options ?? Options$Query$AllGroups());
  graphql.ObservableQuery<Query$AllGroups> watchQuery$AllGroups([
    WatchOptions$Query$AllGroups? options,
  ]) => this.watchQuery(options ?? WatchOptions$Query$AllGroups());
  void writeQuery$AllGroups({
    required Query$AllGroups data,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryAllGroups),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Query$AllGroups? readQuery$AllGroups({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryAllGroups),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$AllGroups.fromJson(result);
  }
}

class Query$AllGroups$groups {
  Query$AllGroups$groups({
    required this.allGroups,
    this.$__typename = 'Groups',
  });

  factory Query$AllGroups$groups.fromJson(Map<String, dynamic> json) {
    final l$allGroups = json['allGroups'];
    final l$$__typename = json['__typename'];
    return Query$AllGroups$groups(
      allGroups:
          (l$allGroups as List<dynamic>)
              .map(
                (e) => Query$AllGroups$groups$allGroups.fromJson(
                  (e as Map<String, dynamic>),
                ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$AllGroups$groups$allGroups> allGroups;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$allGroups = allGroups;
    _resultData['allGroups'] = l$allGroups.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$allGroups = allGroups;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$allGroups.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$AllGroups$groups || runtimeType != other.runtimeType) {
      return false;
    }
    final l$allGroups = allGroups;
    final lOther$allGroups = other.allGroups;
    if (l$allGroups.length != lOther$allGroups.length) {
      return false;
    }
    for (int i = 0; i < l$allGroups.length; i++) {
      final l$allGroups$entry = l$allGroups[i];
      final lOther$allGroups$entry = lOther$allGroups[i];
      if (l$allGroups$entry != lOther$allGroups$entry) {
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

extension UtilityExtension$Query$AllGroups$groups on Query$AllGroups$groups {
  CopyWith$Query$AllGroups$groups<Query$AllGroups$groups> get copyWith =>
      CopyWith$Query$AllGroups$groups(this, (i) => i);
}

abstract class CopyWith$Query$AllGroups$groups<TRes> {
  factory CopyWith$Query$AllGroups$groups(
    Query$AllGroups$groups instance,
    TRes Function(Query$AllGroups$groups) then,
  ) = _CopyWithImpl$Query$AllGroups$groups;

  factory CopyWith$Query$AllGroups$groups.stub(TRes res) =
      _CopyWithStubImpl$Query$AllGroups$groups;

  TRes call({
    List<Query$AllGroups$groups$allGroups>? allGroups,
    String? $__typename,
  });
  TRes allGroups(
    Iterable<Query$AllGroups$groups$allGroups> Function(
      Iterable<
        CopyWith$Query$AllGroups$groups$allGroups<
          Query$AllGroups$groups$allGroups
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$AllGroups$groups<TRes>
    implements CopyWith$Query$AllGroups$groups<TRes> {
  _CopyWithImpl$Query$AllGroups$groups(this._instance, this._then);

  final Query$AllGroups$groups _instance;

  final TRes Function(Query$AllGroups$groups) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? allGroups = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$AllGroups$groups(
      allGroups:
          allGroups == _undefined || allGroups == null
              ? _instance.allGroups
              : (allGroups as List<Query$AllGroups$groups$allGroups>),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes allGroups(
    Iterable<Query$AllGroups$groups$allGroups> Function(
      Iterable<
        CopyWith$Query$AllGroups$groups$allGroups<
          Query$AllGroups$groups$allGroups
        >
      >,
    )
    _fn,
  ) => call(
    allGroups:
        _fn(
          _instance.allGroups.map(
            (e) => CopyWith$Query$AllGroups$groups$allGroups(e, (i) => i),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$AllGroups$groups<TRes>
    implements CopyWith$Query$AllGroups$groups<TRes> {
  _CopyWithStubImpl$Query$AllGroups$groups(this._res);

  TRes _res;

  call({
    List<Query$AllGroups$groups$allGroups>? allGroups,
    String? $__typename,
  }) => _res;

  allGroups(_fn) => _res;
}

class Query$AllGroups$groups$allGroups {
  Query$AllGroups$groups$allGroups({
    required this.name,
    this.$__typename = 'Group',
  });

  factory Query$AllGroups$groups$allGroups.fromJson(Map<String, dynamic> json) {
    final l$name = json['name'];
    final l$$__typename = json['__typename'];
    return Query$AllGroups$groups$allGroups(
      name: (l$name as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String name;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$name = name;
    _resultData['name'] = l$name;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$$__typename = $__typename;
    return Object.hashAll([l$name, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$AllGroups$groups$allGroups ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
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

extension UtilityExtension$Query$AllGroups$groups$allGroups
    on Query$AllGroups$groups$allGroups {
  CopyWith$Query$AllGroups$groups$allGroups<Query$AllGroups$groups$allGroups>
  get copyWith => CopyWith$Query$AllGroups$groups$allGroups(this, (i) => i);
}

abstract class CopyWith$Query$AllGroups$groups$allGroups<TRes> {
  factory CopyWith$Query$AllGroups$groups$allGroups(
    Query$AllGroups$groups$allGroups instance,
    TRes Function(Query$AllGroups$groups$allGroups) then,
  ) = _CopyWithImpl$Query$AllGroups$groups$allGroups;

  factory CopyWith$Query$AllGroups$groups$allGroups.stub(TRes res) =
      _CopyWithStubImpl$Query$AllGroups$groups$allGroups;

  TRes call({String? name, String? $__typename});
}

class _CopyWithImpl$Query$AllGroups$groups$allGroups<TRes>
    implements CopyWith$Query$AllGroups$groups$allGroups<TRes> {
  _CopyWithImpl$Query$AllGroups$groups$allGroups(this._instance, this._then);

  final Query$AllGroups$groups$allGroups _instance;

  final TRes Function(Query$AllGroups$groups$allGroups) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? name = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$AllGroups$groups$allGroups(
          name:
              name == _undefined || name == null
                  ? _instance.name
                  : (name as String),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );
}

class _CopyWithStubImpl$Query$AllGroups$groups$allGroups<TRes>
    implements CopyWith$Query$AllGroups$groups$allGroups<TRes> {
  _CopyWithStubImpl$Query$AllGroups$groups$allGroups(this._res);

  TRes _res;

  call({String? name, String? $__typename}) => _res;
}

class Variables$Query$GetUser {
  factory Variables$Query$GetUser({required String username}) =>
      Variables$Query$GetUser._({r'username': username});

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
      CopyWith$Variables$Query$GetUser(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$GetUser || runtimeType != other.runtimeType) {
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
  _CopyWithImpl$Variables$Query$GetUser(this._instance, this._then);

  final Variables$Query$GetUser _instance;

  final TRes Function(Variables$Query$GetUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? username = _undefined}) => _then(
    Variables$Query$GetUser._({
      ..._instance._$data,
      if (username != _undefined && username != null)
        'username': (username as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$GetUser<TRes>
    implements CopyWith$Variables$Query$GetUser<TRes> {
  _CopyWithStubImpl$Variables$Query$GetUser(this._res);

  TRes _res;

  call({String? username}) => _res;
}

class Query$GetUser {
  Query$GetUser({required this.users, this.$__typename = 'Query'});

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
    return Object.hashAll([l$users, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetUser || runtimeType != other.runtimeType) {
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
  CopyWith$Query$GetUser<Query$GetUser> get copyWith =>
      CopyWith$Query$GetUser(this, (i) => i);
}

abstract class CopyWith$Query$GetUser<TRes> {
  factory CopyWith$Query$GetUser(
    Query$GetUser instance,
    TRes Function(Query$GetUser) then,
  ) = _CopyWithImpl$Query$GetUser;

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

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? users = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$GetUser(
          users:
              users == _undefined || users == null
                  ? _instance.users
                  : (users as Query$GetUser$users),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

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

const documentNodeQueryGetUser = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetUser'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'username')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'users'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'getUser'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'username'),
                      value: VariableNode(name: NameNode(value: 'username')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
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
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionuserFields,
  ],
);
Query$GetUser _parserFn$Query$GetUser(Map<String, dynamic> data) =>
    Query$GetUser.fromJson(data);
typedef OnQueryComplete$Query$GetUser =
    FutureOr<void> Function(Map<String, dynamic>?, Query$GetUser?);

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
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete:
             onComplete == null
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
    Options$Query$GetUser options,
  ) async => await this.query(options);
  graphql.ObservableQuery<Query$GetUser> watchQuery$GetUser(
    WatchOptions$Query$GetUser options,
  ) => this.watchQuery(options);
  void writeQuery$GetUser({
    required Query$GetUser data,
    required Variables$Query$GetUser variables,
    bool broadcast = true,
  }) => this.writeQuery(
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
  Query$GetUser$users({this.getUser, this.$__typename = 'Users'});

  factory Query$GetUser$users.fromJson(Map<String, dynamic> json) {
    final l$getUser = json['getUser'];
    final l$$__typename = json['__typename'];
    return Query$GetUser$users(
      getUser:
          l$getUser == null
              ? null
              : Fragment$userFields.fromJson(
                (l$getUser as Map<String, dynamic>),
              ),
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
    return Object.hashAll([l$getUser, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetUser$users || runtimeType != other.runtimeType) {
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
      CopyWith$Query$GetUser$users(this, (i) => i);
}

abstract class CopyWith$Query$GetUser$users<TRes> {
  factory CopyWith$Query$GetUser$users(
    Query$GetUser$users instance,
    TRes Function(Query$GetUser$users) then,
  ) = _CopyWithImpl$Query$GetUser$users;

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

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? getUser = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$GetUser$users(
          getUser:
              getUser == _undefined
                  ? _instance.getUser
                  : (getUser as Fragment$userFields?),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

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

class Variables$Mutation$CreateUser {
  factory Variables$Mutation$CreateUser({
    required Input$UserMutationInput user,
  }) => Variables$Mutation$CreateUser._({r'user': user});

  Variables$Mutation$CreateUser._(this._$data);

  factory Variables$Mutation$CreateUser.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$user = data['user'];
    result$data['user'] = Input$UserMutationInput.fromJson(
      (l$user as Map<String, dynamic>),
    );
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
  get copyWith => CopyWith$Variables$Mutation$CreateUser(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$CreateUser ||
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
  _CopyWithImpl$Variables$Mutation$CreateUser(this._instance, this._then);

  final Variables$Mutation$CreateUser _instance;

  final TRes Function(Variables$Mutation$CreateUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? user = _undefined}) => _then(
    Variables$Mutation$CreateUser._({
      ..._instance._$data,
      if (user != _undefined && user != null)
        'user': (user as Input$UserMutationInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$CreateUser<TRes>
    implements CopyWith$Variables$Mutation$CreateUser<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateUser(this._res);

  TRes _res;

  call({Input$UserMutationInput? user}) => _res;
}

class Mutation$CreateUser {
  Mutation$CreateUser({required this.users, this.$__typename = 'Mutation'});

  factory Mutation$CreateUser.fromJson(Map<String, dynamic> json) {
    final l$users = json['users'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateUser(
      users: Mutation$CreateUser$users.fromJson(
        (l$users as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$CreateUser$users users;

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
    return Object.hashAll([l$users, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$CreateUser || runtimeType != other.runtimeType) {
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

extension UtilityExtension$Mutation$CreateUser on Mutation$CreateUser {
  CopyWith$Mutation$CreateUser<Mutation$CreateUser> get copyWith =>
      CopyWith$Mutation$CreateUser(this, (i) => i);
}

abstract class CopyWith$Mutation$CreateUser<TRes> {
  factory CopyWith$Mutation$CreateUser(
    Mutation$CreateUser instance,
    TRes Function(Mutation$CreateUser) then,
  ) = _CopyWithImpl$Mutation$CreateUser;

  factory CopyWith$Mutation$CreateUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateUser;

  TRes call({Mutation$CreateUser$users? users, String? $__typename});
  CopyWith$Mutation$CreateUser$users<TRes> get users;
}

class _CopyWithImpl$Mutation$CreateUser<TRes>
    implements CopyWith$Mutation$CreateUser<TRes> {
  _CopyWithImpl$Mutation$CreateUser(this._instance, this._then);

  final Mutation$CreateUser _instance;

  final TRes Function(Mutation$CreateUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? users = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$CreateUser(
          users:
              users == _undefined || users == null
                  ? _instance.users
                  : (users as Mutation$CreateUser$users),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$CreateUser$users<TRes> get users {
    final local$users = _instance.users;
    return CopyWith$Mutation$CreateUser$users(
      local$users,
      (e) => call(users: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$CreateUser<TRes>
    implements CopyWith$Mutation$CreateUser<TRes> {
  _CopyWithStubImpl$Mutation$CreateUser(this._res);

  TRes _res;

  call({Mutation$CreateUser$users? users, String? $__typename}) => _res;

  CopyWith$Mutation$CreateUser$users<TRes> get users =>
      CopyWith$Mutation$CreateUser$users.stub(_res);
}

const documentNodeMutationCreateUser = DocumentNode(
  definitions: [
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
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'users'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'createUser'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'user'),
                      value: VariableNode(name: NameNode(value: 'user')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
                        directives: [],
                      ),
                      FieldNode(
                        name: NameNode(value: 'user'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
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
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionbasicMutationReturnFields,
    fragmentDefinitionuserFields,
  ],
);
Mutation$CreateUser _parserFn$Mutation$CreateUser(Map<String, dynamic> data) =>
    Mutation$CreateUser.fromJson(data);
typedef OnMutationCompleted$Mutation$CreateUser =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$CreateUser?);

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
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
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
    Options$Mutation$CreateUser options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$CreateUser> watchMutation$CreateUser(
    WatchOptions$Mutation$CreateUser options,
  ) => this.watchMutation(options);
}

class Mutation$CreateUser$users {
  Mutation$CreateUser$users({
    required this.createUser,
    this.$__typename = 'UsersMutations',
  });

  factory Mutation$CreateUser$users.fromJson(Map<String, dynamic> json) {
    final l$createUser = json['createUser'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateUser$users(
      createUser: Mutation$CreateUser$users$createUser.fromJson(
        (l$createUser as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$CreateUser$users$createUser createUser;

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
    return Object.hashAll([l$createUser, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$CreateUser$users ||
        runtimeType != other.runtimeType) {
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

extension UtilityExtension$Mutation$CreateUser$users
    on Mutation$CreateUser$users {
  CopyWith$Mutation$CreateUser$users<Mutation$CreateUser$users> get copyWith =>
      CopyWith$Mutation$CreateUser$users(this, (i) => i);
}

abstract class CopyWith$Mutation$CreateUser$users<TRes> {
  factory CopyWith$Mutation$CreateUser$users(
    Mutation$CreateUser$users instance,
    TRes Function(Mutation$CreateUser$users) then,
  ) = _CopyWithImpl$Mutation$CreateUser$users;

  factory CopyWith$Mutation$CreateUser$users.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateUser$users;

  TRes call({
    Mutation$CreateUser$users$createUser? createUser,
    String? $__typename,
  });
  CopyWith$Mutation$CreateUser$users$createUser<TRes> get createUser;
}

class _CopyWithImpl$Mutation$CreateUser$users<TRes>
    implements CopyWith$Mutation$CreateUser$users<TRes> {
  _CopyWithImpl$Mutation$CreateUser$users(this._instance, this._then);

  final Mutation$CreateUser$users _instance;

  final TRes Function(Mutation$CreateUser$users) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createUser = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$CreateUser$users(
      createUser:
          createUser == _undefined || createUser == null
              ? _instance.createUser
              : (createUser as Mutation$CreateUser$users$createUser),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$CreateUser$users$createUser<TRes> get createUser {
    final local$createUser = _instance.createUser;
    return CopyWith$Mutation$CreateUser$users$createUser(
      local$createUser,
      (e) => call(createUser: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$CreateUser$users<TRes>
    implements CopyWith$Mutation$CreateUser$users<TRes> {
  _CopyWithStubImpl$Mutation$CreateUser$users(this._res);

  TRes _res;

  call({
    Mutation$CreateUser$users$createUser? createUser,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$CreateUser$users$createUser<TRes> get createUser =>
      CopyWith$Mutation$CreateUser$users$createUser.stub(_res);
}

class Mutation$CreateUser$users$createUser
    implements Fragment$basicMutationReturnFields$$UserMutationReturn {
  Mutation$CreateUser$users$createUser({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'UserMutationReturn',
    this.user,
  });

  factory Mutation$CreateUser$users$createUser.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$user = json['user'];
    return Mutation$CreateUser$users$createUser(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      user:
          l$user == null
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
    if (other is! Mutation$CreateUser$users$createUser ||
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

extension UtilityExtension$Mutation$CreateUser$users$createUser
    on Mutation$CreateUser$users$createUser {
  CopyWith$Mutation$CreateUser$users$createUser<
    Mutation$CreateUser$users$createUser
  >
  get copyWith => CopyWith$Mutation$CreateUser$users$createUser(this, (i) => i);
}

abstract class CopyWith$Mutation$CreateUser$users$createUser<TRes> {
  factory CopyWith$Mutation$CreateUser$users$createUser(
    Mutation$CreateUser$users$createUser instance,
    TRes Function(Mutation$CreateUser$users$createUser) then,
  ) = _CopyWithImpl$Mutation$CreateUser$users$createUser;

  factory CopyWith$Mutation$CreateUser$users$createUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateUser$users$createUser;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  });
  CopyWith$Fragment$userFields<TRes> get user;
}

class _CopyWithImpl$Mutation$CreateUser$users$createUser<TRes>
    implements CopyWith$Mutation$CreateUser$users$createUser<TRes> {
  _CopyWithImpl$Mutation$CreateUser$users$createUser(
    this._instance,
    this._then,
  );

  final Mutation$CreateUser$users$createUser _instance;

  final TRes Function(Mutation$CreateUser$users$createUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? user = _undefined,
  }) => _then(
    Mutation$CreateUser$users$createUser(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
      user:
          user == _undefined ? _instance.user : (user as Fragment$userFields?),
    ),
  );

  CopyWith$Fragment$userFields<TRes> get user {
    final local$user = _instance.user;
    return local$user == null
        ? CopyWith$Fragment$userFields.stub(_then(_instance))
        : CopyWith$Fragment$userFields(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateUser$users$createUser<TRes>
    implements CopyWith$Mutation$CreateUser$users$createUser<TRes> {
  _CopyWithStubImpl$Mutation$CreateUser$users$createUser(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  }) => _res;

  CopyWith$Fragment$userFields<TRes> get user =>
      CopyWith$Fragment$userFields.stub(_res);
}

class Variables$Mutation$DeleteUser {
  factory Variables$Mutation$DeleteUser({required String username}) =>
      Variables$Mutation$DeleteUser._({r'username': username});

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
  get copyWith => CopyWith$Variables$Mutation$DeleteUser(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$DeleteUser ||
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
  _CopyWithImpl$Variables$Mutation$DeleteUser(this._instance, this._then);

  final Variables$Mutation$DeleteUser _instance;

  final TRes Function(Variables$Mutation$DeleteUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? username = _undefined}) => _then(
    Variables$Mutation$DeleteUser._({
      ..._instance._$data,
      if (username != _undefined && username != null)
        'username': (username as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$DeleteUser<TRes>
    implements CopyWith$Variables$Mutation$DeleteUser<TRes> {
  _CopyWithStubImpl$Variables$Mutation$DeleteUser(this._res);

  TRes _res;

  call({String? username}) => _res;
}

class Mutation$DeleteUser {
  Mutation$DeleteUser({required this.users, this.$__typename = 'Mutation'});

  factory Mutation$DeleteUser.fromJson(Map<String, dynamic> json) {
    final l$users = json['users'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteUser(
      users: Mutation$DeleteUser$users.fromJson(
        (l$users as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$DeleteUser$users users;

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
    return Object.hashAll([l$users, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$DeleteUser || runtimeType != other.runtimeType) {
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

extension UtilityExtension$Mutation$DeleteUser on Mutation$DeleteUser {
  CopyWith$Mutation$DeleteUser<Mutation$DeleteUser> get copyWith =>
      CopyWith$Mutation$DeleteUser(this, (i) => i);
}

abstract class CopyWith$Mutation$DeleteUser<TRes> {
  factory CopyWith$Mutation$DeleteUser(
    Mutation$DeleteUser instance,
    TRes Function(Mutation$DeleteUser) then,
  ) = _CopyWithImpl$Mutation$DeleteUser;

  factory CopyWith$Mutation$DeleteUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DeleteUser;

  TRes call({Mutation$DeleteUser$users? users, String? $__typename});
  CopyWith$Mutation$DeleteUser$users<TRes> get users;
}

class _CopyWithImpl$Mutation$DeleteUser<TRes>
    implements CopyWith$Mutation$DeleteUser<TRes> {
  _CopyWithImpl$Mutation$DeleteUser(this._instance, this._then);

  final Mutation$DeleteUser _instance;

  final TRes Function(Mutation$DeleteUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? users = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$DeleteUser(
          users:
              users == _undefined || users == null
                  ? _instance.users
                  : (users as Mutation$DeleteUser$users),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$DeleteUser$users<TRes> get users {
    final local$users = _instance.users;
    return CopyWith$Mutation$DeleteUser$users(
      local$users,
      (e) => call(users: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$DeleteUser<TRes>
    implements CopyWith$Mutation$DeleteUser<TRes> {
  _CopyWithStubImpl$Mutation$DeleteUser(this._res);

  TRes _res;

  call({Mutation$DeleteUser$users? users, String? $__typename}) => _res;

  CopyWith$Mutation$DeleteUser$users<TRes> get users =>
      CopyWith$Mutation$DeleteUser$users.stub(_res);
}

const documentNodeMutationDeleteUser = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteUser'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'username')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'users'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'deleteUser'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'username'),
                      value: VariableNode(name: NameNode(value: 'username')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
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
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionbasicMutationReturnFields,
  ],
);
Mutation$DeleteUser _parserFn$Mutation$DeleteUser(Map<String, dynamic> data) =>
    Mutation$DeleteUser.fromJson(data);
typedef OnMutationCompleted$Mutation$DeleteUser =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$DeleteUser?);

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
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
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
    Options$Mutation$DeleteUser options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$DeleteUser> watchMutation$DeleteUser(
    WatchOptions$Mutation$DeleteUser options,
  ) => this.watchMutation(options);
}

class Mutation$DeleteUser$users {
  Mutation$DeleteUser$users({
    required this.deleteUser,
    this.$__typename = 'UsersMutations',
  });

  factory Mutation$DeleteUser$users.fromJson(Map<String, dynamic> json) {
    final l$deleteUser = json['deleteUser'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteUser$users(
      deleteUser: Mutation$DeleteUser$users$deleteUser.fromJson(
        (l$deleteUser as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$DeleteUser$users$deleteUser deleteUser;

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
    return Object.hashAll([l$deleteUser, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$DeleteUser$users ||
        runtimeType != other.runtimeType) {
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

extension UtilityExtension$Mutation$DeleteUser$users
    on Mutation$DeleteUser$users {
  CopyWith$Mutation$DeleteUser$users<Mutation$DeleteUser$users> get copyWith =>
      CopyWith$Mutation$DeleteUser$users(this, (i) => i);
}

abstract class CopyWith$Mutation$DeleteUser$users<TRes> {
  factory CopyWith$Mutation$DeleteUser$users(
    Mutation$DeleteUser$users instance,
    TRes Function(Mutation$DeleteUser$users) then,
  ) = _CopyWithImpl$Mutation$DeleteUser$users;

  factory CopyWith$Mutation$DeleteUser$users.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DeleteUser$users;

  TRes call({
    Mutation$DeleteUser$users$deleteUser? deleteUser,
    String? $__typename,
  });
  CopyWith$Mutation$DeleteUser$users$deleteUser<TRes> get deleteUser;
}

class _CopyWithImpl$Mutation$DeleteUser$users<TRes>
    implements CopyWith$Mutation$DeleteUser$users<TRes> {
  _CopyWithImpl$Mutation$DeleteUser$users(this._instance, this._then);

  final Mutation$DeleteUser$users _instance;

  final TRes Function(Mutation$DeleteUser$users) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? deleteUser = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$DeleteUser$users(
      deleteUser:
          deleteUser == _undefined || deleteUser == null
              ? _instance.deleteUser
              : (deleteUser as Mutation$DeleteUser$users$deleteUser),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$DeleteUser$users$deleteUser<TRes> get deleteUser {
    final local$deleteUser = _instance.deleteUser;
    return CopyWith$Mutation$DeleteUser$users$deleteUser(
      local$deleteUser,
      (e) => call(deleteUser: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$DeleteUser$users<TRes>
    implements CopyWith$Mutation$DeleteUser$users<TRes> {
  _CopyWithStubImpl$Mutation$DeleteUser$users(this._res);

  TRes _res;

  call({
    Mutation$DeleteUser$users$deleteUser? deleteUser,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$DeleteUser$users$deleteUser<TRes> get deleteUser =>
      CopyWith$Mutation$DeleteUser$users$deleteUser.stub(_res);
}

class Mutation$DeleteUser$users$deleteUser
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$DeleteUser$users$deleteUser({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$DeleteUser$users$deleteUser.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteUser$users$deleteUser(
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
    return Object.hashAll([l$code, l$message, l$success, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$DeleteUser$users$deleteUser ||
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

extension UtilityExtension$Mutation$DeleteUser$users$deleteUser
    on Mutation$DeleteUser$users$deleteUser {
  CopyWith$Mutation$DeleteUser$users$deleteUser<
    Mutation$DeleteUser$users$deleteUser
  >
  get copyWith => CopyWith$Mutation$DeleteUser$users$deleteUser(this, (i) => i);
}

abstract class CopyWith$Mutation$DeleteUser$users$deleteUser<TRes> {
  factory CopyWith$Mutation$DeleteUser$users$deleteUser(
    Mutation$DeleteUser$users$deleteUser instance,
    TRes Function(Mutation$DeleteUser$users$deleteUser) then,
  ) = _CopyWithImpl$Mutation$DeleteUser$users$deleteUser;

  factory CopyWith$Mutation$DeleteUser$users$deleteUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DeleteUser$users$deleteUser;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$DeleteUser$users$deleteUser<TRes>
    implements CopyWith$Mutation$DeleteUser$users$deleteUser<TRes> {
  _CopyWithImpl$Mutation$DeleteUser$users$deleteUser(
    this._instance,
    this._then,
  );

  final Mutation$DeleteUser$users$deleteUser _instance;

  final TRes Function(Mutation$DeleteUser$users$deleteUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$DeleteUser$users$deleteUser(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Mutation$DeleteUser$users$deleteUser<TRes>
    implements CopyWith$Mutation$DeleteUser$users$deleteUser<TRes> {
  _CopyWithStubImpl$Mutation$DeleteUser$users$deleteUser(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

class Variables$Mutation$UpdateUser {
  factory Variables$Mutation$UpdateUser({
    required Input$UserMutationInput user,
  }) => Variables$Mutation$UpdateUser._({r'user': user});

  Variables$Mutation$UpdateUser._(this._$data);

  factory Variables$Mutation$UpdateUser.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$user = data['user'];
    result$data['user'] = Input$UserMutationInput.fromJson(
      (l$user as Map<String, dynamic>),
    );
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
  get copyWith => CopyWith$Variables$Mutation$UpdateUser(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$UpdateUser ||
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
  _CopyWithImpl$Variables$Mutation$UpdateUser(this._instance, this._then);

  final Variables$Mutation$UpdateUser _instance;

  final TRes Function(Variables$Mutation$UpdateUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? user = _undefined}) => _then(
    Variables$Mutation$UpdateUser._({
      ..._instance._$data,
      if (user != _undefined && user != null)
        'user': (user as Input$UserMutationInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$UpdateUser<TRes>
    implements CopyWith$Variables$Mutation$UpdateUser<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UpdateUser(this._res);

  TRes _res;

  call({Input$UserMutationInput? user}) => _res;
}

class Mutation$UpdateUser {
  Mutation$UpdateUser({required this.users, this.$__typename = 'Mutation'});

  factory Mutation$UpdateUser.fromJson(Map<String, dynamic> json) {
    final l$users = json['users'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateUser(
      users: Mutation$UpdateUser$users.fromJson(
        (l$users as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$UpdateUser$users users;

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
    return Object.hashAll([l$users, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$UpdateUser || runtimeType != other.runtimeType) {
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

extension UtilityExtension$Mutation$UpdateUser on Mutation$UpdateUser {
  CopyWith$Mutation$UpdateUser<Mutation$UpdateUser> get copyWith =>
      CopyWith$Mutation$UpdateUser(this, (i) => i);
}

abstract class CopyWith$Mutation$UpdateUser<TRes> {
  factory CopyWith$Mutation$UpdateUser(
    Mutation$UpdateUser instance,
    TRes Function(Mutation$UpdateUser) then,
  ) = _CopyWithImpl$Mutation$UpdateUser;

  factory CopyWith$Mutation$UpdateUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateUser;

  TRes call({Mutation$UpdateUser$users? users, String? $__typename});
  CopyWith$Mutation$UpdateUser$users<TRes> get users;
}

class _CopyWithImpl$Mutation$UpdateUser<TRes>
    implements CopyWith$Mutation$UpdateUser<TRes> {
  _CopyWithImpl$Mutation$UpdateUser(this._instance, this._then);

  final Mutation$UpdateUser _instance;

  final TRes Function(Mutation$UpdateUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? users = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$UpdateUser(
          users:
              users == _undefined || users == null
                  ? _instance.users
                  : (users as Mutation$UpdateUser$users),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$UpdateUser$users<TRes> get users {
    final local$users = _instance.users;
    return CopyWith$Mutation$UpdateUser$users(
      local$users,
      (e) => call(users: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$UpdateUser<TRes>
    implements CopyWith$Mutation$UpdateUser<TRes> {
  _CopyWithStubImpl$Mutation$UpdateUser(this._res);

  TRes _res;

  call({Mutation$UpdateUser$users? users, String? $__typename}) => _res;

  CopyWith$Mutation$UpdateUser$users<TRes> get users =>
      CopyWith$Mutation$UpdateUser$users.stub(_res);
}

const documentNodeMutationUpdateUser = DocumentNode(
  definitions: [
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
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'users'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'updateUser'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'user'),
                      value: VariableNode(name: NameNode(value: 'user')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
                        directives: [],
                      ),
                      FieldNode(
                        name: NameNode(value: 'user'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
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
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionbasicMutationReturnFields,
    fragmentDefinitionuserFields,
  ],
);
Mutation$UpdateUser _parserFn$Mutation$UpdateUser(Map<String, dynamic> data) =>
    Mutation$UpdateUser.fromJson(data);
typedef OnMutationCompleted$Mutation$UpdateUser =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$UpdateUser?);

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
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
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
    Options$Mutation$UpdateUser options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$UpdateUser> watchMutation$UpdateUser(
    WatchOptions$Mutation$UpdateUser options,
  ) => this.watchMutation(options);
}

class Mutation$UpdateUser$users {
  Mutation$UpdateUser$users({
    required this.updateUser,
    this.$__typename = 'UsersMutations',
  });

  factory Mutation$UpdateUser$users.fromJson(Map<String, dynamic> json) {
    final l$updateUser = json['updateUser'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateUser$users(
      updateUser: Mutation$UpdateUser$users$updateUser.fromJson(
        (l$updateUser as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$UpdateUser$users$updateUser updateUser;

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
    return Object.hashAll([l$updateUser, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$UpdateUser$users ||
        runtimeType != other.runtimeType) {
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

extension UtilityExtension$Mutation$UpdateUser$users
    on Mutation$UpdateUser$users {
  CopyWith$Mutation$UpdateUser$users<Mutation$UpdateUser$users> get copyWith =>
      CopyWith$Mutation$UpdateUser$users(this, (i) => i);
}

abstract class CopyWith$Mutation$UpdateUser$users<TRes> {
  factory CopyWith$Mutation$UpdateUser$users(
    Mutation$UpdateUser$users instance,
    TRes Function(Mutation$UpdateUser$users) then,
  ) = _CopyWithImpl$Mutation$UpdateUser$users;

  factory CopyWith$Mutation$UpdateUser$users.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateUser$users;

  TRes call({
    Mutation$UpdateUser$users$updateUser? updateUser,
    String? $__typename,
  });
  CopyWith$Mutation$UpdateUser$users$updateUser<TRes> get updateUser;
}

class _CopyWithImpl$Mutation$UpdateUser$users<TRes>
    implements CopyWith$Mutation$UpdateUser$users<TRes> {
  _CopyWithImpl$Mutation$UpdateUser$users(this._instance, this._then);

  final Mutation$UpdateUser$users _instance;

  final TRes Function(Mutation$UpdateUser$users) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? updateUser = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$UpdateUser$users(
      updateUser:
          updateUser == _undefined || updateUser == null
              ? _instance.updateUser
              : (updateUser as Mutation$UpdateUser$users$updateUser),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$UpdateUser$users$updateUser<TRes> get updateUser {
    final local$updateUser = _instance.updateUser;
    return CopyWith$Mutation$UpdateUser$users$updateUser(
      local$updateUser,
      (e) => call(updateUser: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$UpdateUser$users<TRes>
    implements CopyWith$Mutation$UpdateUser$users<TRes> {
  _CopyWithStubImpl$Mutation$UpdateUser$users(this._res);

  TRes _res;

  call({
    Mutation$UpdateUser$users$updateUser? updateUser,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$UpdateUser$users$updateUser<TRes> get updateUser =>
      CopyWith$Mutation$UpdateUser$users$updateUser.stub(_res);
}

class Mutation$UpdateUser$users$updateUser
    implements Fragment$basicMutationReturnFields$$UserMutationReturn {
  Mutation$UpdateUser$users$updateUser({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'UserMutationReturn',
    this.user,
  });

  factory Mutation$UpdateUser$users$updateUser.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$user = json['user'];
    return Mutation$UpdateUser$users$updateUser(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      user:
          l$user == null
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
    if (other is! Mutation$UpdateUser$users$updateUser ||
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

extension UtilityExtension$Mutation$UpdateUser$users$updateUser
    on Mutation$UpdateUser$users$updateUser {
  CopyWith$Mutation$UpdateUser$users$updateUser<
    Mutation$UpdateUser$users$updateUser
  >
  get copyWith => CopyWith$Mutation$UpdateUser$users$updateUser(this, (i) => i);
}

abstract class CopyWith$Mutation$UpdateUser$users$updateUser<TRes> {
  factory CopyWith$Mutation$UpdateUser$users$updateUser(
    Mutation$UpdateUser$users$updateUser instance,
    TRes Function(Mutation$UpdateUser$users$updateUser) then,
  ) = _CopyWithImpl$Mutation$UpdateUser$users$updateUser;

  factory CopyWith$Mutation$UpdateUser$users$updateUser.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateUser$users$updateUser;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  });
  CopyWith$Fragment$userFields<TRes> get user;
}

class _CopyWithImpl$Mutation$UpdateUser$users$updateUser<TRes>
    implements CopyWith$Mutation$UpdateUser$users$updateUser<TRes> {
  _CopyWithImpl$Mutation$UpdateUser$users$updateUser(
    this._instance,
    this._then,
  );

  final Mutation$UpdateUser$users$updateUser _instance;

  final TRes Function(Mutation$UpdateUser$users$updateUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? user = _undefined,
  }) => _then(
    Mutation$UpdateUser$users$updateUser(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
      user:
          user == _undefined ? _instance.user : (user as Fragment$userFields?),
    ),
  );

  CopyWith$Fragment$userFields<TRes> get user {
    final local$user = _instance.user;
    return local$user == null
        ? CopyWith$Fragment$userFields.stub(_then(_instance))
        : CopyWith$Fragment$userFields(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Mutation$UpdateUser$users$updateUser<TRes>
    implements CopyWith$Mutation$UpdateUser$users$updateUser<TRes> {
  _CopyWithStubImpl$Mutation$UpdateUser$users$updateUser(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  }) => _res;

  CopyWith$Fragment$userFields<TRes> get user =>
      CopyWith$Fragment$userFields.stub(_res);
}

class Variables$Mutation$AddSshKey {
  factory Variables$Mutation$AddSshKey({
    required Input$SshMutationInput sshInput,
  }) => Variables$Mutation$AddSshKey._({r'sshInput': sshInput});

  Variables$Mutation$AddSshKey._(this._$data);

  factory Variables$Mutation$AddSshKey.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$sshInput = data['sshInput'];
    result$data['sshInput'] = Input$SshMutationInput.fromJson(
      (l$sshInput as Map<String, dynamic>),
    );
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
  get copyWith => CopyWith$Variables$Mutation$AddSshKey(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$AddSshKey ||
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
  _CopyWithImpl$Variables$Mutation$AddSshKey(this._instance, this._then);

  final Variables$Mutation$AddSshKey _instance;

  final TRes Function(Variables$Mutation$AddSshKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? sshInput = _undefined}) => _then(
    Variables$Mutation$AddSshKey._({
      ..._instance._$data,
      if (sshInput != _undefined && sshInput != null)
        'sshInput': (sshInput as Input$SshMutationInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$AddSshKey<TRes>
    implements CopyWith$Variables$Mutation$AddSshKey<TRes> {
  _CopyWithStubImpl$Variables$Mutation$AddSshKey(this._res);

  TRes _res;

  call({Input$SshMutationInput? sshInput}) => _res;
}

class Mutation$AddSshKey {
  Mutation$AddSshKey({required this.users, this.$__typename = 'Mutation'});

  factory Mutation$AddSshKey.fromJson(Map<String, dynamic> json) {
    final l$users = json['users'];
    final l$$__typename = json['__typename'];
    return Mutation$AddSshKey(
      users: Mutation$AddSshKey$users.fromJson(
        (l$users as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$AddSshKey$users users;

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
    return Object.hashAll([l$users, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$AddSshKey || runtimeType != other.runtimeType) {
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

extension UtilityExtension$Mutation$AddSshKey on Mutation$AddSshKey {
  CopyWith$Mutation$AddSshKey<Mutation$AddSshKey> get copyWith =>
      CopyWith$Mutation$AddSshKey(this, (i) => i);
}

abstract class CopyWith$Mutation$AddSshKey<TRes> {
  factory CopyWith$Mutation$AddSshKey(
    Mutation$AddSshKey instance,
    TRes Function(Mutation$AddSshKey) then,
  ) = _CopyWithImpl$Mutation$AddSshKey;

  factory CopyWith$Mutation$AddSshKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$AddSshKey;

  TRes call({Mutation$AddSshKey$users? users, String? $__typename});
  CopyWith$Mutation$AddSshKey$users<TRes> get users;
}

class _CopyWithImpl$Mutation$AddSshKey<TRes>
    implements CopyWith$Mutation$AddSshKey<TRes> {
  _CopyWithImpl$Mutation$AddSshKey(this._instance, this._then);

  final Mutation$AddSshKey _instance;

  final TRes Function(Mutation$AddSshKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? users = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$AddSshKey(
          users:
              users == _undefined || users == null
                  ? _instance.users
                  : (users as Mutation$AddSshKey$users),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$AddSshKey$users<TRes> get users {
    final local$users = _instance.users;
    return CopyWith$Mutation$AddSshKey$users(
      local$users,
      (e) => call(users: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$AddSshKey<TRes>
    implements CopyWith$Mutation$AddSshKey<TRes> {
  _CopyWithStubImpl$Mutation$AddSshKey(this._res);

  TRes _res;

  call({Mutation$AddSshKey$users? users, String? $__typename}) => _res;

  CopyWith$Mutation$AddSshKey$users<TRes> get users =>
      CopyWith$Mutation$AddSshKey$users.stub(_res);
}

const documentNodeMutationAddSshKey = DocumentNode(
  definitions: [
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
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'users'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'addSshKey'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'sshInput'),
                      value: VariableNode(name: NameNode(value: 'sshInput')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
                        directives: [],
                      ),
                      FieldNode(
                        name: NameNode(value: 'user'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
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
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionbasicMutationReturnFields,
    fragmentDefinitionuserFields,
  ],
);
Mutation$AddSshKey _parserFn$Mutation$AddSshKey(Map<String, dynamic> data) =>
    Mutation$AddSshKey.fromJson(data);
typedef OnMutationCompleted$Mutation$AddSshKey =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$AddSshKey?);

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
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
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
    Options$Mutation$AddSshKey options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$AddSshKey> watchMutation$AddSshKey(
    WatchOptions$Mutation$AddSshKey options,
  ) => this.watchMutation(options);
}

class Mutation$AddSshKey$users {
  Mutation$AddSshKey$users({
    required this.addSshKey,
    this.$__typename = 'UsersMutations',
  });

  factory Mutation$AddSshKey$users.fromJson(Map<String, dynamic> json) {
    final l$addSshKey = json['addSshKey'];
    final l$$__typename = json['__typename'];
    return Mutation$AddSshKey$users(
      addSshKey: Mutation$AddSshKey$users$addSshKey.fromJson(
        (l$addSshKey as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$AddSshKey$users$addSshKey addSshKey;

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
    return Object.hashAll([l$addSshKey, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$AddSshKey$users ||
        runtimeType != other.runtimeType) {
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

extension UtilityExtension$Mutation$AddSshKey$users
    on Mutation$AddSshKey$users {
  CopyWith$Mutation$AddSshKey$users<Mutation$AddSshKey$users> get copyWith =>
      CopyWith$Mutation$AddSshKey$users(this, (i) => i);
}

abstract class CopyWith$Mutation$AddSshKey$users<TRes> {
  factory CopyWith$Mutation$AddSshKey$users(
    Mutation$AddSshKey$users instance,
    TRes Function(Mutation$AddSshKey$users) then,
  ) = _CopyWithImpl$Mutation$AddSshKey$users;

  factory CopyWith$Mutation$AddSshKey$users.stub(TRes res) =
      _CopyWithStubImpl$Mutation$AddSshKey$users;

  TRes call({
    Mutation$AddSshKey$users$addSshKey? addSshKey,
    String? $__typename,
  });
  CopyWith$Mutation$AddSshKey$users$addSshKey<TRes> get addSshKey;
}

class _CopyWithImpl$Mutation$AddSshKey$users<TRes>
    implements CopyWith$Mutation$AddSshKey$users<TRes> {
  _CopyWithImpl$Mutation$AddSshKey$users(this._instance, this._then);

  final Mutation$AddSshKey$users _instance;

  final TRes Function(Mutation$AddSshKey$users) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? addSshKey = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$AddSshKey$users(
      addSshKey:
          addSshKey == _undefined || addSshKey == null
              ? _instance.addSshKey
              : (addSshKey as Mutation$AddSshKey$users$addSshKey),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$AddSshKey$users$addSshKey<TRes> get addSshKey {
    final local$addSshKey = _instance.addSshKey;
    return CopyWith$Mutation$AddSshKey$users$addSshKey(
      local$addSshKey,
      (e) => call(addSshKey: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$AddSshKey$users<TRes>
    implements CopyWith$Mutation$AddSshKey$users<TRes> {
  _CopyWithStubImpl$Mutation$AddSshKey$users(this._res);

  TRes _res;

  call({Mutation$AddSshKey$users$addSshKey? addSshKey, String? $__typename}) =>
      _res;

  CopyWith$Mutation$AddSshKey$users$addSshKey<TRes> get addSshKey =>
      CopyWith$Mutation$AddSshKey$users$addSshKey.stub(_res);
}

class Mutation$AddSshKey$users$addSshKey
    implements Fragment$basicMutationReturnFields$$UserMutationReturn {
  Mutation$AddSshKey$users$addSshKey({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'UserMutationReturn',
    this.user,
  });

  factory Mutation$AddSshKey$users$addSshKey.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$user = json['user'];
    return Mutation$AddSshKey$users$addSshKey(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      user:
          l$user == null
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
    if (other is! Mutation$AddSshKey$users$addSshKey ||
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

extension UtilityExtension$Mutation$AddSshKey$users$addSshKey
    on Mutation$AddSshKey$users$addSshKey {
  CopyWith$Mutation$AddSshKey$users$addSshKey<
    Mutation$AddSshKey$users$addSshKey
  >
  get copyWith => CopyWith$Mutation$AddSshKey$users$addSshKey(this, (i) => i);
}

abstract class CopyWith$Mutation$AddSshKey$users$addSshKey<TRes> {
  factory CopyWith$Mutation$AddSshKey$users$addSshKey(
    Mutation$AddSshKey$users$addSshKey instance,
    TRes Function(Mutation$AddSshKey$users$addSshKey) then,
  ) = _CopyWithImpl$Mutation$AddSshKey$users$addSshKey;

  factory CopyWith$Mutation$AddSshKey$users$addSshKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$AddSshKey$users$addSshKey;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  });
  CopyWith$Fragment$userFields<TRes> get user;
}

class _CopyWithImpl$Mutation$AddSshKey$users$addSshKey<TRes>
    implements CopyWith$Mutation$AddSshKey$users$addSshKey<TRes> {
  _CopyWithImpl$Mutation$AddSshKey$users$addSshKey(this._instance, this._then);

  final Mutation$AddSshKey$users$addSshKey _instance;

  final TRes Function(Mutation$AddSshKey$users$addSshKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? user = _undefined,
  }) => _then(
    Mutation$AddSshKey$users$addSshKey(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
      user:
          user == _undefined ? _instance.user : (user as Fragment$userFields?),
    ),
  );

  CopyWith$Fragment$userFields<TRes> get user {
    final local$user = _instance.user;
    return local$user == null
        ? CopyWith$Fragment$userFields.stub(_then(_instance))
        : CopyWith$Fragment$userFields(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Mutation$AddSshKey$users$addSshKey<TRes>
    implements CopyWith$Mutation$AddSshKey$users$addSshKey<TRes> {
  _CopyWithStubImpl$Mutation$AddSshKey$users$addSshKey(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  }) => _res;

  CopyWith$Fragment$userFields<TRes> get user =>
      CopyWith$Fragment$userFields.stub(_res);
}

class Variables$Mutation$RemoveSshKey {
  factory Variables$Mutation$RemoveSshKey({
    required Input$SshMutationInput sshInput,
  }) => Variables$Mutation$RemoveSshKey._({r'sshInput': sshInput});

  Variables$Mutation$RemoveSshKey._(this._$data);

  factory Variables$Mutation$RemoveSshKey.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$sshInput = data['sshInput'];
    result$data['sshInput'] = Input$SshMutationInput.fromJson(
      (l$sshInput as Map<String, dynamic>),
    );
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
  get copyWith => CopyWith$Variables$Mutation$RemoveSshKey(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$RemoveSshKey ||
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
  _CopyWithImpl$Variables$Mutation$RemoveSshKey(this._instance, this._then);

  final Variables$Mutation$RemoveSshKey _instance;

  final TRes Function(Variables$Mutation$RemoveSshKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? sshInput = _undefined}) => _then(
    Variables$Mutation$RemoveSshKey._({
      ..._instance._$data,
      if (sshInput != _undefined && sshInput != null)
        'sshInput': (sshInput as Input$SshMutationInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$RemoveSshKey<TRes>
    implements CopyWith$Variables$Mutation$RemoveSshKey<TRes> {
  _CopyWithStubImpl$Variables$Mutation$RemoveSshKey(this._res);

  TRes _res;

  call({Input$SshMutationInput? sshInput}) => _res;
}

class Mutation$RemoveSshKey {
  Mutation$RemoveSshKey({required this.users, this.$__typename = 'Mutation'});

  factory Mutation$RemoveSshKey.fromJson(Map<String, dynamic> json) {
    final l$users = json['users'];
    final l$$__typename = json['__typename'];
    return Mutation$RemoveSshKey(
      users: Mutation$RemoveSshKey$users.fromJson(
        (l$users as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$RemoveSshKey$users users;

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
    return Object.hashAll([l$users, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RemoveSshKey || runtimeType != other.runtimeType) {
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

extension UtilityExtension$Mutation$RemoveSshKey on Mutation$RemoveSshKey {
  CopyWith$Mutation$RemoveSshKey<Mutation$RemoveSshKey> get copyWith =>
      CopyWith$Mutation$RemoveSshKey(this, (i) => i);
}

abstract class CopyWith$Mutation$RemoveSshKey<TRes> {
  factory CopyWith$Mutation$RemoveSshKey(
    Mutation$RemoveSshKey instance,
    TRes Function(Mutation$RemoveSshKey) then,
  ) = _CopyWithImpl$Mutation$RemoveSshKey;

  factory CopyWith$Mutation$RemoveSshKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RemoveSshKey;

  TRes call({Mutation$RemoveSshKey$users? users, String? $__typename});
  CopyWith$Mutation$RemoveSshKey$users<TRes> get users;
}

class _CopyWithImpl$Mutation$RemoveSshKey<TRes>
    implements CopyWith$Mutation$RemoveSshKey<TRes> {
  _CopyWithImpl$Mutation$RemoveSshKey(this._instance, this._then);

  final Mutation$RemoveSshKey _instance;

  final TRes Function(Mutation$RemoveSshKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? users = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$RemoveSshKey(
          users:
              users == _undefined || users == null
                  ? _instance.users
                  : (users as Mutation$RemoveSshKey$users),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$RemoveSshKey$users<TRes> get users {
    final local$users = _instance.users;
    return CopyWith$Mutation$RemoveSshKey$users(
      local$users,
      (e) => call(users: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$RemoveSshKey<TRes>
    implements CopyWith$Mutation$RemoveSshKey<TRes> {
  _CopyWithStubImpl$Mutation$RemoveSshKey(this._res);

  TRes _res;

  call({Mutation$RemoveSshKey$users? users, String? $__typename}) => _res;

  CopyWith$Mutation$RemoveSshKey$users<TRes> get users =>
      CopyWith$Mutation$RemoveSshKey$users.stub(_res);
}

const documentNodeMutationRemoveSshKey = DocumentNode(
  definitions: [
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
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'users'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'removeSshKey'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'sshInput'),
                      value: VariableNode(name: NameNode(value: 'sshInput')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
                        directives: [],
                      ),
                      FieldNode(
                        name: NameNode(value: 'user'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
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
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionbasicMutationReturnFields,
    fragmentDefinitionuserFields,
  ],
);
Mutation$RemoveSshKey _parserFn$Mutation$RemoveSshKey(
  Map<String, dynamic> data,
) => Mutation$RemoveSshKey.fromJson(data);
typedef OnMutationCompleted$Mutation$RemoveSshKey =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$RemoveSshKey?);

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
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
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
    Options$Mutation$RemoveSshKey options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$RemoveSshKey> watchMutation$RemoveSshKey(
    WatchOptions$Mutation$RemoveSshKey options,
  ) => this.watchMutation(options);
}

class Mutation$RemoveSshKey$users {
  Mutation$RemoveSshKey$users({
    required this.removeSshKey,
    this.$__typename = 'UsersMutations',
  });

  factory Mutation$RemoveSshKey$users.fromJson(Map<String, dynamic> json) {
    final l$removeSshKey = json['removeSshKey'];
    final l$$__typename = json['__typename'];
    return Mutation$RemoveSshKey$users(
      removeSshKey: Mutation$RemoveSshKey$users$removeSshKey.fromJson(
        (l$removeSshKey as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$RemoveSshKey$users$removeSshKey removeSshKey;

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
    return Object.hashAll([l$removeSshKey, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RemoveSshKey$users ||
        runtimeType != other.runtimeType) {
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

extension UtilityExtension$Mutation$RemoveSshKey$users
    on Mutation$RemoveSshKey$users {
  CopyWith$Mutation$RemoveSshKey$users<Mutation$RemoveSshKey$users>
  get copyWith => CopyWith$Mutation$RemoveSshKey$users(this, (i) => i);
}

abstract class CopyWith$Mutation$RemoveSshKey$users<TRes> {
  factory CopyWith$Mutation$RemoveSshKey$users(
    Mutation$RemoveSshKey$users instance,
    TRes Function(Mutation$RemoveSshKey$users) then,
  ) = _CopyWithImpl$Mutation$RemoveSshKey$users;

  factory CopyWith$Mutation$RemoveSshKey$users.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RemoveSshKey$users;

  TRes call({
    Mutation$RemoveSshKey$users$removeSshKey? removeSshKey,
    String? $__typename,
  });
  CopyWith$Mutation$RemoveSshKey$users$removeSshKey<TRes> get removeSshKey;
}

class _CopyWithImpl$Mutation$RemoveSshKey$users<TRes>
    implements CopyWith$Mutation$RemoveSshKey$users<TRes> {
  _CopyWithImpl$Mutation$RemoveSshKey$users(this._instance, this._then);

  final Mutation$RemoveSshKey$users _instance;

  final TRes Function(Mutation$RemoveSshKey$users) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? removeSshKey = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$RemoveSshKey$users(
      removeSshKey:
          removeSshKey == _undefined || removeSshKey == null
              ? _instance.removeSshKey
              : (removeSshKey as Mutation$RemoveSshKey$users$removeSshKey),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$RemoveSshKey$users$removeSshKey<TRes> get removeSshKey {
    final local$removeSshKey = _instance.removeSshKey;
    return CopyWith$Mutation$RemoveSshKey$users$removeSshKey(
      local$removeSshKey,
      (e) => call(removeSshKey: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$RemoveSshKey$users<TRes>
    implements CopyWith$Mutation$RemoveSshKey$users<TRes> {
  _CopyWithStubImpl$Mutation$RemoveSshKey$users(this._res);

  TRes _res;

  call({
    Mutation$RemoveSshKey$users$removeSshKey? removeSshKey,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$RemoveSshKey$users$removeSshKey<TRes> get removeSshKey =>
      CopyWith$Mutation$RemoveSshKey$users$removeSshKey.stub(_res);
}

class Mutation$RemoveSshKey$users$removeSshKey
    implements Fragment$basicMutationReturnFields$$UserMutationReturn {
  Mutation$RemoveSshKey$users$removeSshKey({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'UserMutationReturn',
    this.user,
  });

  factory Mutation$RemoveSshKey$users$removeSshKey.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$user = json['user'];
    return Mutation$RemoveSshKey$users$removeSshKey(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      user:
          l$user == null
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
    if (other is! Mutation$RemoveSshKey$users$removeSshKey ||
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

extension UtilityExtension$Mutation$RemoveSshKey$users$removeSshKey
    on Mutation$RemoveSshKey$users$removeSshKey {
  CopyWith$Mutation$RemoveSshKey$users$removeSshKey<
    Mutation$RemoveSshKey$users$removeSshKey
  >
  get copyWith =>
      CopyWith$Mutation$RemoveSshKey$users$removeSshKey(this, (i) => i);
}

abstract class CopyWith$Mutation$RemoveSshKey$users$removeSshKey<TRes> {
  factory CopyWith$Mutation$RemoveSshKey$users$removeSshKey(
    Mutation$RemoveSshKey$users$removeSshKey instance,
    TRes Function(Mutation$RemoveSshKey$users$removeSshKey) then,
  ) = _CopyWithImpl$Mutation$RemoveSshKey$users$removeSshKey;

  factory CopyWith$Mutation$RemoveSshKey$users$removeSshKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RemoveSshKey$users$removeSshKey;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  });
  CopyWith$Fragment$userFields<TRes> get user;
}

class _CopyWithImpl$Mutation$RemoveSshKey$users$removeSshKey<TRes>
    implements CopyWith$Mutation$RemoveSshKey$users$removeSshKey<TRes> {
  _CopyWithImpl$Mutation$RemoveSshKey$users$removeSshKey(
    this._instance,
    this._then,
  );

  final Mutation$RemoveSshKey$users$removeSshKey _instance;

  final TRes Function(Mutation$RemoveSshKey$users$removeSshKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? user = _undefined,
  }) => _then(
    Mutation$RemoveSshKey$users$removeSshKey(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
      user:
          user == _undefined ? _instance.user : (user as Fragment$userFields?),
    ),
  );

  CopyWith$Fragment$userFields<TRes> get user {
    final local$user = _instance.user;
    return local$user == null
        ? CopyWith$Fragment$userFields.stub(_then(_instance))
        : CopyWith$Fragment$userFields(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Mutation$RemoveSshKey$users$removeSshKey<TRes>
    implements CopyWith$Mutation$RemoveSshKey$users$removeSshKey<TRes> {
  _CopyWithStubImpl$Mutation$RemoveSshKey$users$removeSshKey(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$userFields? user,
  }) => _res;

  CopyWith$Fragment$userFields<TRes> get user =>
      CopyWith$Fragment$userFields.stub(_res);
}

class Variables$Mutation$GeneratePasswordResetLink {
  factory Variables$Mutation$GeneratePasswordResetLink({
    required String username,
  }) => Variables$Mutation$GeneratePasswordResetLink._({r'username': username});

  Variables$Mutation$GeneratePasswordResetLink._(this._$data);

  factory Variables$Mutation$GeneratePasswordResetLink.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$username = data['username'];
    result$data['username'] = (l$username as String);
    return Variables$Mutation$GeneratePasswordResetLink._(result$data);
  }

  Map<String, dynamic> _$data;

  String get username => (_$data['username'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$username = username;
    result$data['username'] = l$username;
    return result$data;
  }

  CopyWith$Variables$Mutation$GeneratePasswordResetLink<
    Variables$Mutation$GeneratePasswordResetLink
  >
  get copyWith =>
      CopyWith$Variables$Mutation$GeneratePasswordResetLink(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$GeneratePasswordResetLink ||
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

abstract class CopyWith$Variables$Mutation$GeneratePasswordResetLink<TRes> {
  factory CopyWith$Variables$Mutation$GeneratePasswordResetLink(
    Variables$Mutation$GeneratePasswordResetLink instance,
    TRes Function(Variables$Mutation$GeneratePasswordResetLink) then,
  ) = _CopyWithImpl$Variables$Mutation$GeneratePasswordResetLink;

  factory CopyWith$Variables$Mutation$GeneratePasswordResetLink.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$GeneratePasswordResetLink;

  TRes call({String? username});
}

class _CopyWithImpl$Variables$Mutation$GeneratePasswordResetLink<TRes>
    implements CopyWith$Variables$Mutation$GeneratePasswordResetLink<TRes> {
  _CopyWithImpl$Variables$Mutation$GeneratePasswordResetLink(
    this._instance,
    this._then,
  );

  final Variables$Mutation$GeneratePasswordResetLink _instance;

  final TRes Function(Variables$Mutation$GeneratePasswordResetLink) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? username = _undefined}) => _then(
    Variables$Mutation$GeneratePasswordResetLink._({
      ..._instance._$data,
      if (username != _undefined && username != null)
        'username': (username as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$GeneratePasswordResetLink<TRes>
    implements CopyWith$Variables$Mutation$GeneratePasswordResetLink<TRes> {
  _CopyWithStubImpl$Variables$Mutation$GeneratePasswordResetLink(this._res);

  TRes _res;

  call({String? username}) => _res;
}

class Mutation$GeneratePasswordResetLink {
  Mutation$GeneratePasswordResetLink({
    required this.users,
    this.$__typename = 'Mutation',
  });

  factory Mutation$GeneratePasswordResetLink.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$users = json['users'];
    final l$$__typename = json['__typename'];
    return Mutation$GeneratePasswordResetLink(
      users: Mutation$GeneratePasswordResetLink$users.fromJson(
        (l$users as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$GeneratePasswordResetLink$users users;

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
    return Object.hashAll([l$users, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$GeneratePasswordResetLink ||
        runtimeType != other.runtimeType) {
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

extension UtilityExtension$Mutation$GeneratePasswordResetLink
    on Mutation$GeneratePasswordResetLink {
  CopyWith$Mutation$GeneratePasswordResetLink<
    Mutation$GeneratePasswordResetLink
  >
  get copyWith => CopyWith$Mutation$GeneratePasswordResetLink(this, (i) => i);
}

abstract class CopyWith$Mutation$GeneratePasswordResetLink<TRes> {
  factory CopyWith$Mutation$GeneratePasswordResetLink(
    Mutation$GeneratePasswordResetLink instance,
    TRes Function(Mutation$GeneratePasswordResetLink) then,
  ) = _CopyWithImpl$Mutation$GeneratePasswordResetLink;

  factory CopyWith$Mutation$GeneratePasswordResetLink.stub(TRes res) =
      _CopyWithStubImpl$Mutation$GeneratePasswordResetLink;

  TRes call({
    Mutation$GeneratePasswordResetLink$users? users,
    String? $__typename,
  });
  CopyWith$Mutation$GeneratePasswordResetLink$users<TRes> get users;
}

class _CopyWithImpl$Mutation$GeneratePasswordResetLink<TRes>
    implements CopyWith$Mutation$GeneratePasswordResetLink<TRes> {
  _CopyWithImpl$Mutation$GeneratePasswordResetLink(this._instance, this._then);

  final Mutation$GeneratePasswordResetLink _instance;

  final TRes Function(Mutation$GeneratePasswordResetLink) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? users = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$GeneratePasswordResetLink(
          users:
              users == _undefined || users == null
                  ? _instance.users
                  : (users as Mutation$GeneratePasswordResetLink$users),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$GeneratePasswordResetLink$users<TRes> get users {
    final local$users = _instance.users;
    return CopyWith$Mutation$GeneratePasswordResetLink$users(
      local$users,
      (e) => call(users: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$GeneratePasswordResetLink<TRes>
    implements CopyWith$Mutation$GeneratePasswordResetLink<TRes> {
  _CopyWithStubImpl$Mutation$GeneratePasswordResetLink(this._res);

  TRes _res;

  call({
    Mutation$GeneratePasswordResetLink$users? users,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$GeneratePasswordResetLink$users<TRes> get users =>
      CopyWith$Mutation$GeneratePasswordResetLink$users.stub(_res);
}

const documentNodeMutationGeneratePasswordResetLink = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'GeneratePasswordResetLink'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'username')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'users'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'generatePasswordResetLink'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'username'),
                      value: VariableNode(name: NameNode(value: 'username')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
                        directives: [],
                      ),
                      FieldNode(
                        name: NameNode(value: 'passwordResetLink'),
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
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionbasicMutationReturnFields,
  ],
);
Mutation$GeneratePasswordResetLink _parserFn$Mutation$GeneratePasswordResetLink(
  Map<String, dynamic> data,
) => Mutation$GeneratePasswordResetLink.fromJson(data);
typedef OnMutationCompleted$Mutation$GeneratePasswordResetLink =
    FutureOr<void> Function(
      Map<String, dynamic>?,
      Mutation$GeneratePasswordResetLink?,
    );

class Options$Mutation$GeneratePasswordResetLink
    extends graphql.MutationOptions<Mutation$GeneratePasswordResetLink> {
  Options$Mutation$GeneratePasswordResetLink({
    String? operationName,
    required Variables$Mutation$GeneratePasswordResetLink variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$GeneratePasswordResetLink? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$GeneratePasswordResetLink? onCompleted,
    graphql.OnMutationUpdate<Mutation$GeneratePasswordResetLink>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null
                       ? null
                       : _parserFn$Mutation$GeneratePasswordResetLink(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationGeneratePasswordResetLink,
         parserFn: _parserFn$Mutation$GeneratePasswordResetLink,
       );

  final OnMutationCompleted$Mutation$GeneratePasswordResetLink?
  onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$GeneratePasswordResetLink
    extends graphql.WatchQueryOptions<Mutation$GeneratePasswordResetLink> {
  WatchOptions$Mutation$GeneratePasswordResetLink({
    String? operationName,
    required Variables$Mutation$GeneratePasswordResetLink variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$GeneratePasswordResetLink? typedOptimisticResult,
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
         document: documentNodeMutationGeneratePasswordResetLink,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$GeneratePasswordResetLink,
       );
}

extension ClientExtension$Mutation$GeneratePasswordResetLink
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$GeneratePasswordResetLink>>
  mutate$GeneratePasswordResetLink(
    Options$Mutation$GeneratePasswordResetLink options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$GeneratePasswordResetLink>
  watchMutation$GeneratePasswordResetLink(
    WatchOptions$Mutation$GeneratePasswordResetLink options,
  ) => this.watchMutation(options);
}

class Mutation$GeneratePasswordResetLink$users {
  Mutation$GeneratePasswordResetLink$users({
    required this.generatePasswordResetLink,
    this.$__typename = 'UsersMutations',
  });

  factory Mutation$GeneratePasswordResetLink$users.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$generatePasswordResetLink = json['generatePasswordResetLink'];
    final l$$__typename = json['__typename'];
    return Mutation$GeneratePasswordResetLink$users(
      generatePasswordResetLink:
          Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink.fromJson(
            (l$generatePasswordResetLink as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink
  generatePasswordResetLink;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$generatePasswordResetLink = generatePasswordResetLink;
    _resultData['generatePasswordResetLink'] =
        l$generatePasswordResetLink.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$generatePasswordResetLink = generatePasswordResetLink;
    final l$$__typename = $__typename;
    return Object.hashAll([l$generatePasswordResetLink, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$GeneratePasswordResetLink$users ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$generatePasswordResetLink = generatePasswordResetLink;
    final lOther$generatePasswordResetLink = other.generatePasswordResetLink;
    if (l$generatePasswordResetLink != lOther$generatePasswordResetLink) {
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

extension UtilityExtension$Mutation$GeneratePasswordResetLink$users
    on Mutation$GeneratePasswordResetLink$users {
  CopyWith$Mutation$GeneratePasswordResetLink$users<
    Mutation$GeneratePasswordResetLink$users
  >
  get copyWith =>
      CopyWith$Mutation$GeneratePasswordResetLink$users(this, (i) => i);
}

abstract class CopyWith$Mutation$GeneratePasswordResetLink$users<TRes> {
  factory CopyWith$Mutation$GeneratePasswordResetLink$users(
    Mutation$GeneratePasswordResetLink$users instance,
    TRes Function(Mutation$GeneratePasswordResetLink$users) then,
  ) = _CopyWithImpl$Mutation$GeneratePasswordResetLink$users;

  factory CopyWith$Mutation$GeneratePasswordResetLink$users.stub(TRes res) =
      _CopyWithStubImpl$Mutation$GeneratePasswordResetLink$users;

  TRes call({
    Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink?
    generatePasswordResetLink,
    String? $__typename,
  });
  CopyWith$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink<
    TRes
  >
  get generatePasswordResetLink;
}

class _CopyWithImpl$Mutation$GeneratePasswordResetLink$users<TRes>
    implements CopyWith$Mutation$GeneratePasswordResetLink$users<TRes> {
  _CopyWithImpl$Mutation$GeneratePasswordResetLink$users(
    this._instance,
    this._then,
  );

  final Mutation$GeneratePasswordResetLink$users _instance;

  final TRes Function(Mutation$GeneratePasswordResetLink$users) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? generatePasswordResetLink = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$GeneratePasswordResetLink$users(
      generatePasswordResetLink:
          generatePasswordResetLink == _undefined ||
                  generatePasswordResetLink == null
              ? _instance.generatePasswordResetLink
              : (generatePasswordResetLink
                  as Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink<
    TRes
  >
  get generatePasswordResetLink {
    final local$generatePasswordResetLink = _instance.generatePasswordResetLink;
    return CopyWith$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink(
      local$generatePasswordResetLink,
      (e) => call(generatePasswordResetLink: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$GeneratePasswordResetLink$users<TRes>
    implements CopyWith$Mutation$GeneratePasswordResetLink$users<TRes> {
  _CopyWithStubImpl$Mutation$GeneratePasswordResetLink$users(this._res);

  TRes _res;

  call({
    Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink?
    generatePasswordResetLink,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink<
    TRes
  >
  get generatePasswordResetLink =>
      CopyWith$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink.stub(
        _res,
      );
}

class Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink
    implements Fragment$basicMutationReturnFields$$PasswordResetLinkReturn {
  Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'PasswordResetLinkReturn',
    this.passwordResetLink,
  });

  factory Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$passwordResetLink = json['passwordResetLink'];
    return Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      passwordResetLink: (l$passwordResetLink as String?),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final String? passwordResetLink;

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
    final l$passwordResetLink = passwordResetLink;
    _resultData['passwordResetLink'] = l$passwordResetLink;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$passwordResetLink = passwordResetLink;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$passwordResetLink,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink ||
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
    final l$passwordResetLink = passwordResetLink;
    final lOther$passwordResetLink = other.passwordResetLink;
    if (l$passwordResetLink != lOther$passwordResetLink) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink
    on Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink {
  CopyWith$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink<
    Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink
  >
  get copyWith =>
      CopyWith$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink<
  TRes
> {
  factory CopyWith$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink(
    Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink instance,
    TRes Function(
      Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink,
    )
    then,
  ) =
      _CopyWithImpl$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink;

  factory CopyWith$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? passwordResetLink,
  });
}

class _CopyWithImpl$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink<
  TRes
>
    implements
        CopyWith$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink<
          TRes
        > {
  _CopyWithImpl$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink(
    this._instance,
    this._then,
  );

  final Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink
  _instance;

  final TRes Function(
    Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? passwordResetLink = _undefined,
  }) => _then(
    Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
      passwordResetLink:
          passwordResetLink == _undefined
              ? _instance.passwordResetLink
              : (passwordResetLink as String?),
    ),
  );
}

class _CopyWithStubImpl$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink<
  TRes
>
    implements
        CopyWith$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink<
          TRes
        > {
  _CopyWithStubImpl$Mutation$GeneratePasswordResetLink$users$generatePasswordResetLink(
    this._res,
  );

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? passwordResetLink,
  }) => _res;
}

class Variables$Mutation$DeleteEmailPassword {
  factory Variables$Mutation$DeleteEmailPassword({
    required String username,
    required String uuid,
  }) => Variables$Mutation$DeleteEmailPassword._({
    r'username': username,
    r'uuid': uuid,
  });

  Variables$Mutation$DeleteEmailPassword._(this._$data);

  factory Variables$Mutation$DeleteEmailPassword.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$username = data['username'];
    result$data['username'] = (l$username as String);
    final l$uuid = data['uuid'];
    result$data['uuid'] = (l$uuid as String);
    return Variables$Mutation$DeleteEmailPassword._(result$data);
  }

  Map<String, dynamic> _$data;

  String get username => (_$data['username'] as String);

  String get uuid => (_$data['uuid'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$username = username;
    result$data['username'] = l$username;
    final l$uuid = uuid;
    result$data['uuid'] = l$uuid;
    return result$data;
  }

  CopyWith$Variables$Mutation$DeleteEmailPassword<
    Variables$Mutation$DeleteEmailPassword
  >
  get copyWith =>
      CopyWith$Variables$Mutation$DeleteEmailPassword(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$DeleteEmailPassword ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) {
      return false;
    }
    final l$uuid = uuid;
    final lOther$uuid = other.uuid;
    if (l$uuid != lOther$uuid) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$username = username;
    final l$uuid = uuid;
    return Object.hashAll([l$username, l$uuid]);
  }
}

abstract class CopyWith$Variables$Mutation$DeleteEmailPassword<TRes> {
  factory CopyWith$Variables$Mutation$DeleteEmailPassword(
    Variables$Mutation$DeleteEmailPassword instance,
    TRes Function(Variables$Mutation$DeleteEmailPassword) then,
  ) = _CopyWithImpl$Variables$Mutation$DeleteEmailPassword;

  factory CopyWith$Variables$Mutation$DeleteEmailPassword.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$DeleteEmailPassword;

  TRes call({String? username, String? uuid});
}

class _CopyWithImpl$Variables$Mutation$DeleteEmailPassword<TRes>
    implements CopyWith$Variables$Mutation$DeleteEmailPassword<TRes> {
  _CopyWithImpl$Variables$Mutation$DeleteEmailPassword(
    this._instance,
    this._then,
  );

  final Variables$Mutation$DeleteEmailPassword _instance;

  final TRes Function(Variables$Mutation$DeleteEmailPassword) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? username = _undefined, Object? uuid = _undefined}) =>
      _then(
        Variables$Mutation$DeleteEmailPassword._({
          ..._instance._$data,
          if (username != _undefined && username != null)
            'username': (username as String),
          if (uuid != _undefined && uuid != null) 'uuid': (uuid as String),
        }),
      );
}

class _CopyWithStubImpl$Variables$Mutation$DeleteEmailPassword<TRes>
    implements CopyWith$Variables$Mutation$DeleteEmailPassword<TRes> {
  _CopyWithStubImpl$Variables$Mutation$DeleteEmailPassword(this._res);

  TRes _res;

  call({String? username, String? uuid}) => _res;
}

class Mutation$DeleteEmailPassword {
  Mutation$DeleteEmailPassword({
    required this.emailPasswordMetadataMutations,
    this.$__typename = 'Mutation',
  });

  factory Mutation$DeleteEmailPassword.fromJson(Map<String, dynamic> json) {
    final l$emailPasswordMetadataMutations =
        json['emailPasswordMetadataMutations'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteEmailPassword(
      emailPasswordMetadataMutations:
          Mutation$DeleteEmailPassword$emailPasswordMetadataMutations.fromJson(
            (l$emailPasswordMetadataMutations as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$DeleteEmailPassword$emailPasswordMetadataMutations
  emailPasswordMetadataMutations;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$emailPasswordMetadataMutations = emailPasswordMetadataMutations;
    _resultData['emailPasswordMetadataMutations'] =
        l$emailPasswordMetadataMutations.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$emailPasswordMetadataMutations = emailPasswordMetadataMutations;
    final l$$__typename = $__typename;
    return Object.hashAll([l$emailPasswordMetadataMutations, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$DeleteEmailPassword ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$emailPasswordMetadataMutations = emailPasswordMetadataMutations;
    final lOther$emailPasswordMetadataMutations =
        other.emailPasswordMetadataMutations;
    if (l$emailPasswordMetadataMutations !=
        lOther$emailPasswordMetadataMutations) {
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

extension UtilityExtension$Mutation$DeleteEmailPassword
    on Mutation$DeleteEmailPassword {
  CopyWith$Mutation$DeleteEmailPassword<Mutation$DeleteEmailPassword>
  get copyWith => CopyWith$Mutation$DeleteEmailPassword(this, (i) => i);
}

abstract class CopyWith$Mutation$DeleteEmailPassword<TRes> {
  factory CopyWith$Mutation$DeleteEmailPassword(
    Mutation$DeleteEmailPassword instance,
    TRes Function(Mutation$DeleteEmailPassword) then,
  ) = _CopyWithImpl$Mutation$DeleteEmailPassword;

  factory CopyWith$Mutation$DeleteEmailPassword.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DeleteEmailPassword;

  TRes call({
    Mutation$DeleteEmailPassword$emailPasswordMetadataMutations?
    emailPasswordMetadataMutations,
    String? $__typename,
  });
  CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations<TRes>
  get emailPasswordMetadataMutations;
}

class _CopyWithImpl$Mutation$DeleteEmailPassword<TRes>
    implements CopyWith$Mutation$DeleteEmailPassword<TRes> {
  _CopyWithImpl$Mutation$DeleteEmailPassword(this._instance, this._then);

  final Mutation$DeleteEmailPassword _instance;

  final TRes Function(Mutation$DeleteEmailPassword) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? emailPasswordMetadataMutations = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$DeleteEmailPassword(
      emailPasswordMetadataMutations:
          emailPasswordMetadataMutations == _undefined ||
                  emailPasswordMetadataMutations == null
              ? _instance.emailPasswordMetadataMutations
              : (emailPasswordMetadataMutations
                  as Mutation$DeleteEmailPassword$emailPasswordMetadataMutations),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations<TRes>
  get emailPasswordMetadataMutations {
    final local$emailPasswordMetadataMutations =
        _instance.emailPasswordMetadataMutations;
    return CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations(
      local$emailPasswordMetadataMutations,
      (e) => call(emailPasswordMetadataMutations: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$DeleteEmailPassword<TRes>
    implements CopyWith$Mutation$DeleteEmailPassword<TRes> {
  _CopyWithStubImpl$Mutation$DeleteEmailPassword(this._res);

  TRes _res;

  call({
    Mutation$DeleteEmailPassword$emailPasswordMetadataMutations?
    emailPasswordMetadataMutations,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations<TRes>
  get emailPasswordMetadataMutations =>
      CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations.stub(
        _res,
      );
}

const documentNodeMutationDeleteEmailPassword = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteEmailPassword'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'username')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'uuid')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'emailPasswordMetadataMutations'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'deleteEmailPassword'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'username'),
                      value: VariableNode(name: NameNode(value: 'username')),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'uuid'),
                      value: VariableNode(name: NameNode(value: 'uuid')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'code'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'message'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'success'),
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
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
  ],
);
Mutation$DeleteEmailPassword _parserFn$Mutation$DeleteEmailPassword(
  Map<String, dynamic> data,
) => Mutation$DeleteEmailPassword.fromJson(data);
typedef OnMutationCompleted$Mutation$DeleteEmailPassword =
    FutureOr<void> Function(
      Map<String, dynamic>?,
      Mutation$DeleteEmailPassword?,
    );

class Options$Mutation$DeleteEmailPassword
    extends graphql.MutationOptions<Mutation$DeleteEmailPassword> {
  Options$Mutation$DeleteEmailPassword({
    String? operationName,
    required Variables$Mutation$DeleteEmailPassword variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DeleteEmailPassword? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$DeleteEmailPassword? onCompleted,
    graphql.OnMutationUpdate<Mutation$DeleteEmailPassword>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null
                       ? null
                       : _parserFn$Mutation$DeleteEmailPassword(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationDeleteEmailPassword,
         parserFn: _parserFn$Mutation$DeleteEmailPassword,
       );

  final OnMutationCompleted$Mutation$DeleteEmailPassword? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$DeleteEmailPassword
    extends graphql.WatchQueryOptions<Mutation$DeleteEmailPassword> {
  WatchOptions$Mutation$DeleteEmailPassword({
    String? operationName,
    required Variables$Mutation$DeleteEmailPassword variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DeleteEmailPassword? typedOptimisticResult,
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
         document: documentNodeMutationDeleteEmailPassword,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$DeleteEmailPassword,
       );
}

extension ClientExtension$Mutation$DeleteEmailPassword
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$DeleteEmailPassword>>
  mutate$DeleteEmailPassword(
    Options$Mutation$DeleteEmailPassword options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$DeleteEmailPassword>
  watchMutation$DeleteEmailPassword(
    WatchOptions$Mutation$DeleteEmailPassword options,
  ) => this.watchMutation(options);
}

class Mutation$DeleteEmailPassword$emailPasswordMetadataMutations {
  Mutation$DeleteEmailPassword$emailPasswordMetadataMutations({
    required this.deleteEmailPassword,
    this.$__typename = 'EmailPasswordsMetadataMutations',
  });

  factory Mutation$DeleteEmailPassword$emailPasswordMetadataMutations.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$deleteEmailPassword = json['deleteEmailPassword'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteEmailPassword$emailPasswordMetadataMutations(
      deleteEmailPassword:
          Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword.fromJson(
            (l$deleteEmailPassword as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword
  deleteEmailPassword;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteEmailPassword = deleteEmailPassword;
    _resultData['deleteEmailPassword'] = l$deleteEmailPassword.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteEmailPassword = deleteEmailPassword;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deleteEmailPassword, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$DeleteEmailPassword$emailPasswordMetadataMutations ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteEmailPassword = deleteEmailPassword;
    final lOther$deleteEmailPassword = other.deleteEmailPassword;
    if (l$deleteEmailPassword != lOther$deleteEmailPassword) {
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

extension UtilityExtension$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations
    on Mutation$DeleteEmailPassword$emailPasswordMetadataMutations {
  CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations<
    Mutation$DeleteEmailPassword$emailPasswordMetadataMutations
  >
  get copyWith =>
      CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations<
  TRes
> {
  factory CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations(
    Mutation$DeleteEmailPassword$emailPasswordMetadataMutations instance,
    TRes Function(Mutation$DeleteEmailPassword$emailPasswordMetadataMutations)
    then,
  ) = _CopyWithImpl$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations;

  factory CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations;

  TRes call({
    Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword?
    deleteEmailPassword,
    String? $__typename,
  });
  CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword<
    TRes
  >
  get deleteEmailPassword;
}

class _CopyWithImpl$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations<
  TRes
>
    implements
        CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations<
          TRes
        > {
  _CopyWithImpl$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations(
    this._instance,
    this._then,
  );

  final Mutation$DeleteEmailPassword$emailPasswordMetadataMutations _instance;

  final TRes Function(
    Mutation$DeleteEmailPassword$emailPasswordMetadataMutations,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? deleteEmailPassword = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$DeleteEmailPassword$emailPasswordMetadataMutations(
      deleteEmailPassword:
          deleteEmailPassword == _undefined || deleteEmailPassword == null
              ? _instance.deleteEmailPassword
              : (deleteEmailPassword
                  as Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword<
    TRes
  >
  get deleteEmailPassword {
    final local$deleteEmailPassword = _instance.deleteEmailPassword;
    return CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword(
      local$deleteEmailPassword,
      (e) => call(deleteEmailPassword: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations<
  TRes
>
    implements
        CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations<
          TRes
        > {
  _CopyWithStubImpl$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations(
    this._res,
  );

  TRes _res;

  call({
    Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword?
    deleteEmailPassword,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword<
    TRes
  >
  get deleteEmailPassword =>
      CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword.stub(
        _res,
      );
}

class Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword {
  Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword(
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
    return Object.hashAll([l$code, l$message, l$success, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword ||
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

extension UtilityExtension$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword
    on
        Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword {
  CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword<
    Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword
  >
  get copyWith =>
      CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword<
  TRes
> {
  factory CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword(
    Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword
    instance,
    TRes Function(
      Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword,
    )
    then,
  ) =
      _CopyWithImpl$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword;

  factory CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword<
  TRes
>
    implements
        CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword<
          TRes
        > {
  _CopyWithImpl$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword(
    this._instance,
    this._then,
  );

  final Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword
  _instance;

  final TRes Function(
    Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword<
  TRes
>
    implements
        CopyWith$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword<
          TRes
        > {
  _CopyWithStubImpl$Mutation$DeleteEmailPassword$emailPasswordMetadataMutations$deleteEmailPassword(
    this._res,
  );

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}
