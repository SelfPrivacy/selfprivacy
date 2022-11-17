import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/utils/scalars.dart';
import 'schema.graphql.dart';
import 'server_api.graphql.dart';
part 'disk_volumes.graphql.g.dart';

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
class Query$GetServerDiskVolumes {
  Query$GetServerDiskVolumes(
      {required this.storage, required this.$__typename});

  @override
  factory Query$GetServerDiskVolumes.fromJson(Map<String, dynamic> json) =>
      _$Query$GetServerDiskVolumesFromJson(json);

  final Query$GetServerDiskVolumes$storage storage;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetServerDiskVolumesToJson(this);
  int get hashCode {
    final l$storage = storage;
    final l$$__typename = $__typename;
    return Object.hashAll([l$storage, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetServerDiskVolumes) ||
        runtimeType != other.runtimeType) return false;
    final l$storage = storage;
    final lOther$storage = other.storage;
    if (l$storage != lOther$storage) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetServerDiskVolumes
    on Query$GetServerDiskVolumes {
  CopyWith$Query$GetServerDiskVolumes<Query$GetServerDiskVolumes>
      get copyWith => CopyWith$Query$GetServerDiskVolumes(this, (i) => i);
}

abstract class CopyWith$Query$GetServerDiskVolumes<TRes> {
  factory CopyWith$Query$GetServerDiskVolumes(
          Query$GetServerDiskVolumes instance,
          TRes Function(Query$GetServerDiskVolumes) then) =
      _CopyWithImpl$Query$GetServerDiskVolumes;

  factory CopyWith$Query$GetServerDiskVolumes.stub(TRes res) =
      _CopyWithStubImpl$Query$GetServerDiskVolumes;

  TRes call({Query$GetServerDiskVolumes$storage? storage, String? $__typename});
  CopyWith$Query$GetServerDiskVolumes$storage<TRes> get storage;
}

class _CopyWithImpl$Query$GetServerDiskVolumes<TRes>
    implements CopyWith$Query$GetServerDiskVolumes<TRes> {
  _CopyWithImpl$Query$GetServerDiskVolumes(this._instance, this._then);

  final Query$GetServerDiskVolumes _instance;

  final TRes Function(Query$GetServerDiskVolumes) _then;

  static const _undefined = {};

  TRes call({Object? storage = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$GetServerDiskVolumes(
          storage: storage == _undefined || storage == null
              ? _instance.storage
              : (storage as Query$GetServerDiskVolumes$storage),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Query$GetServerDiskVolumes$storage<TRes> get storage {
    final local$storage = _instance.storage;
    return CopyWith$Query$GetServerDiskVolumes$storage(
        local$storage, (e) => call(storage: e));
  }
}

class _CopyWithStubImpl$Query$GetServerDiskVolumes<TRes>
    implements CopyWith$Query$GetServerDiskVolumes<TRes> {
  _CopyWithStubImpl$Query$GetServerDiskVolumes(this._res);

  TRes _res;

  call({Query$GetServerDiskVolumes$storage? storage, String? $__typename}) =>
      _res;
  CopyWith$Query$GetServerDiskVolumes$storage<TRes> get storage =>
      CopyWith$Query$GetServerDiskVolumes$storage.stub(_res);
}

const documentNodeQueryGetServerDiskVolumes = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetServerDiskVolumes'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'storage'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'volumes'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'freeSpace'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'model'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'root'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'serial'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'totalSpace'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'type'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'usages'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'title'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'usedSpace'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          InlineFragmentNode(
                              typeCondition: TypeConditionNode(
                                  on: NamedTypeNode(
                                      name: NameNode(
                                          value: 'ServiceStorageUsage'),
                                      isNonNull: false)),
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'service'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'isMovable'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'displayName'),
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
                              ]))
                        ])),
                    FieldNode(
                        name: NameNode(value: 'usedSpace'),
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
Query$GetServerDiskVolumes _parserFn$Query$GetServerDiskVolumes(
        Map<String, dynamic> data) =>
    Query$GetServerDiskVolumes.fromJson(data);

class Options$Query$GetServerDiskVolumes
    extends graphql.QueryOptions<Query$GetServerDiskVolumes> {
  Options$Query$GetServerDiskVolumes(
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
            document: documentNodeQueryGetServerDiskVolumes,
            parserFn: _parserFn$Query$GetServerDiskVolumes);
}

class WatchOptions$Query$GetServerDiskVolumes
    extends graphql.WatchQueryOptions<Query$GetServerDiskVolumes> {
  WatchOptions$Query$GetServerDiskVolumes(
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
            document: documentNodeQueryGetServerDiskVolumes,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Query$GetServerDiskVolumes);
}

class FetchMoreOptions$Query$GetServerDiskVolumes
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetServerDiskVolumes(
      {required graphql.UpdateQuery updateQuery})
      : super(
            updateQuery: updateQuery,
            document: documentNodeQueryGetServerDiskVolumes);
}

