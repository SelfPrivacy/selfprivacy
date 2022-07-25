import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:json_annotation/json_annotation.dart';
part 'get_api_version.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$GetApiVersionQuery {
  Query$GetApiVersionQuery({required this.api, required this.$__typename});

  @override
  factory Query$GetApiVersionQuery.fromJson(Map<String, dynamic> json) =>
      _$Query$GetApiVersionQueryFromJson(json);

  final Query$GetApiVersionQuery$api api;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetApiVersionQueryToJson(this);
  int get hashCode {
    final l$api = api;
    final l$$__typename = $__typename;
    return Object.hashAll([l$api, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetApiVersionQuery) ||
        runtimeType != other.runtimeType) return false;
    final l$api = api;
    final lOther$api = other.api;
    if (l$api != lOther$api) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetApiVersionQuery
    on Query$GetApiVersionQuery {
  CopyWith$Query$GetApiVersionQuery<Query$GetApiVersionQuery> get copyWith =>
      CopyWith$Query$GetApiVersionQuery(this, (i) => i);
}

abstract class CopyWith$Query$GetApiVersionQuery<TRes> {
  factory CopyWith$Query$GetApiVersionQuery(Query$GetApiVersionQuery instance,
          TRes Function(Query$GetApiVersionQuery) then) =
      _CopyWithImpl$Query$GetApiVersionQuery;

  factory CopyWith$Query$GetApiVersionQuery.stub(TRes res) =
      _CopyWithStubImpl$Query$GetApiVersionQuery;

  TRes call({Query$GetApiVersionQuery$api? api, String? $__typename});
  CopyWith$Query$GetApiVersionQuery$api<TRes> get api;
}

class _CopyWithImpl$Query$GetApiVersionQuery<TRes>
    implements CopyWith$Query$GetApiVersionQuery<TRes> {
  _CopyWithImpl$Query$GetApiVersionQuery(this._instance, this._then);

  final Query$GetApiVersionQuery _instance;

  final TRes Function(Query$GetApiVersionQuery) _then;

  static const _undefined = {};

  TRes call({Object? api = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$GetApiVersionQuery(
          api: api == _undefined || api == null
              ? _instance.api
              : (api as Query$GetApiVersionQuery$api),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Query$GetApiVersionQuery$api<TRes> get api {
    final local$api = _instance.api;
    return CopyWith$Query$GetApiVersionQuery$api(
        local$api, (e) => call(api: e));
  }
}

class _CopyWithStubImpl$Query$GetApiVersionQuery<TRes>
    implements CopyWith$Query$GetApiVersionQuery<TRes> {
  _CopyWithStubImpl$Query$GetApiVersionQuery(this._res);

  TRes _res;

  call({Query$GetApiVersionQuery$api? api, String? $__typename}) => _res;
  CopyWith$Query$GetApiVersionQuery$api<TRes> get api =>
      CopyWith$Query$GetApiVersionQuery$api.stub(_res);
}

const documentNodeQueryGetApiVersionQuery = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetApiVersionQuery'),
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
                  name: NameNode(value: 'version'),
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
Query$GetApiVersionQuery _parserFn$Query$GetApiVersionQuery(
        Map<String, dynamic> data) =>
    Query$GetApiVersionQuery.fromJson(data);

class Options$Query$GetApiVersionQuery
    extends graphql.QueryOptions<Query$GetApiVersionQuery> {
  Options$Query$GetApiVersionQuery(
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
            document: documentNodeQueryGetApiVersionQuery,
            parserFn: _parserFn$Query$GetApiVersionQuery);
}

class WatchOptions$Query$GetApiVersionQuery
    extends graphql.WatchQueryOptions<Query$GetApiVersionQuery> {
  WatchOptions$Query$GetApiVersionQuery(
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
            document: documentNodeQueryGetApiVersionQuery,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Query$GetApiVersionQuery);
}

class FetchMoreOptions$Query$GetApiVersionQuery
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetApiVersionQuery(
      {required graphql.UpdateQuery updateQuery})
      : super(
            updateQuery: updateQuery,
            document: documentNodeQueryGetApiVersionQuery);
}

extension ClientExtension$Query$GetApiVersionQuery on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetApiVersionQuery>>
      query$GetApiVersionQuery(
              [Options$Query$GetApiVersionQuery? options]) async =>
          await this.query(options ?? Options$Query$GetApiVersionQuery());
  graphql.ObservableQuery<Query$GetApiVersionQuery>
      watchQuery$GetApiVersionQuery(
              [WatchOptions$Query$GetApiVersionQuery? options]) =>
          this.watchQuery(options ?? WatchOptions$Query$GetApiVersionQuery());
  void writeQuery$GetApiVersionQuery(
          {required Query$GetApiVersionQuery data, bool broadcast = true}) =>
      this.writeQuery(
          graphql.Request(
              operation: graphql.Operation(
                  document: documentNodeQueryGetApiVersionQuery)),
          data: data.toJson(),
          broadcast: broadcast);
  Query$GetApiVersionQuery? readQuery$GetApiVersionQuery(
      {bool optimistic = true}) {
    final result = this.readQuery(
        graphql.Request(
            operation: graphql.Operation(
                document: documentNodeQueryGetApiVersionQuery)),
        optimistic: optimistic);
    return result == null ? null : Query$GetApiVersionQuery.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Query$GetApiVersionQuery$api {
  Query$GetApiVersionQuery$api(
      {required this.version, required this.$__typename});

  @override
  factory Query$GetApiVersionQuery$api.fromJson(Map<String, dynamic> json) =>
      _$Query$GetApiVersionQuery$apiFromJson(json);

  final String version;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetApiVersionQuery$apiToJson(this);
  int get hashCode {
    final l$version = version;
    final l$$__typename = $__typename;
    return Object.hashAll([l$version, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetApiVersionQuery$api) ||
        runtimeType != other.runtimeType) return false;
    final l$version = version;
    final lOther$version = other.version;
    if (l$version != lOther$version) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetApiVersionQuery$api
    on Query$GetApiVersionQuery$api {
  CopyWith$Query$GetApiVersionQuery$api<Query$GetApiVersionQuery$api>
      get copyWith => CopyWith$Query$GetApiVersionQuery$api(this, (i) => i);
}

abstract class CopyWith$Query$GetApiVersionQuery$api<TRes> {
  factory CopyWith$Query$GetApiVersionQuery$api(
          Query$GetApiVersionQuery$api instance,
          TRes Function(Query$GetApiVersionQuery$api) then) =
      _CopyWithImpl$Query$GetApiVersionQuery$api;

  factory CopyWith$Query$GetApiVersionQuery$api.stub(TRes res) =
      _CopyWithStubImpl$Query$GetApiVersionQuery$api;

  TRes call({String? version, String? $__typename});
}

class _CopyWithImpl$Query$GetApiVersionQuery$api<TRes>
    implements CopyWith$Query$GetApiVersionQuery$api<TRes> {
  _CopyWithImpl$Query$GetApiVersionQuery$api(this._instance, this._then);

  final Query$GetApiVersionQuery$api _instance;

  final TRes Function(Query$GetApiVersionQuery$api) _then;

  static const _undefined = {};

  TRes call({Object? version = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$GetApiVersionQuery$api(
          version: version == _undefined || version == null
              ? _instance.version
              : (version as String),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
}

class _CopyWithStubImpl$Query$GetApiVersionQuery$api<TRes>
    implements CopyWith$Query$GetApiVersionQuery$api<TRes> {
  _CopyWithStubImpl$Query$GetApiVersionQuery$api(this._res);

  TRes _res;

  call({String? version, String? $__typename}) => _res;
}
