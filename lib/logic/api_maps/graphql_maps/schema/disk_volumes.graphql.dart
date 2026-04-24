import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'schema.graphql.dart';
import 'server_api.graphql.dart';

class Query$GetServerDiskVolumes {
  Query$GetServerDiskVolumes({
    required this.storage,
    this.$__typename = 'Query',
  });

  factory Query$GetServerDiskVolumes.fromJson(Map<String, dynamic> json) {
    final l$storage = json['storage'];
    final l$$__typename = json['__typename'];
    return Query$GetServerDiskVolumes(
      storage: Query$GetServerDiskVolumes$storage.fromJson(
        (l$storage as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetServerDiskVolumes$storage storage;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$storage = storage;
    _resultData['storage'] = l$storage.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$storage = storage;
    final l$$__typename = $__typename;
    return Object.hashAll([l$storage, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetServerDiskVolumes ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$storage = storage;
    final lOther$storage = other.storage;
    if (l$storage != lOther$storage) {
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

extension UtilityExtension$Query$GetServerDiskVolumes
    on Query$GetServerDiskVolumes {
  CopyWith$Query$GetServerDiskVolumes<Query$GetServerDiskVolumes>
  get copyWith => CopyWith$Query$GetServerDiskVolumes(this, (i) => i);
}

abstract class CopyWith$Query$GetServerDiskVolumes<TRes> {
  factory CopyWith$Query$GetServerDiskVolumes(
    Query$GetServerDiskVolumes instance,
    TRes Function(Query$GetServerDiskVolumes) then,
  ) = _CopyWithImpl$Query$GetServerDiskVolumes;

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

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? storage = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$GetServerDiskVolumes(
          storage:
              storage == _undefined || storage == null
                  ? _instance.storage
                  : (storage as Query$GetServerDiskVolumes$storage),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Query$GetServerDiskVolumes$storage<TRes> get storage {
    final local$storage = _instance.storage;
    return CopyWith$Query$GetServerDiskVolumes$storage(
      local$storage,
      (e) => call(storage: e),
    );
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

const documentNodeQueryGetServerDiskVolumes = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetServerDiskVolumes'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'storage'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'volumes'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'freeSpace'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'model'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'root'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'serial'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'totalSpace'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'type'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'usages'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FieldNode(
                              name: NameNode(value: 'title'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'usedSpace'),
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
                            InlineFragmentNode(
                              typeCondition: TypeConditionNode(
                                on: NamedTypeNode(
                                  name: NameNode(value: 'ServiceStorageUsage'),
                                  isNonNull: false,
                                ),
                              ),
                              directives: [],
                              selectionSet: SelectionSetNode(
                                selections: [
                                  FieldNode(
                                    name: NameNode(value: 'service'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(
                                      selections: [
                                        FieldNode(
                                          name: NameNode(value: 'id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null,
                                        ),
                                        FieldNode(
                                          name: NameNode(value: 'isMovable'),
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
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: 'usedSpace'),
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
Query$GetServerDiskVolumes _parserFn$Query$GetServerDiskVolumes(
  Map<String, dynamic> data,
) => Query$GetServerDiskVolumes.fromJson(data);
typedef OnQueryComplete$Query$GetServerDiskVolumes =
    FutureOr<void> Function(Map<String, dynamic>?, Query$GetServerDiskVolumes?);

class Options$Query$GetServerDiskVolumes
    extends graphql.QueryOptions<Query$GetServerDiskVolumes> {
  Options$Query$GetServerDiskVolumes({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetServerDiskVolumes? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetServerDiskVolumes? onComplete,
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
                   data == null
                       ? null
                       : _parserFn$Query$GetServerDiskVolumes(data),
                 ),
         onError: onError,
         document: documentNodeQueryGetServerDiskVolumes,
         parserFn: _parserFn$Query$GetServerDiskVolumes,
       );

  final OnQueryComplete$Query$GetServerDiskVolumes? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$GetServerDiskVolumes
    extends graphql.WatchQueryOptions<Query$GetServerDiskVolumes> {
  WatchOptions$Query$GetServerDiskVolumes({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetServerDiskVolumes? typedOptimisticResult,
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
         document: documentNodeQueryGetServerDiskVolumes,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$GetServerDiskVolumes,
       );
}

class FetchMoreOptions$Query$GetServerDiskVolumes
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetServerDiskVolumes({
    required graphql.UpdateQuery updateQuery,
  }) : super(
         updateQuery: updateQuery,
         document: documentNodeQueryGetServerDiskVolumes,
       );
}

extension ClientExtension$Query$GetServerDiskVolumes on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetServerDiskVolumes>>
  query$GetServerDiskVolumes([
    Options$Query$GetServerDiskVolumes? options,
  ]) async => await this.query(options ?? Options$Query$GetServerDiskVolumes());
  graphql.ObservableQuery<Query$GetServerDiskVolumes>
  watchQuery$GetServerDiskVolumes([
    WatchOptions$Query$GetServerDiskVolumes? options,
  ]) => this.watchQuery(options ?? WatchOptions$Query$GetServerDiskVolumes());
  void writeQuery$GetServerDiskVolumes({
    required Query$GetServerDiskVolumes data,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(
        document: documentNodeQueryGetServerDiskVolumes,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Query$GetServerDiskVolumes? readQuery$GetServerDiskVolumes({
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(
          document: documentNodeQueryGetServerDiskVolumes,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetServerDiskVolumes.fromJson(result);
  }
}

class Query$GetServerDiskVolumes$storage {
  Query$GetServerDiskVolumes$storage({
    required this.volumes,
    this.$__typename = 'Storage',
  });

  factory Query$GetServerDiskVolumes$storage.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$volumes = json['volumes'];
    final l$$__typename = json['__typename'];
    return Query$GetServerDiskVolumes$storage(
      volumes:
          (l$volumes as List<dynamic>)
              .map(
                (e) => Query$GetServerDiskVolumes$storage$volumes.fromJson(
                  (e as Map<String, dynamic>),
                ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetServerDiskVolumes$storage$volumes> volumes;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$volumes = volumes;
    _resultData['volumes'] = l$volumes.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$volumes = volumes;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$volumes.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetServerDiskVolumes$storage ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$volumes = volumes;
    final lOther$volumes = other.volumes;
    if (l$volumes.length != lOther$volumes.length) {
      return false;
    }
    for (int i = 0; i < l$volumes.length; i++) {
      final l$volumes$entry = l$volumes[i];
      final lOther$volumes$entry = lOther$volumes[i];
      if (l$volumes$entry != lOther$volumes$entry) {
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

extension UtilityExtension$Query$GetServerDiskVolumes$storage
    on Query$GetServerDiskVolumes$storage {
  CopyWith$Query$GetServerDiskVolumes$storage<
    Query$GetServerDiskVolumes$storage
  >
  get copyWith => CopyWith$Query$GetServerDiskVolumes$storage(this, (i) => i);
}

abstract class CopyWith$Query$GetServerDiskVolumes$storage<TRes> {
  factory CopyWith$Query$GetServerDiskVolumes$storage(
    Query$GetServerDiskVolumes$storage instance,
    TRes Function(Query$GetServerDiskVolumes$storage) then,
  ) = _CopyWithImpl$Query$GetServerDiskVolumes$storage;

  factory CopyWith$Query$GetServerDiskVolumes$storage.stub(TRes res) =
      _CopyWithStubImpl$Query$GetServerDiskVolumes$storage;

  TRes call({
    List<Query$GetServerDiskVolumes$storage$volumes>? volumes,
    String? $__typename,
  });
  TRes volumes(
    Iterable<Query$GetServerDiskVolumes$storage$volumes> Function(
      Iterable<
        CopyWith$Query$GetServerDiskVolumes$storage$volumes<
          Query$GetServerDiskVolumes$storage$volumes
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetServerDiskVolumes$storage<TRes>
    implements CopyWith$Query$GetServerDiskVolumes$storage<TRes> {
  _CopyWithImpl$Query$GetServerDiskVolumes$storage(this._instance, this._then);

  final Query$GetServerDiskVolumes$storage _instance;

  final TRes Function(Query$GetServerDiskVolumes$storage) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? volumes = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$GetServerDiskVolumes$storage(
          volumes:
              volumes == _undefined || volumes == null
                  ? _instance.volumes
                  : (volumes
                      as List<Query$GetServerDiskVolumes$storage$volumes>),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  TRes volumes(
    Iterable<Query$GetServerDiskVolumes$storage$volumes> Function(
      Iterable<
        CopyWith$Query$GetServerDiskVolumes$storage$volumes<
          Query$GetServerDiskVolumes$storage$volumes
        >
      >,
    )
    _fn,
  ) => call(
    volumes:
        _fn(
          _instance.volumes.map(
            (e) => CopyWith$Query$GetServerDiskVolumes$storage$volumes(
              e,
              (i) => i,
            ),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetServerDiskVolumes$storage<TRes>
    implements CopyWith$Query$GetServerDiskVolumes$storage<TRes> {
  _CopyWithStubImpl$Query$GetServerDiskVolumes$storage(this._res);

  TRes _res;

  call({
    List<Query$GetServerDiskVolumes$storage$volumes>? volumes,
    String? $__typename,
  }) => _res;

  volumes(_fn) => _res;
}

class Query$GetServerDiskVolumes$storage$volumes {
  Query$GetServerDiskVolumes$storage$volumes({
    required this.freeSpace,
    this.model,
    required this.name,
    required this.root,
    this.serial,
    required this.totalSpace,
    required this.type,
    required this.usages,
    required this.usedSpace,
    this.$__typename = 'StorageVolume',
  });

  factory Query$GetServerDiskVolumes$storage$volumes.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$freeSpace = json['freeSpace'];
    final l$model = json['model'];
    final l$name = json['name'];
    final l$root = json['root'];
    final l$serial = json['serial'];
    final l$totalSpace = json['totalSpace'];
    final l$type = json['type'];
    final l$usages = json['usages'];
    final l$usedSpace = json['usedSpace'];
    final l$$__typename = json['__typename'];
    return Query$GetServerDiskVolumes$storage$volumes(
      freeSpace: (l$freeSpace as String),
      model: (l$model as String?),
      name: (l$name as String),
      root: (l$root as bool),
      serial: (l$serial as String?),
      totalSpace: (l$totalSpace as String),
      type: (l$type as String),
      usages:
          (l$usages as List<dynamic>)
              .map(
                (e) =>
                    Query$GetServerDiskVolumes$storage$volumes$usages.fromJson(
                      (e as Map<String, dynamic>),
                    ),
              )
              .toList(),
      usedSpace: (l$usedSpace as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String freeSpace;

  final String? model;

  final String name;

  final bool root;

  final String? serial;

  final String totalSpace;

  final String type;

  final List<Query$GetServerDiskVolumes$storage$volumes$usages> usages;

  final String usedSpace;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$freeSpace = freeSpace;
    _resultData['freeSpace'] = l$freeSpace;
    final l$model = model;
    _resultData['model'] = l$model;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$root = root;
    _resultData['root'] = l$root;
    final l$serial = serial;
    _resultData['serial'] = l$serial;
    final l$totalSpace = totalSpace;
    _resultData['totalSpace'] = l$totalSpace;
    final l$type = type;
    _resultData['type'] = l$type;
    final l$usages = usages;
    _resultData['usages'] = l$usages.map((e) => e.toJson()).toList();
    final l$usedSpace = usedSpace;
    _resultData['usedSpace'] = l$usedSpace;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
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
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetServerDiskVolumes$storage$volumes ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$freeSpace = freeSpace;
    final lOther$freeSpace = other.freeSpace;
    if (l$freeSpace != lOther$freeSpace) {
      return false;
    }
    final l$model = model;
    final lOther$model = other.model;
    if (l$model != lOther$model) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$root = root;
    final lOther$root = other.root;
    if (l$root != lOther$root) {
      return false;
    }
    final l$serial = serial;
    final lOther$serial = other.serial;
    if (l$serial != lOther$serial) {
      return false;
    }
    final l$totalSpace = totalSpace;
    final lOther$totalSpace = other.totalSpace;
    if (l$totalSpace != lOther$totalSpace) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    final l$usages = usages;
    final lOther$usages = other.usages;
    if (l$usages.length != lOther$usages.length) {
      return false;
    }
    for (int i = 0; i < l$usages.length; i++) {
      final l$usages$entry = l$usages[i];
      final lOther$usages$entry = lOther$usages[i];
      if (l$usages$entry != lOther$usages$entry) {
        return false;
      }
    }
    final l$usedSpace = usedSpace;
    final lOther$usedSpace = other.usedSpace;
    if (l$usedSpace != lOther$usedSpace) {
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

extension UtilityExtension$Query$GetServerDiskVolumes$storage$volumes
    on Query$GetServerDiskVolumes$storage$volumes {
  CopyWith$Query$GetServerDiskVolumes$storage$volumes<
    Query$GetServerDiskVolumes$storage$volumes
  >
  get copyWith =>
      CopyWith$Query$GetServerDiskVolumes$storage$volumes(this, (i) => i);
}

abstract class CopyWith$Query$GetServerDiskVolumes$storage$volumes<TRes> {
  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes(
    Query$GetServerDiskVolumes$storage$volumes instance,
    TRes Function(Query$GetServerDiskVolumes$storage$volumes) then,
  ) = _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes;

  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes.stub(TRes res) =
      _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes;

  TRes call({
    String? freeSpace,
    String? model,
    String? name,
    bool? root,
    String? serial,
    String? totalSpace,
    String? type,
    List<Query$GetServerDiskVolumes$storage$volumes$usages>? usages,
    String? usedSpace,
    String? $__typename,
  });
  TRes usages(
    Iterable<Query$GetServerDiskVolumes$storage$volumes$usages> Function(
      Iterable<
        CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages<
          Query$GetServerDiskVolumes$storage$volumes$usages
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes<TRes>
    implements CopyWith$Query$GetServerDiskVolumes$storage$volumes<TRes> {
  _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes(
    this._instance,
    this._then,
  );

  final Query$GetServerDiskVolumes$storage$volumes _instance;

  final TRes Function(Query$GetServerDiskVolumes$storage$volumes) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? freeSpace = _undefined,
    Object? model = _undefined,
    Object? name = _undefined,
    Object? root = _undefined,
    Object? serial = _undefined,
    Object? totalSpace = _undefined,
    Object? type = _undefined,
    Object? usages = _undefined,
    Object? usedSpace = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetServerDiskVolumes$storage$volumes(
      freeSpace:
          freeSpace == _undefined || freeSpace == null
              ? _instance.freeSpace
              : (freeSpace as String),
      model: model == _undefined ? _instance.model : (model as String?),
      name:
          name == _undefined || name == null
              ? _instance.name
              : (name as String),
      root:
          root == _undefined || root == null ? _instance.root : (root as bool),
      serial: serial == _undefined ? _instance.serial : (serial as String?),
      totalSpace:
          totalSpace == _undefined || totalSpace == null
              ? _instance.totalSpace
              : (totalSpace as String),
      type:
          type == _undefined || type == null
              ? _instance.type
              : (type as String),
      usages:
          usages == _undefined || usages == null
              ? _instance.usages
              : (usages
                  as List<Query$GetServerDiskVolumes$storage$volumes$usages>),
      usedSpace:
          usedSpace == _undefined || usedSpace == null
              ? _instance.usedSpace
              : (usedSpace as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes usages(
    Iterable<Query$GetServerDiskVolumes$storage$volumes$usages> Function(
      Iterable<
        CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages<
          Query$GetServerDiskVolumes$storage$volumes$usages
        >
      >,
    )
    _fn,
  ) => call(
    usages:
        _fn(
          _instance.usages.map(
            (e) => CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages(
              e,
              (i) => i,
            ),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes<TRes>
    implements CopyWith$Query$GetServerDiskVolumes$storage$volumes<TRes> {
  _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes(this._res);

  TRes _res;

  call({
    String? freeSpace,
    String? model,
    String? name,
    bool? root,
    String? serial,
    String? totalSpace,
    String? type,
    List<Query$GetServerDiskVolumes$storage$volumes$usages>? usages,
    String? usedSpace,
    String? $__typename,
  }) => _res;

  usages(_fn) => _res;
}

class Query$GetServerDiskVolumes$storage$volumes$usages {
  Query$GetServerDiskVolumes$storage$volumes$usages({
    required this.title,
    required this.usedSpace,
    required this.$__typename,
  });

  factory Query$GetServerDiskVolumes$storage$volumes$usages.fromJson(
    Map<String, dynamic> json,
  ) {
    switch (json["__typename"] as String) {
      case "ServiceStorageUsage":
        return Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage.fromJson(
          json,
        );

      default:
        final l$title = json['title'];
        final l$usedSpace = json['usedSpace'];
        final l$$__typename = json['__typename'];
        return Query$GetServerDiskVolumes$storage$volumes$usages(
          title: (l$title as String),
          usedSpace: (l$usedSpace as String),
          $__typename: (l$$__typename as String),
        );
    }
  }

  final String title;

  final String usedSpace;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$title = title;
    _resultData['title'] = l$title;
    final l$usedSpace = usedSpace;
    _resultData['usedSpace'] = l$usedSpace;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$title = title;
    final l$usedSpace = usedSpace;
    final l$$__typename = $__typename;
    return Object.hashAll([l$title, l$usedSpace, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetServerDiskVolumes$storage$volumes$usages ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$usedSpace = usedSpace;
    final lOther$usedSpace = other.usedSpace;
    if (l$usedSpace != lOther$usedSpace) {
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

extension UtilityExtension$Query$GetServerDiskVolumes$storage$volumes$usages
    on Query$GetServerDiskVolumes$storage$volumes$usages {
  CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages<
    Query$GetServerDiskVolumes$storage$volumes$usages
  >
  get copyWith => CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages(
    this,
    (i) => i,
  );
  _T when<_T>({
    required _T Function(
      Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage,
    )
    serviceStorageUsage,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "ServiceStorageUsage":
        return serviceStorageUsage(
          this
              as Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage,
        );

      default:
        return orElse();
    }
  }

  _T maybeWhen<_T>({
    _T Function(
      Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage,
    )?
    serviceStorageUsage,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "ServiceStorageUsage":
        if (serviceStorageUsage != null) {
          return serviceStorageUsage(
            this
                as Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage,
          );
        } else {
          return orElse();
        }

      default:
        return orElse();
    }
  }
}

abstract class CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages<
  TRes
> {
  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages(
    Query$GetServerDiskVolumes$storage$volumes$usages instance,
    TRes Function(Query$GetServerDiskVolumes$storage$volumes$usages) then,
  ) = _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages;

  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages.stub(
    TRes res,
  ) = _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages;

  TRes call({String? title, String? usedSpace, String? $__typename});
}

class _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages<TRes>
    implements
        CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages<TRes> {
  _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages(
    this._instance,
    this._then,
  );

  final Query$GetServerDiskVolumes$storage$volumes$usages _instance;

  final TRes Function(Query$GetServerDiskVolumes$storage$volumes$usages) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? title = _undefined,
    Object? usedSpace = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetServerDiskVolumes$storage$volumes$usages(
      title:
          title == _undefined || title == null
              ? _instance.title
              : (title as String),
      usedSpace:
          usedSpace == _undefined || usedSpace == null
              ? _instance.usedSpace
              : (usedSpace as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages<TRes>
    implements
        CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages<TRes> {
  _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages(
    this._res,
  );

  TRes _res;

  call({String? title, String? usedSpace, String? $__typename}) => _res;
}

class Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage
    implements Query$GetServerDiskVolumes$storage$volumes$usages {
  Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage({
    this.service,
    this.$__typename = 'ServiceStorageUsage',
    required this.title,
    required this.usedSpace,
  });

  factory Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$service = json['service'];
    final l$$__typename = json['__typename'];
    final l$title = json['title'];
    final l$usedSpace = json['usedSpace'];
    return Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage(
      service:
          l$service == null
              ? null
              : Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service.fromJson(
                (l$service as Map<String, dynamic>),
              ),
      $__typename: (l$$__typename as String),
      title: (l$title as String),
      usedSpace: (l$usedSpace as String),
    );
  }

  final Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service?
  service;

  final String $__typename;

  final String title;

  final String usedSpace;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$service = service;
    _resultData['service'] = l$service?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$usedSpace = usedSpace;
    _resultData['usedSpace'] = l$usedSpace;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$service = service;
    final l$$__typename = $__typename;
    final l$title = title;
    final l$usedSpace = usedSpace;
    return Object.hashAll([l$service, l$$__typename, l$title, l$usedSpace]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$service = service;
    final lOther$service = other.service;
    if (l$service != lOther$service) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$usedSpace = usedSpace;
    final lOther$usedSpace = other.usedSpace;
    if (l$usedSpace != lOther$usedSpace) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage
    on Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage {
  CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage<
    Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage
  >
  get copyWith =>
      CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage<
  TRes
> {
  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage(
    Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage
    instance,
    TRes Function(
      Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage;

  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage;

  TRes call({
    Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service?
    service,
    String? $__typename,
    String? title,
    String? usedSpace,
  });
  CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
    TRes
  >
  get service;
}

class _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage<
  TRes
>
    implements
        CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage<
          TRes
        > {
  _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage(
    this._instance,
    this._then,
  );

  final Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage
  _instance;

  final TRes Function(
    Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? service = _undefined,
    Object? $__typename = _undefined,
    Object? title = _undefined,
    Object? usedSpace = _undefined,
  }) => _then(
    Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage(
      service:
          service == _undefined
              ? _instance.service
              : (service
                  as Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service?),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
      title:
          title == _undefined || title == null
              ? _instance.title
              : (title as String),
      usedSpace:
          usedSpace == _undefined || usedSpace == null
              ? _instance.usedSpace
              : (usedSpace as String),
    ),
  );

  CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
    TRes
  >
  get service {
    final local$service = _instance.service;
    return local$service == null
        ? CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service.stub(
          _then(_instance),
        )
        : CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
          local$service,
          (e) => call(service: e),
        );
  }
}

class _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage<
  TRes
>
    implements
        CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage<
          TRes
        > {
  _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage(
    this._res,
  );

  TRes _res;

  call({
    Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service?
    service,
    String? $__typename,
    String? title,
    String? usedSpace,
  }) => _res;

  CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
    TRes
  >
  get service =>
      CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service.stub(
        _res,
      );
}

class Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service {
  Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service({
    required this.id,
    required this.isMovable,
    required this.displayName,
    this.$__typename = 'Service',
  });

  factory Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    final l$isMovable = json['isMovable'];
    final l$displayName = json['displayName'];
    final l$$__typename = json['__typename'];
    return Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
      id: (l$id as String),
      isMovable: (l$isMovable as bool),
      displayName: (l$displayName as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final bool isMovable;

  final String displayName;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$isMovable = isMovable;
    _resultData['isMovable'] = l$isMovable;
    final l$displayName = displayName;
    _resultData['displayName'] = l$displayName;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$isMovable = isMovable;
    final l$displayName = displayName;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$isMovable, l$displayName, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$isMovable = isMovable;
    final lOther$isMovable = other.isMovable;
    if (l$isMovable != lOther$isMovable) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) {
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

extension UtilityExtension$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service
    on Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service {
  CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
    Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service
  >
  get copyWith =>
      CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
  TRes
> {
  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
    Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service
    instance,
    TRes Function(
      Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service;

  factory CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service;

  TRes call({
    String? id,
    bool? isMovable,
    String? displayName,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
  TRes
>
    implements
        CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
          TRes
        > {
  _CopyWithImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
    this._instance,
    this._then,
  );

  final Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service
  _instance;

  final TRes Function(
    Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? isMovable = _undefined,
    Object? displayName = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      isMovable:
          isMovable == _undefined || isMovable == null
              ? _instance.isMovable
              : (isMovable as bool),
      displayName:
          displayName == _undefined || displayName == null
              ? _instance.displayName
              : (displayName as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
  TRes
>
    implements
        CopyWith$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service<
          TRes
        > {
  _CopyWithStubImpl$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
    this._res,
  );

  TRes _res;

  call({
    String? id,
    bool? isMovable,
    String? displayName,
    String? $__typename,
  }) => _res;
}

class Variables$Mutation$MountVolume {
  factory Variables$Mutation$MountVolume({required String name}) =>
      Variables$Mutation$MountVolume._({r'name': name});

  Variables$Mutation$MountVolume._(this._$data);

  factory Variables$Mutation$MountVolume.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    return Variables$Mutation$MountVolume._(result$data);
  }

  Map<String, dynamic> _$data;

  String get name => (_$data['name'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$name = name;
    result$data['name'] = l$name;
    return result$data;
  }

  CopyWith$Variables$Mutation$MountVolume<Variables$Mutation$MountVolume>
  get copyWith => CopyWith$Variables$Mutation$MountVolume(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$MountVolume ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$name = name;
    return Object.hashAll([l$name]);
  }
}

abstract class CopyWith$Variables$Mutation$MountVolume<TRes> {
  factory CopyWith$Variables$Mutation$MountVolume(
    Variables$Mutation$MountVolume instance,
    TRes Function(Variables$Mutation$MountVolume) then,
  ) = _CopyWithImpl$Variables$Mutation$MountVolume;

  factory CopyWith$Variables$Mutation$MountVolume.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$MountVolume;

  TRes call({String? name});
}

class _CopyWithImpl$Variables$Mutation$MountVolume<TRes>
    implements CopyWith$Variables$Mutation$MountVolume<TRes> {
  _CopyWithImpl$Variables$Mutation$MountVolume(this._instance, this._then);

  final Variables$Mutation$MountVolume _instance;

  final TRes Function(Variables$Mutation$MountVolume) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? name = _undefined}) => _then(
    Variables$Mutation$MountVolume._({
      ..._instance._$data,
      if (name != _undefined && name != null) 'name': (name as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$MountVolume<TRes>
    implements CopyWith$Variables$Mutation$MountVolume<TRes> {
  _CopyWithStubImpl$Variables$Mutation$MountVolume(this._res);

  TRes _res;

  call({String? name}) => _res;
}

class Mutation$MountVolume {
  Mutation$MountVolume({required this.storage, this.$__typename = 'Mutation'});

  factory Mutation$MountVolume.fromJson(Map<String, dynamic> json) {
    final l$storage = json['storage'];
    final l$$__typename = json['__typename'];
    return Mutation$MountVolume(
      storage: Mutation$MountVolume$storage.fromJson(
        (l$storage as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$MountVolume$storage storage;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$storage = storage;
    _resultData['storage'] = l$storage.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$storage = storage;
    final l$$__typename = $__typename;
    return Object.hashAll([l$storage, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$MountVolume || runtimeType != other.runtimeType) {
      return false;
    }
    final l$storage = storage;
    final lOther$storage = other.storage;
    if (l$storage != lOther$storage) {
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

extension UtilityExtension$Mutation$MountVolume on Mutation$MountVolume {
  CopyWith$Mutation$MountVolume<Mutation$MountVolume> get copyWith =>
      CopyWith$Mutation$MountVolume(this, (i) => i);
}

abstract class CopyWith$Mutation$MountVolume<TRes> {
  factory CopyWith$Mutation$MountVolume(
    Mutation$MountVolume instance,
    TRes Function(Mutation$MountVolume) then,
  ) = _CopyWithImpl$Mutation$MountVolume;

  factory CopyWith$Mutation$MountVolume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MountVolume;

  TRes call({Mutation$MountVolume$storage? storage, String? $__typename});
  CopyWith$Mutation$MountVolume$storage<TRes> get storage;
}

class _CopyWithImpl$Mutation$MountVolume<TRes>
    implements CopyWith$Mutation$MountVolume<TRes> {
  _CopyWithImpl$Mutation$MountVolume(this._instance, this._then);

  final Mutation$MountVolume _instance;

  final TRes Function(Mutation$MountVolume) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? storage = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$MountVolume(
          storage:
              storage == _undefined || storage == null
                  ? _instance.storage
                  : (storage as Mutation$MountVolume$storage),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$MountVolume$storage<TRes> get storage {
    final local$storage = _instance.storage;
    return CopyWith$Mutation$MountVolume$storage(
      local$storage,
      (e) => call(storage: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$MountVolume<TRes>
    implements CopyWith$Mutation$MountVolume<TRes> {
  _CopyWithStubImpl$Mutation$MountVolume(this._res);

  TRes _res;

  call({Mutation$MountVolume$storage? storage, String? $__typename}) => _res;

  CopyWith$Mutation$MountVolume$storage<TRes> get storage =>
      CopyWith$Mutation$MountVolume$storage.stub(_res);
}

const documentNodeMutationMountVolume = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'MountVolume'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'name')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'storage'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'mountVolume'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'name'),
                      value: VariableNode(name: NameNode(value: 'name')),
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
Mutation$MountVolume _parserFn$Mutation$MountVolume(
  Map<String, dynamic> data,
) => Mutation$MountVolume.fromJson(data);
typedef OnMutationCompleted$Mutation$MountVolume =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$MountVolume?);

class Options$Mutation$MountVolume
    extends graphql.MutationOptions<Mutation$MountVolume> {
  Options$Mutation$MountVolume({
    String? operationName,
    required Variables$Mutation$MountVolume variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$MountVolume? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$MountVolume? onCompleted,
    graphql.OnMutationUpdate<Mutation$MountVolume>? update,
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
                   data == null ? null : _parserFn$Mutation$MountVolume(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationMountVolume,
         parserFn: _parserFn$Mutation$MountVolume,
       );

  final OnMutationCompleted$Mutation$MountVolume? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$MountVolume
    extends graphql.WatchQueryOptions<Mutation$MountVolume> {
  WatchOptions$Mutation$MountVolume({
    String? operationName,
    required Variables$Mutation$MountVolume variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$MountVolume? typedOptimisticResult,
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
         document: documentNodeMutationMountVolume,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$MountVolume,
       );
}

extension ClientExtension$Mutation$MountVolume on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$MountVolume>> mutate$MountVolume(
    Options$Mutation$MountVolume options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$MountVolume> watchMutation$MountVolume(
    WatchOptions$Mutation$MountVolume options,
  ) => this.watchMutation(options);
}

class Mutation$MountVolume$storage {
  Mutation$MountVolume$storage({
    required this.mountVolume,
    this.$__typename = 'StorageMutations',
  });

  factory Mutation$MountVolume$storage.fromJson(Map<String, dynamic> json) {
    final l$mountVolume = json['mountVolume'];
    final l$$__typename = json['__typename'];
    return Mutation$MountVolume$storage(
      mountVolume: Mutation$MountVolume$storage$mountVolume.fromJson(
        (l$mountVolume as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$MountVolume$storage$mountVolume mountVolume;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$mountVolume = mountVolume;
    _resultData['mountVolume'] = l$mountVolume.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$mountVolume = mountVolume;
    final l$$__typename = $__typename;
    return Object.hashAll([l$mountVolume, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$MountVolume$storage ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$mountVolume = mountVolume;
    final lOther$mountVolume = other.mountVolume;
    if (l$mountVolume != lOther$mountVolume) {
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

extension UtilityExtension$Mutation$MountVolume$storage
    on Mutation$MountVolume$storage {
  CopyWith$Mutation$MountVolume$storage<Mutation$MountVolume$storage>
  get copyWith => CopyWith$Mutation$MountVolume$storage(this, (i) => i);
}

abstract class CopyWith$Mutation$MountVolume$storage<TRes> {
  factory CopyWith$Mutation$MountVolume$storage(
    Mutation$MountVolume$storage instance,
    TRes Function(Mutation$MountVolume$storage) then,
  ) = _CopyWithImpl$Mutation$MountVolume$storage;

  factory CopyWith$Mutation$MountVolume$storage.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MountVolume$storage;

  TRes call({
    Mutation$MountVolume$storage$mountVolume? mountVolume,
    String? $__typename,
  });
  CopyWith$Mutation$MountVolume$storage$mountVolume<TRes> get mountVolume;
}

class _CopyWithImpl$Mutation$MountVolume$storage<TRes>
    implements CopyWith$Mutation$MountVolume$storage<TRes> {
  _CopyWithImpl$Mutation$MountVolume$storage(this._instance, this._then);

  final Mutation$MountVolume$storage _instance;

  final TRes Function(Mutation$MountVolume$storage) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? mountVolume = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$MountVolume$storage(
      mountVolume:
          mountVolume == _undefined || mountVolume == null
              ? _instance.mountVolume
              : (mountVolume as Mutation$MountVolume$storage$mountVolume),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$MountVolume$storage$mountVolume<TRes> get mountVolume {
    final local$mountVolume = _instance.mountVolume;
    return CopyWith$Mutation$MountVolume$storage$mountVolume(
      local$mountVolume,
      (e) => call(mountVolume: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$MountVolume$storage<TRes>
    implements CopyWith$Mutation$MountVolume$storage<TRes> {
  _CopyWithStubImpl$Mutation$MountVolume$storage(this._res);

  TRes _res;

  call({
    Mutation$MountVolume$storage$mountVolume? mountVolume,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$MountVolume$storage$mountVolume<TRes> get mountVolume =>
      CopyWith$Mutation$MountVolume$storage$mountVolume.stub(_res);
}

class Mutation$MountVolume$storage$mountVolume
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$MountVolume$storage$mountVolume({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$MountVolume$storage$mountVolume.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$MountVolume$storage$mountVolume(
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
    if (other is! Mutation$MountVolume$storage$mountVolume ||
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

extension UtilityExtension$Mutation$MountVolume$storage$mountVolume
    on Mutation$MountVolume$storage$mountVolume {
  CopyWith$Mutation$MountVolume$storage$mountVolume<
    Mutation$MountVolume$storage$mountVolume
  >
  get copyWith =>
      CopyWith$Mutation$MountVolume$storage$mountVolume(this, (i) => i);
}

abstract class CopyWith$Mutation$MountVolume$storage$mountVolume<TRes> {
  factory CopyWith$Mutation$MountVolume$storage$mountVolume(
    Mutation$MountVolume$storage$mountVolume instance,
    TRes Function(Mutation$MountVolume$storage$mountVolume) then,
  ) = _CopyWithImpl$Mutation$MountVolume$storage$mountVolume;

  factory CopyWith$Mutation$MountVolume$storage$mountVolume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MountVolume$storage$mountVolume;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$MountVolume$storage$mountVolume<TRes>
    implements CopyWith$Mutation$MountVolume$storage$mountVolume<TRes> {
  _CopyWithImpl$Mutation$MountVolume$storage$mountVolume(
    this._instance,
    this._then,
  );

  final Mutation$MountVolume$storage$mountVolume _instance;

  final TRes Function(Mutation$MountVolume$storage$mountVolume) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$MountVolume$storage$mountVolume(
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

class _CopyWithStubImpl$Mutation$MountVolume$storage$mountVolume<TRes>
    implements CopyWith$Mutation$MountVolume$storage$mountVolume<TRes> {
  _CopyWithStubImpl$Mutation$MountVolume$storage$mountVolume(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

class Variables$Mutation$ResizeVolume {
  factory Variables$Mutation$ResizeVolume({required String name}) =>
      Variables$Mutation$ResizeVolume._({r'name': name});

  Variables$Mutation$ResizeVolume._(this._$data);

  factory Variables$Mutation$ResizeVolume.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    return Variables$Mutation$ResizeVolume._(result$data);
  }

  Map<String, dynamic> _$data;

  String get name => (_$data['name'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$name = name;
    result$data['name'] = l$name;
    return result$data;
  }

  CopyWith$Variables$Mutation$ResizeVolume<Variables$Mutation$ResizeVolume>
  get copyWith => CopyWith$Variables$Mutation$ResizeVolume(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$ResizeVolume ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$name = name;
    return Object.hashAll([l$name]);
  }
}

abstract class CopyWith$Variables$Mutation$ResizeVolume<TRes> {
  factory CopyWith$Variables$Mutation$ResizeVolume(
    Variables$Mutation$ResizeVolume instance,
    TRes Function(Variables$Mutation$ResizeVolume) then,
  ) = _CopyWithImpl$Variables$Mutation$ResizeVolume;

  factory CopyWith$Variables$Mutation$ResizeVolume.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ResizeVolume;

  TRes call({String? name});
}

class _CopyWithImpl$Variables$Mutation$ResizeVolume<TRes>
    implements CopyWith$Variables$Mutation$ResizeVolume<TRes> {
  _CopyWithImpl$Variables$Mutation$ResizeVolume(this._instance, this._then);

  final Variables$Mutation$ResizeVolume _instance;

  final TRes Function(Variables$Mutation$ResizeVolume) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? name = _undefined}) => _then(
    Variables$Mutation$ResizeVolume._({
      ..._instance._$data,
      if (name != _undefined && name != null) 'name': (name as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$ResizeVolume<TRes>
    implements CopyWith$Variables$Mutation$ResizeVolume<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ResizeVolume(this._res);

  TRes _res;

  call({String? name}) => _res;
}

class Mutation$ResizeVolume {
  Mutation$ResizeVolume({required this.storage, this.$__typename = 'Mutation'});

  factory Mutation$ResizeVolume.fromJson(Map<String, dynamic> json) {
    final l$storage = json['storage'];
    final l$$__typename = json['__typename'];
    return Mutation$ResizeVolume(
      storage: Mutation$ResizeVolume$storage.fromJson(
        (l$storage as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ResizeVolume$storage storage;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$storage = storage;
    _resultData['storage'] = l$storage.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$storage = storage;
    final l$$__typename = $__typename;
    return Object.hashAll([l$storage, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ResizeVolume || runtimeType != other.runtimeType) {
      return false;
    }
    final l$storage = storage;
    final lOther$storage = other.storage;
    if (l$storage != lOther$storage) {
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

extension UtilityExtension$Mutation$ResizeVolume on Mutation$ResizeVolume {
  CopyWith$Mutation$ResizeVolume<Mutation$ResizeVolume> get copyWith =>
      CopyWith$Mutation$ResizeVolume(this, (i) => i);
}

abstract class CopyWith$Mutation$ResizeVolume<TRes> {
  factory CopyWith$Mutation$ResizeVolume(
    Mutation$ResizeVolume instance,
    TRes Function(Mutation$ResizeVolume) then,
  ) = _CopyWithImpl$Mutation$ResizeVolume;

  factory CopyWith$Mutation$ResizeVolume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ResizeVolume;

  TRes call({Mutation$ResizeVolume$storage? storage, String? $__typename});
  CopyWith$Mutation$ResizeVolume$storage<TRes> get storage;
}

class _CopyWithImpl$Mutation$ResizeVolume<TRes>
    implements CopyWith$Mutation$ResizeVolume<TRes> {
  _CopyWithImpl$Mutation$ResizeVolume(this._instance, this._then);

  final Mutation$ResizeVolume _instance;

  final TRes Function(Mutation$ResizeVolume) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? storage = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$ResizeVolume(
          storage:
              storage == _undefined || storage == null
                  ? _instance.storage
                  : (storage as Mutation$ResizeVolume$storage),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$ResizeVolume$storage<TRes> get storage {
    final local$storage = _instance.storage;
    return CopyWith$Mutation$ResizeVolume$storage(
      local$storage,
      (e) => call(storage: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$ResizeVolume<TRes>
    implements CopyWith$Mutation$ResizeVolume<TRes> {
  _CopyWithStubImpl$Mutation$ResizeVolume(this._res);

  TRes _res;

  call({Mutation$ResizeVolume$storage? storage, String? $__typename}) => _res;

  CopyWith$Mutation$ResizeVolume$storage<TRes> get storage =>
      CopyWith$Mutation$ResizeVolume$storage.stub(_res);
}

const documentNodeMutationResizeVolume = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ResizeVolume'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'name')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'storage'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'resizeVolume'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'name'),
                      value: VariableNode(name: NameNode(value: 'name')),
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
Mutation$ResizeVolume _parserFn$Mutation$ResizeVolume(
  Map<String, dynamic> data,
) => Mutation$ResizeVolume.fromJson(data);
typedef OnMutationCompleted$Mutation$ResizeVolume =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$ResizeVolume?);

class Options$Mutation$ResizeVolume
    extends graphql.MutationOptions<Mutation$ResizeVolume> {
  Options$Mutation$ResizeVolume({
    String? operationName,
    required Variables$Mutation$ResizeVolume variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ResizeVolume? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$ResizeVolume? onCompleted,
    graphql.OnMutationUpdate<Mutation$ResizeVolume>? update,
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
                   data == null ? null : _parserFn$Mutation$ResizeVolume(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationResizeVolume,
         parserFn: _parserFn$Mutation$ResizeVolume,
       );

  final OnMutationCompleted$Mutation$ResizeVolume? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$ResizeVolume
    extends graphql.WatchQueryOptions<Mutation$ResizeVolume> {
  WatchOptions$Mutation$ResizeVolume({
    String? operationName,
    required Variables$Mutation$ResizeVolume variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ResizeVolume? typedOptimisticResult,
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
         document: documentNodeMutationResizeVolume,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$ResizeVolume,
       );
}

extension ClientExtension$Mutation$ResizeVolume on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ResizeVolume>> mutate$ResizeVolume(
    Options$Mutation$ResizeVolume options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$ResizeVolume> watchMutation$ResizeVolume(
    WatchOptions$Mutation$ResizeVolume options,
  ) => this.watchMutation(options);
}

class Mutation$ResizeVolume$storage {
  Mutation$ResizeVolume$storage({
    required this.resizeVolume,
    this.$__typename = 'StorageMutations',
  });

  factory Mutation$ResizeVolume$storage.fromJson(Map<String, dynamic> json) {
    final l$resizeVolume = json['resizeVolume'];
    final l$$__typename = json['__typename'];
    return Mutation$ResizeVolume$storage(
      resizeVolume: Mutation$ResizeVolume$storage$resizeVolume.fromJson(
        (l$resizeVolume as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ResizeVolume$storage$resizeVolume resizeVolume;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$resizeVolume = resizeVolume;
    _resultData['resizeVolume'] = l$resizeVolume.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$resizeVolume = resizeVolume;
    final l$$__typename = $__typename;
    return Object.hashAll([l$resizeVolume, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ResizeVolume$storage ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$resizeVolume = resizeVolume;
    final lOther$resizeVolume = other.resizeVolume;
    if (l$resizeVolume != lOther$resizeVolume) {
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

extension UtilityExtension$Mutation$ResizeVolume$storage
    on Mutation$ResizeVolume$storage {
  CopyWith$Mutation$ResizeVolume$storage<Mutation$ResizeVolume$storage>
  get copyWith => CopyWith$Mutation$ResizeVolume$storage(this, (i) => i);
}

abstract class CopyWith$Mutation$ResizeVolume$storage<TRes> {
  factory CopyWith$Mutation$ResizeVolume$storage(
    Mutation$ResizeVolume$storage instance,
    TRes Function(Mutation$ResizeVolume$storage) then,
  ) = _CopyWithImpl$Mutation$ResizeVolume$storage;

  factory CopyWith$Mutation$ResizeVolume$storage.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ResizeVolume$storage;

  TRes call({
    Mutation$ResizeVolume$storage$resizeVolume? resizeVolume,
    String? $__typename,
  });
  CopyWith$Mutation$ResizeVolume$storage$resizeVolume<TRes> get resizeVolume;
}

class _CopyWithImpl$Mutation$ResizeVolume$storage<TRes>
    implements CopyWith$Mutation$ResizeVolume$storage<TRes> {
  _CopyWithImpl$Mutation$ResizeVolume$storage(this._instance, this._then);

  final Mutation$ResizeVolume$storage _instance;

  final TRes Function(Mutation$ResizeVolume$storage) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? resizeVolume = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$ResizeVolume$storage(
      resizeVolume:
          resizeVolume == _undefined || resizeVolume == null
              ? _instance.resizeVolume
              : (resizeVolume as Mutation$ResizeVolume$storage$resizeVolume),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$ResizeVolume$storage$resizeVolume<TRes> get resizeVolume {
    final local$resizeVolume = _instance.resizeVolume;
    return CopyWith$Mutation$ResizeVolume$storage$resizeVolume(
      local$resizeVolume,
      (e) => call(resizeVolume: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$ResizeVolume$storage<TRes>
    implements CopyWith$Mutation$ResizeVolume$storage<TRes> {
  _CopyWithStubImpl$Mutation$ResizeVolume$storage(this._res);

  TRes _res;

  call({
    Mutation$ResizeVolume$storage$resizeVolume? resizeVolume,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$ResizeVolume$storage$resizeVolume<TRes> get resizeVolume =>
      CopyWith$Mutation$ResizeVolume$storage$resizeVolume.stub(_res);
}

class Mutation$ResizeVolume$storage$resizeVolume
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$ResizeVolume$storage$resizeVolume({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$ResizeVolume$storage$resizeVolume.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$ResizeVolume$storage$resizeVolume(
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
    if (other is! Mutation$ResizeVolume$storage$resizeVolume ||
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

extension UtilityExtension$Mutation$ResizeVolume$storage$resizeVolume
    on Mutation$ResizeVolume$storage$resizeVolume {
  CopyWith$Mutation$ResizeVolume$storage$resizeVolume<
    Mutation$ResizeVolume$storage$resizeVolume
  >
  get copyWith =>
      CopyWith$Mutation$ResizeVolume$storage$resizeVolume(this, (i) => i);
}

abstract class CopyWith$Mutation$ResizeVolume$storage$resizeVolume<TRes> {
  factory CopyWith$Mutation$ResizeVolume$storage$resizeVolume(
    Mutation$ResizeVolume$storage$resizeVolume instance,
    TRes Function(Mutation$ResizeVolume$storage$resizeVolume) then,
  ) = _CopyWithImpl$Mutation$ResizeVolume$storage$resizeVolume;

  factory CopyWith$Mutation$ResizeVolume$storage$resizeVolume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ResizeVolume$storage$resizeVolume;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$ResizeVolume$storage$resizeVolume<TRes>
    implements CopyWith$Mutation$ResizeVolume$storage$resizeVolume<TRes> {
  _CopyWithImpl$Mutation$ResizeVolume$storage$resizeVolume(
    this._instance,
    this._then,
  );

  final Mutation$ResizeVolume$storage$resizeVolume _instance;

  final TRes Function(Mutation$ResizeVolume$storage$resizeVolume) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$ResizeVolume$storage$resizeVolume(
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

class _CopyWithStubImpl$Mutation$ResizeVolume$storage$resizeVolume<TRes>
    implements CopyWith$Mutation$ResizeVolume$storage$resizeVolume<TRes> {
  _CopyWithStubImpl$Mutation$ResizeVolume$storage$resizeVolume(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

class Variables$Mutation$UnmountVolume {
  factory Variables$Mutation$UnmountVolume({required String name}) =>
      Variables$Mutation$UnmountVolume._({r'name': name});

  Variables$Mutation$UnmountVolume._(this._$data);

  factory Variables$Mutation$UnmountVolume.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    return Variables$Mutation$UnmountVolume._(result$data);
  }

  Map<String, dynamic> _$data;

  String get name => (_$data['name'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$name = name;
    result$data['name'] = l$name;
    return result$data;
  }

  CopyWith$Variables$Mutation$UnmountVolume<Variables$Mutation$UnmountVolume>
  get copyWith => CopyWith$Variables$Mutation$UnmountVolume(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$UnmountVolume ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$name = name;
    return Object.hashAll([l$name]);
  }
}

abstract class CopyWith$Variables$Mutation$UnmountVolume<TRes> {
  factory CopyWith$Variables$Mutation$UnmountVolume(
    Variables$Mutation$UnmountVolume instance,
    TRes Function(Variables$Mutation$UnmountVolume) then,
  ) = _CopyWithImpl$Variables$Mutation$UnmountVolume;

  factory CopyWith$Variables$Mutation$UnmountVolume.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UnmountVolume;

  TRes call({String? name});
}

class _CopyWithImpl$Variables$Mutation$UnmountVolume<TRes>
    implements CopyWith$Variables$Mutation$UnmountVolume<TRes> {
  _CopyWithImpl$Variables$Mutation$UnmountVolume(this._instance, this._then);

  final Variables$Mutation$UnmountVolume _instance;

  final TRes Function(Variables$Mutation$UnmountVolume) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? name = _undefined}) => _then(
    Variables$Mutation$UnmountVolume._({
      ..._instance._$data,
      if (name != _undefined && name != null) 'name': (name as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$UnmountVolume<TRes>
    implements CopyWith$Variables$Mutation$UnmountVolume<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UnmountVolume(this._res);

  TRes _res;

  call({String? name}) => _res;
}

class Mutation$UnmountVolume {
  Mutation$UnmountVolume({
    required this.storage,
    this.$__typename = 'Mutation',
  });

  factory Mutation$UnmountVolume.fromJson(Map<String, dynamic> json) {
    final l$storage = json['storage'];
    final l$$__typename = json['__typename'];
    return Mutation$UnmountVolume(
      storage: Mutation$UnmountVolume$storage.fromJson(
        (l$storage as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$UnmountVolume$storage storage;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$storage = storage;
    _resultData['storage'] = l$storage.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$storage = storage;
    final l$$__typename = $__typename;
    return Object.hashAll([l$storage, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$UnmountVolume || runtimeType != other.runtimeType) {
      return false;
    }
    final l$storage = storage;
    final lOther$storage = other.storage;
    if (l$storage != lOther$storage) {
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

extension UtilityExtension$Mutation$UnmountVolume on Mutation$UnmountVolume {
  CopyWith$Mutation$UnmountVolume<Mutation$UnmountVolume> get copyWith =>
      CopyWith$Mutation$UnmountVolume(this, (i) => i);
}

abstract class CopyWith$Mutation$UnmountVolume<TRes> {
  factory CopyWith$Mutation$UnmountVolume(
    Mutation$UnmountVolume instance,
    TRes Function(Mutation$UnmountVolume) then,
  ) = _CopyWithImpl$Mutation$UnmountVolume;

  factory CopyWith$Mutation$UnmountVolume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UnmountVolume;

  TRes call({Mutation$UnmountVolume$storage? storage, String? $__typename});
  CopyWith$Mutation$UnmountVolume$storage<TRes> get storage;
}

class _CopyWithImpl$Mutation$UnmountVolume<TRes>
    implements CopyWith$Mutation$UnmountVolume<TRes> {
  _CopyWithImpl$Mutation$UnmountVolume(this._instance, this._then);

  final Mutation$UnmountVolume _instance;

  final TRes Function(Mutation$UnmountVolume) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? storage = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$UnmountVolume(
          storage:
              storage == _undefined || storage == null
                  ? _instance.storage
                  : (storage as Mutation$UnmountVolume$storage),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$UnmountVolume$storage<TRes> get storage {
    final local$storage = _instance.storage;
    return CopyWith$Mutation$UnmountVolume$storage(
      local$storage,
      (e) => call(storage: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$UnmountVolume<TRes>
    implements CopyWith$Mutation$UnmountVolume<TRes> {
  _CopyWithStubImpl$Mutation$UnmountVolume(this._res);

  TRes _res;

  call({Mutation$UnmountVolume$storage? storage, String? $__typename}) => _res;

  CopyWith$Mutation$UnmountVolume$storage<TRes> get storage =>
      CopyWith$Mutation$UnmountVolume$storage.stub(_res);
}

const documentNodeMutationUnmountVolume = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UnmountVolume'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'name')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'storage'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'unmountVolume'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'name'),
                      value: VariableNode(name: NameNode(value: 'name')),
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
Mutation$UnmountVolume _parserFn$Mutation$UnmountVolume(
  Map<String, dynamic> data,
) => Mutation$UnmountVolume.fromJson(data);
typedef OnMutationCompleted$Mutation$UnmountVolume =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$UnmountVolume?);

class Options$Mutation$UnmountVolume
    extends graphql.MutationOptions<Mutation$UnmountVolume> {
  Options$Mutation$UnmountVolume({
    String? operationName,
    required Variables$Mutation$UnmountVolume variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UnmountVolume? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UnmountVolume? onCompleted,
    graphql.OnMutationUpdate<Mutation$UnmountVolume>? update,
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
                   data == null ? null : _parserFn$Mutation$UnmountVolume(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationUnmountVolume,
         parserFn: _parserFn$Mutation$UnmountVolume,
       );

  final OnMutationCompleted$Mutation$UnmountVolume? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$UnmountVolume
    extends graphql.WatchQueryOptions<Mutation$UnmountVolume> {
  WatchOptions$Mutation$UnmountVolume({
    String? operationName,
    required Variables$Mutation$UnmountVolume variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UnmountVolume? typedOptimisticResult,
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
         document: documentNodeMutationUnmountVolume,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$UnmountVolume,
       );
}

extension ClientExtension$Mutation$UnmountVolume on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UnmountVolume>> mutate$UnmountVolume(
    Options$Mutation$UnmountVolume options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$UnmountVolume> watchMutation$UnmountVolume(
    WatchOptions$Mutation$UnmountVolume options,
  ) => this.watchMutation(options);
}

class Mutation$UnmountVolume$storage {
  Mutation$UnmountVolume$storage({
    required this.unmountVolume,
    this.$__typename = 'StorageMutations',
  });

  factory Mutation$UnmountVolume$storage.fromJson(Map<String, dynamic> json) {
    final l$unmountVolume = json['unmountVolume'];
    final l$$__typename = json['__typename'];
    return Mutation$UnmountVolume$storage(
      unmountVolume: Mutation$UnmountVolume$storage$unmountVolume.fromJson(
        (l$unmountVolume as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$UnmountVolume$storage$unmountVolume unmountVolume;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$unmountVolume = unmountVolume;
    _resultData['unmountVolume'] = l$unmountVolume.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$unmountVolume = unmountVolume;
    final l$$__typename = $__typename;
    return Object.hashAll([l$unmountVolume, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$UnmountVolume$storage ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$unmountVolume = unmountVolume;
    final lOther$unmountVolume = other.unmountVolume;
    if (l$unmountVolume != lOther$unmountVolume) {
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

extension UtilityExtension$Mutation$UnmountVolume$storage
    on Mutation$UnmountVolume$storage {
  CopyWith$Mutation$UnmountVolume$storage<Mutation$UnmountVolume$storage>
  get copyWith => CopyWith$Mutation$UnmountVolume$storage(this, (i) => i);
}

abstract class CopyWith$Mutation$UnmountVolume$storage<TRes> {
  factory CopyWith$Mutation$UnmountVolume$storage(
    Mutation$UnmountVolume$storage instance,
    TRes Function(Mutation$UnmountVolume$storage) then,
  ) = _CopyWithImpl$Mutation$UnmountVolume$storage;

  factory CopyWith$Mutation$UnmountVolume$storage.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UnmountVolume$storage;

  TRes call({
    Mutation$UnmountVolume$storage$unmountVolume? unmountVolume,
    String? $__typename,
  });
  CopyWith$Mutation$UnmountVolume$storage$unmountVolume<TRes> get unmountVolume;
}

class _CopyWithImpl$Mutation$UnmountVolume$storage<TRes>
    implements CopyWith$Mutation$UnmountVolume$storage<TRes> {
  _CopyWithImpl$Mutation$UnmountVolume$storage(this._instance, this._then);

  final Mutation$UnmountVolume$storage _instance;

  final TRes Function(Mutation$UnmountVolume$storage) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? unmountVolume = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$UnmountVolume$storage(
      unmountVolume:
          unmountVolume == _undefined || unmountVolume == null
              ? _instance.unmountVolume
              : (unmountVolume as Mutation$UnmountVolume$storage$unmountVolume),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$UnmountVolume$storage$unmountVolume<TRes>
  get unmountVolume {
    final local$unmountVolume = _instance.unmountVolume;
    return CopyWith$Mutation$UnmountVolume$storage$unmountVolume(
      local$unmountVolume,
      (e) => call(unmountVolume: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$UnmountVolume$storage<TRes>
    implements CopyWith$Mutation$UnmountVolume$storage<TRes> {
  _CopyWithStubImpl$Mutation$UnmountVolume$storage(this._res);

  TRes _res;

  call({
    Mutation$UnmountVolume$storage$unmountVolume? unmountVolume,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$UnmountVolume$storage$unmountVolume<TRes>
  get unmountVolume =>
      CopyWith$Mutation$UnmountVolume$storage$unmountVolume.stub(_res);
}

class Mutation$UnmountVolume$storage$unmountVolume
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$UnmountVolume$storage$unmountVolume({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$UnmountVolume$storage$unmountVolume.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$UnmountVolume$storage$unmountVolume(
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
    if (other is! Mutation$UnmountVolume$storage$unmountVolume ||
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

extension UtilityExtension$Mutation$UnmountVolume$storage$unmountVolume
    on Mutation$UnmountVolume$storage$unmountVolume {
  CopyWith$Mutation$UnmountVolume$storage$unmountVolume<
    Mutation$UnmountVolume$storage$unmountVolume
  >
  get copyWith =>
      CopyWith$Mutation$UnmountVolume$storage$unmountVolume(this, (i) => i);
}

abstract class CopyWith$Mutation$UnmountVolume$storage$unmountVolume<TRes> {
  factory CopyWith$Mutation$UnmountVolume$storage$unmountVolume(
    Mutation$UnmountVolume$storage$unmountVolume instance,
    TRes Function(Mutation$UnmountVolume$storage$unmountVolume) then,
  ) = _CopyWithImpl$Mutation$UnmountVolume$storage$unmountVolume;

  factory CopyWith$Mutation$UnmountVolume$storage$unmountVolume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UnmountVolume$storage$unmountVolume;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$UnmountVolume$storage$unmountVolume<TRes>
    implements CopyWith$Mutation$UnmountVolume$storage$unmountVolume<TRes> {
  _CopyWithImpl$Mutation$UnmountVolume$storage$unmountVolume(
    this._instance,
    this._then,
  );

  final Mutation$UnmountVolume$storage$unmountVolume _instance;

  final TRes Function(Mutation$UnmountVolume$storage$unmountVolume) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$UnmountVolume$storage$unmountVolume(
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

class _CopyWithStubImpl$Mutation$UnmountVolume$storage$unmountVolume<TRes>
    implements CopyWith$Mutation$UnmountVolume$storage$unmountVolume<TRes> {
  _CopyWithStubImpl$Mutation$UnmountVolume$storage$unmountVolume(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

class Variables$Mutation$MigrateToBinds {
  factory Variables$Mutation$MigrateToBinds({
    required Input$MigrateToBindsInput input,
  }) => Variables$Mutation$MigrateToBinds._({r'input': input});

  Variables$Mutation$MigrateToBinds._(this._$data);

  factory Variables$Mutation$MigrateToBinds.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$MigrateToBindsInput.fromJson(
      (l$input as Map<String, dynamic>),
    );
    return Variables$Mutation$MigrateToBinds._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$MigrateToBindsInput get input =>
      (_$data['input'] as Input$MigrateToBindsInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$MigrateToBinds<Variables$Mutation$MigrateToBinds>
  get copyWith => CopyWith$Variables$Mutation$MigrateToBinds(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$MigrateToBinds ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$MigrateToBinds<TRes> {
  factory CopyWith$Variables$Mutation$MigrateToBinds(
    Variables$Mutation$MigrateToBinds instance,
    TRes Function(Variables$Mutation$MigrateToBinds) then,
  ) = _CopyWithImpl$Variables$Mutation$MigrateToBinds;

  factory CopyWith$Variables$Mutation$MigrateToBinds.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$MigrateToBinds;

  TRes call({Input$MigrateToBindsInput? input});
}

class _CopyWithImpl$Variables$Mutation$MigrateToBinds<TRes>
    implements CopyWith$Variables$Mutation$MigrateToBinds<TRes> {
  _CopyWithImpl$Variables$Mutation$MigrateToBinds(this._instance, this._then);

  final Variables$Mutation$MigrateToBinds _instance;

  final TRes Function(Variables$Mutation$MigrateToBinds) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) => _then(
    Variables$Mutation$MigrateToBinds._({
      ..._instance._$data,
      if (input != _undefined && input != null)
        'input': (input as Input$MigrateToBindsInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$MigrateToBinds<TRes>
    implements CopyWith$Variables$Mutation$MigrateToBinds<TRes> {
  _CopyWithStubImpl$Variables$Mutation$MigrateToBinds(this._res);

  TRes _res;

  call({Input$MigrateToBindsInput? input}) => _res;
}

class Mutation$MigrateToBinds {
  Mutation$MigrateToBinds({
    required this.storage,
    this.$__typename = 'Mutation',
  });

  factory Mutation$MigrateToBinds.fromJson(Map<String, dynamic> json) {
    final l$storage = json['storage'];
    final l$$__typename = json['__typename'];
    return Mutation$MigrateToBinds(
      storage: Mutation$MigrateToBinds$storage.fromJson(
        (l$storage as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$MigrateToBinds$storage storage;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$storage = storage;
    _resultData['storage'] = l$storage.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$storage = storage;
    final l$$__typename = $__typename;
    return Object.hashAll([l$storage, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$MigrateToBinds || runtimeType != other.runtimeType) {
      return false;
    }
    final l$storage = storage;
    final lOther$storage = other.storage;
    if (l$storage != lOther$storage) {
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

extension UtilityExtension$Mutation$MigrateToBinds on Mutation$MigrateToBinds {
  CopyWith$Mutation$MigrateToBinds<Mutation$MigrateToBinds> get copyWith =>
      CopyWith$Mutation$MigrateToBinds(this, (i) => i);
}

abstract class CopyWith$Mutation$MigrateToBinds<TRes> {
  factory CopyWith$Mutation$MigrateToBinds(
    Mutation$MigrateToBinds instance,
    TRes Function(Mutation$MigrateToBinds) then,
  ) = _CopyWithImpl$Mutation$MigrateToBinds;

  factory CopyWith$Mutation$MigrateToBinds.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MigrateToBinds;

  TRes call({Mutation$MigrateToBinds$storage? storage, String? $__typename});
  CopyWith$Mutation$MigrateToBinds$storage<TRes> get storage;
}

class _CopyWithImpl$Mutation$MigrateToBinds<TRes>
    implements CopyWith$Mutation$MigrateToBinds<TRes> {
  _CopyWithImpl$Mutation$MigrateToBinds(this._instance, this._then);

  final Mutation$MigrateToBinds _instance;

  final TRes Function(Mutation$MigrateToBinds) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? storage = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$MigrateToBinds(
          storage:
              storage == _undefined || storage == null
                  ? _instance.storage
                  : (storage as Mutation$MigrateToBinds$storage),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$MigrateToBinds$storage<TRes> get storage {
    final local$storage = _instance.storage;
    return CopyWith$Mutation$MigrateToBinds$storage(
      local$storage,
      (e) => call(storage: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$MigrateToBinds<TRes>
    implements CopyWith$Mutation$MigrateToBinds<TRes> {
  _CopyWithStubImpl$Mutation$MigrateToBinds(this._res);

  TRes _res;

  call({Mutation$MigrateToBinds$storage? storage, String? $__typename}) => _res;

  CopyWith$Mutation$MigrateToBinds$storage<TRes> get storage =>
      CopyWith$Mutation$MigrateToBinds$storage.stub(_res);
}

const documentNodeMutationMigrateToBinds = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'MigrateToBinds'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'input')),
          type: NamedTypeNode(
            name: NameNode(value: 'MigrateToBindsInput'),
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
            name: NameNode(value: 'storage'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'migrateToBinds'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'input'),
                      value: VariableNode(name: NameNode(value: 'input')),
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
                        name: NameNode(value: 'job'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'basicApiJobsFields'),
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
    fragmentDefinitionbasicApiJobsFields,
  ],
);
Mutation$MigrateToBinds _parserFn$Mutation$MigrateToBinds(
  Map<String, dynamic> data,
) => Mutation$MigrateToBinds.fromJson(data);
typedef OnMutationCompleted$Mutation$MigrateToBinds =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$MigrateToBinds?);

class Options$Mutation$MigrateToBinds
    extends graphql.MutationOptions<Mutation$MigrateToBinds> {
  Options$Mutation$MigrateToBinds({
    String? operationName,
    required Variables$Mutation$MigrateToBinds variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$MigrateToBinds? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$MigrateToBinds? onCompleted,
    graphql.OnMutationUpdate<Mutation$MigrateToBinds>? update,
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
                       : _parserFn$Mutation$MigrateToBinds(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationMigrateToBinds,
         parserFn: _parserFn$Mutation$MigrateToBinds,
       );

  final OnMutationCompleted$Mutation$MigrateToBinds? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$MigrateToBinds
    extends graphql.WatchQueryOptions<Mutation$MigrateToBinds> {
  WatchOptions$Mutation$MigrateToBinds({
    String? operationName,
    required Variables$Mutation$MigrateToBinds variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$MigrateToBinds? typedOptimisticResult,
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
         document: documentNodeMutationMigrateToBinds,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$MigrateToBinds,
       );
}

extension ClientExtension$Mutation$MigrateToBinds on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$MigrateToBinds>> mutate$MigrateToBinds(
    Options$Mutation$MigrateToBinds options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$MigrateToBinds> watchMutation$MigrateToBinds(
    WatchOptions$Mutation$MigrateToBinds options,
  ) => this.watchMutation(options);
}

class Mutation$MigrateToBinds$storage {
  Mutation$MigrateToBinds$storage({
    required this.migrateToBinds,
    this.$__typename = 'StorageMutations',
  });

  factory Mutation$MigrateToBinds$storage.fromJson(Map<String, dynamic> json) {
    final l$migrateToBinds = json['migrateToBinds'];
    final l$$__typename = json['__typename'];
    return Mutation$MigrateToBinds$storage(
      migrateToBinds: Mutation$MigrateToBinds$storage$migrateToBinds.fromJson(
        (l$migrateToBinds as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$MigrateToBinds$storage$migrateToBinds migrateToBinds;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$migrateToBinds = migrateToBinds;
    _resultData['migrateToBinds'] = l$migrateToBinds.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$migrateToBinds = migrateToBinds;
    final l$$__typename = $__typename;
    return Object.hashAll([l$migrateToBinds, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$MigrateToBinds$storage ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$migrateToBinds = migrateToBinds;
    final lOther$migrateToBinds = other.migrateToBinds;
    if (l$migrateToBinds != lOther$migrateToBinds) {
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

extension UtilityExtension$Mutation$MigrateToBinds$storage
    on Mutation$MigrateToBinds$storage {
  CopyWith$Mutation$MigrateToBinds$storage<Mutation$MigrateToBinds$storage>
  get copyWith => CopyWith$Mutation$MigrateToBinds$storage(this, (i) => i);
}

abstract class CopyWith$Mutation$MigrateToBinds$storage<TRes> {
  factory CopyWith$Mutation$MigrateToBinds$storage(
    Mutation$MigrateToBinds$storage instance,
    TRes Function(Mutation$MigrateToBinds$storage) then,
  ) = _CopyWithImpl$Mutation$MigrateToBinds$storage;

  factory CopyWith$Mutation$MigrateToBinds$storage.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MigrateToBinds$storage;

  TRes call({
    Mutation$MigrateToBinds$storage$migrateToBinds? migrateToBinds,
    String? $__typename,
  });
  CopyWith$Mutation$MigrateToBinds$storage$migrateToBinds<TRes>
  get migrateToBinds;
}

class _CopyWithImpl$Mutation$MigrateToBinds$storage<TRes>
    implements CopyWith$Mutation$MigrateToBinds$storage<TRes> {
  _CopyWithImpl$Mutation$MigrateToBinds$storage(this._instance, this._then);

  final Mutation$MigrateToBinds$storage _instance;

  final TRes Function(Mutation$MigrateToBinds$storage) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? migrateToBinds = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$MigrateToBinds$storage(
      migrateToBinds:
          migrateToBinds == _undefined || migrateToBinds == null
              ? _instance.migrateToBinds
              : (migrateToBinds
                  as Mutation$MigrateToBinds$storage$migrateToBinds),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$MigrateToBinds$storage$migrateToBinds<TRes>
  get migrateToBinds {
    final local$migrateToBinds = _instance.migrateToBinds;
    return CopyWith$Mutation$MigrateToBinds$storage$migrateToBinds(
      local$migrateToBinds,
      (e) => call(migrateToBinds: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$MigrateToBinds$storage<TRes>
    implements CopyWith$Mutation$MigrateToBinds$storage<TRes> {
  _CopyWithStubImpl$Mutation$MigrateToBinds$storage(this._res);

  TRes _res;

  call({
    Mutation$MigrateToBinds$storage$migrateToBinds? migrateToBinds,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$MigrateToBinds$storage$migrateToBinds<TRes>
  get migrateToBinds =>
      CopyWith$Mutation$MigrateToBinds$storage$migrateToBinds.stub(_res);
}

class Mutation$MigrateToBinds$storage$migrateToBinds
    implements Fragment$basicMutationReturnFields$$GenericJobMutationReturn {
  Mutation$MigrateToBinds$storage$migrateToBinds({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericJobMutationReturn',
    this.job,
  });

  factory Mutation$MigrateToBinds$storage$migrateToBinds.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$job = json['job'];
    return Mutation$MigrateToBinds$storage$migrateToBinds(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      job:
          l$job == null
              ? null
              : Fragment$basicApiJobsFields.fromJson(
                (l$job as Map<String, dynamic>),
              ),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final Fragment$basicApiJobsFields? job;

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
    final l$job = job;
    _resultData['job'] = l$job?.toJson();
    return _resultData;
  }

  @override
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
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$MigrateToBinds$storage$migrateToBinds ||
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
    final l$job = job;
    final lOther$job = other.job;
    if (l$job != lOther$job) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$MigrateToBinds$storage$migrateToBinds
    on Mutation$MigrateToBinds$storage$migrateToBinds {
  CopyWith$Mutation$MigrateToBinds$storage$migrateToBinds<
    Mutation$MigrateToBinds$storage$migrateToBinds
  >
  get copyWith =>
      CopyWith$Mutation$MigrateToBinds$storage$migrateToBinds(this, (i) => i);
}

abstract class CopyWith$Mutation$MigrateToBinds$storage$migrateToBinds<TRes> {
  factory CopyWith$Mutation$MigrateToBinds$storage$migrateToBinds(
    Mutation$MigrateToBinds$storage$migrateToBinds instance,
    TRes Function(Mutation$MigrateToBinds$storage$migrateToBinds) then,
  ) = _CopyWithImpl$Mutation$MigrateToBinds$storage$migrateToBinds;

  factory CopyWith$Mutation$MigrateToBinds$storage$migrateToBinds.stub(
    TRes res,
  ) = _CopyWithStubImpl$Mutation$MigrateToBinds$storage$migrateToBinds;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$basicApiJobsFields? job,
  });
  CopyWith$Fragment$basicApiJobsFields<TRes> get job;
}

class _CopyWithImpl$Mutation$MigrateToBinds$storage$migrateToBinds<TRes>
    implements CopyWith$Mutation$MigrateToBinds$storage$migrateToBinds<TRes> {
  _CopyWithImpl$Mutation$MigrateToBinds$storage$migrateToBinds(
    this._instance,
    this._then,
  );

  final Mutation$MigrateToBinds$storage$migrateToBinds _instance;

  final TRes Function(Mutation$MigrateToBinds$storage$migrateToBinds) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? job = _undefined,
  }) => _then(
    Mutation$MigrateToBinds$storage$migrateToBinds(
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
      job:
          job == _undefined
              ? _instance.job
              : (job as Fragment$basicApiJobsFields?),
    ),
  );

  CopyWith$Fragment$basicApiJobsFields<TRes> get job {
    final local$job = _instance.job;
    return local$job == null
        ? CopyWith$Fragment$basicApiJobsFields.stub(_then(_instance))
        : CopyWith$Fragment$basicApiJobsFields(local$job, (e) => call(job: e));
  }
}

class _CopyWithStubImpl$Mutation$MigrateToBinds$storage$migrateToBinds<TRes>
    implements CopyWith$Mutation$MigrateToBinds$storage$migrateToBinds<TRes> {
  _CopyWithStubImpl$Mutation$MigrateToBinds$storage$migrateToBinds(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$basicApiJobsFields? job,
  }) => _res;

  CopyWith$Fragment$basicApiJobsFields<TRes> get job =>
      CopyWith$Fragment$basicApiJobsFields.stub(_res);
}
