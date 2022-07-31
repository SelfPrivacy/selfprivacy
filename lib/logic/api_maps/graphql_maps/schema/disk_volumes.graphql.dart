import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:json_annotation/json_annotation.dart';
part 'disk_volumes.graphql.g.dart';

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
      required this.model,
      required this.name,
      required this.root,
      required this.serial,
      required this.totalSpace,
      required this.type,
      required this.usedSpace,
      required this.$__typename});

  @override
  factory Query$GetServerDiskVolumesQuery$storage$volumes.fromJson(
          Map<String, dynamic> json) =>
      _$Query$GetServerDiskVolumesQuery$storage$volumesFromJson(json);

  final String freeSpace;

  final String model;

  final String name;

  final bool root;

  final String serial;

  final String totalSpace;

  final String type;

  final String usedSpace;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$GetServerDiskVolumesQuery$storage$volumesToJson(this);
  int get hashCode {
    final l$freeSpace = freeSpace;
    final l$model = model;
    final l$name = name;
    final l$root = root;
    final l$serial = serial;
    final l$totalSpace = totalSpace;
    final l$type = type;
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
      String? model,
      String? name,
      bool? root,
      String? serial,
      String? totalSpace,
      String? type,
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
          Object? model = _undefined,
          Object? name = _undefined,
          Object? root = _undefined,
          Object? serial = _undefined,
          Object? totalSpace = _undefined,
          Object? type = _undefined,
          Object? usedSpace = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$GetServerDiskVolumesQuery$storage$volumes(
          freeSpace: freeSpace == _undefined || freeSpace == null
              ? _instance.freeSpace
              : (freeSpace as String),
          model: model == _undefined || model == null
              ? _instance.model
              : (model as String),
          name: name == _undefined || name == null
              ? _instance.name
              : (name as String),
          root: root == _undefined || root == null
              ? _instance.root
              : (root as bool),
          serial: serial == _undefined || serial == null
              ? _instance.serial
              : (serial as String),
          totalSpace: totalSpace == _undefined || totalSpace == null
              ? _instance.totalSpace
              : (totalSpace as String),
          type: type == _undefined || type == null
              ? _instance.type
              : (type as String),
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
          String? model,
          String? name,
          bool? root,
          String? serial,
          String? totalSpace,
          String? type,
          String? usedSpace,
          String? $__typename}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$MountVolumeMutation {
  Variables$Mutation$MountVolumeMutation({required this.name});

  @override
  factory Variables$Mutation$MountVolumeMutation.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$MountVolumeMutationFromJson(json);

  final String name;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$MountVolumeMutationToJson(this);
  int get hashCode {
    final l$name = name;
    return Object.hashAll([l$name]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$MountVolumeMutation) ||
        runtimeType != other.runtimeType) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    return true;
  }

  CopyWith$Variables$Mutation$MountVolumeMutation<
          Variables$Mutation$MountVolumeMutation>
      get copyWith =>
          CopyWith$Variables$Mutation$MountVolumeMutation(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$MountVolumeMutation<TRes> {
  factory CopyWith$Variables$Mutation$MountVolumeMutation(
          Variables$Mutation$MountVolumeMutation instance,
          TRes Function(Variables$Mutation$MountVolumeMutation) then) =
      _CopyWithImpl$Variables$Mutation$MountVolumeMutation;

  factory CopyWith$Variables$Mutation$MountVolumeMutation.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$MountVolumeMutation;

  TRes call({String? name});
}

class _CopyWithImpl$Variables$Mutation$MountVolumeMutation<TRes>
    implements CopyWith$Variables$Mutation$MountVolumeMutation<TRes> {
  _CopyWithImpl$Variables$Mutation$MountVolumeMutation(
      this._instance, this._then);

  final Variables$Mutation$MountVolumeMutation _instance;

  final TRes Function(Variables$Mutation$MountVolumeMutation) _then;

  static const _undefined = {};

  TRes call({Object? name = _undefined}) =>
      _then(Variables$Mutation$MountVolumeMutation(
          name: name == _undefined || name == null
              ? _instance.name
              : (name as String)));
}

class _CopyWithStubImpl$Variables$Mutation$MountVolumeMutation<TRes>
    implements CopyWith$Variables$Mutation$MountVolumeMutation<TRes> {
  _CopyWithStubImpl$Variables$Mutation$MountVolumeMutation(this._res);

  TRes _res;

  call({String? name}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Mutation$MountVolumeMutation {
  Mutation$MountVolumeMutation(
      {required this.mountVolume, required this.$__typename});

  @override
  factory Mutation$MountVolumeMutation.fromJson(Map<String, dynamic> json) =>
      _$Mutation$MountVolumeMutationFromJson(json);

  final Mutation$MountVolumeMutation$mountVolume mountVolume;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$MountVolumeMutationToJson(this);
  int get hashCode {
    final l$mountVolume = mountVolume;
    final l$$__typename = $__typename;
    return Object.hashAll([l$mountVolume, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$MountVolumeMutation) ||
        runtimeType != other.runtimeType) return false;
    final l$mountVolume = mountVolume;
    final lOther$mountVolume = other.mountVolume;
    if (l$mountVolume != lOther$mountVolume) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$MountVolumeMutation
    on Mutation$MountVolumeMutation {
  CopyWith$Mutation$MountVolumeMutation<Mutation$MountVolumeMutation>
      get copyWith => CopyWith$Mutation$MountVolumeMutation(this, (i) => i);
}

abstract class CopyWith$Mutation$MountVolumeMutation<TRes> {
  factory CopyWith$Mutation$MountVolumeMutation(
          Mutation$MountVolumeMutation instance,
          TRes Function(Mutation$MountVolumeMutation) then) =
      _CopyWithImpl$Mutation$MountVolumeMutation;

  factory CopyWith$Mutation$MountVolumeMutation.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MountVolumeMutation;

  TRes call(
      {Mutation$MountVolumeMutation$mountVolume? mountVolume,
      String? $__typename});
  CopyWith$Mutation$MountVolumeMutation$mountVolume<TRes> get mountVolume;
}

class _CopyWithImpl$Mutation$MountVolumeMutation<TRes>
    implements CopyWith$Mutation$MountVolumeMutation<TRes> {
  _CopyWithImpl$Mutation$MountVolumeMutation(this._instance, this._then);

  final Mutation$MountVolumeMutation _instance;

  final TRes Function(Mutation$MountVolumeMutation) _then;

  static const _undefined = {};

  TRes call(
          {Object? mountVolume = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$MountVolumeMutation(
          mountVolume: mountVolume == _undefined || mountVolume == null
              ? _instance.mountVolume
              : (mountVolume as Mutation$MountVolumeMutation$mountVolume),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$MountVolumeMutation$mountVolume<TRes> get mountVolume {
    final local$mountVolume = _instance.mountVolume;
    return CopyWith$Mutation$MountVolumeMutation$mountVolume(
        local$mountVolume, (e) => call(mountVolume: e));
  }
}

class _CopyWithStubImpl$Mutation$MountVolumeMutation<TRes>
    implements CopyWith$Mutation$MountVolumeMutation<TRes> {
  _CopyWithStubImpl$Mutation$MountVolumeMutation(this._res);

  TRes _res;

  call(
          {Mutation$MountVolumeMutation$mountVolume? mountVolume,
          String? $__typename}) =>
      _res;
  CopyWith$Mutation$MountVolumeMutation$mountVolume<TRes> get mountVolume =>
      CopyWith$Mutation$MountVolumeMutation$mountVolume.stub(_res);
}

const documentNodeMutationMountVolumeMutation = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'MountVolumeMutation'),
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
            ])),
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
]);
Mutation$MountVolumeMutation _parserFn$Mutation$MountVolumeMutation(
        Map<String, dynamic> data) =>
    Mutation$MountVolumeMutation.fromJson(data);
typedef OnMutationCompleted$Mutation$MountVolumeMutation = FutureOr<void>
    Function(dynamic, Mutation$MountVolumeMutation?);

class Options$Mutation$MountVolumeMutation
    extends graphql.MutationOptions<Mutation$MountVolumeMutation> {
  Options$Mutation$MountVolumeMutation(
      {String? operationName,
      required Variables$Mutation$MountVolumeMutation variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$MountVolumeMutation? onCompleted,
      graphql.OnMutationUpdate<Mutation$MountVolumeMutation>? update,
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
                        : _parserFn$Mutation$MountVolumeMutation(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationMountVolumeMutation,
            parserFn: _parserFn$Mutation$MountVolumeMutation);

  final OnMutationCompleted$Mutation$MountVolumeMutation? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$MountVolumeMutation
    extends graphql.WatchQueryOptions<Mutation$MountVolumeMutation> {
  WatchOptions$Mutation$MountVolumeMutation(
      {String? operationName,
      required Variables$Mutation$MountVolumeMutation variables,
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
            document: documentNodeMutationMountVolumeMutation,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$MountVolumeMutation);
}

extension ClientExtension$Mutation$MountVolumeMutation
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$MountVolumeMutation>>
      mutate$MountVolumeMutation(
              Options$Mutation$MountVolumeMutation options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$MountVolumeMutation>
      watchMutation$MountVolumeMutation(
              WatchOptions$Mutation$MountVolumeMutation options) =>
          this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$MountVolumeMutation$mountVolume {
  Mutation$MountVolumeMutation$mountVolume(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$MountVolumeMutation$mountVolume.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$MountVolumeMutation$mountVolumeFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$MountVolumeMutation$mountVolumeToJson(this);
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
    if (!(other is Mutation$MountVolumeMutation$mountVolume) ||
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

extension UtilityExtension$Mutation$MountVolumeMutation$mountVolume
    on Mutation$MountVolumeMutation$mountVolume {
  CopyWith$Mutation$MountVolumeMutation$mountVolume<
          Mutation$MountVolumeMutation$mountVolume>
      get copyWith =>
          CopyWith$Mutation$MountVolumeMutation$mountVolume(this, (i) => i);
}

abstract class CopyWith$Mutation$MountVolumeMutation$mountVolume<TRes> {
  factory CopyWith$Mutation$MountVolumeMutation$mountVolume(
          Mutation$MountVolumeMutation$mountVolume instance,
          TRes Function(Mutation$MountVolumeMutation$mountVolume) then) =
      _CopyWithImpl$Mutation$MountVolumeMutation$mountVolume;

  factory CopyWith$Mutation$MountVolumeMutation$mountVolume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MountVolumeMutation$mountVolume;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$MountVolumeMutation$mountVolume<TRes>
    implements CopyWith$Mutation$MountVolumeMutation$mountVolume<TRes> {
  _CopyWithImpl$Mutation$MountVolumeMutation$mountVolume(
      this._instance, this._then);

  final Mutation$MountVolumeMutation$mountVolume _instance;

  final TRes Function(Mutation$MountVolumeMutation$mountVolume) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$MountVolumeMutation$mountVolume(
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

class _CopyWithStubImpl$Mutation$MountVolumeMutation$mountVolume<TRes>
    implements CopyWith$Mutation$MountVolumeMutation$mountVolume<TRes> {
  _CopyWithStubImpl$Mutation$MountVolumeMutation$mountVolume(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$ResizeVolumeMutation {
  Variables$Mutation$ResizeVolumeMutation({required this.name});

  @override
  factory Variables$Mutation$ResizeVolumeMutation.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$ResizeVolumeMutationFromJson(json);

  final String name;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$ResizeVolumeMutationToJson(this);
  int get hashCode {
    final l$name = name;
    return Object.hashAll([l$name]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$ResizeVolumeMutation) ||
        runtimeType != other.runtimeType) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    return true;
  }

  CopyWith$Variables$Mutation$ResizeVolumeMutation<
          Variables$Mutation$ResizeVolumeMutation>
      get copyWith =>
          CopyWith$Variables$Mutation$ResizeVolumeMutation(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$ResizeVolumeMutation<TRes> {
  factory CopyWith$Variables$Mutation$ResizeVolumeMutation(
          Variables$Mutation$ResizeVolumeMutation instance,
          TRes Function(Variables$Mutation$ResizeVolumeMutation) then) =
      _CopyWithImpl$Variables$Mutation$ResizeVolumeMutation;

  factory CopyWith$Variables$Mutation$ResizeVolumeMutation.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ResizeVolumeMutation;

  TRes call({String? name});
}

class _CopyWithImpl$Variables$Mutation$ResizeVolumeMutation<TRes>
    implements CopyWith$Variables$Mutation$ResizeVolumeMutation<TRes> {
  _CopyWithImpl$Variables$Mutation$ResizeVolumeMutation(
      this._instance, this._then);

  final Variables$Mutation$ResizeVolumeMutation _instance;

  final TRes Function(Variables$Mutation$ResizeVolumeMutation) _then;

  static const _undefined = {};

  TRes call({Object? name = _undefined}) =>
      _then(Variables$Mutation$ResizeVolumeMutation(
          name: name == _undefined || name == null
              ? _instance.name
              : (name as String)));
}

class _CopyWithStubImpl$Variables$Mutation$ResizeVolumeMutation<TRes>
    implements CopyWith$Variables$Mutation$ResizeVolumeMutation<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ResizeVolumeMutation(this._res);

  TRes _res;

  call({String? name}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Mutation$ResizeVolumeMutation {
  Mutation$ResizeVolumeMutation(
      {required this.resizeVolume, required this.$__typename});

  @override
  factory Mutation$ResizeVolumeMutation.fromJson(Map<String, dynamic> json) =>
      _$Mutation$ResizeVolumeMutationFromJson(json);

  final Mutation$ResizeVolumeMutation$resizeVolume resizeVolume;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$ResizeVolumeMutationToJson(this);
  int get hashCode {
    final l$resizeVolume = resizeVolume;
    final l$$__typename = $__typename;
    return Object.hashAll([l$resizeVolume, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$ResizeVolumeMutation) ||
        runtimeType != other.runtimeType) return false;
    final l$resizeVolume = resizeVolume;
    final lOther$resizeVolume = other.resizeVolume;
    if (l$resizeVolume != lOther$resizeVolume) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$ResizeVolumeMutation
    on Mutation$ResizeVolumeMutation {
  CopyWith$Mutation$ResizeVolumeMutation<Mutation$ResizeVolumeMutation>
      get copyWith => CopyWith$Mutation$ResizeVolumeMutation(this, (i) => i);
}

abstract class CopyWith$Mutation$ResizeVolumeMutation<TRes> {
  factory CopyWith$Mutation$ResizeVolumeMutation(
          Mutation$ResizeVolumeMutation instance,
          TRes Function(Mutation$ResizeVolumeMutation) then) =
      _CopyWithImpl$Mutation$ResizeVolumeMutation;

  factory CopyWith$Mutation$ResizeVolumeMutation.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ResizeVolumeMutation;

  TRes call(
      {Mutation$ResizeVolumeMutation$resizeVolume? resizeVolume,
      String? $__typename});
  CopyWith$Mutation$ResizeVolumeMutation$resizeVolume<TRes> get resizeVolume;
}

class _CopyWithImpl$Mutation$ResizeVolumeMutation<TRes>
    implements CopyWith$Mutation$ResizeVolumeMutation<TRes> {
  _CopyWithImpl$Mutation$ResizeVolumeMutation(this._instance, this._then);

  final Mutation$ResizeVolumeMutation _instance;

  final TRes Function(Mutation$ResizeVolumeMutation) _then;

  static const _undefined = {};

  TRes call(
          {Object? resizeVolume = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$ResizeVolumeMutation(
          resizeVolume: resizeVolume == _undefined || resizeVolume == null
              ? _instance.resizeVolume
              : (resizeVolume as Mutation$ResizeVolumeMutation$resizeVolume),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$ResizeVolumeMutation$resizeVolume<TRes> get resizeVolume {
    final local$resizeVolume = _instance.resizeVolume;
    return CopyWith$Mutation$ResizeVolumeMutation$resizeVolume(
        local$resizeVolume, (e) => call(resizeVolume: e));
  }
}

class _CopyWithStubImpl$Mutation$ResizeVolumeMutation<TRes>
    implements CopyWith$Mutation$ResizeVolumeMutation<TRes> {
  _CopyWithStubImpl$Mutation$ResizeVolumeMutation(this._res);

  TRes _res;

  call(
          {Mutation$ResizeVolumeMutation$resizeVolume? resizeVolume,
          String? $__typename}) =>
      _res;
  CopyWith$Mutation$ResizeVolumeMutation$resizeVolume<TRes> get resizeVolume =>
      CopyWith$Mutation$ResizeVolumeMutation$resizeVolume.stub(_res);
}

const documentNodeMutationResizeVolumeMutation = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ResizeVolumeMutation'),
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
            ])),
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
]);
Mutation$ResizeVolumeMutation _parserFn$Mutation$ResizeVolumeMutation(
        Map<String, dynamic> data) =>
    Mutation$ResizeVolumeMutation.fromJson(data);
typedef OnMutationCompleted$Mutation$ResizeVolumeMutation = FutureOr<void>
    Function(dynamic, Mutation$ResizeVolumeMutation?);

class Options$Mutation$ResizeVolumeMutation
    extends graphql.MutationOptions<Mutation$ResizeVolumeMutation> {
  Options$Mutation$ResizeVolumeMutation(
      {String? operationName,
      required Variables$Mutation$ResizeVolumeMutation variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$ResizeVolumeMutation? onCompleted,
      graphql.OnMutationUpdate<Mutation$ResizeVolumeMutation>? update,
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
                        : _parserFn$Mutation$ResizeVolumeMutation(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationResizeVolumeMutation,
            parserFn: _parserFn$Mutation$ResizeVolumeMutation);

  final OnMutationCompleted$Mutation$ResizeVolumeMutation?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$ResizeVolumeMutation
    extends graphql.WatchQueryOptions<Mutation$ResizeVolumeMutation> {
  WatchOptions$Mutation$ResizeVolumeMutation(
      {String? operationName,
      required Variables$Mutation$ResizeVolumeMutation variables,
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
            document: documentNodeMutationResizeVolumeMutation,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$ResizeVolumeMutation);
}

extension ClientExtension$Mutation$ResizeVolumeMutation
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ResizeVolumeMutation>>
      mutate$ResizeVolumeMutation(
              Options$Mutation$ResizeVolumeMutation options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$ResizeVolumeMutation>
      watchMutation$ResizeVolumeMutation(
              WatchOptions$Mutation$ResizeVolumeMutation options) =>
          this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$ResizeVolumeMutation$resizeVolume {
  Mutation$ResizeVolumeMutation$resizeVolume(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$ResizeVolumeMutation$resizeVolume.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$ResizeVolumeMutation$resizeVolumeFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$ResizeVolumeMutation$resizeVolumeToJson(this);
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
    if (!(other is Mutation$ResizeVolumeMutation$resizeVolume) ||
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

extension UtilityExtension$Mutation$ResizeVolumeMutation$resizeVolume
    on Mutation$ResizeVolumeMutation$resizeVolume {
  CopyWith$Mutation$ResizeVolumeMutation$resizeVolume<
          Mutation$ResizeVolumeMutation$resizeVolume>
      get copyWith =>
          CopyWith$Mutation$ResizeVolumeMutation$resizeVolume(this, (i) => i);
}

abstract class CopyWith$Mutation$ResizeVolumeMutation$resizeVolume<TRes> {
  factory CopyWith$Mutation$ResizeVolumeMutation$resizeVolume(
          Mutation$ResizeVolumeMutation$resizeVolume instance,
          TRes Function(Mutation$ResizeVolumeMutation$resizeVolume) then) =
      _CopyWithImpl$Mutation$ResizeVolumeMutation$resizeVolume;

  factory CopyWith$Mutation$ResizeVolumeMutation$resizeVolume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ResizeVolumeMutation$resizeVolume;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$ResizeVolumeMutation$resizeVolume<TRes>
    implements CopyWith$Mutation$ResizeVolumeMutation$resizeVolume<TRes> {
  _CopyWithImpl$Mutation$ResizeVolumeMutation$resizeVolume(
      this._instance, this._then);

  final Mutation$ResizeVolumeMutation$resizeVolume _instance;

  final TRes Function(Mutation$ResizeVolumeMutation$resizeVolume) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$ResizeVolumeMutation$resizeVolume(
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

class _CopyWithStubImpl$Mutation$ResizeVolumeMutation$resizeVolume<TRes>
    implements CopyWith$Mutation$ResizeVolumeMutation$resizeVolume<TRes> {
  _CopyWithStubImpl$Mutation$ResizeVolumeMutation$resizeVolume(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$UnmountVolumeMutation {
  Variables$Mutation$UnmountVolumeMutation({required this.name});

  @override
  factory Variables$Mutation$UnmountVolumeMutation.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$UnmountVolumeMutationFromJson(json);

  final String name;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$UnmountVolumeMutationToJson(this);
  int get hashCode {
    final l$name = name;
    return Object.hashAll([l$name]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$UnmountVolumeMutation) ||
        runtimeType != other.runtimeType) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    return true;
  }

  CopyWith$Variables$Mutation$UnmountVolumeMutation<
          Variables$Mutation$UnmountVolumeMutation>
      get copyWith =>
          CopyWith$Variables$Mutation$UnmountVolumeMutation(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$UnmountVolumeMutation<TRes> {
  factory CopyWith$Variables$Mutation$UnmountVolumeMutation(
          Variables$Mutation$UnmountVolumeMutation instance,
          TRes Function(Variables$Mutation$UnmountVolumeMutation) then) =
      _CopyWithImpl$Variables$Mutation$UnmountVolumeMutation;

  factory CopyWith$Variables$Mutation$UnmountVolumeMutation.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UnmountVolumeMutation;

  TRes call({String? name});
}

class _CopyWithImpl$Variables$Mutation$UnmountVolumeMutation<TRes>
    implements CopyWith$Variables$Mutation$UnmountVolumeMutation<TRes> {
  _CopyWithImpl$Variables$Mutation$UnmountVolumeMutation(
      this._instance, this._then);

  final Variables$Mutation$UnmountVolumeMutation _instance;

  final TRes Function(Variables$Mutation$UnmountVolumeMutation) _then;

  static const _undefined = {};

  TRes call({Object? name = _undefined}) =>
      _then(Variables$Mutation$UnmountVolumeMutation(
          name: name == _undefined || name == null
              ? _instance.name
              : (name as String)));
}

class _CopyWithStubImpl$Variables$Mutation$UnmountVolumeMutation<TRes>
    implements CopyWith$Variables$Mutation$UnmountVolumeMutation<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UnmountVolumeMutation(this._res);

  TRes _res;

  call({String? name}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Mutation$UnmountVolumeMutation {
  Mutation$UnmountVolumeMutation(
      {required this.unmountVolume, required this.$__typename});

  @override
  factory Mutation$UnmountVolumeMutation.fromJson(Map<String, dynamic> json) =>
      _$Mutation$UnmountVolumeMutationFromJson(json);

  final Mutation$UnmountVolumeMutation$unmountVolume unmountVolume;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$UnmountVolumeMutationToJson(this);
  int get hashCode {
    final l$unmountVolume = unmountVolume;
    final l$$__typename = $__typename;
    return Object.hashAll([l$unmountVolume, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$UnmountVolumeMutation) ||
        runtimeType != other.runtimeType) return false;
    final l$unmountVolume = unmountVolume;
    final lOther$unmountVolume = other.unmountVolume;
    if (l$unmountVolume != lOther$unmountVolume) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$UnmountVolumeMutation
    on Mutation$UnmountVolumeMutation {
  CopyWith$Mutation$UnmountVolumeMutation<Mutation$UnmountVolumeMutation>
      get copyWith => CopyWith$Mutation$UnmountVolumeMutation(this, (i) => i);
}

abstract class CopyWith$Mutation$UnmountVolumeMutation<TRes> {
  factory CopyWith$Mutation$UnmountVolumeMutation(
          Mutation$UnmountVolumeMutation instance,
          TRes Function(Mutation$UnmountVolumeMutation) then) =
      _CopyWithImpl$Mutation$UnmountVolumeMutation;

  factory CopyWith$Mutation$UnmountVolumeMutation.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UnmountVolumeMutation;

  TRes call(
      {Mutation$UnmountVolumeMutation$unmountVolume? unmountVolume,
      String? $__typename});
  CopyWith$Mutation$UnmountVolumeMutation$unmountVolume<TRes> get unmountVolume;
}

class _CopyWithImpl$Mutation$UnmountVolumeMutation<TRes>
    implements CopyWith$Mutation$UnmountVolumeMutation<TRes> {
  _CopyWithImpl$Mutation$UnmountVolumeMutation(this._instance, this._then);

  final Mutation$UnmountVolumeMutation _instance;

  final TRes Function(Mutation$UnmountVolumeMutation) _then;

  static const _undefined = {};

  TRes call(
          {Object? unmountVolume = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$UnmountVolumeMutation(
          unmountVolume: unmountVolume == _undefined || unmountVolume == null
              ? _instance.unmountVolume
              : (unmountVolume as Mutation$UnmountVolumeMutation$unmountVolume),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$UnmountVolumeMutation$unmountVolume<TRes>
      get unmountVolume {
    final local$unmountVolume = _instance.unmountVolume;
    return CopyWith$Mutation$UnmountVolumeMutation$unmountVolume(
        local$unmountVolume, (e) => call(unmountVolume: e));
  }
}

class _CopyWithStubImpl$Mutation$UnmountVolumeMutation<TRes>
    implements CopyWith$Mutation$UnmountVolumeMutation<TRes> {
  _CopyWithStubImpl$Mutation$UnmountVolumeMutation(this._res);

  TRes _res;

  call(
          {Mutation$UnmountVolumeMutation$unmountVolume? unmountVolume,
          String? $__typename}) =>
      _res;
  CopyWith$Mutation$UnmountVolumeMutation$unmountVolume<TRes>
      get unmountVolume =>
          CopyWith$Mutation$UnmountVolumeMutation$unmountVolume.stub(_res);
}

const documentNodeMutationUnmountVolumeMutation = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UnmountVolumeMutation'),
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
            ])),
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
]);
Mutation$UnmountVolumeMutation _parserFn$Mutation$UnmountVolumeMutation(
        Map<String, dynamic> data) =>
    Mutation$UnmountVolumeMutation.fromJson(data);
typedef OnMutationCompleted$Mutation$UnmountVolumeMutation = FutureOr<void>
    Function(dynamic, Mutation$UnmountVolumeMutation?);

class Options$Mutation$UnmountVolumeMutation
    extends graphql.MutationOptions<Mutation$UnmountVolumeMutation> {
  Options$Mutation$UnmountVolumeMutation(
      {String? operationName,
      required Variables$Mutation$UnmountVolumeMutation variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$UnmountVolumeMutation? onCompleted,
      graphql.OnMutationUpdate<Mutation$UnmountVolumeMutation>? update,
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
                        : _parserFn$Mutation$UnmountVolumeMutation(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationUnmountVolumeMutation,
            parserFn: _parserFn$Mutation$UnmountVolumeMutation);

  final OnMutationCompleted$Mutation$UnmountVolumeMutation?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$UnmountVolumeMutation
    extends graphql.WatchQueryOptions<Mutation$UnmountVolumeMutation> {
  WatchOptions$Mutation$UnmountVolumeMutation(
      {String? operationName,
      required Variables$Mutation$UnmountVolumeMutation variables,
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
            document: documentNodeMutationUnmountVolumeMutation,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$UnmountVolumeMutation);
}

extension ClientExtension$Mutation$UnmountVolumeMutation
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UnmountVolumeMutation>>
      mutate$UnmountVolumeMutation(
              Options$Mutation$UnmountVolumeMutation options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$UnmountVolumeMutation>
      watchMutation$UnmountVolumeMutation(
              WatchOptions$Mutation$UnmountVolumeMutation options) =>
          this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$UnmountVolumeMutation$unmountVolume {
  Mutation$UnmountVolumeMutation$unmountVolume(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$UnmountVolumeMutation$unmountVolume.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$UnmountVolumeMutation$unmountVolumeFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$UnmountVolumeMutation$unmountVolumeToJson(this);
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
    if (!(other is Mutation$UnmountVolumeMutation$unmountVolume) ||
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

extension UtilityExtension$Mutation$UnmountVolumeMutation$unmountVolume
    on Mutation$UnmountVolumeMutation$unmountVolume {
  CopyWith$Mutation$UnmountVolumeMutation$unmountVolume<
          Mutation$UnmountVolumeMutation$unmountVolume>
      get copyWith =>
          CopyWith$Mutation$UnmountVolumeMutation$unmountVolume(this, (i) => i);
}

abstract class CopyWith$Mutation$UnmountVolumeMutation$unmountVolume<TRes> {
  factory CopyWith$Mutation$UnmountVolumeMutation$unmountVolume(
          Mutation$UnmountVolumeMutation$unmountVolume instance,
          TRes Function(Mutation$UnmountVolumeMutation$unmountVolume) then) =
      _CopyWithImpl$Mutation$UnmountVolumeMutation$unmountVolume;

  factory CopyWith$Mutation$UnmountVolumeMutation$unmountVolume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UnmountVolumeMutation$unmountVolume;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$UnmountVolumeMutation$unmountVolume<TRes>
    implements CopyWith$Mutation$UnmountVolumeMutation$unmountVolume<TRes> {
  _CopyWithImpl$Mutation$UnmountVolumeMutation$unmountVolume(
      this._instance, this._then);

  final Mutation$UnmountVolumeMutation$unmountVolume _instance;

  final TRes Function(Mutation$UnmountVolumeMutation$unmountVolume) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$UnmountVolumeMutation$unmountVolume(
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

class _CopyWithStubImpl$Mutation$UnmountVolumeMutation$unmountVolume<TRes>
    implements CopyWith$Mutation$UnmountVolumeMutation$unmountVolume<TRes> {
  _CopyWithStubImpl$Mutation$UnmountVolumeMutation$unmountVolume(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}