extension ClientExtension$Query$GetServerDiskVolumes on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetServerDiskVolumes>>
      query$GetServerDiskVolumes(
              [Options$Query$GetServerDiskVolumes? options]) async =>
          await this.query(options ?? Options$Query$GetServerDiskVolumes());
  graphql.ObservableQuery<Query$GetServerDiskVolumes>
      watchQuery$GetServerDiskVolumes(
              [WatchOptions$Query$GetServerDiskVolumes? options]) =>
          this.watchQuery(options ?? WatchOptions$Query$GetServerDiskVolumes());
  void writeQuery$GetServerDiskVolumes(
          {required Query$GetServerDiskVolumes data, bool broadcast = true}) =>
      this.writeQuery(
          graphql.Request(
              operation: graphql.Operation(
                  document: documentNodeQueryGetServerDiskVolumes)),
          data: data.toJson(),
          broadcast: broadcast);
  Query$GetServerDiskVolumes? readQuery$GetServerDiskVolumes(
      {bool optimistic = true}) {
    final result = this.readQuery(
        graphql.Request(
            operation: graphql.Operation(
                document: documentNodeQueryGetServerDiskVolumes)),
        optimistic: optimistic);
    return result == null ? null : Query$GetServerDiskVolumes.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Query$GetServerDiskVolumes$storage {
  Query$GetServerDiskVolumes$storage(
      {required this.volumes, required this.$__typename});

  @override
  factory Query$GetServerDiskVolumes$storage.fromJson(
          Map<String, dynamic> json) =>
      _$Query$GetServerDiskVolumes$storageFromJson(json);

  final List<Query$GetServerDiskVolumes$storage$volumes> volumes;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$GetServerDiskVolumes$storageToJson(this);
  int get hashCode {
    final l$volumes = volumes;
    final l$$__typename = $__typename;
    return Object.hashAll(
        [Object.hashAll(l$volumes.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetServerDiskVolumes$storage) ||
        runtimeType != other.runtimeType) return false;
    final l$volumes = volumes;
    final lOther$volumes = other.volumes;
    if (l$volumes.length != lOther$volumes.length) return false;
    for (int i = 0; i < l$volumes.length; i++) {
      final l$volumes$entry = l$volumes[i];
      final lOther$volumes$entry = lOther$volumes[i];
      if (l$volumes$entry != lOther$volumes$entry) return false;
    }

    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetServerDiskVolumes$storage
    on Query$GetServerDiskVolumes$storage {
  CopyWith$Query$GetServerDiskVolumes$storage<
          Query$GetServerDiskVolumes$storage>
      get copyWith =>
          CopyWith$Query$GetServerDiskVolumes$storage(this, (i) => i);
}

abstract class CopyWith$Query$GetServerDiskVolumes$storage<TRes> {
  factory CopyWith$Query$GetServerDiskVolumes$storage(
          Query$GetServerDiskVolumes$storage instance,
          TRes Function(Query$GetServerDiskVolumes$storage) then) =
      _CopyWithImpl$Query$GetServerDiskVolumes$storage;

  factory CopyWith$Query$GetServerDiskVolumes$storage.stub(TRes res) =
      _CopyWithStubImpl$Query$GetServerDiskVolumes$storage;

  TRes call(
      {List<Query$GetServerDiskVolumes$storage$volumes>? volumes,
      String? $__typename});
  TRes volumes(
      Iterable<Query$GetServerDiskVolumes$storage$volumes> Function(
              Iterable<
                  CopyWith$Query$GetServerDiskVolumes$storage$volumes<
                      Query$GetServerDiskVolumes$storage$volumes>>)
          _fn);
}

class _CopyWithImpl$Query$GetServerDiskVolumes$storage<TRes>
    implements CopyWith$Query$GetServerDiskVolumes$storage<TRes> {
  _CopyWithImpl$Query$GetServerDiskVolumes$storage(this._instance, this._then);

  final Query$GetServerDiskVolumes$storage _instance;

  final TRes Function(Query$GetServerDiskVolumes$storage) _then;

  static const _undefined = {};

  TRes call({Object? volumes = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$GetServerDiskVolumes$storage(
          volumes: volumes == _undefined || volumes == null
              ? _instance.volumes
              : (volumes as List<Query$GetServerDiskVolumes$storage$volumes>),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  TRes volumes(
          Iterable<Query$GetServerDiskVolumes$storage$volumes> Function(
                  Iterable<
                      CopyWith$Query$GetServerDiskVolumes$storage$volumes<
                          Query$GetServerDiskVolumes$storage$volumes>>)
              _fn) =>
      call(
          volumes: _fn(_instance.volumes.map((e) =>
              CopyWith$Query$GetServerDiskVolumes$storage$volumes(
                  e, (i) => i))).toList());
}

class _CopyWithStubImpl$Query$GetServerDiskVolumes$storage<TRes>
    implements CopyWith$Query$GetServerDiskVolumes$storage<TRes> {
  _CopyWithStubImpl$Query$GetServerDiskVolumes$storage(this._res);

  TRes _res;

  call(
          {List<Query$GetServerDiskVolumes$storage$volumes>? volumes,
          String? $__typename}) =>
      _res;
  volumes(_fn) => _res;
}

@JsonSerializable(explicitToJson: true)
class Query$GetServerDiskVolumes$storage$volumes {
  Query$GetServerDiskVolumes$storage$volumes(
      {required this.freeSpace,
      this.model,
      required this.name,
      required this.root,
      this.serial,
      required this.totalSpace,
      required this.type,
      required this.usages,
      required this.usedSpace,
      required this.$__typename});

  @override
  factory Query$GetServerDiskVolumes$storage$volumes.fromJson(
          Map<String, dynamic> json) =>
      _$Query$GetServerDiskVolumes$storage$volumesFromJson(json);

  final String freeSpace;

  final String? model;

  final String name;

  final bool root;

  final String? serial;

  final String totalSpace;

  final String type;

  final List<Query$GetServerDiskVolumes$storage$volumes$usages> usages;

  final String usedSpace;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$GetServerDiskVolumes$storage$volumesToJson(this);
  int get hashCode {
    final l$freeSpace = freeSpace;
    final l$model = model;
    final l$name = name;
    final l$root = root;
    final l$serial = serial;
    final l$totalSpace = totalSpace;
    final l$type = type;
    final l$usages = usages;
    final l$usedSpace = usedSpace;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$freeSpace,
      l$model,
      l$name,
      l$root,
      l$serial,
      l$totalSpace,
      l$type,
      Object.hashAll(l$usages.map((v) => v)),
      l$usedSpace,
      l$$__typename
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetServerDiskVolumes$storage$volumes) ||
        runtimeType != other.runtimeType) return false;
    final l$freeSpace = freeSpace;
    final lOther$freeSpace = other.freeSpace;
    if (l$freeSpace != lOther$freeSpace) return false;
    final l$model = model;
    final lOther$model = other.model;
    if (l$model != lOther$model) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    final l$root = root;
    final lOther$root = other.root;
    if (l$root != lOther$root) return false;
    final l$serial = serial;
    final lOther$serial = other.serial;
    if (l$serial != lOther$serial) return false;
    final l$totalSpace = totalSpace;
    final lOther$totalSpace = other.totalSpace;
    if (l$totalSpace != lOther$totalSpace) return false;
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) return false;
    final l$usages = usages;
    final lOther$usages = other.usages;
    if (l$usages.length != lOther$usages.length) return false;
    for (int i = 0; i < l$usages.length; i++) {
      final l$usages$entry = l$usages[i];
      final lOther$usages$entry = lOther$usages[i];
      if (l$usages$entry != lOther$usages$entry) return false;
    }

    final l$usedSpace = usedSpace;
    final lOther$usedSpace = other.usedSpace;
    if (l$usedSpace != lOther$usedSpace) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetServerDiskVolumes$storage$volumes
    on Query$GetServerDiskVolumes$storage$volumes {
  CopyWith$Query$GetServerDiskVolumes$storage$volumes<
          Query$GetServerDiskVolumes$storage$volumes>
      get copyWith =>
          CopyWith$Query$GetServerDiskVolumes$storage$volumes(this, (i) => i);
}

abstract class CopyWith$Query$GetServerDiskVolumes$storage$volumes<TRes> {
  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes(
          Query$GetServerDiskVolumes$storage$volumes instance,
          TRes Function(Query$GetServerDiskVolumes$storage$volumes) then) =
      _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes;

  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes.stub(TRes res) =
      _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes;

  TRes call(
      {String? freeSpace,
      String? model,
      String? name,
      bool? root,
      String? serial,
      String? totalSpace,
      String? type,
      List<Query$GetServerDiskVolumes$storage$volumes$usages>? usages,
      String? usedSpace,
      String? $__typename});
  TRes usages(
      Iterable<Query$GetServerDiskVolumes$storage$volumes$usages> Function(
              Iterable<
                  CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages<
                      Query$GetServerDiskVolumes$storage$volumes$usages>>)
          _fn);
}

class _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes<TRes>
    implements CopyWith$Query$GetServerDiskVolumes$storage$volumes<TRes> {
  _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes(
      this._instance, this._then);

  final Query$GetServerDiskVolumes$storage$volumes _instance;

  final TRes Function(Query$GetServerDiskVolumes$storage$volumes) _then;

  static const _undefined = {};

  TRes call(
          {Object? freeSpace = _undefined,
          Object? model = _undefined,
          Object? name = _undefined,
          Object? root = _undefined,
          Object? serial = _undefined,
          Object? totalSpace = _undefined,
          Object? type = _undefined,
          Object? usages = _undefined,
          Object? usedSpace = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$GetServerDiskVolumes$storage$volumes(
          freeSpace: freeSpace == _undefined || freeSpace == null
              ? _instance.freeSpace
              : (freeSpace as String),
          model: model == _undefined ? _instance.model : (model as String?),
          name: name == _undefined || name == null
              ? _instance.name
              : (name as String),
          root: root == _undefined || root == null
              ? _instance.root
              : (root as bool),
          serial: serial == _undefined ? _instance.serial : (serial as String?),
          totalSpace: totalSpace == _undefined || totalSpace == null
              ? _instance.totalSpace
              : (totalSpace as String),
          type: type == _undefined || type == null
              ? _instance.type
              : (type as String),
          usages: usages == _undefined || usages == null
              ? _instance.usages
              : (usages
                  as List<Query$GetServerDiskVolumes$storage$volumes$usages>),
          usedSpace: usedSpace == _undefined || usedSpace == null
              ? _instance.usedSpace
              : (usedSpace as String),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  TRes usages(
          Iterable<Query$GetServerDiskVolumes$storage$volumes$usages> Function(
                  Iterable<
                      CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages<
                          Query$GetServerDiskVolumes$storage$volumes$usages>>)
              _fn) =>
      call(
          usages: _fn(_instance.usages.map((e) =>
              CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages(
                  e, (i) => i))).toList());
}

class _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes<TRes>
    implements CopyWith$Query$GetServerDiskVolumes$storage$volumes<TRes> {
  _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes(this._res);

  TRes _res;

  call(
          {String? freeSpace,
          String? model,
          String? name,
          bool? root,
          String? serial,
          String? totalSpace,
          String? type,
          List<Query$GetServerDiskVolumes$storage$volumes$usages>? usages,
          String? usedSpace,
          String? $__typename}) =>
      _res;
  usages(_fn) => _res;
}

@JsonSerializable(explicitToJson: true)
class Query$GetServerDiskVolumes$storage$volumes$usages {
  Query$GetServerDiskVolumes$storage$volumes$usages(
      {required this.title,
      required this.usedSpace,
      required this.$__typename});

  @override
  factory Query$GetServerDiskVolumes$storage$volumes$usages.fromJson(
      Map<String, dynamic> json) {
    switch (json["__typename"] as String) {
      case "ServiceStorageUsage":
        return Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage
            .fromJson(json);
      default:
        return _$Query$GetServerDiskVolumes$storage$volumes$usagesFromJson(
            json);
    }
  }

  final String title;

  final String usedSpace;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$GetServerDiskVolumes$storage$volumes$usagesToJson(this);
  int get hashCode {
    final l$title = title;
    final l$usedSpace = usedSpace;
    final l$$__typename = $__typename;
    return Object.hashAll([l$title, l$usedSpace, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetServerDiskVolumes$storage$volumes$usages) ||
        runtimeType != other.runtimeType) return false;
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) return false;
    final l$usedSpace = usedSpace;
    final lOther$usedSpace = other.usedSpace;
    if (l$usedSpace != lOther$usedSpace) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetServerDiskVolumes$storage$volumes$usages
    on Query$GetServerDiskVolumes$storage$volumes$usages {
  CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages<
          Query$GetServerDiskVolumes$storage$volumes$usages>
      get copyWith =>
          CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages(
              this, (i) => i);
}

abstract class CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages<
    TRes> {
  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages(
          Query$GetServerDiskVolumes$storage$volumes$usages instance,
          TRes Function(Query$GetServerDiskVolumes$storage$volumes$usages)
              then) =
      _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages;

  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages;

  TRes call({String? title, String? usedSpace, String? $__typename});
}

class _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages<TRes>
    implements
        CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages<TRes> {
  _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages(
      this._instance, this._then);

  final Query$GetServerDiskVolumes$storage$volumes$usages _instance;

  final TRes Function(Query$GetServerDiskVolumes$storage$volumes$usages) _then;

  static const _undefined = {};

  TRes call(
          {Object? title = _undefined,
          Object? usedSpace = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$GetServerDiskVolumes$storage$volumes$usages(
          title: title == _undefined || title == null
              ? _instance.title
              : (title as String),
          usedSpace: usedSpace == _undefined || usedSpace == null
              ? _instance.usedSpace
              : (usedSpace as String),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
}

class _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages<TRes>
    implements
        CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages<TRes> {
  _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages(
      this._res);

  TRes _res;

  call({String? title, String? usedSpace, String? $__typename}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage
    implements Query$GetServerDiskVolumes$storage$volumes$usages {
  Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage(
      {required this.title,
      required this.usedSpace,
      required this.$__typename,
      this.service});

  @override
  factory Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage.fromJson(
          Map<String, dynamic> json) =>
      _$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsageFromJson(
          json);

  final String title;

  final String usedSpace;

  @JsonKey(name: '__typename')
  final String $__typename;

  final Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service?
      service;

  Map<String, dynamic> toJson() =>
      _$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsageToJson(
          this);
  int get hashCode {
    final l$title = title;
    final l$usedSpace = usedSpace;
    final l$$__typename = $__typename;
    final l$service = service;
    return Object.hashAll([l$title, l$usedSpace, l$$__typename, l$service]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other
            is Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage) ||
        runtimeType != other.runtimeType) return false;
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) return false;
    final l$usedSpace = usedSpace;
    final lOther$usedSpace = other.usedSpace;
    if (l$usedSpace != lOther$usedSpace) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    final l$service = service;
    final lOther$service = other.service;
    if (l$service != lOther$service) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage
    on Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage {
  CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage<
          Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage>
      get copyWith =>
          CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage(
              this, (i) => i);
}

abstract class CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage<
    TRes> {
  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage(
          Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage
              instance,
          TRes Function(
                  Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage)
              then) =
      _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage;

  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage;

  TRes call(
      {String? title,
      String? usedSpace,
      String? $__typename,
      Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service?
          service});
  CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
      TRes> get service;
}

class _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage<
        TRes>
    implements
        CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage<
            TRes> {
  _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage(
      this._instance, this._then);

  final Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage
      _instance;

  final TRes Function(
          Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage)
      _then;

  static const _undefined = {};

  TRes call(
          {Object? title = _undefined,
          Object? usedSpace = _undefined,
          Object? $__typename = _undefined,
          Object? service = _undefined}) =>
      _then(Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage(
          title: title == _undefined || title == null
              ? _instance.title
              : (title as String),
          usedSpace: usedSpace == _undefined || usedSpace == null
              ? _instance.usedSpace
              : (usedSpace as String),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
          service: service == _undefined
              ? _instance.service
              : (service
                  as Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service?)));
  CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
      TRes> get service {
    final local$service = _instance.service;
    return local$service == null
        ? CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service
            .stub(_then(_instance))
        : CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
            local$service, (e) => call(service: e));
  }
}

class _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage<
        TRes>
    implements
        CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage<
            TRes> {
  _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage(
      this._res);

  TRes _res;

  call(
          {String? title,
          String? usedSpace,
          String? $__typename,
          Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service?
              service}) =>
      _res;
  CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
          TRes>
      get service =>
          CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service
              .stub(_res);
}

@JsonSerializable(explicitToJson: true)
class Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service {
  Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
      {required this.id,
      required this.isMovable,
      required this.displayName,
      required this.$__typename});

  @override
  factory Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service.fromJson(
          Map<String, dynamic> json) =>
      _$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$serviceFromJson(
          json);

  final String id;

  final bool isMovable;

  final String displayName;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$serviceToJson(
          this);
  int get hashCode {
    final l$id = id;
    final l$isMovable = isMovable;
    final l$displayName = displayName;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$isMovable, l$displayName, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other
            is Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service) ||
        runtimeType != other.runtimeType) return false;
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) return false;
    final l$isMovable = isMovable;
    final lOther$isMovable = other.isMovable;
    if (l$isMovable != lOther$isMovable) return false;
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service
    on Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service {
  CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
          Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service>
      get copyWith =>
          CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
              this, (i) => i);
}

abstract class CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
    TRes> {
  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
          Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service
              instance,
          TRes Function(
                  Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service)
              then) =
      _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service;

  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service;

  TRes call(
      {String? id, bool? isMovable, String? displayName, String? $__typename});
}

class _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
        TRes>
    implements
        CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
            TRes> {
  _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
      this._instance, this._then);

  final Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service
      _instance;

  final TRes Function(
          Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service)
      _then;

  static const _undefined = {};

  TRes call(
          {Object? id = _undefined,
          Object? isMovable = _undefined,
          Object? displayName = _undefined,
          Object? $__typename = _undefined}) =>
      _then(
          Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
              id: id == _undefined || id == null
                  ? _instance.id
                  : (id as String),
              isMovable: isMovable == _undefined || isMovable == null
                  ? _instance.isMovable
                  : (isMovable as bool),
              displayName: displayName == _undefined || displayName == null
                  ? _instance.displayName
                  : (displayName as String),
              $__typename: $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String)));
}

class _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
        TRes>
    implements
        CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
            TRes> {
  _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
      this._res);

  TRes _res;

  call(
          {String? id,
          bool? isMovable,
          String? displayName,
          String? $__typename}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$MountVolume {
  Variables$Mutation$MountVolume({required this.name});

  @override
  factory Variables$Mutation$MountVolume.fromJson(Map<String, dynamic> json) =>
      _$Variables$Mutation$MountVolumeFromJson(json);

  final String name;

  Map<String, dynamic> toJson() => _$Variables$Mutation$MountVolumeToJson(this);
  int get hashCode {
    final l$name = name;
    return Object.hashAll([l$name]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$MountVolume) ||
        runtimeType != other.runtimeType) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    return true;
  }

  CopyWith$Variables$Mutation$MountVolume<Variables$Mutation$MountVolume>
      get copyWith => CopyWith$Variables$Mutation$MountVolume(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$MountVolume<TRes> {
  factory CopyWith$Variables$Mutation$MountVolume(
          Variables$Mutation$MountVolume instance,
          TRes Function(Variables$Mutation$MountVolume) then) =
      _CopyWithImpl$Variables$Mutation$MountVolume;

  factory CopyWith$Variables$Mutation$MountVolume.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$MountVolume;

  TRes call({String? name});
}

class _CopyWithImpl$Variables$Mutation$MountVolume<TRes>
    implements CopyWith$Variables$Mutation$MountVolume<TRes> {
  _CopyWithImpl$Variables$Mutation$MountVolume(this._instance, this._then);

  final Variables$Mutation$MountVolume _instance;

  final TRes Function(Variables$Mutation$MountVolume) _then;

  static const _undefined = {};

  TRes call({Object? name = _undefined}) =>
      _then(Variables$Mutation$MountVolume(
          name: name == _undefined || name == null
              ? _instance.name
              : (name as String)));
}

class _CopyWithStubImpl$Variables$Mutation$MountVolume<TRes>
    implements CopyWith$Variables$Mutation$MountVolume<TRes> {
  _CopyWithStubImpl$Variables$Mutation$MountVolume(this._res);

  TRes _res;

  call({String? name}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Mutation$MountVolume {
  Mutation$MountVolume({required this.mountVolume, required this.$__typename});

  @override
  factory Mutation$MountVolume.fromJson(Map<String, dynamic> json) =>
      _$Mutation$MountVolumeFromJson(json);

  final Mutation$MountVolume$mountVolume mountVolume;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$MountVolumeToJson(this);
  int get hashCode {
    final l$mountVolume = mountVolume;
    final l$$__typename = $__typename;
    return Object.hashAll([l$mountVolume, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$MountVolume) || runtimeType != other.runtimeType)
      return false;
    final l$mountVolume = mountVolume;
    final lOther$mountVolume = other.mountVolume;
    if (l$mountVolume != lOther$mountVolume) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$MountVolume on Mutation$MountVolume {
  CopyWith$Mutation$MountVolume<Mutation$MountVolume> get copyWith =>
      CopyWith$Mutation$MountVolume(this, (i) => i);
}

abstract class CopyWith$Mutation$MountVolume<TRes> {
  factory CopyWith$Mutation$MountVolume(Mutation$MountVolume instance,
          TRes Function(Mutation$MountVolume) then) =
      _CopyWithImpl$Mutation$MountVolume;

  factory CopyWith$Mutation$MountVolume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MountVolume;

  TRes call(
      {Mutation$MountVolume$mountVolume? mountVolume, String? $__typename});
  CopyWith$Mutation$MountVolume$mountVolume<TRes> get mountVolume;
}

class _CopyWithImpl$Mutation$MountVolume<TRes>
    implements CopyWith$Mutation$MountVolume<TRes> {
  _CopyWithImpl$Mutation$MountVolume(this._instance, this._then);

  final Mutation$MountVolume _instance;

  final TRes Function(Mutation$MountVolume) _then;

  static const _undefined = {};

  TRes call(
          {Object? mountVolume = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$MountVolume(
          mountVolume: mountVolume == _undefined || mountVolume == null
              ? _instance.mountVolume
              : (mountVolume as Mutation$MountVolume$mountVolume),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$MountVolume$mountVolume<TRes> get mountVolume {
    final local$mountVolume = _instance.mountVolume;
    return CopyWith$Mutation$MountVolume$mountVolume(
        local$mountVolume, (e) => call(mountVolume: e));
  }
}

class _CopyWithStubImpl$Mutation$MountVolume<TRes>
    implements CopyWith$Mutation$MountVolume<TRes> {
  _CopyWithStubImpl$Mutation$MountVolume(this._res);

  TRes _res;

  call({Mutation$MountVolume$mountVolume? mountVolume, String? $__typename}) =>
      _res;
  CopyWith$Mutation$MountVolume$mountVolume<TRes> get mountVolume =>
      CopyWith$Mutation$MountVolume$mountVolume.stub(_res);
}

const documentNodeMutationMountVolume = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'MountVolume'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'name')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'mountVolume'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'name'),
                  value: VariableNode(name: NameNode(value: 'name')))
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
Mutation$MountVolume _parserFn$Mutation$MountVolume(
        Map<String, dynamic> data) =>
    Mutation$MountVolume.fromJson(data);
typedef OnMutationCompleted$Mutation$MountVolume = FutureOr<void> Function(
    dynamic, Mutation$MountVolume?);

class Options$Mutation$MountVolume
    extends graphql.MutationOptions<Mutation$MountVolume> {
  Options$Mutation$MountVolume(
      {String? operationName,
      required Variables$Mutation$MountVolume variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$MountVolume? onCompleted,
      graphql.OnMutationUpdate<Mutation$MountVolume>? update,
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
                    data == null ? null : _parserFn$Mutation$MountVolume(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationMountVolume,
            parserFn: _parserFn$Mutation$MountVolume);

  final OnMutationCompleted$Mutation$MountVolume? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$MountVolume
    extends graphql.WatchQueryOptions<Mutation$MountVolume> {
  WatchOptions$Mutation$MountVolume(
      {String? operationName,
      required Variables$Mutation$MountVolume variables,
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
            document: documentNodeMutationMountVolume,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$MountVolume);
}

extension ClientExtension$Mutation$MountVolume on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$MountVolume>> mutate$MountVolume(
          Options$Mutation$MountVolume options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$MountVolume> watchMutation$MountVolume(
          WatchOptions$Mutation$MountVolume options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$MountVolume$mountVolume
    implements Fragment$basicMutationReturnFields {
  Mutation$MountVolume$mountVolume(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$MountVolume$mountVolume.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$MountVolume$mountVolumeFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$MountVolume$mountVolumeToJson(this);
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
    if (!(other is Mutation$MountVolume$mountVolume) ||
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

extension UtilityExtension$Mutation$MountVolume$mountVolume
    on Mutation$MountVolume$mountVolume {
  CopyWith$Mutation$MountVolume$mountVolume<Mutation$MountVolume$mountVolume>
      get copyWith => CopyWith$Mutation$MountVolume$mountVolume(this, (i) => i);
}

abstract class CopyWith$Mutation$MountVolume$mountVolume<TRes> {
  factory CopyWith$Mutation$MountVolume$mountVolume(
          Mutation$MountVolume$mountVolume instance,
          TRes Function(Mutation$MountVolume$mountVolume) then) =
      _CopyWithImpl$Mutation$MountVolume$mountVolume;

  factory CopyWith$Mutation$MountVolume$mountVolume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MountVolume$mountVolume;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$MountVolume$mountVolume<TRes>
    implements CopyWith$Mutation$MountVolume$mountVolume<TRes> {
  _CopyWithImpl$Mutation$MountVolume$mountVolume(this._instance, this._then);

  final Mutation$MountVolume$mountVolume _instance;

  final TRes Function(Mutation$MountVolume$mountVolume) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$MountVolume$mountVolume(
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

class _CopyWithStubImpl$Mutation$MountVolume$mountVolume<TRes>
    implements CopyWith$Mutation$MountVolume$mountVolume<TRes> {
  _CopyWithStubImpl$Mutation$MountVolume$mountVolume(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$ResizeVolume {
  Variables$Mutation$ResizeVolume({required this.name});

  @override
  factory Variables$Mutation$ResizeVolume.fromJson(Map<String, dynamic> json) =>
      _$Variables$Mutation$ResizeVolumeFromJson(json);

  final String name;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$ResizeVolumeToJson(this);
  int get hashCode {
    final l$name = name;
    return Object.hashAll([l$name]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$ResizeVolume) ||
        runtimeType != other.runtimeType) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    return true;
  }

  CopyWith$Variables$Mutation$ResizeVolume<Variables$Mutation$ResizeVolume>
      get copyWith => CopyWith$Variables$Mutation$ResizeVolume(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$ResizeVolume<TRes> {
  factory CopyWith$Variables$Mutation$ResizeVolume(
          Variables$Mutation$ResizeVolume instance,
          TRes Function(Variables$Mutation$ResizeVolume) then) =
      _CopyWithImpl$Variables$Mutation$ResizeVolume;

  factory CopyWith$Variables$Mutation$ResizeVolume.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ResizeVolume;

  TRes call({String? name});
}

class _CopyWithImpl$Variables$Mutation$ResizeVolume<TRes>
    implements CopyWith$Variables$Mutation$ResizeVolume<TRes> {
  _CopyWithImpl$Variables$Mutation$ResizeVolume(this._instance, this._then);

  final Variables$Mutation$ResizeVolume _instance;

  final TRes Function(Variables$Mutation$ResizeVolume) _then;

  static const _undefined = {};

  TRes call({Object? name = _undefined}) =>
      _then(Variables$Mutation$ResizeVolume(
          name: name == _undefined || name == null
              ? _instance.name
              : (name as String)));
}

class _CopyWithStubImpl$Variables$Mutation$ResizeVolume<TRes>
    implements CopyWith$Variables$Mutation$ResizeVolume<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ResizeVolume(this._res);

  TRes _res;

  call({String? name}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Mutation$ResizeVolume {
  Mutation$ResizeVolume(
      {required this.resizeVolume, required this.$__typename});

  @override
  factory Mutation$ResizeVolume.fromJson(Map<String, dynamic> json) =>
      _$Mutation$ResizeVolumeFromJson(json);

  final Mutation$ResizeVolume$resizeVolume resizeVolume;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$ResizeVolumeToJson(this);
  int get hashCode {
    final l$resizeVolume = resizeVolume;
    final l$$__typename = $__typename;
    return Object.hashAll([l$resizeVolume, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$ResizeVolume) || runtimeType != other.runtimeType)
      return false;
    final l$resizeVolume = resizeVolume;
    final lOther$resizeVolume = other.resizeVolume;
    if (l$resizeVolume != lOther$resizeVolume) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$ResizeVolume on Mutation$ResizeVolume {
  CopyWith$Mutation$ResizeVolume<Mutation$ResizeVolume> get copyWith =>
      CopyWith$Mutation$ResizeVolume(this, (i) => i);
}

abstract class CopyWith$Mutation$ResizeVolume<TRes> {
  factory CopyWith$Mutation$ResizeVolume(Mutation$ResizeVolume instance,
          TRes Function(Mutation$ResizeVolume) then) =
      _CopyWithImpl$Mutation$ResizeVolume;

  factory CopyWith$Mutation$ResizeVolume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ResizeVolume;

  TRes call(
      {Mutation$ResizeVolume$resizeVolume? resizeVolume, String? $__typename});
  CopyWith$Mutation$ResizeVolume$resizeVolume<TRes> get resizeVolume;
}

class _CopyWithImpl$Mutation$ResizeVolume<TRes>
    implements CopyWith$Mutation$ResizeVolume<TRes> {
  _CopyWithImpl$Mutation$ResizeVolume(this._instance, this._then);

  final Mutation$ResizeVolume _instance;

  final TRes Function(Mutation$ResizeVolume) _then;

  static const _undefined = {};

  TRes call(
          {Object? resizeVolume = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$ResizeVolume(
          resizeVolume: resizeVolume == _undefined || resizeVolume == null
              ? _instance.resizeVolume
              : (resizeVolume as Mutation$ResizeVolume$resizeVolume),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$ResizeVolume$resizeVolume<TRes> get resizeVolume {
    final local$resizeVolume = _instance.resizeVolume;
    return CopyWith$Mutation$ResizeVolume$resizeVolume(
        local$resizeVolume, (e) => call(resizeVolume: e));
  }
}

class _CopyWithStubImpl$Mutation$ResizeVolume<TRes>
    implements CopyWith$Mutation$ResizeVolume<TRes> {
  _CopyWithStubImpl$Mutation$ResizeVolume(this._res);

  TRes _res;

  call(
          {Mutation$ResizeVolume$resizeVolume? resizeVolume,
          String? $__typename}) =>
      _res;
  CopyWith$Mutation$ResizeVolume$resizeVolume<TRes> get resizeVolume =>
      CopyWith$Mutation$ResizeVolume$resizeVolume.stub(_res);
}

const documentNodeMutationResizeVolume = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ResizeVolume'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'name')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'resizeVolume'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'name'),
                  value: VariableNode(name: NameNode(value: 'name')))
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
Mutation$ResizeVolume _parserFn$Mutation$ResizeVolume(
        Map<String, dynamic> data) =>
    Mutation$ResizeVolume.fromJson(data);
typedef OnMutationCompleted$Mutation$ResizeVolume = FutureOr<void> Function(
    dynamic, Mutation$ResizeVolume?);

class Options$Mutation$ResizeVolume
    extends graphql.MutationOptions<Mutation$ResizeVolume> {
  Options$Mutation$ResizeVolume(
      {String? operationName,
      required Variables$Mutation$ResizeVolume variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$ResizeVolume? onCompleted,
      graphql.OnMutationUpdate<Mutation$ResizeVolume>? update,
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
                        : _parserFn$Mutation$ResizeVolume(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationResizeVolume,
            parserFn: _parserFn$Mutation$ResizeVolume);

  final OnMutationCompleted$Mutation$ResizeVolume? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$ResizeVolume
    extends graphql.WatchQueryOptions<Mutation$ResizeVolume> {
  WatchOptions$Mutation$ResizeVolume(
      {String? operationName,
      required Variables$Mutation$ResizeVolume variables,
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
            document: documentNodeMutationResizeVolume,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$ResizeVolume);
}

extension ClientExtension$Mutation$ResizeVolume on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ResizeVolume>> mutate$ResizeVolume(
          Options$Mutation$ResizeVolume options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$ResizeVolume> watchMutation$ResizeVolume(
          WatchOptions$Mutation$ResizeVolume options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$ResizeVolume$resizeVolume
    implements Fragment$basicMutationReturnFields {
  Mutation$ResizeVolume$resizeVolume(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$ResizeVolume$resizeVolume.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$ResizeVolume$resizeVolumeFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$ResizeVolume$resizeVolumeToJson(this);
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
    if (!(other is Mutation$ResizeVolume$resizeVolume) ||
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

extension UtilityExtension$Mutation$ResizeVolume$resizeVolume
    on Mutation$ResizeVolume$resizeVolume {
  CopyWith$Mutation$ResizeVolume$resizeVolume<
          Mutation$ResizeVolume$resizeVolume>
      get copyWith =>
          CopyWith$Mutation$ResizeVolume$resizeVolume(this, (i) => i);
}

abstract class CopyWith$Mutation$ResizeVolume$resizeVolume<TRes> {
  factory CopyWith$Mutation$ResizeVolume$resizeVolume(
          Mutation$ResizeVolume$resizeVolume instance,
          TRes Function(Mutation$ResizeVolume$resizeVolume) then) =
      _CopyWithImpl$Mutation$ResizeVolume$resizeVolume;

  factory CopyWith$Mutation$ResizeVolume$resizeVolume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ResizeVolume$resizeVolume;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$ResizeVolume$resizeVolume<TRes>
    implements CopyWith$Mutation$ResizeVolume$resizeVolume<TRes> {
  _CopyWithImpl$Mutation$ResizeVolume$resizeVolume(this._instance, this._then);

  final Mutation$ResizeVolume$resizeVolume _instance;

  final TRes Function(Mutation$ResizeVolume$resizeVolume) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$ResizeVolume$resizeVolume(
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

class _CopyWithStubImpl$Mutation$ResizeVolume$resizeVolume<TRes>
    implements CopyWith$Mutation$ResizeVolume$resizeVolume<TRes> {
  _CopyWithStubImpl$Mutation$ResizeVolume$resizeVolume(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$UnmountVolume {
  Variables$Mutation$UnmountVolume({required this.name});

  @override
  factory Variables$Mutation$UnmountVolume.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$UnmountVolumeFromJson(json);

  final String name;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$UnmountVolumeToJson(this);
  int get hashCode {
    final l$name = name;
    return Object.hashAll([l$name]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$UnmountVolume) ||
        runtimeType != other.runtimeType) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    return true;
  }

  CopyWith$Variables$Mutation$UnmountVolume<Variables$Mutation$UnmountVolume>
      get copyWith => CopyWith$Variables$Mutation$UnmountVolume(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$UnmountVolume<TRes> {
  factory CopyWith$Variables$Mutation$UnmountVolume(
          Variables$Mutation$UnmountVolume instance,
          TRes Function(Variables$Mutation$UnmountVolume) then) =
      _CopyWithImpl$Variables$Mutation$UnmountVolume;

  factory CopyWith$Variables$Mutation$UnmountVolume.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UnmountVolume;

  TRes call({String? name});
}

class _CopyWithImpl$Variables$Mutation$UnmountVolume<TRes>
    implements CopyWith$Variables$Mutation$UnmountVolume<TRes> {
  _CopyWithImpl$Variables$Mutation$UnmountVolume(this._instance, this._then);

  final Variables$Mutation$UnmountVolume _instance;

  final TRes Function(Variables$Mutation$UnmountVolume) _then;

  static const _undefined = {};

  TRes call({Object? name = _undefined}) =>
      _then(Variables$Mutation$UnmountVolume(
          name: name == _undefined || name == null
              ? _instance.name
              : (name as String)));
}

class _CopyWithStubImpl$Variables$Mutation$UnmountVolume<TRes>
    implements CopyWith$Variables$Mutation$UnmountVolume<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UnmountVolume(this._res);

  TRes _res;

  call({String? name}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Mutation$UnmountVolume {
  Mutation$UnmountVolume(
      {required this.unmountVolume, required this.$__typename});

  @override
  factory Mutation$UnmountVolume.fromJson(Map<String, dynamic> json) =>
      _$Mutation$UnmountVolumeFromJson(json);

  final Mutation$UnmountVolume$unmountVolume unmountVolume;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$UnmountVolumeToJson(this);
  int get hashCode {
    final l$unmountVolume = unmountVolume;
    final l$$__typename = $__typename;
    return Object.hashAll([l$unmountVolume, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$UnmountVolume) || runtimeType != other.runtimeType)
      return false;
    final l$unmountVolume = unmountVolume;
    final lOther$unmountVolume = other.unmountVolume;
    if (l$unmountVolume != lOther$unmountVolume) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$UnmountVolume on Mutation$UnmountVolume {
  CopyWith$Mutation$UnmountVolume<Mutation$UnmountVolume> get copyWith =>
      CopyWith$Mutation$UnmountVolume(this, (i) => i);
}

abstract class CopyWith$Mutation$UnmountVolume<TRes> {
  factory CopyWith$Mutation$UnmountVolume(Mutation$UnmountVolume instance,
          TRes Function(Mutation$UnmountVolume) then) =
      _CopyWithImpl$Mutation$UnmountVolume;

  factory CopyWith$Mutation$UnmountVolume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UnmountVolume;

  TRes call(
      {Mutation$UnmountVolume$unmountVolume? unmountVolume,
      String? $__typename});
  CopyWith$Mutation$UnmountVolume$unmountVolume<TRes> get unmountVolume;
}

class _CopyWithImpl$Mutation$UnmountVolume<TRes>
    implements CopyWith$Mutation$UnmountVolume<TRes> {
  _CopyWithImpl$Mutation$UnmountVolume(this._instance, this._then);

  final Mutation$UnmountVolume _instance;

  final TRes Function(Mutation$UnmountVolume) _then;

  static const _undefined = {};

  TRes call(
          {Object? unmountVolume = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$UnmountVolume(
          unmountVolume: unmountVolume == _undefined || unmountVolume == null
              ? _instance.unmountVolume
              : (unmountVolume as Mutation$UnmountVolume$unmountVolume),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$UnmountVolume$unmountVolume<TRes> get unmountVolume {
    final local$unmountVolume = _instance.unmountVolume;
    return CopyWith$Mutation$UnmountVolume$unmountVolume(
        local$unmountVolume, (e) => call(unmountVolume: e));
  }
}

class _CopyWithStubImpl$Mutation$UnmountVolume<TRes>
    implements CopyWith$Mutation$UnmountVolume<TRes> {
  _CopyWithStubImpl$Mutation$UnmountVolume(this._res);

  TRes _res;

  call(
          {Mutation$UnmountVolume$unmountVolume? unmountVolume,
          String? $__typename}) =>
      _res;
  CopyWith$Mutation$UnmountVolume$unmountVolume<TRes> get unmountVolume =>
      CopyWith$Mutation$UnmountVolume$unmountVolume.stub(_res);
}

const documentNodeMutationUnmountVolume = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UnmountVolume'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'name')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'unmountVolume'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'name'),
                  value: VariableNode(name: NameNode(value: 'name')))
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
Mutation$UnmountVolume _parserFn$Mutation$UnmountVolume(
        Map<String, dynamic> data) =>
    Mutation$UnmountVolume.fromJson(data);
typedef OnMutationCompleted$Mutation$UnmountVolume = FutureOr<void> Function(
    dynamic, Mutation$UnmountVolume?);

class Options$Mutation$UnmountVolume
    extends graphql.MutationOptions<Mutation$UnmountVolume> {
  Options$Mutation$UnmountVolume(
      {String? operationName,
      required Variables$Mutation$UnmountVolume variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$UnmountVolume? onCompleted,
      graphql.OnMutationUpdate<Mutation$UnmountVolume>? update,
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
                        : _parserFn$Mutation$UnmountVolume(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationUnmountVolume,
            parserFn: _parserFn$Mutation$UnmountVolume);

  final OnMutationCompleted$Mutation$UnmountVolume? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$UnmountVolume
    extends graphql.WatchQueryOptions<Mutation$UnmountVolume> {
  WatchOptions$Mutation$UnmountVolume(
      {String? operationName,
      required Variables$Mutation$UnmountVolume variables,
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
            document: documentNodeMutationUnmountVolume,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$UnmountVolume);
}

extension ClientExtension$Mutation$UnmountVolume on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UnmountVolume>> mutate$UnmountVolume(
          Options$Mutation$UnmountVolume options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$UnmountVolume> watchMutation$UnmountVolume(
          WatchOptions$Mutation$UnmountVolume options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$UnmountVolume$unmountVolume
    implements Fragment$basicMutationReturnFields {
  Mutation$UnmountVolume$unmountVolume(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$UnmountVolume$unmountVolume.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$UnmountVolume$unmountVolumeFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$UnmountVolume$unmountVolumeToJson(this);
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
    if (!(other is Mutation$UnmountVolume$unmountVolume) ||
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

extension UtilityExtension$Mutation$UnmountVolume$unmountVolume
    on Mutation$UnmountVolume$unmountVolume {
  CopyWith$Mutation$UnmountVolume$unmountVolume<
          Mutation$UnmountVolume$unmountVolume>
      get copyWith =>
          CopyWith$Mutation$UnmountVolume$unmountVolume(this, (i) => i);
}

abstract class CopyWith$Mutation$UnmountVolume$unmountVolume<TRes> {
  factory CopyWith$Mutation$UnmountVolume$unmountVolume(
          Mutation$UnmountVolume$unmountVolume instance,
          TRes Function(Mutation$UnmountVolume$unmountVolume) then) =
      _CopyWithImpl$Mutation$UnmountVolume$unmountVolume;

  factory CopyWith$Mutation$UnmountVolume$unmountVolume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UnmountVolume$unmountVolume;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$UnmountVolume$unmountVolume<TRes>
    implements CopyWith$Mutation$UnmountVolume$unmountVolume<TRes> {
  _CopyWithImpl$Mutation$UnmountVolume$unmountVolume(
      this._instance, this._then);

  final Mutation$UnmountVolume$unmountVolume _instance;

  final TRes Function(Mutation$UnmountVolume$unmountVolume) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$UnmountVolume$unmountVolume(
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

class _CopyWithStubImpl$Mutation$UnmountVolume$unmountVolume<TRes>
    implements CopyWith$Mutation$UnmountVolume$unmountVolume<TRes> {
  _CopyWithStubImpl$Mutation$UnmountVolume$unmountVolume(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$MigrateToBinds {
  Variables$Mutation$MigrateToBinds({required this.input});

  @override
  factory Variables$Mutation$MigrateToBinds.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$MigrateToBindsFromJson(json);

  final Input$MigrateToBindsInput input;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$MigrateToBindsToJson(this);
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$MigrateToBinds) ||
        runtimeType != other.runtimeType) return false;
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) return false;
    return true;
  }

  CopyWith$Variables$Mutation$MigrateToBinds<Variables$Mutation$MigrateToBinds>
      get copyWith =>
          CopyWith$Variables$Mutation$MigrateToBinds(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$MigrateToBinds<TRes> {
  factory CopyWith$Variables$Mutation$MigrateToBinds(
          Variables$Mutation$MigrateToBinds instance,
          TRes Function(Variables$Mutation$MigrateToBinds) then) =
      _CopyWithImpl$Variables$Mutation$MigrateToBinds;

  factory CopyWith$Variables$Mutation$MigrateToBinds.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$MigrateToBinds;

  TRes call({Input$MigrateToBindsInput? input});
}

class _CopyWithImpl$Variables$Mutation$MigrateToBinds<TRes>
    implements CopyWith$Variables$Mutation$MigrateToBinds<TRes> {
  _CopyWithImpl$Variables$Mutation$MigrateToBinds(this._instance, this._then);

  final Variables$Mutation$MigrateToBinds _instance;

  final TRes Function(Variables$Mutation$MigrateToBinds) _then;

  static const _undefined = {};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$MigrateToBinds(
          input: input == _undefined || input == null
              ? _instance.input
              : (input as Input$MigrateToBindsInput)));
}

class _CopyWithStubImpl$Variables$Mutation$MigrateToBinds<TRes>
    implements CopyWith$Variables$Mutation$MigrateToBinds<TRes> {
  _CopyWithStubImpl$Variables$Mutation$MigrateToBinds(this._res);

  TRes _res;

  call({Input$MigrateToBindsInput? input}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Mutation$MigrateToBinds {
  Mutation$MigrateToBinds(
      {required this.migrateToBinds, required this.$__typename});

  @override
  factory Mutation$MigrateToBinds.fromJson(Map<String, dynamic> json) =>
      _$Mutation$MigrateToBindsFromJson(json);

  final Mutation$MigrateToBinds$migrateToBinds migrateToBinds;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$MigrateToBindsToJson(this);
  int get hashCode {
    final l$migrateToBinds = migrateToBinds;
    final l$$__typename = $__typename;
    return Object.hashAll([l$migrateToBinds, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$MigrateToBinds) || runtimeType != other.runtimeType)
      return false;
    final l$migrateToBinds = migrateToBinds;
    final lOther$migrateToBinds = other.migrateToBinds;
    if (l$migrateToBinds != lOther$migrateToBinds) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$MigrateToBinds on Mutation$MigrateToBinds {
  CopyWith$Mutation$MigrateToBinds<Mutation$MigrateToBinds> get copyWith =>
      CopyWith$Mutation$MigrateToBinds(this, (i) => i);
}

abstract class CopyWith$Mutation$MigrateToBinds<TRes> {
  factory CopyWith$Mutation$MigrateToBinds(Mutation$MigrateToBinds instance,
          TRes Function(Mutation$MigrateToBinds) then) =
      _CopyWithImpl$Mutation$MigrateToBinds;

  factory CopyWith$Mutation$MigrateToBinds.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MigrateToBinds;

  TRes call(
      {Mutation$MigrateToBinds$migrateToBinds? migrateToBinds,
      String? $__typename});
  CopyWith$Mutation$MigrateToBinds$migrateToBinds<TRes> get migrateToBinds;
}

class _CopyWithImpl$Mutation$MigrateToBinds<TRes>
    implements CopyWith$Mutation$MigrateToBinds<TRes> {
  _CopyWithImpl$Mutation$MigrateToBinds(this._instance, this._then);

  final Mutation$MigrateToBinds _instance;

  final TRes Function(Mutation$MigrateToBinds) _then;

  static const _undefined = {};

  TRes call(
          {Object? migrateToBinds = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$MigrateToBinds(
          migrateToBinds: migrateToBinds == _undefined || migrateToBinds == null
              ? _instance.migrateToBinds
              : (migrateToBinds as Mutation$MigrateToBinds$migrateToBinds),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$MigrateToBinds$migrateToBinds<TRes> get migrateToBinds {
    final local$migrateToBinds = _instance.migrateToBinds;
    return CopyWith$Mutation$MigrateToBinds$migrateToBinds(
        local$migrateToBinds, (e) => call(migrateToBinds: e));
  }
}

class _CopyWithStubImpl$Mutation$MigrateToBinds<TRes>
    implements CopyWith$Mutation$MigrateToBinds<TRes> {
  _CopyWithStubImpl$Mutation$MigrateToBinds(this._res);

  TRes _res;

  call(
          {Mutation$MigrateToBinds$migrateToBinds? migrateToBinds,
          String? $__typename}) =>
      _res;
  CopyWith$Mutation$MigrateToBinds$migrateToBinds<TRes> get migrateToBinds =>
      CopyWith$Mutation$MigrateToBinds$migrateToBinds.stub(_res);
}

const documentNodeMutationMigrateToBinds = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'MigrateToBinds'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type: NamedTypeNode(
                name: NameNode(value: 'MigrateToBindsInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'migrateToBinds'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'input'),
                  value: VariableNode(name: NameNode(value: 'input')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
              FieldNode(
                  name: NameNode(value: 'job'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'createdAt'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'description'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'finishedAt'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'progress'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'result'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'status'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'statusText'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'uid'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'updatedAt'),
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
Mutation$MigrateToBinds _parserFn$Mutation$MigrateToBinds(
        Map<String, dynamic> data) =>
    Mutation$MigrateToBinds.fromJson(data);
typedef OnMutationCompleted$Mutation$MigrateToBinds = FutureOr<void> Function(
    dynamic, Mutation$MigrateToBinds?);

class Options$Mutation$MigrateToBinds
    extends graphql.MutationOptions<Mutation$MigrateToBinds> {
  Options$Mutation$MigrateToBinds(
      {String? operationName,
      required Variables$Mutation$MigrateToBinds variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$MigrateToBinds? onCompleted,
      graphql.OnMutationUpdate<Mutation$MigrateToBinds>? update,
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
                        : _parserFn$Mutation$MigrateToBinds(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationMigrateToBinds,
            parserFn: _parserFn$Mutation$MigrateToBinds);

  final OnMutationCompleted$Mutation$MigrateToBinds? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$MigrateToBinds
    extends graphql.WatchQueryOptions<Mutation$MigrateToBinds> {
  WatchOptions$Mutation$MigrateToBinds(
      {String? operationName,
      required Variables$Mutation$MigrateToBinds variables,
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
            document: documentNodeMutationMigrateToBinds,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$MigrateToBinds);
}

extension ClientExtension$Mutation$MigrateToBinds on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$MigrateToBinds>> mutate$MigrateToBinds(
          Options$Mutation$MigrateToBinds options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$MigrateToBinds> watchMutation$MigrateToBinds(
          WatchOptions$Mutation$MigrateToBinds options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$MigrateToBinds$migrateToBinds
    implements Fragment$basicMutationReturnFields {
  Mutation$MigrateToBinds$migrateToBinds(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename,
      this.job});

  @override
  factory Mutation$MigrateToBinds$migrateToBinds.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$MigrateToBinds$migrateToBindsFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  final Mutation$MigrateToBinds$migrateToBinds$job? job;

  Map<String, dynamic> toJson() =>
      _$Mutation$MigrateToBinds$migrateToBindsToJson(this);
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$job = job;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename, l$job]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$MigrateToBinds$migrateToBinds) ||
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
    final l$job = job;
    final lOther$job = other.job;
    if (l$job != lOther$job) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$MigrateToBinds$migrateToBinds
    on Mutation$MigrateToBinds$migrateToBinds {
  CopyWith$Mutation$MigrateToBinds$migrateToBinds<
          Mutation$MigrateToBinds$migrateToBinds>
      get copyWith =>
          CopyWith$Mutation$MigrateToBinds$migrateToBinds(this, (i) => i);
}

abstract class CopyWith$Mutation$MigrateToBinds$migrateToBinds<TRes> {
  factory CopyWith$Mutation$MigrateToBinds$migrateToBinds(
          Mutation$MigrateToBinds$migrateToBinds instance,
          TRes Function(Mutation$MigrateToBinds$migrateToBinds) then) =
      _CopyWithImpl$Mutation$MigrateToBinds$migrateToBinds;

  factory CopyWith$Mutation$MigrateToBinds$migrateToBinds.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MigrateToBinds$migrateToBinds;

  TRes call(
      {int? code,
      String? message,
      bool? success,
      String? $__typename,
      Mutation$MigrateToBinds$migrateToBinds$job? job});
  CopyWith$Mutation$MigrateToBinds$migrateToBinds$job<TRes> get job;
}

class _CopyWithImpl$Mutation$MigrateToBinds$migrateToBinds<TRes>
    implements CopyWith$Mutation$MigrateToBinds$migrateToBinds<TRes> {
  _CopyWithImpl$Mutation$MigrateToBinds$migrateToBinds(
      this._instance, this._then);

  final Mutation$MigrateToBinds$migrateToBinds _instance;

  final TRes Function(Mutation$MigrateToBinds$migrateToBinds) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined,
          Object? job = _undefined}) =>
      _then(Mutation$MigrateToBinds$migrateToBinds(
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
          job: job == _undefined
              ? _instance.job
              : (job as Mutation$MigrateToBinds$migrateToBinds$job?)));
  CopyWith$Mutation$MigrateToBinds$migrateToBinds$job<TRes> get job {
    final local$job = _instance.job;
    return local$job == null
        ? CopyWith$Mutation$MigrateToBinds$migrateToBinds$job.stub(
            _then(_instance))
        : CopyWith$Mutation$MigrateToBinds$migrateToBinds$job(
            local$job, (e) => call(job: e));
  }
}

class _CopyWithStubImpl$Mutation$MigrateToBinds$migrateToBinds<TRes>
    implements CopyWith$Mutation$MigrateToBinds$migrateToBinds<TRes> {
  _CopyWithStubImpl$Mutation$MigrateToBinds$migrateToBinds(this._res);

  TRes _res;

  call(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          Mutation$MigrateToBinds$migrateToBinds$job? job}) =>
      _res;
  CopyWith$Mutation$MigrateToBinds$migrateToBinds$job<TRes> get job =>
      CopyWith$Mutation$MigrateToBinds$migrateToBinds$job.stub(_res);
}

@JsonSerializable(explicitToJson: true)
class Mutation$MigrateToBinds$migrateToBinds$job {
  Mutation$MigrateToBinds$migrateToBinds$job(
      {required this.createdAt,
      required this.description,
      this.error,
      this.finishedAt,
      required this.name,
      this.progress,
      this.result,
      required this.status,
      this.statusText,
      required this.uid,
      required this.updatedAt,
      required this.$__typename});

  @override
  factory Mutation$MigrateToBinds$migrateToBinds$job.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$MigrateToBinds$migrateToBinds$jobFromJson(json);

  @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime createdAt;

  final String description;

  final String? error;

  @JsonKey(
      fromJson: _nullable$dateTimeFromJson, toJson: _nullable$dateTimeToJson)
  final DateTime? finishedAt;

  final String name;

  final int? progress;

  final String? result;

  final String status;

  final String? statusText;

  final String uid;

  @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime updatedAt;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$MigrateToBinds$migrateToBinds$jobToJson(this);
  int get hashCode {
    final l$createdAt = createdAt;
    final l$description = description;
    final l$error = error;
    final l$finishedAt = finishedAt;
    final l$name = name;
    final l$progress = progress;
    final l$result = result;
    final l$status = status;
    final l$statusText = statusText;
    final l$uid = uid;
    final l$updatedAt = updatedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createdAt,
      l$description,
      l$error,
      l$finishedAt,
      l$name,
      l$progress,
      l$result,
      l$status,
      l$statusText,
      l$uid,
      l$updatedAt,
      l$$__typename
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$MigrateToBinds$migrateToBinds$job) ||
        runtimeType != other.runtimeType) return false;
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) return false;
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) return false;
    final l$error = error;
    final lOther$error = other.error;
    if (l$error != lOther$error) return false;
    final l$finishedAt = finishedAt;
    final lOther$finishedAt = other.finishedAt;
    if (l$finishedAt != lOther$finishedAt) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    final l$progress = progress;
    final lOther$progress = other.progress;
    if (l$progress != lOther$progress) return false;
    final l$result = result;
    final lOther$result = other.result;
    if (l$result != lOther$result) return false;
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) return false;
    final l$statusText = statusText;
    final lOther$statusText = other.statusText;
    if (l$statusText != lOther$statusText) return false;
    final l$uid = uid;
    final lOther$uid = other.uid;
    if (l$uid != lOther$uid) return false;
    final l$updatedAt = updatedAt;
    final lOther$updatedAt = other.updatedAt;
    if (l$updatedAt != lOther$updatedAt) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$MigrateToBinds$migrateToBinds$job
    on Mutation$MigrateToBinds$migrateToBinds$job {
  CopyWith$Mutation$MigrateToBinds$migrateToBinds$job<
          Mutation$MigrateToBinds$migrateToBinds$job>
      get copyWith =>
          CopyWith$Mutation$MigrateToBinds$migrateToBinds$job(this, (i) => i);
}

abstract class CopyWith$Mutation$MigrateToBinds$migrateToBinds$job<TRes> {
  factory CopyWith$Mutation$MigrateToBinds$migrateToBinds$job(
          Mutation$MigrateToBinds$migrateToBinds$job instance,
          TRes Function(Mutation$MigrateToBinds$migrateToBinds$job) then) =
      _CopyWithImpl$Mutation$MigrateToBinds$migrateToBinds$job;

  factory CopyWith$Mutation$MigrateToBinds$migrateToBinds$job.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MigrateToBinds$migrateToBinds$job;

  TRes call(
      {DateTime? createdAt,
      String? description,
      String? error,
      DateTime? finishedAt,
      String? name,
      int? progress,
      String? result,
      String? status,
      String? statusText,
      String? uid,
      DateTime? updatedAt,
      String? $__typename});
}

class _CopyWithImpl$Mutation$MigrateToBinds$migrateToBinds$job<TRes>
    implements CopyWith$Mutation$MigrateToBinds$migrateToBinds$job<TRes> {
  _CopyWithImpl$Mutation$MigrateToBinds$migrateToBinds$job(
      this._instance, this._then);

  final Mutation$MigrateToBinds$migrateToBinds$job _instance;

  final TRes Function(Mutation$MigrateToBinds$migrateToBinds$job) _then;

  static const _undefined = {};

  TRes call(
          {Object? createdAt = _undefined,
          Object? description = _undefined,
          Object? error = _undefined,
          Object? finishedAt = _undefined,
          Object? name = _undefined,
          Object? progress = _undefined,
          Object? result = _undefined,
          Object? status = _undefined,
          Object? statusText = _undefined,
          Object? uid = _undefined,
          Object? updatedAt = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$MigrateToBinds$migrateToBinds$job(
          createdAt: createdAt == _undefined || createdAt == null
              ? _instance.createdAt
              : (createdAt as DateTime),
          description: description == _undefined || description == null
              ? _instance.description
              : (description as String),
          error: error == _undefined ? _instance.error : (error as String?),
          finishedAt: finishedAt == _undefined
              ? _instance.finishedAt
              : (finishedAt as DateTime?),
          name: name == _undefined || name == null
              ? _instance.name
              : (name as String),
          progress:
              progress == _undefined ? _instance.progress : (progress as int?),
          result: result == _undefined ? _instance.result : (result as String?),
          status: status == _undefined || status == null
              ? _instance.status
              : (status as String),
          statusText: statusText == _undefined
              ? _instance.statusText
              : (statusText as String?),
          uid: uid == _undefined || uid == null
              ? _instance.uid
              : (uid as String),
          updatedAt: updatedAt == _undefined || updatedAt == null
              ? _instance.updatedAt
              : (updatedAt as DateTime),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
}

class _CopyWithStubImpl$Mutation$MigrateToBinds$migrateToBinds$job<TRes>
    implements CopyWith$Mutation$MigrateToBinds$migrateToBinds$job<TRes> {
  _CopyWithStubImpl$Mutation$MigrateToBinds$migrateToBinds$job(this._res);

  TRes _res;

  call(
          {DateTime? createdAt,
          String? description,
          String? error,
          DateTime? finishedAt,
          String? name,
          int? progress,
          String? result,
          String? status,
          String? statusText,
          String? uid,
          DateTime? updatedAt,
          String? $__typename}) =>
      _res;
}

DateTime? _nullable$dateTimeFromJson(dynamic data) =>
    data == null ? null : dateTimeFromJson(data);
dynamic _nullable$dateTimeToJson(DateTime? data) =>
    data == null ? null : dateTimeToJson(data);
