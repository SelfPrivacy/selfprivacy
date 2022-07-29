import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:json_annotation/json_annotation.dart';
part 'get_server_disk_volumes.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$GetServerDiskVolumesQuery {
  Query$GetServerDiskVolumesQuery(
      {required this.storage, required this.$__typename});

  @override
  factory Query$GetServerDiskVolumesQuery.fromJson(Map<String, dynamic> json) =>
      _$Query$GetServerDiskVolumesQueryFromJson(json);

  final Query$GetServerDiskVolumesQuery$storage storage;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$GetServerDiskVolumesQueryToJson(this);
  int get hashCode {
    final l$storage = storage;
    final l$$__typename = $__typename;
    return Object.hashAll([l$storage, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetServerDiskVolumesQuery) ||
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

extension UtilityExtension$Query$GetServerDiskVolumesQuery
    on Query$GetServerDiskVolumesQuery {
  CopyWith$Query$GetServerDiskVolumesQuery<Query$GetServerDiskVolumesQuery>
      get copyWith => CopyWith$Query$GetServerDiskVolumesQuery(this, (i) => i);
}

abstract class CopyWith$Query$GetServerDiskVolumesQuery<TRes> {
  factory CopyWith$Query$GetServerDiskVolumesQuery(
          Query$GetServerDiskVolumesQuery instance,
          TRes Function(Query$GetServerDiskVolumesQuery) then) =
      _CopyWithImpl$Query$GetServerDiskVolumesQuery;

  factory CopyWith$Query$GetServerDiskVolumesQuery.stub(TRes res) =
      _CopyWithStubImpl$Query$GetServerDiskVolumesQuery;

  TRes call(
      {Query$GetServerDiskVolumesQuery$storage? storage, String? $__typename});
  CopyWith$Query$GetServerDiskVolumesQuery$storage<TRes> get storage;
}

class _CopyWithImpl$Query$GetServerDiskVolumesQuery<TRes>
    implements CopyWith$Query$GetServerDiskVolumesQuery<TRes> {
  _CopyWithImpl$Query$GetServerDiskVolumesQuery(this._instance, this._then);

  final Query$GetServerDiskVolumesQuery _instance;

  final TRes Function(Query$GetServerDiskVolumesQuery) _then;

  static const _undefined = {};

  TRes call({Object? storage = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$GetServerDiskVolumesQuery(
          storage: storage == _undefined || storage == null
              ? _instance.storage
              : (storage as Query$GetServerDiskVolumesQuery$storage),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Query$GetServerDiskVolumesQuery$storage<TRes> get storage {
    final local$storage = _instance.storage;
    return CopyWith$Query$GetServerDiskVolumesQuery$storage(
        local$storage, (e) => call(storage: e));
  }
}

class _CopyWithStubImpl$Query$GetServerDiskVolumesQuery<TRes>
    implements CopyWith$Query$GetServerDiskVolumesQuery<TRes> {
  _CopyWithStubImpl$Query$GetServerDiskVolumesQuery(this._res);

  TRes _res;

  call(
          {Query$GetServerDiskVolumesQuery$storage? storage,
          String? $__typename}) =>
      _res;
  CopyWith$Query$GetServerDiskVolumesQuery$storage<TRes> get storage =>
      CopyWith$Query$GetServerDiskVolumesQuery$storage.stub(_res);
}

const documentNodeQueryGetServerDiskVolumesQuery = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetServerDiskVolumesQuery'),
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
                        name: NameNode(value: 'totalSpace'),
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
Query$GetServerDiskVolumesQuery _parserFn$Query$GetServerDiskVolumesQuery(
        Map<String, dynamic> data) =>
    Query$GetServerDiskVolumesQuery.fromJson(data);

class Options$Query$GetServerDiskVolumesQuery
    extends graphql.QueryOptions<Query$GetServerDiskVolumesQuery> {
  Options$Query$GetServerDiskVolumesQuery(
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
            document: documentNodeQueryGetServerDiskVolumesQuery,
            parserFn: _parserFn$Query$GetServerDiskVolumesQuery);
}

class WatchOptions$Query$GetServerDiskVolumesQuery
    extends graphql.WatchQueryOptions<Query$GetServerDiskVolumesQuery> {
  WatchOptions$Query$GetServerDiskVolumesQuery(
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
            document: documentNodeQueryGetServerDiskVolumesQuery,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Query$GetServerDiskVolumesQuery);
}

class FetchMoreOptions$Query$GetServerDiskVolumesQuery
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetServerDiskVolumesQuery(
      {required graphql.UpdateQuery updateQuery})
      : super(
            updateQuery: updateQuery,
            document: documentNodeQueryGetServerDiskVolumesQuery);
}

extension ClientExtension$Query$GetServerDiskVolumesQuery
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetServerDiskVolumesQuery>>
      query$GetServerDiskVolumesQuery(
              [Options$Query$GetServerDiskVolumesQuery? options]) async =>
          await this
              .query(options ?? Options$Query$GetServerDiskVolumesQuery());
  graphql.ObservableQuery<Query$GetServerDiskVolumesQuery>
      watchQuery$GetServerDiskVolumesQuery(
              [WatchOptions$Query$GetServerDiskVolumesQuery? options]) =>
          this.watchQuery(
              options ?? WatchOptions$Query$GetServerDiskVolumesQuery());
  void writeQuery$GetServerDiskVolumesQuery(
          {required Query$GetServerDiskVolumesQuery data,
          bool broadcast = true}) =>
      this.writeQuery(
          graphql.Request(
              operation: graphql.Operation(
                  document: documentNodeQueryGetServerDiskVolumesQuery)),
          data: data.toJson(),
          broadcast: broadcast);
  Query$GetServerDiskVolumesQuery? readQuery$GetServerDiskVolumesQuery(
      {bool optimistic = true}) {
    final result = this.readQuery(
        graphql.Request(
            operation: graphql.Operation(
                document: documentNodeQueryGetServerDiskVolumesQuery)),
        optimistic: optimistic);
    return result == null
        ? null
        : Query$GetServerDiskVolumesQuery.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Query$GetServerDiskVolumesQuery$storage {
  Query$GetServerDiskVolumesQuery$storage(
      {required this.volumes, required this.$__typename});

  @override
  factory Query$GetServerDiskVolumesQuery$storage.fromJson(
          Map<String, dynamic> json) =>
      _$Query$GetServerDiskVolumesQuery$storageFromJson(json);

  final List<Query$GetServerDiskVolumesQuery$storage$volumes> volumes;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$GetServerDiskVolumesQuery$storageToJson(this);
  int get hashCode {
    final l$volumes = volumes;
    final l$$__typename = $__typename;
    return Object.hashAll(
        [Object.hashAll(l$volumes.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetServerDiskVolumesQuery$storage) ||
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

extension UtilityExtension$Query$GetServerDiskVolumesQuery$storage
    on Query$GetServerDiskVolumesQuery$storage {
  CopyWith$Query$GetServerDiskVolumesQuery$storage<
          Query$GetServerDiskVolumesQuery$storage>
      get copyWith =>
          CopyWith$Query$GetServerDiskVolumesQuery$storage(this, (i) => i);
}

abstract class CopyWith$Query$GetServerDiskVolumesQuery$storage<TRes> {
  factory CopyWith$Query$GetServerDiskVolumesQuery$storage(
          Query$GetServerDiskVolumesQuery$storage instance,
          TRes Function(Query$GetServerDiskVolumesQuery$storage) then) =
      _CopyWithImpl$Query$GetServerDiskVolumesQuery$storage;

  factory CopyWith$Query$GetServerDiskVolumesQuery$storage.stub(TRes res) =
      _CopyWithStubImpl$Query$GetServerDiskVolumesQuery$storage;

  TRes call(
      {List<Query$GetServerDiskVolumesQuery$storage$volumes>? volumes,
      String? $__typename});
  TRes volumes(
      Iterable<Query$GetServerDiskVolumesQuery$storage$volumes> Function(
              Iterable<
                  CopyWith$Query$GetServerDiskVolumesQuery$storage$volumes<
                      Query$GetServerDiskVolumesQuery$storage$volumes>>)
          _fn);
}

class _CopyWithImpl$Query$GetServerDiskVolumesQuery$storage<TRes>
    implements CopyWith$Query$GetServerDiskVolumesQuery$storage<TRes> {
  _CopyWithImpl$Query$GetServerDiskVolumesQuery$storage(
      this._instance, this._then);

  final Query$GetServerDiskVolumesQuery$storage _instance;

  final TRes Function(Query$GetServerDiskVolumesQuery$storage) _then;

  static const _undefined = {};

  TRes call({Object? volumes = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$GetServerDiskVolumesQuery$storage(
          volumes: volumes == _undefined || volumes == null
              ? _instance.volumes
              : (volumes
                  as List<Query$GetServerDiskVolumesQuery$storage$volumes>),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  TRes volumes(
          Iterable<Query$GetServerDiskVolumesQuery$storage$volumes> Function(
                  Iterable<
                      CopyWith$Query$GetServerDiskVolumesQuery$storage$volumes<
                          Query$GetServerDiskVolumesQuery$storage$volumes>>)
              _fn) =>
      call(
          volumes: _fn(_instance.volumes.map((e) =>
              CopyWith$Query$GetServerDiskVolumesQuery$storage$volumes(
                  e, (i) => i))).toList());
}

class _CopyWithStubImpl$Query$GetServerDiskVolumesQuery$storage<TRes>
    implements CopyWith$Query$GetServerDiskVolumesQuery$storage<TRes> {
  _CopyWithStubImpl$Query$GetServerDiskVolumesQuery$storage(this._res);

  TRes _res;

  call(
          {List<Query$GetServerDiskVolumesQuery$storage$volumes>? volumes,
          String? $__typename}) =>
      _res;
  volumes(_fn) => _res;
}

@JsonSerializable(explicitToJson: true)
class Query$GetServerDiskVolumesQuery$storage$volumes {
  Query$GetServerDiskVolumesQuery$storage$volumes(
      {required this.freeSpace,
      required this.name,
      required this.root,
      required this.totalSpace,
      required this.usedSpace,
      required this.$__typename});

  @override
  factory Query$GetServerDiskVolumesQuery$storage$volumes.fromJson(
          Map<String, dynamic> json) =>
      _$Query$GetServerDiskVolumesQuery$storage$volumesFromJson(json);

  final String freeSpace;

  final String name;

  final bool root;

  final String totalSpace;

  final String usedSpace;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$GetServerDiskVolumesQuery$storage$volumesToJson(this);
  int get hashCode {
    final l$freeSpace = freeSpace;
    final l$name = name;
    final l$root = root;
    final l$totalSpace = totalSpace;
    final l$usedSpace = usedSpace;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$freeSpace,
      l$name,
      l$root,
      l$totalSpace,
      l$usedSpace,
      l$$__typename
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetServerDiskVolumesQuery$storage$volumes) ||
        runtimeType != other.runtimeType) return false;
    final l$freeSpace = freeSpace;
    final lOther$freeSpace = other.freeSpace;
    if (l$freeSpace != lOther$freeSpace) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    final l$root = root;
    final lOther$root = other.root;
    if (l$root != lOther$root) return false;
    final l$totalSpace = totalSpace;
    final lOther$totalSpace = other.totalSpace;
    if (l$totalSpace != lOther$totalSpace) return false;
    final l$usedSpace = usedSpace;
    final lOther$usedSpace = other.usedSpace;
    if (l$usedSpace != lOther$usedSpace) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetServerDiskVolumesQuery$storage$volumes
    on Query$GetServerDiskVolumesQuery$storage$volumes {
  CopyWith$Query$GetServerDiskVolumesQuery$storage$volumes<
          Query$GetServerDiskVolumesQuery$storage$volumes>
      get copyWith => CopyWith$Query$GetServerDiskVolumesQuery$storage$volumes(
          this, (i) => i);
}

abstract class CopyWith$Query$GetServerDiskVolumesQuery$storage$volumes<TRes> {
  factory CopyWith$Query$GetServerDiskVolumesQuery$storage$volumes(
          Query$GetServerDiskVolumesQuery$storage$volumes instance,
          TRes Function(Query$GetServerDiskVolumesQuery$storage$volumes) then) =
      _CopyWithImpl$Query$GetServerDiskVolumesQuery$storage$volumes;

  factory CopyWith$Query$GetServerDiskVolumesQuery$storage$volumes.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetServerDiskVolumesQuery$storage$volumes;

  TRes call(
      {String? freeSpace,
      String? name,
      bool? root,
      String? totalSpace,
      String? usedSpace,
      String? $__typename});
}

class _CopyWithImpl$Query$GetServerDiskVolumesQuery$storage$volumes<TRes>
    implements CopyWith$Query$GetServerDiskVolumesQuery$storage$volumes<TRes> {
  _CopyWithImpl$Query$GetServerDiskVolumesQuery$storage$volumes(
      this._instance, this._then);

  final Query$GetServerDiskVolumesQuery$storage$volumes _instance;

  final TRes Function(Query$GetServerDiskVolumesQuery$storage$volumes) _then;

  static const _undefined = {};

  TRes call(
          {Object? freeSpace = _undefined,
          Object? name = _undefined,
          Object? root = _undefined,
          Object? totalSpace = _undefined,
          Object? usedSpace = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$GetServerDiskVolumesQuery$storage$volumes(
          freeSpace: freeSpace == _undefined || freeSpace == null
              ? _instance.freeSpace
              : (freeSpace as String),
          name: name == _undefined || name == null
              ? _instance.name
              : (name as String),
          root: root == _undefined || root == null
              ? _instance.root
              : (root as bool),
          totalSpace: totalSpace == _undefined || totalSpace == null
              ? _instance.totalSpace
              : (totalSpace as String),
          usedSpace: usedSpace == _undefined || usedSpace == null
              ? _instance.usedSpace
              : (usedSpace as String),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
}

class _CopyWithStubImpl$Query$GetServerDiskVolumesQuery$storage$volumes<TRes>
    implements CopyWith$Query$GetServerDiskVolumesQuery$storage$volumes<TRes> {
  _CopyWithStubImpl$Query$GetServerDiskVolumesQuery$storage$volumes(this._res);

  TRes _res;

  call(
          {String? freeSpace,
          String? name,
          bool? root,
          String? totalSpace,
          String? usedSpace,
          String? $__typename}) =>
      _res;
}
