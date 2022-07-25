import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/utils/scalars.dart';
part 'get_api_tokens.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$GetApiTokensQuery {
  Query$GetApiTokensQuery({required this.api, required this.$__typename});

  @override
  factory Query$GetApiTokensQuery.fromJson(Map<String, dynamic> json) =>
      _$Query$GetApiTokensQueryFromJson(json);

  final Query$GetApiTokensQuery$api api;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetApiTokensQueryToJson(this);
  int get hashCode {
    final l$api = api;
    final l$$__typename = $__typename;
    return Object.hashAll([l$api, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetApiTokensQuery) || runtimeType != other.runtimeType)
      return false;
    final l$api = api;
    final lOther$api = other.api;
    if (l$api != lOther$api) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetApiTokensQuery on Query$GetApiTokensQuery {
  CopyWith$Query$GetApiTokensQuery<Query$GetApiTokensQuery> get copyWith =>
      CopyWith$Query$GetApiTokensQuery(this, (i) => i);
}

abstract class CopyWith$Query$GetApiTokensQuery<TRes> {
  factory CopyWith$Query$GetApiTokensQuery(Query$GetApiTokensQuery instance,
          TRes Function(Query$GetApiTokensQuery) then) =
      _CopyWithImpl$Query$GetApiTokensQuery;

  factory CopyWith$Query$GetApiTokensQuery.stub(TRes res) =
      _CopyWithStubImpl$Query$GetApiTokensQuery;

  TRes call({Query$GetApiTokensQuery$api? api, String? $__typename});
  CopyWith$Query$GetApiTokensQuery$api<TRes> get api;
}

class _CopyWithImpl$Query$GetApiTokensQuery<TRes>
    implements CopyWith$Query$GetApiTokensQuery<TRes> {
  _CopyWithImpl$Query$GetApiTokensQuery(this._instance, this._then);

  final Query$GetApiTokensQuery _instance;

  final TRes Function(Query$GetApiTokensQuery) _then;

  static const _undefined = {};

  TRes call({Object? api = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$GetApiTokensQuery(
          api: api == _undefined || api == null
              ? _instance.api
              : (api as Query$GetApiTokensQuery$api),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Query$GetApiTokensQuery$api<TRes> get api {
    final local$api = _instance.api;
    return CopyWith$Query$GetApiTokensQuery$api(local$api, (e) => call(api: e));
  }
}

class _CopyWithStubImpl$Query$GetApiTokensQuery<TRes>
    implements CopyWith$Query$GetApiTokensQuery<TRes> {
  _CopyWithStubImpl$Query$GetApiTokensQuery(this._res);

  TRes _res;

  call({Query$GetApiTokensQuery$api? api, String? $__typename}) => _res;
  CopyWith$Query$GetApiTokensQuery$api<TRes> get api =>
      CopyWith$Query$GetApiTokensQuery$api.stub(_res);
}

const documentNodeQueryGetApiTokensQuery = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetApiTokensQuery'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'api'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'devices'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'creationDate'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'isCaller'),
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
Query$GetApiTokensQuery _parserFn$Query$GetApiTokensQuery(
        Map<String, dynamic> data) =>
    Query$GetApiTokensQuery.fromJson(data);

class Options$Query$GetApiTokensQuery
    extends graphql.QueryOptions<Query$GetApiTokensQuery> {
  Options$Query$GetApiTokensQuery(
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
            document: documentNodeQueryGetApiTokensQuery,
            parserFn: _parserFn$Query$GetApiTokensQuery);
}

class WatchOptions$Query$GetApiTokensQuery
    extends graphql.WatchQueryOptions<Query$GetApiTokensQuery> {
  WatchOptions$Query$GetApiTokensQuery(
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
            document: documentNodeQueryGetApiTokensQuery,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Query$GetApiTokensQuery);
}

class FetchMoreOptions$Query$GetApiTokensQuery
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetApiTokensQuery(
      {required graphql.UpdateQuery updateQuery})
      : super(
            updateQuery: updateQuery,
            document: documentNodeQueryGetApiTokensQuery);
}

extension ClientExtension$Query$GetApiTokensQuery on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetApiTokensQuery>> query$GetApiTokensQuery(
          [Options$Query$GetApiTokensQuery? options]) async =>
      await this.query(options ?? Options$Query$GetApiTokensQuery());
  graphql.ObservableQuery<Query$GetApiTokensQuery> watchQuery$GetApiTokensQuery(
          [WatchOptions$Query$GetApiTokensQuery? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetApiTokensQuery());
  void writeQuery$GetApiTokensQuery(
          {required Query$GetApiTokensQuery data, bool broadcast = true}) =>
      this.writeQuery(
          graphql.Request(
              operation: graphql.Operation(
                  document: documentNodeQueryGetApiTokensQuery)),
          data: data.toJson(),
          broadcast: broadcast);
  Query$GetApiTokensQuery? readQuery$GetApiTokensQuery(
      {bool optimistic = true}) {
    final result = this.readQuery(
        graphql.Request(
            operation: graphql.Operation(
                document: documentNodeQueryGetApiTokensQuery)),
        optimistic: optimistic);
    return result == null ? null : Query$GetApiTokensQuery.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Query$GetApiTokensQuery$api {
  Query$GetApiTokensQuery$api(
      {required this.devices, required this.$__typename});

  @override
  factory Query$GetApiTokensQuery$api.fromJson(Map<String, dynamic> json) =>
      _$Query$GetApiTokensQuery$apiFromJson(json);

  final List<Query$GetApiTokensQuery$api$devices> devices;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetApiTokensQuery$apiToJson(this);
  int get hashCode {
    final l$devices = devices;
    final l$$__typename = $__typename;
    return Object.hashAll(
        [Object.hashAll(l$devices.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetApiTokensQuery$api) ||
        runtimeType != other.runtimeType) return false;
    final l$devices = devices;
    final lOther$devices = other.devices;
    if (l$devices.length != lOther$devices.length) return false;
    for (int i = 0; i < l$devices.length; i++) {
      final l$devices$entry = l$devices[i];
      final lOther$devices$entry = lOther$devices[i];
      if (l$devices$entry != lOther$devices$entry) return false;
    }

    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetApiTokensQuery$api
    on Query$GetApiTokensQuery$api {
  CopyWith$Query$GetApiTokensQuery$api<Query$GetApiTokensQuery$api>
      get copyWith => CopyWith$Query$GetApiTokensQuery$api(this, (i) => i);
}

abstract class CopyWith$Query$GetApiTokensQuery$api<TRes> {
  factory CopyWith$Query$GetApiTokensQuery$api(
          Query$GetApiTokensQuery$api instance,
          TRes Function(Query$GetApiTokensQuery$api) then) =
      _CopyWithImpl$Query$GetApiTokensQuery$api;

  factory CopyWith$Query$GetApiTokensQuery$api.stub(TRes res) =
      _CopyWithStubImpl$Query$GetApiTokensQuery$api;

  TRes call(
      {List<Query$GetApiTokensQuery$api$devices>? devices,
      String? $__typename});
  TRes devices(
      Iterable<Query$GetApiTokensQuery$api$devices> Function(
              Iterable<
                  CopyWith$Query$GetApiTokensQuery$api$devices<
                      Query$GetApiTokensQuery$api$devices>>)
          _fn);
}

class _CopyWithImpl$Query$GetApiTokensQuery$api<TRes>
    implements CopyWith$Query$GetApiTokensQuery$api<TRes> {
  _CopyWithImpl$Query$GetApiTokensQuery$api(this._instance, this._then);

  final Query$GetApiTokensQuery$api _instance;

  final TRes Function(Query$GetApiTokensQuery$api) _then;

  static const _undefined = {};

  TRes call({Object? devices = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$GetApiTokensQuery$api(
          devices: devices == _undefined || devices == null
              ? _instance.devices
              : (devices as List<Query$GetApiTokensQuery$api$devices>),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  TRes devices(
          Iterable<Query$GetApiTokensQuery$api$devices> Function(
                  Iterable<
                      CopyWith$Query$GetApiTokensQuery$api$devices<
                          Query$GetApiTokensQuery$api$devices>>)
              _fn) =>
      call(
          devices: _fn(_instance.devices.map((e) =>
                  CopyWith$Query$GetApiTokensQuery$api$devices(e, (i) => i)))
              .toList());
}

class _CopyWithStubImpl$Query$GetApiTokensQuery$api<TRes>
    implements CopyWith$Query$GetApiTokensQuery$api<TRes> {
  _CopyWithStubImpl$Query$GetApiTokensQuery$api(this._res);

  TRes _res;

  call(
          {List<Query$GetApiTokensQuery$api$devices>? devices,
          String? $__typename}) =>
      _res;
  devices(_fn) => _res;
}

@JsonSerializable(explicitToJson: true)
class Query$GetApiTokensQuery$api$devices {
  Query$GetApiTokensQuery$api$devices(
      {required this.creationDate,
      required this.isCaller,
      required this.name,
      required this.$__typename});

  @override
  factory Query$GetApiTokensQuery$api$devices.fromJson(
          Map<String, dynamic> json) =>
      _$Query$GetApiTokensQuery$api$devicesFromJson(json);

  @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime creationDate;

  final bool isCaller;

  final String name;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$GetApiTokensQuery$api$devicesToJson(this);
  int get hashCode {
    final l$creationDate = creationDate;
    final l$isCaller = isCaller;
    final l$name = name;
    final l$$__typename = $__typename;
    return Object.hashAll([l$creationDate, l$isCaller, l$name, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetApiTokensQuery$api$devices) ||
        runtimeType != other.runtimeType) return false;
    final l$creationDate = creationDate;
    final lOther$creationDate = other.creationDate;
    if (l$creationDate != lOther$creationDate) return false;
    final l$isCaller = isCaller;
    final lOther$isCaller = other.isCaller;
    if (l$isCaller != lOther$isCaller) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetApiTokensQuery$api$devices
    on Query$GetApiTokensQuery$api$devices {
  CopyWith$Query$GetApiTokensQuery$api$devices<
          Query$GetApiTokensQuery$api$devices>
      get copyWith =>
          CopyWith$Query$GetApiTokensQuery$api$devices(this, (i) => i);
}

abstract class CopyWith$Query$GetApiTokensQuery$api$devices<TRes> {
  factory CopyWith$Query$GetApiTokensQuery$api$devices(
          Query$GetApiTokensQuery$api$devices instance,
          TRes Function(Query$GetApiTokensQuery$api$devices) then) =
      _CopyWithImpl$Query$GetApiTokensQuery$api$devices;

  factory CopyWith$Query$GetApiTokensQuery$api$devices.stub(TRes res) =
      _CopyWithStubImpl$Query$GetApiTokensQuery$api$devices;

  TRes call(
      {DateTime? creationDate,
      bool? isCaller,
      String? name,
      String? $__typename});
}

class _CopyWithImpl$Query$GetApiTokensQuery$api$devices<TRes>
    implements CopyWith$Query$GetApiTokensQuery$api$devices<TRes> {
  _CopyWithImpl$Query$GetApiTokensQuery$api$devices(this._instance, this._then);

  final Query$GetApiTokensQuery$api$devices _instance;

  final TRes Function(Query$GetApiTokensQuery$api$devices) _then;

  static const _undefined = {};

  TRes call(
          {Object? creationDate = _undefined,
          Object? isCaller = _undefined,
          Object? name = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$GetApiTokensQuery$api$devices(
          creationDate: creationDate == _undefined || creationDate == null
              ? _instance.creationDate
              : (creationDate as DateTime),
          isCaller: isCaller == _undefined || isCaller == null
              ? _instance.isCaller
              : (isCaller as bool),
          name: name == _undefined || name == null
              ? _instance.name
              : (name as String),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
}

class _CopyWithStubImpl$Query$GetApiTokensQuery$api$devices<TRes>
    implements CopyWith$Query$GetApiTokensQuery$api$devices<TRes> {
  _CopyWithStubImpl$Query$GetApiTokensQuery$api$devices(this._res);

  TRes _res;

  call(
          {DateTime? creationDate,
          bool? isCaller,
          String? name,
          String? $__typename}) =>
      _res;
}
