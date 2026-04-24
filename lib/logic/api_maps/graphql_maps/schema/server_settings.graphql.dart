import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'schema.graphql.dart';
import 'server_api.graphql.dart';

class Fragment$fragmentDnsRecords {
  Fragment$fragmentDnsRecords({
    required this.recordType,
    required this.name,
    required this.displayName,
    required this.content,
    required this.ttl,
    this.priority,
    this.$__typename = 'DnsRecord',
  });

  factory Fragment$fragmentDnsRecords.fromJson(Map<String, dynamic> json) {
    final l$recordType = json['recordType'];
    final l$name = json['name'];
    final l$displayName = json['displayName'];
    final l$content = json['content'];
    final l$ttl = json['ttl'];
    final l$priority = json['priority'];
    final l$$__typename = json['__typename'];
    return Fragment$fragmentDnsRecords(
      recordType: (l$recordType as String),
      name: (l$name as String),
      displayName: (l$displayName as String),
      content: (l$content as String),
      ttl: (l$ttl as int),
      priority: (l$priority as int?),
      $__typename: (l$$__typename as String),
    );
  }

  final String recordType;

  final String name;

  final String displayName;

  final String content;

  final int ttl;

  final int? priority;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$recordType = recordType;
    _resultData['recordType'] = l$recordType;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$displayName = displayName;
    _resultData['displayName'] = l$displayName;
    final l$content = content;
    _resultData['content'] = l$content;
    final l$ttl = ttl;
    _resultData['ttl'] = l$ttl;
    final l$priority = priority;
    _resultData['priority'] = l$priority;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$recordType = recordType;
    final l$name = name;
    final l$displayName = displayName;
    final l$content = content;
    final l$ttl = ttl;
    final l$priority = priority;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$recordType,
      l$name,
      l$displayName,
      l$content,
      l$ttl,
      l$priority,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$fragmentDnsRecords ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$recordType = recordType;
    final lOther$recordType = other.recordType;
    if (l$recordType != lOther$recordType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) {
      return false;
    }
    final l$content = content;
    final lOther$content = other.content;
    if (l$content != lOther$content) {
      return false;
    }
    final l$ttl = ttl;
    final lOther$ttl = other.ttl;
    if (l$ttl != lOther$ttl) {
      return false;
    }
    final l$priority = priority;
    final lOther$priority = other.priority;
    if (l$priority != lOther$priority) {
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

extension UtilityExtension$Fragment$fragmentDnsRecords
    on Fragment$fragmentDnsRecords {
  CopyWith$Fragment$fragmentDnsRecords<Fragment$fragmentDnsRecords>
  get copyWith => CopyWith$Fragment$fragmentDnsRecords(this, (i) => i);
}

abstract class CopyWith$Fragment$fragmentDnsRecords<TRes> {
  factory CopyWith$Fragment$fragmentDnsRecords(
    Fragment$fragmentDnsRecords instance,
    TRes Function(Fragment$fragmentDnsRecords) then,
  ) = _CopyWithImpl$Fragment$fragmentDnsRecords;

  factory CopyWith$Fragment$fragmentDnsRecords.stub(TRes res) =
      _CopyWithStubImpl$Fragment$fragmentDnsRecords;

  TRes call({
    String? recordType,
    String? name,
    String? displayName,
    String? content,
    int? ttl,
    int? priority,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$fragmentDnsRecords<TRes>
    implements CopyWith$Fragment$fragmentDnsRecords<TRes> {
  _CopyWithImpl$Fragment$fragmentDnsRecords(this._instance, this._then);

  final Fragment$fragmentDnsRecords _instance;

  final TRes Function(Fragment$fragmentDnsRecords) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? recordType = _undefined,
    Object? name = _undefined,
    Object? displayName = _undefined,
    Object? content = _undefined,
    Object? ttl = _undefined,
    Object? priority = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$fragmentDnsRecords(
      recordType:
          recordType == _undefined || recordType == null
              ? _instance.recordType
              : (recordType as String),
      name:
          name == _undefined || name == null
              ? _instance.name
              : (name as String),
      displayName:
          displayName == _undefined || displayName == null
              ? _instance.displayName
              : (displayName as String),
      content:
          content == _undefined || content == null
              ? _instance.content
              : (content as String),
      ttl: ttl == _undefined || ttl == null ? _instance.ttl : (ttl as int),
      priority:
          priority == _undefined ? _instance.priority : (priority as int?),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$fragmentDnsRecords<TRes>
    implements CopyWith$Fragment$fragmentDnsRecords<TRes> {
  _CopyWithStubImpl$Fragment$fragmentDnsRecords(this._res);

  TRes _res;

  call({
    String? recordType,
    String? name,
    String? displayName,
    String? content,
    int? ttl,
    int? priority,
    String? $__typename,
  }) => _res;
}

const fragmentDefinitionfragmentDnsRecords = FragmentDefinitionNode(
  name: NameNode(value: 'fragmentDnsRecords'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'DnsRecord'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'recordType'),
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
        name: NameNode(value: 'displayName'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'content'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'ttl'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'priority'),
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
);
const documentNodeFragmentfragmentDnsRecords = DocumentNode(
  definitions: [fragmentDefinitionfragmentDnsRecords],
);

extension ClientExtension$Fragment$fragmentDnsRecords on graphql.GraphQLClient {
  void writeFragment$fragmentDnsRecords({
    required Fragment$fragmentDnsRecords data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'fragmentDnsRecords',
        document: documentNodeFragmentfragmentDnsRecords,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Fragment$fragmentDnsRecords? readFragment$fragmentDnsRecords({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'fragmentDnsRecords',
          document: documentNodeFragmentfragmentDnsRecords,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$fragmentDnsRecords.fromJson(result);
  }
}

class Query$SystemSettings {
  Query$SystemSettings({required this.system, this.$__typename = 'Query'});

  factory Query$SystemSettings.fromJson(Map<String, dynamic> json) {
    final l$system = json['system'];
    final l$$__typename = json['__typename'];
    return Query$SystemSettings(
      system: Query$SystemSettings$system.fromJson(
        (l$system as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$SystemSettings$system system;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$system = system;
    _resultData['system'] = l$system.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$system = system;
    final l$$__typename = $__typename;
    return Object.hashAll([l$system, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$SystemSettings || runtimeType != other.runtimeType) {
      return false;
    }
    final l$system = system;
    final lOther$system = other.system;
    if (l$system != lOther$system) {
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

extension UtilityExtension$Query$SystemSettings on Query$SystemSettings {
  CopyWith$Query$SystemSettings<Query$SystemSettings> get copyWith =>
      CopyWith$Query$SystemSettings(this, (i) => i);
}

abstract class CopyWith$Query$SystemSettings<TRes> {
  factory CopyWith$Query$SystemSettings(
    Query$SystemSettings instance,
    TRes Function(Query$SystemSettings) then,
  ) = _CopyWithImpl$Query$SystemSettings;

  factory CopyWith$Query$SystemSettings.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemSettings;

  TRes call({Query$SystemSettings$system? system, String? $__typename});
  CopyWith$Query$SystemSettings$system<TRes> get system;
}

class _CopyWithImpl$Query$SystemSettings<TRes>
    implements CopyWith$Query$SystemSettings<TRes> {
  _CopyWithImpl$Query$SystemSettings(this._instance, this._then);

  final Query$SystemSettings _instance;

  final TRes Function(Query$SystemSettings) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? system = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$SystemSettings(
          system:
              system == _undefined || system == null
                  ? _instance.system
                  : (system as Query$SystemSettings$system),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Query$SystemSettings$system<TRes> get system {
    final local$system = _instance.system;
    return CopyWith$Query$SystemSettings$system(
      local$system,
      (e) => call(system: e),
    );
  }
}

class _CopyWithStubImpl$Query$SystemSettings<TRes>
    implements CopyWith$Query$SystemSettings<TRes> {
  _CopyWithStubImpl$Query$SystemSettings(this._res);

  TRes _res;

  call({Query$SystemSettings$system? system, String? $__typename}) => _res;

  CopyWith$Query$SystemSettings$system<TRes> get system =>
      CopyWith$Query$SystemSettings$system.stub(_res);
}

const documentNodeQuerySystemSettings = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SystemSettings'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'system'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'settings'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'autoUpgrade'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FieldNode(
                              name: NameNode(value: 'allowReboot'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'enable'),
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
                        name: NameNode(value: 'ssh'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FieldNode(
                              name: NameNode(value: 'enable'),
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
                        name: NameNode(value: 'timezone'),
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
Query$SystemSettings _parserFn$Query$SystemSettings(
  Map<String, dynamic> data,
) => Query$SystemSettings.fromJson(data);
typedef OnQueryComplete$Query$SystemSettings =
    FutureOr<void> Function(Map<String, dynamic>?, Query$SystemSettings?);

class Options$Query$SystemSettings
    extends graphql.QueryOptions<Query$SystemSettings> {
  Options$Query$SystemSettings({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$SystemSettings? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$SystemSettings? onComplete,
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
                   data == null ? null : _parserFn$Query$SystemSettings(data),
                 ),
         onError: onError,
         document: documentNodeQuerySystemSettings,
         parserFn: _parserFn$Query$SystemSettings,
       );

  final OnQueryComplete$Query$SystemSettings? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$SystemSettings
    extends graphql.WatchQueryOptions<Query$SystemSettings> {
  WatchOptions$Query$SystemSettings({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$SystemSettings? typedOptimisticResult,
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
         document: documentNodeQuerySystemSettings,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$SystemSettings,
       );
}

class FetchMoreOptions$Query$SystemSettings extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$SystemSettings({
    required graphql.UpdateQuery updateQuery,
  }) : super(
         updateQuery: updateQuery,
         document: documentNodeQuerySystemSettings,
       );
}

extension ClientExtension$Query$SystemSettings on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$SystemSettings>> query$SystemSettings([
    Options$Query$SystemSettings? options,
  ]) async => await this.query(options ?? Options$Query$SystemSettings());
  graphql.ObservableQuery<Query$SystemSettings> watchQuery$SystemSettings([
    WatchOptions$Query$SystemSettings? options,
  ]) => this.watchQuery(options ?? WatchOptions$Query$SystemSettings());
  void writeQuery$SystemSettings({
    required Query$SystemSettings data,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQuerySystemSettings),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Query$SystemSettings? readQuery$SystemSettings({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQuerySystemSettings),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$SystemSettings.fromJson(result);
  }
}

class Query$SystemSettings$system {
  Query$SystemSettings$system({
    required this.settings,
    this.$__typename = 'System',
  });

  factory Query$SystemSettings$system.fromJson(Map<String, dynamic> json) {
    final l$settings = json['settings'];
    final l$$__typename = json['__typename'];
    return Query$SystemSettings$system(
      settings: Query$SystemSettings$system$settings.fromJson(
        (l$settings as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$SystemSettings$system$settings settings;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$settings = settings;
    _resultData['settings'] = l$settings.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$settings = settings;
    final l$$__typename = $__typename;
    return Object.hashAll([l$settings, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$SystemSettings$system ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$settings = settings;
    final lOther$settings = other.settings;
    if (l$settings != lOther$settings) {
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

extension UtilityExtension$Query$SystemSettings$system
    on Query$SystemSettings$system {
  CopyWith$Query$SystemSettings$system<Query$SystemSettings$system>
  get copyWith => CopyWith$Query$SystemSettings$system(this, (i) => i);
}

abstract class CopyWith$Query$SystemSettings$system<TRes> {
  factory CopyWith$Query$SystemSettings$system(
    Query$SystemSettings$system instance,
    TRes Function(Query$SystemSettings$system) then,
  ) = _CopyWithImpl$Query$SystemSettings$system;

  factory CopyWith$Query$SystemSettings$system.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemSettings$system;

  TRes call({
    Query$SystemSettings$system$settings? settings,
    String? $__typename,
  });
  CopyWith$Query$SystemSettings$system$settings<TRes> get settings;
}

class _CopyWithImpl$Query$SystemSettings$system<TRes>
    implements CopyWith$Query$SystemSettings$system<TRes> {
  _CopyWithImpl$Query$SystemSettings$system(this._instance, this._then);

  final Query$SystemSettings$system _instance;

  final TRes Function(Query$SystemSettings$system) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? settings = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$SystemSettings$system(
      settings:
          settings == _undefined || settings == null
              ? _instance.settings
              : (settings as Query$SystemSettings$system$settings),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$SystemSettings$system$settings<TRes> get settings {
    final local$settings = _instance.settings;
    return CopyWith$Query$SystemSettings$system$settings(
      local$settings,
      (e) => call(settings: e),
    );
  }
}

class _CopyWithStubImpl$Query$SystemSettings$system<TRes>
    implements CopyWith$Query$SystemSettings$system<TRes> {
  _CopyWithStubImpl$Query$SystemSettings$system(this._res);

  TRes _res;

  call({Query$SystemSettings$system$settings? settings, String? $__typename}) =>
      _res;

  CopyWith$Query$SystemSettings$system$settings<TRes> get settings =>
      CopyWith$Query$SystemSettings$system$settings.stub(_res);
}

class Query$SystemSettings$system$settings {
  Query$SystemSettings$system$settings({
    required this.autoUpgrade,
    required this.ssh,
    required this.timezone,
    this.$__typename = 'SystemSettings',
  });

  factory Query$SystemSettings$system$settings.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$autoUpgrade = json['autoUpgrade'];
    final l$ssh = json['ssh'];
    final l$timezone = json['timezone'];
    final l$$__typename = json['__typename'];
    return Query$SystemSettings$system$settings(
      autoUpgrade: Query$SystemSettings$system$settings$autoUpgrade.fromJson(
        (l$autoUpgrade as Map<String, dynamic>),
      ),
      ssh: Query$SystemSettings$system$settings$ssh.fromJson(
        (l$ssh as Map<String, dynamic>),
      ),
      timezone: (l$timezone as String),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$SystemSettings$system$settings$autoUpgrade autoUpgrade;

  final Query$SystemSettings$system$settings$ssh ssh;

  final String timezone;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$autoUpgrade = autoUpgrade;
    _resultData['autoUpgrade'] = l$autoUpgrade.toJson();
    final l$ssh = ssh;
    _resultData['ssh'] = l$ssh.toJson();
    final l$timezone = timezone;
    _resultData['timezone'] = l$timezone;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$autoUpgrade = autoUpgrade;
    final l$ssh = ssh;
    final l$timezone = timezone;
    final l$$__typename = $__typename;
    return Object.hashAll([l$autoUpgrade, l$ssh, l$timezone, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$SystemSettings$system$settings ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$autoUpgrade = autoUpgrade;
    final lOther$autoUpgrade = other.autoUpgrade;
    if (l$autoUpgrade != lOther$autoUpgrade) {
      return false;
    }
    final l$ssh = ssh;
    final lOther$ssh = other.ssh;
    if (l$ssh != lOther$ssh) {
      return false;
    }
    final l$timezone = timezone;
    final lOther$timezone = other.timezone;
    if (l$timezone != lOther$timezone) {
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

extension UtilityExtension$Query$SystemSettings$system$settings
    on Query$SystemSettings$system$settings {
  CopyWith$Query$SystemSettings$system$settings<
    Query$SystemSettings$system$settings
  >
  get copyWith => CopyWith$Query$SystemSettings$system$settings(this, (i) => i);
}

abstract class CopyWith$Query$SystemSettings$system$settings<TRes> {
  factory CopyWith$Query$SystemSettings$system$settings(
    Query$SystemSettings$system$settings instance,
    TRes Function(Query$SystemSettings$system$settings) then,
  ) = _CopyWithImpl$Query$SystemSettings$system$settings;

  factory CopyWith$Query$SystemSettings$system$settings.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemSettings$system$settings;

  TRes call({
    Query$SystemSettings$system$settings$autoUpgrade? autoUpgrade,
    Query$SystemSettings$system$settings$ssh? ssh,
    String? timezone,
    String? $__typename,
  });
  CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes>
  get autoUpgrade;
  CopyWith$Query$SystemSettings$system$settings$ssh<TRes> get ssh;
}

class _CopyWithImpl$Query$SystemSettings$system$settings<TRes>
    implements CopyWith$Query$SystemSettings$system$settings<TRes> {
  _CopyWithImpl$Query$SystemSettings$system$settings(
    this._instance,
    this._then,
  );

  final Query$SystemSettings$system$settings _instance;

  final TRes Function(Query$SystemSettings$system$settings) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? autoUpgrade = _undefined,
    Object? ssh = _undefined,
    Object? timezone = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$SystemSettings$system$settings(
      autoUpgrade:
          autoUpgrade == _undefined || autoUpgrade == null
              ? _instance.autoUpgrade
              : (autoUpgrade
                  as Query$SystemSettings$system$settings$autoUpgrade),
      ssh:
          ssh == _undefined || ssh == null
              ? _instance.ssh
              : (ssh as Query$SystemSettings$system$settings$ssh),
      timezone:
          timezone == _undefined || timezone == null
              ? _instance.timezone
              : (timezone as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes>
  get autoUpgrade {
    final local$autoUpgrade = _instance.autoUpgrade;
    return CopyWith$Query$SystemSettings$system$settings$autoUpgrade(
      local$autoUpgrade,
      (e) => call(autoUpgrade: e),
    );
  }

  CopyWith$Query$SystemSettings$system$settings$ssh<TRes> get ssh {
    final local$ssh = _instance.ssh;
    return CopyWith$Query$SystemSettings$system$settings$ssh(
      local$ssh,
      (e) => call(ssh: e),
    );
  }
}

class _CopyWithStubImpl$Query$SystemSettings$system$settings<TRes>
    implements CopyWith$Query$SystemSettings$system$settings<TRes> {
  _CopyWithStubImpl$Query$SystemSettings$system$settings(this._res);

  TRes _res;

  call({
    Query$SystemSettings$system$settings$autoUpgrade? autoUpgrade,
    Query$SystemSettings$system$settings$ssh? ssh,
    String? timezone,
    String? $__typename,
  }) => _res;

  CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes>
  get autoUpgrade =>
      CopyWith$Query$SystemSettings$system$settings$autoUpgrade.stub(_res);

  CopyWith$Query$SystemSettings$system$settings$ssh<TRes> get ssh =>
      CopyWith$Query$SystemSettings$system$settings$ssh.stub(_res);
}

class Query$SystemSettings$system$settings$autoUpgrade {
  Query$SystemSettings$system$settings$autoUpgrade({
    required this.allowReboot,
    required this.enable,
    this.$__typename = 'AutoUpgradeOptions',
  });

  factory Query$SystemSettings$system$settings$autoUpgrade.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$allowReboot = json['allowReboot'];
    final l$enable = json['enable'];
    final l$$__typename = json['__typename'];
    return Query$SystemSettings$system$settings$autoUpgrade(
      allowReboot: (l$allowReboot as bool),
      enable: (l$enable as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final bool allowReboot;

  final bool enable;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$allowReboot = allowReboot;
    _resultData['allowReboot'] = l$allowReboot;
    final l$enable = enable;
    _resultData['enable'] = l$enable;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$allowReboot = allowReboot;
    final l$enable = enable;
    final l$$__typename = $__typename;
    return Object.hashAll([l$allowReboot, l$enable, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$SystemSettings$system$settings$autoUpgrade ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$allowReboot = allowReboot;
    final lOther$allowReboot = other.allowReboot;
    if (l$allowReboot != lOther$allowReboot) {
      return false;
    }
    final l$enable = enable;
    final lOther$enable = other.enable;
    if (l$enable != lOther$enable) {
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

extension UtilityExtension$Query$SystemSettings$system$settings$autoUpgrade
    on Query$SystemSettings$system$settings$autoUpgrade {
  CopyWith$Query$SystemSettings$system$settings$autoUpgrade<
    Query$SystemSettings$system$settings$autoUpgrade
  >
  get copyWith =>
      CopyWith$Query$SystemSettings$system$settings$autoUpgrade(this, (i) => i);
}

abstract class CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes> {
  factory CopyWith$Query$SystemSettings$system$settings$autoUpgrade(
    Query$SystemSettings$system$settings$autoUpgrade instance,
    TRes Function(Query$SystemSettings$system$settings$autoUpgrade) then,
  ) = _CopyWithImpl$Query$SystemSettings$system$settings$autoUpgrade;

  factory CopyWith$Query$SystemSettings$system$settings$autoUpgrade.stub(
    TRes res,
  ) = _CopyWithStubImpl$Query$SystemSettings$system$settings$autoUpgrade;

  TRes call({bool? allowReboot, bool? enable, String? $__typename});
}

class _CopyWithImpl$Query$SystemSettings$system$settings$autoUpgrade<TRes>
    implements CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes> {
  _CopyWithImpl$Query$SystemSettings$system$settings$autoUpgrade(
    this._instance,
    this._then,
  );

  final Query$SystemSettings$system$settings$autoUpgrade _instance;

  final TRes Function(Query$SystemSettings$system$settings$autoUpgrade) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? allowReboot = _undefined,
    Object? enable = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$SystemSettings$system$settings$autoUpgrade(
      allowReboot:
          allowReboot == _undefined || allowReboot == null
              ? _instance.allowReboot
              : (allowReboot as bool),
      enable:
          enable == _undefined || enable == null
              ? _instance.enable
              : (enable as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$SystemSettings$system$settings$autoUpgrade<TRes>
    implements CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes> {
  _CopyWithStubImpl$Query$SystemSettings$system$settings$autoUpgrade(this._res);

  TRes _res;

  call({bool? allowReboot, bool? enable, String? $__typename}) => _res;
}

class Query$SystemSettings$system$settings$ssh {
  Query$SystemSettings$system$settings$ssh({
    required this.enable,
    this.$__typename = 'SshSettings',
  });

  factory Query$SystemSettings$system$settings$ssh.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$enable = json['enable'];
    final l$$__typename = json['__typename'];
    return Query$SystemSettings$system$settings$ssh(
      enable: (l$enable as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final bool enable;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$enable = enable;
    _resultData['enable'] = l$enable;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$enable = enable;
    final l$$__typename = $__typename;
    return Object.hashAll([l$enable, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$SystemSettings$system$settings$ssh ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$enable = enable;
    final lOther$enable = other.enable;
    if (l$enable != lOther$enable) {
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

extension UtilityExtension$Query$SystemSettings$system$settings$ssh
    on Query$SystemSettings$system$settings$ssh {
  CopyWith$Query$SystemSettings$system$settings$ssh<
    Query$SystemSettings$system$settings$ssh
  >
  get copyWith =>
      CopyWith$Query$SystemSettings$system$settings$ssh(this, (i) => i);
}

abstract class CopyWith$Query$SystemSettings$system$settings$ssh<TRes> {
  factory CopyWith$Query$SystemSettings$system$settings$ssh(
    Query$SystemSettings$system$settings$ssh instance,
    TRes Function(Query$SystemSettings$system$settings$ssh) then,
  ) = _CopyWithImpl$Query$SystemSettings$system$settings$ssh;

  factory CopyWith$Query$SystemSettings$system$settings$ssh.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemSettings$system$settings$ssh;

  TRes call({bool? enable, String? $__typename});
}

class _CopyWithImpl$Query$SystemSettings$system$settings$ssh<TRes>
    implements CopyWith$Query$SystemSettings$system$settings$ssh<TRes> {
  _CopyWithImpl$Query$SystemSettings$system$settings$ssh(
    this._instance,
    this._then,
  );

  final Query$SystemSettings$system$settings$ssh _instance;

  final TRes Function(Query$SystemSettings$system$settings$ssh) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? enable = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$SystemSettings$system$settings$ssh(
          enable:
              enable == _undefined || enable == null
                  ? _instance.enable
                  : (enable as bool),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );
}

class _CopyWithStubImpl$Query$SystemSettings$system$settings$ssh<TRes>
    implements CopyWith$Query$SystemSettings$system$settings$ssh<TRes> {
  _CopyWithStubImpl$Query$SystemSettings$system$settings$ssh(this._res);

  TRes _res;

  call({bool? enable, String? $__typename}) => _res;
}

class Query$SystemIsUsingBinds {
  Query$SystemIsUsingBinds({required this.system, this.$__typename = 'Query'});

  factory Query$SystemIsUsingBinds.fromJson(Map<String, dynamic> json) {
    final l$system = json['system'];
    final l$$__typename = json['__typename'];
    return Query$SystemIsUsingBinds(
      system: Query$SystemIsUsingBinds$system.fromJson(
        (l$system as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$SystemIsUsingBinds$system system;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$system = system;
    _resultData['system'] = l$system.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$system = system;
    final l$$__typename = $__typename;
    return Object.hashAll([l$system, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$SystemIsUsingBinds ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$system = system;
    final lOther$system = other.system;
    if (l$system != lOther$system) {
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

extension UtilityExtension$Query$SystemIsUsingBinds
    on Query$SystemIsUsingBinds {
  CopyWith$Query$SystemIsUsingBinds<Query$SystemIsUsingBinds> get copyWith =>
      CopyWith$Query$SystemIsUsingBinds(this, (i) => i);
}

abstract class CopyWith$Query$SystemIsUsingBinds<TRes> {
  factory CopyWith$Query$SystemIsUsingBinds(
    Query$SystemIsUsingBinds instance,
    TRes Function(Query$SystemIsUsingBinds) then,
  ) = _CopyWithImpl$Query$SystemIsUsingBinds;

  factory CopyWith$Query$SystemIsUsingBinds.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemIsUsingBinds;

  TRes call({Query$SystemIsUsingBinds$system? system, String? $__typename});
  CopyWith$Query$SystemIsUsingBinds$system<TRes> get system;
}

class _CopyWithImpl$Query$SystemIsUsingBinds<TRes>
    implements CopyWith$Query$SystemIsUsingBinds<TRes> {
  _CopyWithImpl$Query$SystemIsUsingBinds(this._instance, this._then);

  final Query$SystemIsUsingBinds _instance;

  final TRes Function(Query$SystemIsUsingBinds) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? system = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$SystemIsUsingBinds(
          system:
              system == _undefined || system == null
                  ? _instance.system
                  : (system as Query$SystemIsUsingBinds$system),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Query$SystemIsUsingBinds$system<TRes> get system {
    final local$system = _instance.system;
    return CopyWith$Query$SystemIsUsingBinds$system(
      local$system,
      (e) => call(system: e),
    );
  }
}

class _CopyWithStubImpl$Query$SystemIsUsingBinds<TRes>
    implements CopyWith$Query$SystemIsUsingBinds<TRes> {
  _CopyWithStubImpl$Query$SystemIsUsingBinds(this._res);

  TRes _res;

  call({Query$SystemIsUsingBinds$system? system, String? $__typename}) => _res;

  CopyWith$Query$SystemIsUsingBinds$system<TRes> get system =>
      CopyWith$Query$SystemIsUsingBinds$system.stub(_res);
}

const documentNodeQuerySystemIsUsingBinds = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SystemIsUsingBinds'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'system'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'info'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'usingBinds'),
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
Query$SystemIsUsingBinds _parserFn$Query$SystemIsUsingBinds(
  Map<String, dynamic> data,
) => Query$SystemIsUsingBinds.fromJson(data);
typedef OnQueryComplete$Query$SystemIsUsingBinds =
    FutureOr<void> Function(Map<String, dynamic>?, Query$SystemIsUsingBinds?);

class Options$Query$SystemIsUsingBinds
    extends graphql.QueryOptions<Query$SystemIsUsingBinds> {
  Options$Query$SystemIsUsingBinds({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$SystemIsUsingBinds? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$SystemIsUsingBinds? onComplete,
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
                       : _parserFn$Query$SystemIsUsingBinds(data),
                 ),
         onError: onError,
         document: documentNodeQuerySystemIsUsingBinds,
         parserFn: _parserFn$Query$SystemIsUsingBinds,
       );

  final OnQueryComplete$Query$SystemIsUsingBinds? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$SystemIsUsingBinds
    extends graphql.WatchQueryOptions<Query$SystemIsUsingBinds> {
  WatchOptions$Query$SystemIsUsingBinds({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$SystemIsUsingBinds? typedOptimisticResult,
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
         document: documentNodeQuerySystemIsUsingBinds,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$SystemIsUsingBinds,
       );
}

class FetchMoreOptions$Query$SystemIsUsingBinds
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$SystemIsUsingBinds({
    required graphql.UpdateQuery updateQuery,
  }) : super(
         updateQuery: updateQuery,
         document: documentNodeQuerySystemIsUsingBinds,
       );
}

extension ClientExtension$Query$SystemIsUsingBinds on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$SystemIsUsingBinds>>
  query$SystemIsUsingBinds([Options$Query$SystemIsUsingBinds? options]) async =>
      await this.query(options ?? Options$Query$SystemIsUsingBinds());
  graphql.ObservableQuery<Query$SystemIsUsingBinds>
  watchQuery$SystemIsUsingBinds([
    WatchOptions$Query$SystemIsUsingBinds? options,
  ]) => this.watchQuery(options ?? WatchOptions$Query$SystemIsUsingBinds());
  void writeQuery$SystemIsUsingBinds({
    required Query$SystemIsUsingBinds data,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(
        document: documentNodeQuerySystemIsUsingBinds,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Query$SystemIsUsingBinds? readQuery$SystemIsUsingBinds({
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(
          document: documentNodeQuerySystemIsUsingBinds,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$SystemIsUsingBinds.fromJson(result);
  }
}

class Query$SystemIsUsingBinds$system {
  Query$SystemIsUsingBinds$system({
    required this.info,
    this.$__typename = 'System',
  });

  factory Query$SystemIsUsingBinds$system.fromJson(Map<String, dynamic> json) {
    final l$info = json['info'];
    final l$$__typename = json['__typename'];
    return Query$SystemIsUsingBinds$system(
      info: Query$SystemIsUsingBinds$system$info.fromJson(
        (l$info as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$SystemIsUsingBinds$system$info info;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$info = info;
    _resultData['info'] = l$info.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$info = info;
    final l$$__typename = $__typename;
    return Object.hashAll([l$info, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$SystemIsUsingBinds$system ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$info = info;
    final lOther$info = other.info;
    if (l$info != lOther$info) {
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

extension UtilityExtension$Query$SystemIsUsingBinds$system
    on Query$SystemIsUsingBinds$system {
  CopyWith$Query$SystemIsUsingBinds$system<Query$SystemIsUsingBinds$system>
  get copyWith => CopyWith$Query$SystemIsUsingBinds$system(this, (i) => i);
}

abstract class CopyWith$Query$SystemIsUsingBinds$system<TRes> {
  factory CopyWith$Query$SystemIsUsingBinds$system(
    Query$SystemIsUsingBinds$system instance,
    TRes Function(Query$SystemIsUsingBinds$system) then,
  ) = _CopyWithImpl$Query$SystemIsUsingBinds$system;

  factory CopyWith$Query$SystemIsUsingBinds$system.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemIsUsingBinds$system;

  TRes call({Query$SystemIsUsingBinds$system$info? info, String? $__typename});
  CopyWith$Query$SystemIsUsingBinds$system$info<TRes> get info;
}

class _CopyWithImpl$Query$SystemIsUsingBinds$system<TRes>
    implements CopyWith$Query$SystemIsUsingBinds$system<TRes> {
  _CopyWithImpl$Query$SystemIsUsingBinds$system(this._instance, this._then);

  final Query$SystemIsUsingBinds$system _instance;

  final TRes Function(Query$SystemIsUsingBinds$system) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? info = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$SystemIsUsingBinds$system(
          info:
              info == _undefined || info == null
                  ? _instance.info
                  : (info as Query$SystemIsUsingBinds$system$info),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Query$SystemIsUsingBinds$system$info<TRes> get info {
    final local$info = _instance.info;
    return CopyWith$Query$SystemIsUsingBinds$system$info(
      local$info,
      (e) => call(info: e),
    );
  }
}

class _CopyWithStubImpl$Query$SystemIsUsingBinds$system<TRes>
    implements CopyWith$Query$SystemIsUsingBinds$system<TRes> {
  _CopyWithStubImpl$Query$SystemIsUsingBinds$system(this._res);

  TRes _res;

  call({Query$SystemIsUsingBinds$system$info? info, String? $__typename}) =>
      _res;

  CopyWith$Query$SystemIsUsingBinds$system$info<TRes> get info =>
      CopyWith$Query$SystemIsUsingBinds$system$info.stub(_res);
}

class Query$SystemIsUsingBinds$system$info {
  Query$SystemIsUsingBinds$system$info({
    required this.usingBinds,
    this.$__typename = 'SystemInfo',
  });

  factory Query$SystemIsUsingBinds$system$info.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$usingBinds = json['usingBinds'];
    final l$$__typename = json['__typename'];
    return Query$SystemIsUsingBinds$system$info(
      usingBinds: (l$usingBinds as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final bool usingBinds;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$usingBinds = usingBinds;
    _resultData['usingBinds'] = l$usingBinds;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$usingBinds = usingBinds;
    final l$$__typename = $__typename;
    return Object.hashAll([l$usingBinds, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$SystemIsUsingBinds$system$info ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$usingBinds = usingBinds;
    final lOther$usingBinds = other.usingBinds;
    if (l$usingBinds != lOther$usingBinds) {
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

extension UtilityExtension$Query$SystemIsUsingBinds$system$info
    on Query$SystemIsUsingBinds$system$info {
  CopyWith$Query$SystemIsUsingBinds$system$info<
    Query$SystemIsUsingBinds$system$info
  >
  get copyWith => CopyWith$Query$SystemIsUsingBinds$system$info(this, (i) => i);
}

abstract class CopyWith$Query$SystemIsUsingBinds$system$info<TRes> {
  factory CopyWith$Query$SystemIsUsingBinds$system$info(
    Query$SystemIsUsingBinds$system$info instance,
    TRes Function(Query$SystemIsUsingBinds$system$info) then,
  ) = _CopyWithImpl$Query$SystemIsUsingBinds$system$info;

  factory CopyWith$Query$SystemIsUsingBinds$system$info.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemIsUsingBinds$system$info;

  TRes call({bool? usingBinds, String? $__typename});
}

class _CopyWithImpl$Query$SystemIsUsingBinds$system$info<TRes>
    implements CopyWith$Query$SystemIsUsingBinds$system$info<TRes> {
  _CopyWithImpl$Query$SystemIsUsingBinds$system$info(
    this._instance,
    this._then,
  );

  final Query$SystemIsUsingBinds$system$info _instance;

  final TRes Function(Query$SystemIsUsingBinds$system$info) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? usingBinds = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$SystemIsUsingBinds$system$info(
      usingBinds:
          usingBinds == _undefined || usingBinds == null
              ? _instance.usingBinds
              : (usingBinds as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$SystemIsUsingBinds$system$info<TRes>
    implements CopyWith$Query$SystemIsUsingBinds$system$info<TRes> {
  _CopyWithStubImpl$Query$SystemIsUsingBinds$system$info(this._res);

  TRes _res;

  call({bool? usingBinds, String? $__typename}) => _res;
}

class Query$GetDnsRecords {
  Query$GetDnsRecords({required this.system, this.$__typename = 'Query'});

  factory Query$GetDnsRecords.fromJson(Map<String, dynamic> json) {
    final l$system = json['system'];
    final l$$__typename = json['__typename'];
    return Query$GetDnsRecords(
      system: Query$GetDnsRecords$system.fromJson(
        (l$system as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetDnsRecords$system system;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$system = system;
    _resultData['system'] = l$system.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$system = system;
    final l$$__typename = $__typename;
    return Object.hashAll([l$system, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetDnsRecords || runtimeType != other.runtimeType) {
      return false;
    }
    final l$system = system;
    final lOther$system = other.system;
    if (l$system != lOther$system) {
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

extension UtilityExtension$Query$GetDnsRecords on Query$GetDnsRecords {
  CopyWith$Query$GetDnsRecords<Query$GetDnsRecords> get copyWith =>
      CopyWith$Query$GetDnsRecords(this, (i) => i);
}

abstract class CopyWith$Query$GetDnsRecords<TRes> {
  factory CopyWith$Query$GetDnsRecords(
    Query$GetDnsRecords instance,
    TRes Function(Query$GetDnsRecords) then,
  ) = _CopyWithImpl$Query$GetDnsRecords;

  factory CopyWith$Query$GetDnsRecords.stub(TRes res) =
      _CopyWithStubImpl$Query$GetDnsRecords;

  TRes call({Query$GetDnsRecords$system? system, String? $__typename});
  CopyWith$Query$GetDnsRecords$system<TRes> get system;
}

class _CopyWithImpl$Query$GetDnsRecords<TRes>
    implements CopyWith$Query$GetDnsRecords<TRes> {
  _CopyWithImpl$Query$GetDnsRecords(this._instance, this._then);

  final Query$GetDnsRecords _instance;

  final TRes Function(Query$GetDnsRecords) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? system = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$GetDnsRecords(
          system:
              system == _undefined || system == null
                  ? _instance.system
                  : (system as Query$GetDnsRecords$system),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Query$GetDnsRecords$system<TRes> get system {
    final local$system = _instance.system;
    return CopyWith$Query$GetDnsRecords$system(
      local$system,
      (e) => call(system: e),
    );
  }
}

class _CopyWithStubImpl$Query$GetDnsRecords<TRes>
    implements CopyWith$Query$GetDnsRecords<TRes> {
  _CopyWithStubImpl$Query$GetDnsRecords(this._res);

  TRes _res;

  call({Query$GetDnsRecords$system? system, String? $__typename}) => _res;

  CopyWith$Query$GetDnsRecords$system<TRes> get system =>
      CopyWith$Query$GetDnsRecords$system.stub(_res);
}

const documentNodeQueryGetDnsRecords = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetDnsRecords'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'system'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'domainInfo'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'domain'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'hostname'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'provider'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'requiredDnsRecords'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'fragmentDnsRecords'),
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
    fragmentDefinitionfragmentDnsRecords,
  ],
);
Query$GetDnsRecords _parserFn$Query$GetDnsRecords(Map<String, dynamic> data) =>
    Query$GetDnsRecords.fromJson(data);
typedef OnQueryComplete$Query$GetDnsRecords =
    FutureOr<void> Function(Map<String, dynamic>?, Query$GetDnsRecords?);

class Options$Query$GetDnsRecords
    extends graphql.QueryOptions<Query$GetDnsRecords> {
  Options$Query$GetDnsRecords({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetDnsRecords? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetDnsRecords? onComplete,
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
                   data == null ? null : _parserFn$Query$GetDnsRecords(data),
                 ),
         onError: onError,
         document: documentNodeQueryGetDnsRecords,
         parserFn: _parserFn$Query$GetDnsRecords,
       );

  final OnQueryComplete$Query$GetDnsRecords? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$GetDnsRecords
    extends graphql.WatchQueryOptions<Query$GetDnsRecords> {
  WatchOptions$Query$GetDnsRecords({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetDnsRecords? typedOptimisticResult,
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
         document: documentNodeQueryGetDnsRecords,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$GetDnsRecords,
       );
}

class FetchMoreOptions$Query$GetDnsRecords extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetDnsRecords({
    required graphql.UpdateQuery updateQuery,
  }) : super(
         updateQuery: updateQuery,
         document: documentNodeQueryGetDnsRecords,
       );
}

extension ClientExtension$Query$GetDnsRecords on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetDnsRecords>> query$GetDnsRecords([
    Options$Query$GetDnsRecords? options,
  ]) async => await this.query(options ?? Options$Query$GetDnsRecords());
  graphql.ObservableQuery<Query$GetDnsRecords> watchQuery$GetDnsRecords([
    WatchOptions$Query$GetDnsRecords? options,
  ]) => this.watchQuery(options ?? WatchOptions$Query$GetDnsRecords());
  void writeQuery$GetDnsRecords({
    required Query$GetDnsRecords data,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryGetDnsRecords),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Query$GetDnsRecords? readQuery$GetDnsRecords({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryGetDnsRecords),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetDnsRecords.fromJson(result);
  }
}

class Query$GetDnsRecords$system {
  Query$GetDnsRecords$system({
    required this.domainInfo,
    this.$__typename = 'System',
  });

  factory Query$GetDnsRecords$system.fromJson(Map<String, dynamic> json) {
    final l$domainInfo = json['domainInfo'];
    final l$$__typename = json['__typename'];
    return Query$GetDnsRecords$system(
      domainInfo: Query$GetDnsRecords$system$domainInfo.fromJson(
        (l$domainInfo as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetDnsRecords$system$domainInfo domainInfo;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$domainInfo = domainInfo;
    _resultData['domainInfo'] = l$domainInfo.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$domainInfo = domainInfo;
    final l$$__typename = $__typename;
    return Object.hashAll([l$domainInfo, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetDnsRecords$system ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$domainInfo = domainInfo;
    final lOther$domainInfo = other.domainInfo;
    if (l$domainInfo != lOther$domainInfo) {
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

extension UtilityExtension$Query$GetDnsRecords$system
    on Query$GetDnsRecords$system {
  CopyWith$Query$GetDnsRecords$system<Query$GetDnsRecords$system>
  get copyWith => CopyWith$Query$GetDnsRecords$system(this, (i) => i);
}

abstract class CopyWith$Query$GetDnsRecords$system<TRes> {
  factory CopyWith$Query$GetDnsRecords$system(
    Query$GetDnsRecords$system instance,
    TRes Function(Query$GetDnsRecords$system) then,
  ) = _CopyWithImpl$Query$GetDnsRecords$system;

  factory CopyWith$Query$GetDnsRecords$system.stub(TRes res) =
      _CopyWithStubImpl$Query$GetDnsRecords$system;

  TRes call({
    Query$GetDnsRecords$system$domainInfo? domainInfo,
    String? $__typename,
  });
  CopyWith$Query$GetDnsRecords$system$domainInfo<TRes> get domainInfo;
}

class _CopyWithImpl$Query$GetDnsRecords$system<TRes>
    implements CopyWith$Query$GetDnsRecords$system<TRes> {
  _CopyWithImpl$Query$GetDnsRecords$system(this._instance, this._then);

  final Query$GetDnsRecords$system _instance;

  final TRes Function(Query$GetDnsRecords$system) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? domainInfo = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetDnsRecords$system(
      domainInfo:
          domainInfo == _undefined || domainInfo == null
              ? _instance.domainInfo
              : (domainInfo as Query$GetDnsRecords$system$domainInfo),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$GetDnsRecords$system$domainInfo<TRes> get domainInfo {
    final local$domainInfo = _instance.domainInfo;
    return CopyWith$Query$GetDnsRecords$system$domainInfo(
      local$domainInfo,
      (e) => call(domainInfo: e),
    );
  }
}

class _CopyWithStubImpl$Query$GetDnsRecords$system<TRes>
    implements CopyWith$Query$GetDnsRecords$system<TRes> {
  _CopyWithStubImpl$Query$GetDnsRecords$system(this._res);

  TRes _res;

  call({
    Query$GetDnsRecords$system$domainInfo? domainInfo,
    String? $__typename,
  }) => _res;

  CopyWith$Query$GetDnsRecords$system$domainInfo<TRes> get domainInfo =>
      CopyWith$Query$GetDnsRecords$system$domainInfo.stub(_res);
}

class Query$GetDnsRecords$system$domainInfo {
  Query$GetDnsRecords$system$domainInfo({
    required this.domain,
    required this.hostname,
    required this.provider,
    required this.requiredDnsRecords,
    this.$__typename = 'SystemDomainInfo',
  });

  factory Query$GetDnsRecords$system$domainInfo.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$domain = json['domain'];
    final l$hostname = json['hostname'];
    final l$provider = json['provider'];
    final l$requiredDnsRecords = json['requiredDnsRecords'];
    final l$$__typename = json['__typename'];
    return Query$GetDnsRecords$system$domainInfo(
      domain: (l$domain as String),
      hostname: (l$hostname as String),
      provider: fromJson$Enum$DnsProvider((l$provider as String)),
      requiredDnsRecords:
          (l$requiredDnsRecords as List<dynamic>)
              .map(
                (e) => Fragment$fragmentDnsRecords.fromJson(
                  (e as Map<String, dynamic>),
                ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String domain;

  final String hostname;

  final Enum$DnsProvider provider;

  final List<Fragment$fragmentDnsRecords> requiredDnsRecords;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$domain = domain;
    _resultData['domain'] = l$domain;
    final l$hostname = hostname;
    _resultData['hostname'] = l$hostname;
    final l$provider = provider;
    _resultData['provider'] = toJson$Enum$DnsProvider(l$provider);
    final l$requiredDnsRecords = requiredDnsRecords;
    _resultData['requiredDnsRecords'] =
        l$requiredDnsRecords.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$domain = domain;
    final l$hostname = hostname;
    final l$provider = provider;
    final l$requiredDnsRecords = requiredDnsRecords;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$domain,
      l$hostname,
      l$provider,
      Object.hashAll(l$requiredDnsRecords.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetDnsRecords$system$domainInfo ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$domain = domain;
    final lOther$domain = other.domain;
    if (l$domain != lOther$domain) {
      return false;
    }
    final l$hostname = hostname;
    final lOther$hostname = other.hostname;
    if (l$hostname != lOther$hostname) {
      return false;
    }
    final l$provider = provider;
    final lOther$provider = other.provider;
    if (l$provider != lOther$provider) {
      return false;
    }
    final l$requiredDnsRecords = requiredDnsRecords;
    final lOther$requiredDnsRecords = other.requiredDnsRecords;
    if (l$requiredDnsRecords.length != lOther$requiredDnsRecords.length) {
      return false;
    }
    for (int i = 0; i < l$requiredDnsRecords.length; i++) {
      final l$requiredDnsRecords$entry = l$requiredDnsRecords[i];
      final lOther$requiredDnsRecords$entry = lOther$requiredDnsRecords[i];
      if (l$requiredDnsRecords$entry != lOther$requiredDnsRecords$entry) {
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

extension UtilityExtension$Query$GetDnsRecords$system$domainInfo
    on Query$GetDnsRecords$system$domainInfo {
  CopyWith$Query$GetDnsRecords$system$domainInfo<
    Query$GetDnsRecords$system$domainInfo
  >
  get copyWith =>
      CopyWith$Query$GetDnsRecords$system$domainInfo(this, (i) => i);
}

abstract class CopyWith$Query$GetDnsRecords$system$domainInfo<TRes> {
  factory CopyWith$Query$GetDnsRecords$system$domainInfo(
    Query$GetDnsRecords$system$domainInfo instance,
    TRes Function(Query$GetDnsRecords$system$domainInfo) then,
  ) = _CopyWithImpl$Query$GetDnsRecords$system$domainInfo;

  factory CopyWith$Query$GetDnsRecords$system$domainInfo.stub(TRes res) =
      _CopyWithStubImpl$Query$GetDnsRecords$system$domainInfo;

  TRes call({
    String? domain,
    String? hostname,
    Enum$DnsProvider? provider,
    List<Fragment$fragmentDnsRecords>? requiredDnsRecords,
    String? $__typename,
  });
  TRes requiredDnsRecords(
    Iterable<Fragment$fragmentDnsRecords> Function(
      Iterable<
        CopyWith$Fragment$fragmentDnsRecords<Fragment$fragmentDnsRecords>
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetDnsRecords$system$domainInfo<TRes>
    implements CopyWith$Query$GetDnsRecords$system$domainInfo<TRes> {
  _CopyWithImpl$Query$GetDnsRecords$system$domainInfo(
    this._instance,
    this._then,
  );

  final Query$GetDnsRecords$system$domainInfo _instance;

  final TRes Function(Query$GetDnsRecords$system$domainInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? domain = _undefined,
    Object? hostname = _undefined,
    Object? provider = _undefined,
    Object? requiredDnsRecords = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetDnsRecords$system$domainInfo(
      domain:
          domain == _undefined || domain == null
              ? _instance.domain
              : (domain as String),
      hostname:
          hostname == _undefined || hostname == null
              ? _instance.hostname
              : (hostname as String),
      provider:
          provider == _undefined || provider == null
              ? _instance.provider
              : (provider as Enum$DnsProvider),
      requiredDnsRecords:
          requiredDnsRecords == _undefined || requiredDnsRecords == null
              ? _instance.requiredDnsRecords
              : (requiredDnsRecords as List<Fragment$fragmentDnsRecords>),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes requiredDnsRecords(
    Iterable<Fragment$fragmentDnsRecords> Function(
      Iterable<
        CopyWith$Fragment$fragmentDnsRecords<Fragment$fragmentDnsRecords>
      >,
    )
    _fn,
  ) => call(
    requiredDnsRecords:
        _fn(
          _instance.requiredDnsRecords.map(
            (e) => CopyWith$Fragment$fragmentDnsRecords(e, (i) => i),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetDnsRecords$system$domainInfo<TRes>
    implements CopyWith$Query$GetDnsRecords$system$domainInfo<TRes> {
  _CopyWithStubImpl$Query$GetDnsRecords$system$domainInfo(this._res);

  TRes _res;

  call({
    String? domain,
    String? hostname,
    Enum$DnsProvider? provider,
    List<Fragment$fragmentDnsRecords>? requiredDnsRecords,
    String? $__typename,
  }) => _res;

  requiredDnsRecords(_fn) => _res;
}

class Variables$Mutation$ChangeTimezone {
  factory Variables$Mutation$ChangeTimezone({required String timezone}) =>
      Variables$Mutation$ChangeTimezone._({r'timezone': timezone});

  Variables$Mutation$ChangeTimezone._(this._$data);

  factory Variables$Mutation$ChangeTimezone.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$timezone = data['timezone'];
    result$data['timezone'] = (l$timezone as String);
    return Variables$Mutation$ChangeTimezone._(result$data);
  }

  Map<String, dynamic> _$data;

  String get timezone => (_$data['timezone'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$timezone = timezone;
    result$data['timezone'] = l$timezone;
    return result$data;
  }

  CopyWith$Variables$Mutation$ChangeTimezone<Variables$Mutation$ChangeTimezone>
  get copyWith => CopyWith$Variables$Mutation$ChangeTimezone(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$ChangeTimezone ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$timezone = timezone;
    final lOther$timezone = other.timezone;
    if (l$timezone != lOther$timezone) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$timezone = timezone;
    return Object.hashAll([l$timezone]);
  }
}

abstract class CopyWith$Variables$Mutation$ChangeTimezone<TRes> {
  factory CopyWith$Variables$Mutation$ChangeTimezone(
    Variables$Mutation$ChangeTimezone instance,
    TRes Function(Variables$Mutation$ChangeTimezone) then,
  ) = _CopyWithImpl$Variables$Mutation$ChangeTimezone;

  factory CopyWith$Variables$Mutation$ChangeTimezone.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ChangeTimezone;

  TRes call({String? timezone});
}

class _CopyWithImpl$Variables$Mutation$ChangeTimezone<TRes>
    implements CopyWith$Variables$Mutation$ChangeTimezone<TRes> {
  _CopyWithImpl$Variables$Mutation$ChangeTimezone(this._instance, this._then);

  final Variables$Mutation$ChangeTimezone _instance;

  final TRes Function(Variables$Mutation$ChangeTimezone) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? timezone = _undefined}) => _then(
    Variables$Mutation$ChangeTimezone._({
      ..._instance._$data,
      if (timezone != _undefined && timezone != null)
        'timezone': (timezone as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$ChangeTimezone<TRes>
    implements CopyWith$Variables$Mutation$ChangeTimezone<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ChangeTimezone(this._res);

  TRes _res;

  call({String? timezone}) => _res;
}

class Mutation$ChangeTimezone {
  Mutation$ChangeTimezone({
    required this.system,
    this.$__typename = 'Mutation',
  });

  factory Mutation$ChangeTimezone.fromJson(Map<String, dynamic> json) {
    final l$system = json['system'];
    final l$$__typename = json['__typename'];
    return Mutation$ChangeTimezone(
      system: Mutation$ChangeTimezone$system.fromJson(
        (l$system as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ChangeTimezone$system system;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$system = system;
    _resultData['system'] = l$system.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$system = system;
    final l$$__typename = $__typename;
    return Object.hashAll([l$system, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ChangeTimezone || runtimeType != other.runtimeType) {
      return false;
    }
    final l$system = system;
    final lOther$system = other.system;
    if (l$system != lOther$system) {
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

extension UtilityExtension$Mutation$ChangeTimezone on Mutation$ChangeTimezone {
  CopyWith$Mutation$ChangeTimezone<Mutation$ChangeTimezone> get copyWith =>
      CopyWith$Mutation$ChangeTimezone(this, (i) => i);
}

abstract class CopyWith$Mutation$ChangeTimezone<TRes> {
  factory CopyWith$Mutation$ChangeTimezone(
    Mutation$ChangeTimezone instance,
    TRes Function(Mutation$ChangeTimezone) then,
  ) = _CopyWithImpl$Mutation$ChangeTimezone;

  factory CopyWith$Mutation$ChangeTimezone.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ChangeTimezone;

  TRes call({Mutation$ChangeTimezone$system? system, String? $__typename});
  CopyWith$Mutation$ChangeTimezone$system<TRes> get system;
}

class _CopyWithImpl$Mutation$ChangeTimezone<TRes>
    implements CopyWith$Mutation$ChangeTimezone<TRes> {
  _CopyWithImpl$Mutation$ChangeTimezone(this._instance, this._then);

  final Mutation$ChangeTimezone _instance;

  final TRes Function(Mutation$ChangeTimezone) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? system = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$ChangeTimezone(
          system:
              system == _undefined || system == null
                  ? _instance.system
                  : (system as Mutation$ChangeTimezone$system),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$ChangeTimezone$system<TRes> get system {
    final local$system = _instance.system;
    return CopyWith$Mutation$ChangeTimezone$system(
      local$system,
      (e) => call(system: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$ChangeTimezone<TRes>
    implements CopyWith$Mutation$ChangeTimezone<TRes> {
  _CopyWithStubImpl$Mutation$ChangeTimezone(this._res);

  TRes _res;

  call({Mutation$ChangeTimezone$system? system, String? $__typename}) => _res;

  CopyWith$Mutation$ChangeTimezone$system<TRes> get system =>
      CopyWith$Mutation$ChangeTimezone$system.stub(_res);
}

const documentNodeMutationChangeTimezone = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ChangeTimezone'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'timezone')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'system'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'changeTimezone'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'timezone'),
                      value: VariableNode(name: NameNode(value: 'timezone')),
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
                        name: NameNode(value: 'timezone'),
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
Mutation$ChangeTimezone _parserFn$Mutation$ChangeTimezone(
  Map<String, dynamic> data,
) => Mutation$ChangeTimezone.fromJson(data);
typedef OnMutationCompleted$Mutation$ChangeTimezone =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$ChangeTimezone?);

class Options$Mutation$ChangeTimezone
    extends graphql.MutationOptions<Mutation$ChangeTimezone> {
  Options$Mutation$ChangeTimezone({
    String? operationName,
    required Variables$Mutation$ChangeTimezone variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ChangeTimezone? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$ChangeTimezone? onCompleted,
    graphql.OnMutationUpdate<Mutation$ChangeTimezone>? update,
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
                       : _parserFn$Mutation$ChangeTimezone(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationChangeTimezone,
         parserFn: _parserFn$Mutation$ChangeTimezone,
       );

  final OnMutationCompleted$Mutation$ChangeTimezone? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$ChangeTimezone
    extends graphql.WatchQueryOptions<Mutation$ChangeTimezone> {
  WatchOptions$Mutation$ChangeTimezone({
    String? operationName,
    required Variables$Mutation$ChangeTimezone variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ChangeTimezone? typedOptimisticResult,
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
         document: documentNodeMutationChangeTimezone,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$ChangeTimezone,
       );
}

extension ClientExtension$Mutation$ChangeTimezone on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ChangeTimezone>> mutate$ChangeTimezone(
    Options$Mutation$ChangeTimezone options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$ChangeTimezone> watchMutation$ChangeTimezone(
    WatchOptions$Mutation$ChangeTimezone options,
  ) => this.watchMutation(options);
}

class Mutation$ChangeTimezone$system {
  Mutation$ChangeTimezone$system({
    required this.changeTimezone,
    this.$__typename = 'SystemMutations',
  });

  factory Mutation$ChangeTimezone$system.fromJson(Map<String, dynamic> json) {
    final l$changeTimezone = json['changeTimezone'];
    final l$$__typename = json['__typename'];
    return Mutation$ChangeTimezone$system(
      changeTimezone: Mutation$ChangeTimezone$system$changeTimezone.fromJson(
        (l$changeTimezone as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ChangeTimezone$system$changeTimezone changeTimezone;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$changeTimezone = changeTimezone;
    _resultData['changeTimezone'] = l$changeTimezone.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$changeTimezone = changeTimezone;
    final l$$__typename = $__typename;
    return Object.hashAll([l$changeTimezone, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ChangeTimezone$system ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$changeTimezone = changeTimezone;
    final lOther$changeTimezone = other.changeTimezone;
    if (l$changeTimezone != lOther$changeTimezone) {
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

extension UtilityExtension$Mutation$ChangeTimezone$system
    on Mutation$ChangeTimezone$system {
  CopyWith$Mutation$ChangeTimezone$system<Mutation$ChangeTimezone$system>
  get copyWith => CopyWith$Mutation$ChangeTimezone$system(this, (i) => i);
}

abstract class CopyWith$Mutation$ChangeTimezone$system<TRes> {
  factory CopyWith$Mutation$ChangeTimezone$system(
    Mutation$ChangeTimezone$system instance,
    TRes Function(Mutation$ChangeTimezone$system) then,
  ) = _CopyWithImpl$Mutation$ChangeTimezone$system;

  factory CopyWith$Mutation$ChangeTimezone$system.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ChangeTimezone$system;

  TRes call({
    Mutation$ChangeTimezone$system$changeTimezone? changeTimezone,
    String? $__typename,
  });
  CopyWith$Mutation$ChangeTimezone$system$changeTimezone<TRes>
  get changeTimezone;
}

class _CopyWithImpl$Mutation$ChangeTimezone$system<TRes>
    implements CopyWith$Mutation$ChangeTimezone$system<TRes> {
  _CopyWithImpl$Mutation$ChangeTimezone$system(this._instance, this._then);

  final Mutation$ChangeTimezone$system _instance;

  final TRes Function(Mutation$ChangeTimezone$system) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? changeTimezone = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$ChangeTimezone$system(
      changeTimezone:
          changeTimezone == _undefined || changeTimezone == null
              ? _instance.changeTimezone
              : (changeTimezone
                  as Mutation$ChangeTimezone$system$changeTimezone),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$ChangeTimezone$system$changeTimezone<TRes>
  get changeTimezone {
    final local$changeTimezone = _instance.changeTimezone;
    return CopyWith$Mutation$ChangeTimezone$system$changeTimezone(
      local$changeTimezone,
      (e) => call(changeTimezone: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$ChangeTimezone$system<TRes>
    implements CopyWith$Mutation$ChangeTimezone$system<TRes> {
  _CopyWithStubImpl$Mutation$ChangeTimezone$system(this._res);

  TRes _res;

  call({
    Mutation$ChangeTimezone$system$changeTimezone? changeTimezone,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$ChangeTimezone$system$changeTimezone<TRes>
  get changeTimezone =>
      CopyWith$Mutation$ChangeTimezone$system$changeTimezone.stub(_res);
}

class Mutation$ChangeTimezone$system$changeTimezone
    implements Fragment$basicMutationReturnFields$$TimezoneMutationReturn {
  Mutation$ChangeTimezone$system$changeTimezone({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'TimezoneMutationReturn',
    this.timezone,
  });

  factory Mutation$ChangeTimezone$system$changeTimezone.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$timezone = json['timezone'];
    return Mutation$ChangeTimezone$system$changeTimezone(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      timezone: (l$timezone as String?),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final String? timezone;

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
    final l$timezone = timezone;
    _resultData['timezone'] = l$timezone;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$timezone = timezone;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$timezone,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ChangeTimezone$system$changeTimezone ||
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
    final l$timezone = timezone;
    final lOther$timezone = other.timezone;
    if (l$timezone != lOther$timezone) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$ChangeTimezone$system$changeTimezone
    on Mutation$ChangeTimezone$system$changeTimezone {
  CopyWith$Mutation$ChangeTimezone$system$changeTimezone<
    Mutation$ChangeTimezone$system$changeTimezone
  >
  get copyWith =>
      CopyWith$Mutation$ChangeTimezone$system$changeTimezone(this, (i) => i);
}

abstract class CopyWith$Mutation$ChangeTimezone$system$changeTimezone<TRes> {
  factory CopyWith$Mutation$ChangeTimezone$system$changeTimezone(
    Mutation$ChangeTimezone$system$changeTimezone instance,
    TRes Function(Mutation$ChangeTimezone$system$changeTimezone) then,
  ) = _CopyWithImpl$Mutation$ChangeTimezone$system$changeTimezone;

  factory CopyWith$Mutation$ChangeTimezone$system$changeTimezone.stub(
    TRes res,
  ) = _CopyWithStubImpl$Mutation$ChangeTimezone$system$changeTimezone;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? timezone,
  });
}

class _CopyWithImpl$Mutation$ChangeTimezone$system$changeTimezone<TRes>
    implements CopyWith$Mutation$ChangeTimezone$system$changeTimezone<TRes> {
  _CopyWithImpl$Mutation$ChangeTimezone$system$changeTimezone(
    this._instance,
    this._then,
  );

  final Mutation$ChangeTimezone$system$changeTimezone _instance;

  final TRes Function(Mutation$ChangeTimezone$system$changeTimezone) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? timezone = _undefined,
  }) => _then(
    Mutation$ChangeTimezone$system$changeTimezone(
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
      timezone:
          timezone == _undefined ? _instance.timezone : (timezone as String?),
    ),
  );
}

class _CopyWithStubImpl$Mutation$ChangeTimezone$system$changeTimezone<TRes>
    implements CopyWith$Mutation$ChangeTimezone$system$changeTimezone<TRes> {
  _CopyWithStubImpl$Mutation$ChangeTimezone$system$changeTimezone(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? timezone,
  }) => _res;
}

class Variables$Mutation$ChangeAutoUpgradeSettings {
  factory Variables$Mutation$ChangeAutoUpgradeSettings({
    required Input$AutoUpgradeSettingsInput settings,
  }) => Variables$Mutation$ChangeAutoUpgradeSettings._({r'settings': settings});

  Variables$Mutation$ChangeAutoUpgradeSettings._(this._$data);

  factory Variables$Mutation$ChangeAutoUpgradeSettings.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$settings = data['settings'];
    result$data['settings'] = Input$AutoUpgradeSettingsInput.fromJson(
      (l$settings as Map<String, dynamic>),
    );
    return Variables$Mutation$ChangeAutoUpgradeSettings._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$AutoUpgradeSettingsInput get settings =>
      (_$data['settings'] as Input$AutoUpgradeSettingsInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$settings = settings;
    result$data['settings'] = l$settings.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings<
    Variables$Mutation$ChangeAutoUpgradeSettings
  >
  get copyWith =>
      CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$ChangeAutoUpgradeSettings ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$settings = settings;
    final lOther$settings = other.settings;
    if (l$settings != lOther$settings) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$settings = settings;
    return Object.hashAll([l$settings]);
  }
}

abstract class CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings<TRes> {
  factory CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings(
    Variables$Mutation$ChangeAutoUpgradeSettings instance,
    TRes Function(Variables$Mutation$ChangeAutoUpgradeSettings) then,
  ) = _CopyWithImpl$Variables$Mutation$ChangeAutoUpgradeSettings;

  factory CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ChangeAutoUpgradeSettings;

  TRes call({Input$AutoUpgradeSettingsInput? settings});
}

class _CopyWithImpl$Variables$Mutation$ChangeAutoUpgradeSettings<TRes>
    implements CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings<TRes> {
  _CopyWithImpl$Variables$Mutation$ChangeAutoUpgradeSettings(
    this._instance,
    this._then,
  );

  final Variables$Mutation$ChangeAutoUpgradeSettings _instance;

  final TRes Function(Variables$Mutation$ChangeAutoUpgradeSettings) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? settings = _undefined}) => _then(
    Variables$Mutation$ChangeAutoUpgradeSettings._({
      ..._instance._$data,
      if (settings != _undefined && settings != null)
        'settings': (settings as Input$AutoUpgradeSettingsInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$ChangeAutoUpgradeSettings<TRes>
    implements CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ChangeAutoUpgradeSettings(this._res);

  TRes _res;

  call({Input$AutoUpgradeSettingsInput? settings}) => _res;
}

class Mutation$ChangeAutoUpgradeSettings {
  Mutation$ChangeAutoUpgradeSettings({
    required this.system,
    this.$__typename = 'Mutation',
  });

  factory Mutation$ChangeAutoUpgradeSettings.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$system = json['system'];
    final l$$__typename = json['__typename'];
    return Mutation$ChangeAutoUpgradeSettings(
      system: Mutation$ChangeAutoUpgradeSettings$system.fromJson(
        (l$system as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ChangeAutoUpgradeSettings$system system;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$system = system;
    _resultData['system'] = l$system.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$system = system;
    final l$$__typename = $__typename;
    return Object.hashAll([l$system, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ChangeAutoUpgradeSettings ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$system = system;
    final lOther$system = other.system;
    if (l$system != lOther$system) {
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

extension UtilityExtension$Mutation$ChangeAutoUpgradeSettings
    on Mutation$ChangeAutoUpgradeSettings {
  CopyWith$Mutation$ChangeAutoUpgradeSettings<
    Mutation$ChangeAutoUpgradeSettings
  >
  get copyWith => CopyWith$Mutation$ChangeAutoUpgradeSettings(this, (i) => i);
}

abstract class CopyWith$Mutation$ChangeAutoUpgradeSettings<TRes> {
  factory CopyWith$Mutation$ChangeAutoUpgradeSettings(
    Mutation$ChangeAutoUpgradeSettings instance,
    TRes Function(Mutation$ChangeAutoUpgradeSettings) then,
  ) = _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings;

  factory CopyWith$Mutation$ChangeAutoUpgradeSettings.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings;

  TRes call({
    Mutation$ChangeAutoUpgradeSettings$system? system,
    String? $__typename,
  });
  CopyWith$Mutation$ChangeAutoUpgradeSettings$system<TRes> get system;
}

class _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings<TRes>
    implements CopyWith$Mutation$ChangeAutoUpgradeSettings<TRes> {
  _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings(this._instance, this._then);

  final Mutation$ChangeAutoUpgradeSettings _instance;

  final TRes Function(Mutation$ChangeAutoUpgradeSettings) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? system = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$ChangeAutoUpgradeSettings(
          system:
              system == _undefined || system == null
                  ? _instance.system
                  : (system as Mutation$ChangeAutoUpgradeSettings$system),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$ChangeAutoUpgradeSettings$system<TRes> get system {
    final local$system = _instance.system;
    return CopyWith$Mutation$ChangeAutoUpgradeSettings$system(
      local$system,
      (e) => call(system: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings<TRes>
    implements CopyWith$Mutation$ChangeAutoUpgradeSettings<TRes> {
  _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings(this._res);

  TRes _res;

  call({
    Mutation$ChangeAutoUpgradeSettings$system? system,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$ChangeAutoUpgradeSettings$system<TRes> get system =>
      CopyWith$Mutation$ChangeAutoUpgradeSettings$system.stub(_res);
}

const documentNodeMutationChangeAutoUpgradeSettings = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ChangeAutoUpgradeSettings'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'settings')),
          type: NamedTypeNode(
            name: NameNode(value: 'AutoUpgradeSettingsInput'),
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
            name: NameNode(value: 'system'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'changeAutoUpgradeSettings'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'settings'),
                      value: VariableNode(name: NameNode(value: 'settings')),
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
                        name: NameNode(value: 'allowReboot'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'enableAutoUpgrade'),
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
Mutation$ChangeAutoUpgradeSettings _parserFn$Mutation$ChangeAutoUpgradeSettings(
  Map<String, dynamic> data,
) => Mutation$ChangeAutoUpgradeSettings.fromJson(data);
typedef OnMutationCompleted$Mutation$ChangeAutoUpgradeSettings =
    FutureOr<void> Function(
      Map<String, dynamic>?,
      Mutation$ChangeAutoUpgradeSettings?,
    );

class Options$Mutation$ChangeAutoUpgradeSettings
    extends graphql.MutationOptions<Mutation$ChangeAutoUpgradeSettings> {
  Options$Mutation$ChangeAutoUpgradeSettings({
    String? operationName,
    required Variables$Mutation$ChangeAutoUpgradeSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ChangeAutoUpgradeSettings? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$ChangeAutoUpgradeSettings? onCompleted,
    graphql.OnMutationUpdate<Mutation$ChangeAutoUpgradeSettings>? update,
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
                       : _parserFn$Mutation$ChangeAutoUpgradeSettings(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationChangeAutoUpgradeSettings,
         parserFn: _parserFn$Mutation$ChangeAutoUpgradeSettings,
       );

  final OnMutationCompleted$Mutation$ChangeAutoUpgradeSettings?
  onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$ChangeAutoUpgradeSettings
    extends graphql.WatchQueryOptions<Mutation$ChangeAutoUpgradeSettings> {
  WatchOptions$Mutation$ChangeAutoUpgradeSettings({
    String? operationName,
    required Variables$Mutation$ChangeAutoUpgradeSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ChangeAutoUpgradeSettings? typedOptimisticResult,
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
         document: documentNodeMutationChangeAutoUpgradeSettings,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$ChangeAutoUpgradeSettings,
       );
}

extension ClientExtension$Mutation$ChangeAutoUpgradeSettings
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ChangeAutoUpgradeSettings>>
  mutate$ChangeAutoUpgradeSettings(
    Options$Mutation$ChangeAutoUpgradeSettings options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$ChangeAutoUpgradeSettings>
  watchMutation$ChangeAutoUpgradeSettings(
    WatchOptions$Mutation$ChangeAutoUpgradeSettings options,
  ) => this.watchMutation(options);
}

class Mutation$ChangeAutoUpgradeSettings$system {
  Mutation$ChangeAutoUpgradeSettings$system({
    required this.changeAutoUpgradeSettings,
    this.$__typename = 'SystemMutations',
  });

  factory Mutation$ChangeAutoUpgradeSettings$system.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$changeAutoUpgradeSettings = json['changeAutoUpgradeSettings'];
    final l$$__typename = json['__typename'];
    return Mutation$ChangeAutoUpgradeSettings$system(
      changeAutoUpgradeSettings:
          Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings.fromJson(
            (l$changeAutoUpgradeSettings as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings
  changeAutoUpgradeSettings;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$changeAutoUpgradeSettings = changeAutoUpgradeSettings;
    _resultData['changeAutoUpgradeSettings'] =
        l$changeAutoUpgradeSettings.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$changeAutoUpgradeSettings = changeAutoUpgradeSettings;
    final l$$__typename = $__typename;
    return Object.hashAll([l$changeAutoUpgradeSettings, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ChangeAutoUpgradeSettings$system ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$changeAutoUpgradeSettings = changeAutoUpgradeSettings;
    final lOther$changeAutoUpgradeSettings = other.changeAutoUpgradeSettings;
    if (l$changeAutoUpgradeSettings != lOther$changeAutoUpgradeSettings) {
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

extension UtilityExtension$Mutation$ChangeAutoUpgradeSettings$system
    on Mutation$ChangeAutoUpgradeSettings$system {
  CopyWith$Mutation$ChangeAutoUpgradeSettings$system<
    Mutation$ChangeAutoUpgradeSettings$system
  >
  get copyWith =>
      CopyWith$Mutation$ChangeAutoUpgradeSettings$system(this, (i) => i);
}

abstract class CopyWith$Mutation$ChangeAutoUpgradeSettings$system<TRes> {
  factory CopyWith$Mutation$ChangeAutoUpgradeSettings$system(
    Mutation$ChangeAutoUpgradeSettings$system instance,
    TRes Function(Mutation$ChangeAutoUpgradeSettings$system) then,
  ) = _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings$system;

  factory CopyWith$Mutation$ChangeAutoUpgradeSettings$system.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings$system;

  TRes call({
    Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings?
    changeAutoUpgradeSettings,
    String? $__typename,
  });
  CopyWith$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings<
    TRes
  >
  get changeAutoUpgradeSettings;
}

class _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings$system<TRes>
    implements CopyWith$Mutation$ChangeAutoUpgradeSettings$system<TRes> {
  _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings$system(
    this._instance,
    this._then,
  );

  final Mutation$ChangeAutoUpgradeSettings$system _instance;

  final TRes Function(Mutation$ChangeAutoUpgradeSettings$system) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? changeAutoUpgradeSettings = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$ChangeAutoUpgradeSettings$system(
      changeAutoUpgradeSettings:
          changeAutoUpgradeSettings == _undefined ||
                  changeAutoUpgradeSettings == null
              ? _instance.changeAutoUpgradeSettings
              : (changeAutoUpgradeSettings
                  as Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings<
    TRes
  >
  get changeAutoUpgradeSettings {
    final local$changeAutoUpgradeSettings = _instance.changeAutoUpgradeSettings;
    return CopyWith$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings(
      local$changeAutoUpgradeSettings,
      (e) => call(changeAutoUpgradeSettings: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings$system<TRes>
    implements CopyWith$Mutation$ChangeAutoUpgradeSettings$system<TRes> {
  _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings$system(this._res);

  TRes _res;

  call({
    Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings?
    changeAutoUpgradeSettings,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings<
    TRes
  >
  get changeAutoUpgradeSettings =>
      CopyWith$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings.stub(
        _res,
      );
}

class Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings
    implements
        Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn {
  Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'AutoUpgradeSettingsMutationReturn',
    required this.allowReboot,
    required this.enableAutoUpgrade,
  });

  factory Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$allowReboot = json['allowReboot'];
    final l$enableAutoUpgrade = json['enableAutoUpgrade'];
    return Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      allowReboot: (l$allowReboot as bool),
      enableAutoUpgrade: (l$enableAutoUpgrade as bool),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final bool allowReboot;

  final bool enableAutoUpgrade;

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
    final l$allowReboot = allowReboot;
    _resultData['allowReboot'] = l$allowReboot;
    final l$enableAutoUpgrade = enableAutoUpgrade;
    _resultData['enableAutoUpgrade'] = l$enableAutoUpgrade;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$allowReboot = allowReboot;
    final l$enableAutoUpgrade = enableAutoUpgrade;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$allowReboot,
      l$enableAutoUpgrade,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings ||
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
    final l$allowReboot = allowReboot;
    final lOther$allowReboot = other.allowReboot;
    if (l$allowReboot != lOther$allowReboot) {
      return false;
    }
    final l$enableAutoUpgrade = enableAutoUpgrade;
    final lOther$enableAutoUpgrade = other.enableAutoUpgrade;
    if (l$enableAutoUpgrade != lOther$enableAutoUpgrade) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings
    on Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings {
  CopyWith$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings<
    Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings
  >
  get copyWith =>
      CopyWith$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings<
  TRes
> {
  factory CopyWith$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings(
    Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings
    instance,
    TRes Function(
      Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings,
    )
    then,
  ) =
      _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings;

  factory CopyWith$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    bool? allowReboot,
    bool? enableAutoUpgrade,
  });
}

class _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings<
  TRes
>
    implements
        CopyWith$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings<
          TRes
        > {
  _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings(
    this._instance,
    this._then,
  );

  final Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings
  _instance;

  final TRes Function(
    Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? allowReboot = _undefined,
    Object? enableAutoUpgrade = _undefined,
  }) => _then(
    Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings(
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
      allowReboot:
          allowReboot == _undefined || allowReboot == null
              ? _instance.allowReboot
              : (allowReboot as bool),
      enableAutoUpgrade:
          enableAutoUpgrade == _undefined || enableAutoUpgrade == null
              ? _instance.enableAutoUpgrade
              : (enableAutoUpgrade as bool),
    ),
  );
}

class _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings<
  TRes
>
    implements
        CopyWith$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings<
          TRes
        > {
  _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings$system$changeAutoUpgradeSettings(
    this._res,
  );

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    bool? allowReboot,
    bool? enableAutoUpgrade,
  }) => _res;
}

class Variables$Mutation$ChangeSshSettings {
  factory Variables$Mutation$ChangeSshSettings({
    required Input$SSHSettingsInput settings,
  }) => Variables$Mutation$ChangeSshSettings._({r'settings': settings});

  Variables$Mutation$ChangeSshSettings._(this._$data);

  factory Variables$Mutation$ChangeSshSettings.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$settings = data['settings'];
    result$data['settings'] = Input$SSHSettingsInput.fromJson(
      (l$settings as Map<String, dynamic>),
    );
    return Variables$Mutation$ChangeSshSettings._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$SSHSettingsInput get settings =>
      (_$data['settings'] as Input$SSHSettingsInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$settings = settings;
    result$data['settings'] = l$settings.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$ChangeSshSettings<
    Variables$Mutation$ChangeSshSettings
  >
  get copyWith => CopyWith$Variables$Mutation$ChangeSshSettings(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$ChangeSshSettings ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$settings = settings;
    final lOther$settings = other.settings;
    if (l$settings != lOther$settings) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$settings = settings;
    return Object.hashAll([l$settings]);
  }
}

abstract class CopyWith$Variables$Mutation$ChangeSshSettings<TRes> {
  factory CopyWith$Variables$Mutation$ChangeSshSettings(
    Variables$Mutation$ChangeSshSettings instance,
    TRes Function(Variables$Mutation$ChangeSshSettings) then,
  ) = _CopyWithImpl$Variables$Mutation$ChangeSshSettings;

  factory CopyWith$Variables$Mutation$ChangeSshSettings.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ChangeSshSettings;

  TRes call({Input$SSHSettingsInput? settings});
}

class _CopyWithImpl$Variables$Mutation$ChangeSshSettings<TRes>
    implements CopyWith$Variables$Mutation$ChangeSshSettings<TRes> {
  _CopyWithImpl$Variables$Mutation$ChangeSshSettings(
    this._instance,
    this._then,
  );

  final Variables$Mutation$ChangeSshSettings _instance;

  final TRes Function(Variables$Mutation$ChangeSshSettings) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? settings = _undefined}) => _then(
    Variables$Mutation$ChangeSshSettings._({
      ..._instance._$data,
      if (settings != _undefined && settings != null)
        'settings': (settings as Input$SSHSettingsInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$ChangeSshSettings<TRes>
    implements CopyWith$Variables$Mutation$ChangeSshSettings<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ChangeSshSettings(this._res);

  TRes _res;

  call({Input$SSHSettingsInput? settings}) => _res;
}

class Mutation$ChangeSshSettings {
  Mutation$ChangeSshSettings({
    required this.system,
    this.$__typename = 'Mutation',
  });

  factory Mutation$ChangeSshSettings.fromJson(Map<String, dynamic> json) {
    final l$system = json['system'];
    final l$$__typename = json['__typename'];
    return Mutation$ChangeSshSettings(
      system: Mutation$ChangeSshSettings$system.fromJson(
        (l$system as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ChangeSshSettings$system system;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$system = system;
    _resultData['system'] = l$system.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$system = system;
    final l$$__typename = $__typename;
    return Object.hashAll([l$system, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ChangeSshSettings ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$system = system;
    final lOther$system = other.system;
    if (l$system != lOther$system) {
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

extension UtilityExtension$Mutation$ChangeSshSettings
    on Mutation$ChangeSshSettings {
  CopyWith$Mutation$ChangeSshSettings<Mutation$ChangeSshSettings>
  get copyWith => CopyWith$Mutation$ChangeSshSettings(this, (i) => i);
}

abstract class CopyWith$Mutation$ChangeSshSettings<TRes> {
  factory CopyWith$Mutation$ChangeSshSettings(
    Mutation$ChangeSshSettings instance,
    TRes Function(Mutation$ChangeSshSettings) then,
  ) = _CopyWithImpl$Mutation$ChangeSshSettings;

  factory CopyWith$Mutation$ChangeSshSettings.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ChangeSshSettings;

  TRes call({Mutation$ChangeSshSettings$system? system, String? $__typename});
  CopyWith$Mutation$ChangeSshSettings$system<TRes> get system;
}

class _CopyWithImpl$Mutation$ChangeSshSettings<TRes>
    implements CopyWith$Mutation$ChangeSshSettings<TRes> {
  _CopyWithImpl$Mutation$ChangeSshSettings(this._instance, this._then);

  final Mutation$ChangeSshSettings _instance;

  final TRes Function(Mutation$ChangeSshSettings) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? system = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$ChangeSshSettings(
          system:
              system == _undefined || system == null
                  ? _instance.system
                  : (system as Mutation$ChangeSshSettings$system),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$ChangeSshSettings$system<TRes> get system {
    final local$system = _instance.system;
    return CopyWith$Mutation$ChangeSshSettings$system(
      local$system,
      (e) => call(system: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$ChangeSshSettings<TRes>
    implements CopyWith$Mutation$ChangeSshSettings<TRes> {
  _CopyWithStubImpl$Mutation$ChangeSshSettings(this._res);

  TRes _res;

  call({Mutation$ChangeSshSettings$system? system, String? $__typename}) =>
      _res;

  CopyWith$Mutation$ChangeSshSettings$system<TRes> get system =>
      CopyWith$Mutation$ChangeSshSettings$system.stub(_res);
}

const documentNodeMutationChangeSshSettings = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ChangeSshSettings'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'settings')),
          type: NamedTypeNode(
            name: NameNode(value: 'SSHSettingsInput'),
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
            name: NameNode(value: 'system'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'changeSshSettings'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'settings'),
                      value: VariableNode(name: NameNode(value: 'settings')),
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
                        name: NameNode(value: 'enable'),
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
Mutation$ChangeSshSettings _parserFn$Mutation$ChangeSshSettings(
  Map<String, dynamic> data,
) => Mutation$ChangeSshSettings.fromJson(data);
typedef OnMutationCompleted$Mutation$ChangeSshSettings =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$ChangeSshSettings?);

class Options$Mutation$ChangeSshSettings
    extends graphql.MutationOptions<Mutation$ChangeSshSettings> {
  Options$Mutation$ChangeSshSettings({
    String? operationName,
    required Variables$Mutation$ChangeSshSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ChangeSshSettings? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$ChangeSshSettings? onCompleted,
    graphql.OnMutationUpdate<Mutation$ChangeSshSettings>? update,
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
                       : _parserFn$Mutation$ChangeSshSettings(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationChangeSshSettings,
         parserFn: _parserFn$Mutation$ChangeSshSettings,
       );

  final OnMutationCompleted$Mutation$ChangeSshSettings? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$ChangeSshSettings
    extends graphql.WatchQueryOptions<Mutation$ChangeSshSettings> {
  WatchOptions$Mutation$ChangeSshSettings({
    String? operationName,
    required Variables$Mutation$ChangeSshSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ChangeSshSettings? typedOptimisticResult,
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
         document: documentNodeMutationChangeSshSettings,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$ChangeSshSettings,
       );
}

extension ClientExtension$Mutation$ChangeSshSettings on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ChangeSshSettings>>
  mutate$ChangeSshSettings(Options$Mutation$ChangeSshSettings options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$ChangeSshSettings>
  watchMutation$ChangeSshSettings(
    WatchOptions$Mutation$ChangeSshSettings options,
  ) => this.watchMutation(options);
}

class Mutation$ChangeSshSettings$system {
  Mutation$ChangeSshSettings$system({
    required this.changeSshSettings,
    this.$__typename = 'SystemMutations',
  });

  factory Mutation$ChangeSshSettings$system.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$changeSshSettings = json['changeSshSettings'];
    final l$$__typename = json['__typename'];
    return Mutation$ChangeSshSettings$system(
      changeSshSettings:
          Mutation$ChangeSshSettings$system$changeSshSettings.fromJson(
            (l$changeSshSettings as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ChangeSshSettings$system$changeSshSettings changeSshSettings;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$changeSshSettings = changeSshSettings;
    _resultData['changeSshSettings'] = l$changeSshSettings.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$changeSshSettings = changeSshSettings;
    final l$$__typename = $__typename;
    return Object.hashAll([l$changeSshSettings, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ChangeSshSettings$system ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$changeSshSettings = changeSshSettings;
    final lOther$changeSshSettings = other.changeSshSettings;
    if (l$changeSshSettings != lOther$changeSshSettings) {
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

extension UtilityExtension$Mutation$ChangeSshSettings$system
    on Mutation$ChangeSshSettings$system {
  CopyWith$Mutation$ChangeSshSettings$system<Mutation$ChangeSshSettings$system>
  get copyWith => CopyWith$Mutation$ChangeSshSettings$system(this, (i) => i);
}

abstract class CopyWith$Mutation$ChangeSshSettings$system<TRes> {
  factory CopyWith$Mutation$ChangeSshSettings$system(
    Mutation$ChangeSshSettings$system instance,
    TRes Function(Mutation$ChangeSshSettings$system) then,
  ) = _CopyWithImpl$Mutation$ChangeSshSettings$system;

  factory CopyWith$Mutation$ChangeSshSettings$system.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ChangeSshSettings$system;

  TRes call({
    Mutation$ChangeSshSettings$system$changeSshSettings? changeSshSettings,
    String? $__typename,
  });
  CopyWith$Mutation$ChangeSshSettings$system$changeSshSettings<TRes>
  get changeSshSettings;
}

class _CopyWithImpl$Mutation$ChangeSshSettings$system<TRes>
    implements CopyWith$Mutation$ChangeSshSettings$system<TRes> {
  _CopyWithImpl$Mutation$ChangeSshSettings$system(this._instance, this._then);

  final Mutation$ChangeSshSettings$system _instance;

  final TRes Function(Mutation$ChangeSshSettings$system) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? changeSshSettings = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$ChangeSshSettings$system(
      changeSshSettings:
          changeSshSettings == _undefined || changeSshSettings == null
              ? _instance.changeSshSettings
              : (changeSshSettings
                  as Mutation$ChangeSshSettings$system$changeSshSettings),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$ChangeSshSettings$system$changeSshSettings<TRes>
  get changeSshSettings {
    final local$changeSshSettings = _instance.changeSshSettings;
    return CopyWith$Mutation$ChangeSshSettings$system$changeSshSettings(
      local$changeSshSettings,
      (e) => call(changeSshSettings: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$ChangeSshSettings$system<TRes>
    implements CopyWith$Mutation$ChangeSshSettings$system<TRes> {
  _CopyWithStubImpl$Mutation$ChangeSshSettings$system(this._res);

  TRes _res;

  call({
    Mutation$ChangeSshSettings$system$changeSshSettings? changeSshSettings,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$ChangeSshSettings$system$changeSshSettings<TRes>
  get changeSshSettings =>
      CopyWith$Mutation$ChangeSshSettings$system$changeSshSettings.stub(_res);
}

class Mutation$ChangeSshSettings$system$changeSshSettings
    implements Fragment$basicMutationReturnFields$$SSHSettingsMutationReturn {
  Mutation$ChangeSshSettings$system$changeSshSettings({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'SSHSettingsMutationReturn',
    required this.enable,
  });

  factory Mutation$ChangeSshSettings$system$changeSshSettings.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$enable = json['enable'];
    return Mutation$ChangeSshSettings$system$changeSshSettings(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      enable: (l$enable as bool),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final bool enable;

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
    final l$enable = enable;
    _resultData['enable'] = l$enable;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$enable = enable;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$enable,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ChangeSshSettings$system$changeSshSettings ||
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
    final l$enable = enable;
    final lOther$enable = other.enable;
    if (l$enable != lOther$enable) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$ChangeSshSettings$system$changeSshSettings
    on Mutation$ChangeSshSettings$system$changeSshSettings {
  CopyWith$Mutation$ChangeSshSettings$system$changeSshSettings<
    Mutation$ChangeSshSettings$system$changeSshSettings
  >
  get copyWith => CopyWith$Mutation$ChangeSshSettings$system$changeSshSettings(
    this,
    (i) => i,
  );
}

abstract class CopyWith$Mutation$ChangeSshSettings$system$changeSshSettings<
  TRes
> {
  factory CopyWith$Mutation$ChangeSshSettings$system$changeSshSettings(
    Mutation$ChangeSshSettings$system$changeSshSettings instance,
    TRes Function(Mutation$ChangeSshSettings$system$changeSshSettings) then,
  ) = _CopyWithImpl$Mutation$ChangeSshSettings$system$changeSshSettings;

  factory CopyWith$Mutation$ChangeSshSettings$system$changeSshSettings.stub(
    TRes res,
  ) = _CopyWithStubImpl$Mutation$ChangeSshSettings$system$changeSshSettings;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    bool? enable,
  });
}

class _CopyWithImpl$Mutation$ChangeSshSettings$system$changeSshSettings<TRes>
    implements
        CopyWith$Mutation$ChangeSshSettings$system$changeSshSettings<TRes> {
  _CopyWithImpl$Mutation$ChangeSshSettings$system$changeSshSettings(
    this._instance,
    this._then,
  );

  final Mutation$ChangeSshSettings$system$changeSshSettings _instance;

  final TRes Function(Mutation$ChangeSshSettings$system$changeSshSettings)
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? enable = _undefined,
  }) => _then(
    Mutation$ChangeSshSettings$system$changeSshSettings(
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
      enable:
          enable == _undefined || enable == null
              ? _instance.enable
              : (enable as bool),
    ),
  );
}

class _CopyWithStubImpl$Mutation$ChangeSshSettings$system$changeSshSettings<
  TRes
>
    implements
        CopyWith$Mutation$ChangeSshSettings$system$changeSshSettings<TRes> {
  _CopyWithStubImpl$Mutation$ChangeSshSettings$system$changeSshSettings(
    this._res,
  );

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    bool? enable,
  }) => _res;
}
