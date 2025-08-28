import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:selfprivacy/utils/scalars.dart';

class Fragment$LogEntry {
  Fragment$LogEntry({
    required this.message,
    required this.timestamp,
    this.priority,
    this.systemdUnit,
    this.systemdSlice,
    required this.cursor,
    this.$__typename = 'LogEntry',
  });

  factory Fragment$LogEntry.fromJson(Map<String, dynamic> json) {
    final l$message = json['message'];
    final l$timestamp = json['timestamp'];
    final l$priority = json['priority'];
    final l$systemdUnit = json['systemdUnit'];
    final l$systemdSlice = json['systemdSlice'];
    final l$cursor = json['cursor'];
    final l$$__typename = json['__typename'];
    return Fragment$LogEntry(
      message: (l$message as String),
      timestamp: dateTimeFromJson(l$timestamp),
      priority: (l$priority as int?),
      systemdUnit: (l$systemdUnit as String?),
      systemdSlice: (l$systemdSlice as String?),
      cursor: (l$cursor as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String message;

  final DateTime timestamp;

  final int? priority;

  final String? systemdUnit;

  final String? systemdSlice;

  final String cursor;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$message = message;
    _resultData['message'] = l$message;
    final l$timestamp = timestamp;
    _resultData['timestamp'] = dateTimeToJson(l$timestamp);
    final l$priority = priority;
    _resultData['priority'] = l$priority;
    final l$systemdUnit = systemdUnit;
    _resultData['systemdUnit'] = l$systemdUnit;
    final l$systemdSlice = systemdSlice;
    _resultData['systemdSlice'] = l$systemdSlice;
    final l$cursor = cursor;
    _resultData['cursor'] = l$cursor;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$message = message;
    final l$timestamp = timestamp;
    final l$priority = priority;
    final l$systemdUnit = systemdUnit;
    final l$systemdSlice = systemdSlice;
    final l$cursor = cursor;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$message,
      l$timestamp,
      l$priority,
      l$systemdUnit,
      l$systemdSlice,
      l$cursor,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$LogEntry || runtimeType != other.runtimeType) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$timestamp = timestamp;
    final lOther$timestamp = other.timestamp;
    if (l$timestamp != lOther$timestamp) {
      return false;
    }
    final l$priority = priority;
    final lOther$priority = other.priority;
    if (l$priority != lOther$priority) {
      return false;
    }
    final l$systemdUnit = systemdUnit;
    final lOther$systemdUnit = other.systemdUnit;
    if (l$systemdUnit != lOther$systemdUnit) {
      return false;
    }
    final l$systemdSlice = systemdSlice;
    final lOther$systemdSlice = other.systemdSlice;
    if (l$systemdSlice != lOther$systemdSlice) {
      return false;
    }
    final l$cursor = cursor;
    final lOther$cursor = other.cursor;
    if (l$cursor != lOther$cursor) {
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

extension UtilityExtension$Fragment$LogEntry on Fragment$LogEntry {
  CopyWith$Fragment$LogEntry<Fragment$LogEntry> get copyWith =>
      CopyWith$Fragment$LogEntry(this, (i) => i);
}

abstract class CopyWith$Fragment$LogEntry<TRes> {
  factory CopyWith$Fragment$LogEntry(
    Fragment$LogEntry instance,
    TRes Function(Fragment$LogEntry) then,
  ) = _CopyWithImpl$Fragment$LogEntry;

  factory CopyWith$Fragment$LogEntry.stub(TRes res) =
      _CopyWithStubImpl$Fragment$LogEntry;

  TRes call({
    String? message,
    DateTime? timestamp,
    int? priority,
    String? systemdUnit,
    String? systemdSlice,
    String? cursor,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$LogEntry<TRes>
    implements CopyWith$Fragment$LogEntry<TRes> {
  _CopyWithImpl$Fragment$LogEntry(this._instance, this._then);

  final Fragment$LogEntry _instance;

  final TRes Function(Fragment$LogEntry) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? message = _undefined,
    Object? timestamp = _undefined,
    Object? priority = _undefined,
    Object? systemdUnit = _undefined,
    Object? systemdSlice = _undefined,
    Object? cursor = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$LogEntry(
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      timestamp:
          timestamp == _undefined || timestamp == null
              ? _instance.timestamp
              : (timestamp as DateTime),
      priority:
          priority == _undefined ? _instance.priority : (priority as int?),
      systemdUnit:
          systemdUnit == _undefined
              ? _instance.systemdUnit
              : (systemdUnit as String?),
      systemdSlice:
          systemdSlice == _undefined
              ? _instance.systemdSlice
              : (systemdSlice as String?),
      cursor:
          cursor == _undefined || cursor == null
              ? _instance.cursor
              : (cursor as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$LogEntry<TRes>
    implements CopyWith$Fragment$LogEntry<TRes> {
  _CopyWithStubImpl$Fragment$LogEntry(this._res);

  TRes _res;

  call({
    String? message,
    DateTime? timestamp,
    int? priority,
    String? systemdUnit,
    String? systemdSlice,
    String? cursor,
    String? $__typename,
  }) => _res;
}

const fragmentDefinitionLogEntry = FragmentDefinitionNode(
  name: NameNode(value: 'LogEntry'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'LogEntry'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'message'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'timestamp'),
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
        name: NameNode(value: 'systemdUnit'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'systemdSlice'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'cursor'),
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
const documentNodeFragmentLogEntry = DocumentNode(
  definitions: [fragmentDefinitionLogEntry],
);

extension ClientExtension$Fragment$LogEntry on graphql.GraphQLClient {
  void writeFragment$LogEntry({
    required Fragment$LogEntry data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'LogEntry',
        document: documentNodeFragmentLogEntry,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Fragment$LogEntry? readFragment$LogEntry({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'LogEntry',
          document: documentNodeFragmentLogEntry,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$LogEntry.fromJson(result);
  }
}

class Variables$Query$Logs {
  factory Variables$Query$Logs({
    required int limit,
    String? upCursor,
    String? downCursor,
    String? filterBySlice,
    String? filterByUnit,
  }) => Variables$Query$Logs._({
    r'limit': limit,
    if (upCursor != null) r'upCursor': upCursor,
    if (downCursor != null) r'downCursor': downCursor,
    if (filterBySlice != null) r'filterBySlice': filterBySlice,
    if (filterByUnit != null) r'filterByUnit': filterByUnit,
  });

  Variables$Query$Logs._(this._$data);

  factory Variables$Query$Logs.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$limit = data['limit'];
    result$data['limit'] = (l$limit as int);
    if (data.containsKey('upCursor')) {
      final l$upCursor = data['upCursor'];
      result$data['upCursor'] = (l$upCursor as String?);
    }
    if (data.containsKey('downCursor')) {
      final l$downCursor = data['downCursor'];
      result$data['downCursor'] = (l$downCursor as String?);
    }
    if (data.containsKey('filterBySlice')) {
      final l$filterBySlice = data['filterBySlice'];
      result$data['filterBySlice'] = (l$filterBySlice as String?);
    }
    if (data.containsKey('filterByUnit')) {
      final l$filterByUnit = data['filterByUnit'];
      result$data['filterByUnit'] = (l$filterByUnit as String?);
    }
    return Variables$Query$Logs._(result$data);
  }

  Map<String, dynamic> _$data;

  int get limit => (_$data['limit'] as int);

  String? get upCursor => (_$data['upCursor'] as String?);

  String? get downCursor => (_$data['downCursor'] as String?);

  String? get filterBySlice => (_$data['filterBySlice'] as String?);

  String? get filterByUnit => (_$data['filterByUnit'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$limit = limit;
    result$data['limit'] = l$limit;
    if (_$data.containsKey('upCursor')) {
      final l$upCursor = upCursor;
      result$data['upCursor'] = l$upCursor;
    }
    if (_$data.containsKey('downCursor')) {
      final l$downCursor = downCursor;
      result$data['downCursor'] = l$downCursor;
    }
    if (_$data.containsKey('filterBySlice')) {
      final l$filterBySlice = filterBySlice;
      result$data['filterBySlice'] = l$filterBySlice;
    }
    if (_$data.containsKey('filterByUnit')) {
      final l$filterByUnit = filterByUnit;
      result$data['filterByUnit'] = l$filterByUnit;
    }
    return result$data;
  }

  CopyWith$Variables$Query$Logs<Variables$Query$Logs> get copyWith =>
      CopyWith$Variables$Query$Logs(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$Logs || runtimeType != other.runtimeType) {
      return false;
    }
    final l$limit = limit;
    final lOther$limit = other.limit;
    if (l$limit != lOther$limit) {
      return false;
    }
    final l$upCursor = upCursor;
    final lOther$upCursor = other.upCursor;
    if (_$data.containsKey('upCursor') !=
        other._$data.containsKey('upCursor')) {
      return false;
    }
    if (l$upCursor != lOther$upCursor) {
      return false;
    }
    final l$downCursor = downCursor;
    final lOther$downCursor = other.downCursor;
    if (_$data.containsKey('downCursor') !=
        other._$data.containsKey('downCursor')) {
      return false;
    }
    if (l$downCursor != lOther$downCursor) {
      return false;
    }
    final l$filterBySlice = filterBySlice;
    final lOther$filterBySlice = other.filterBySlice;
    if (_$data.containsKey('filterBySlice') !=
        other._$data.containsKey('filterBySlice')) {
      return false;
    }
    if (l$filterBySlice != lOther$filterBySlice) {
      return false;
    }
    final l$filterByUnit = filterByUnit;
    final lOther$filterByUnit = other.filterByUnit;
    if (_$data.containsKey('filterByUnit') !=
        other._$data.containsKey('filterByUnit')) {
      return false;
    }
    if (l$filterByUnit != lOther$filterByUnit) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$limit = limit;
    final l$upCursor = upCursor;
    final l$downCursor = downCursor;
    final l$filterBySlice = filterBySlice;
    final l$filterByUnit = filterByUnit;
    return Object.hashAll([
      l$limit,
      _$data.containsKey('upCursor') ? l$upCursor : const {},
      _$data.containsKey('downCursor') ? l$downCursor : const {},
      _$data.containsKey('filterBySlice') ? l$filterBySlice : const {},
      _$data.containsKey('filterByUnit') ? l$filterByUnit : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Query$Logs<TRes> {
  factory CopyWith$Variables$Query$Logs(
    Variables$Query$Logs instance,
    TRes Function(Variables$Query$Logs) then,
  ) = _CopyWithImpl$Variables$Query$Logs;

  factory CopyWith$Variables$Query$Logs.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$Logs;

  TRes call({
    int? limit,
    String? upCursor,
    String? downCursor,
    String? filterBySlice,
    String? filterByUnit,
  });
}

class _CopyWithImpl$Variables$Query$Logs<TRes>
    implements CopyWith$Variables$Query$Logs<TRes> {
  _CopyWithImpl$Variables$Query$Logs(this._instance, this._then);

  final Variables$Query$Logs _instance;

  final TRes Function(Variables$Query$Logs) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? limit = _undefined,
    Object? upCursor = _undefined,
    Object? downCursor = _undefined,
    Object? filterBySlice = _undefined,
    Object? filterByUnit = _undefined,
  }) => _then(
    Variables$Query$Logs._({
      ..._instance._$data,
      if (limit != _undefined && limit != null) 'limit': (limit as int),
      if (upCursor != _undefined) 'upCursor': (upCursor as String?),
      if (downCursor != _undefined) 'downCursor': (downCursor as String?),
      if (filterBySlice != _undefined)
        'filterBySlice': (filterBySlice as String?),
      if (filterByUnit != _undefined) 'filterByUnit': (filterByUnit as String?),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$Logs<TRes>
    implements CopyWith$Variables$Query$Logs<TRes> {
  _CopyWithStubImpl$Variables$Query$Logs(this._res);

  TRes _res;

  call({
    int? limit,
    String? upCursor,
    String? downCursor,
    String? filterBySlice,
    String? filterByUnit,
  }) => _res;
}

class Query$Logs {
  Query$Logs({required this.logs, this.$__typename = 'Query'});

  factory Query$Logs.fromJson(Map<String, dynamic> json) {
    final l$logs = json['logs'];
    final l$$__typename = json['__typename'];
    return Query$Logs(
      logs: Query$Logs$logs.fromJson((l$logs as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$Logs$logs logs;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$logs = logs;
    _resultData['logs'] = l$logs.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$logs = logs;
    final l$$__typename = $__typename;
    return Object.hashAll([l$logs, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Logs || runtimeType != other.runtimeType) {
      return false;
    }
    final l$logs = logs;
    final lOther$logs = other.logs;
    if (l$logs != lOther$logs) {
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

extension UtilityExtension$Query$Logs on Query$Logs {
  CopyWith$Query$Logs<Query$Logs> get copyWith =>
      CopyWith$Query$Logs(this, (i) => i);
}

abstract class CopyWith$Query$Logs<TRes> {
  factory CopyWith$Query$Logs(
    Query$Logs instance,
    TRes Function(Query$Logs) then,
  ) = _CopyWithImpl$Query$Logs;

  factory CopyWith$Query$Logs.stub(TRes res) = _CopyWithStubImpl$Query$Logs;

  TRes call({Query$Logs$logs? logs, String? $__typename});
  CopyWith$Query$Logs$logs<TRes> get logs;
}

class _CopyWithImpl$Query$Logs<TRes> implements CopyWith$Query$Logs<TRes> {
  _CopyWithImpl$Query$Logs(this._instance, this._then);

  final Query$Logs _instance;

  final TRes Function(Query$Logs) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? logs = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$Logs(
          logs:
              logs == _undefined || logs == null
                  ? _instance.logs
                  : (logs as Query$Logs$logs),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Query$Logs$logs<TRes> get logs {
    final local$logs = _instance.logs;
    return CopyWith$Query$Logs$logs(local$logs, (e) => call(logs: e));
  }
}

class _CopyWithStubImpl$Query$Logs<TRes> implements CopyWith$Query$Logs<TRes> {
  _CopyWithStubImpl$Query$Logs(this._res);

  TRes _res;

  call({Query$Logs$logs? logs, String? $__typename}) => _res;

  CopyWith$Query$Logs$logs<TRes> get logs =>
      CopyWith$Query$Logs$logs.stub(_res);
}

const documentNodeQueryLogs = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Logs'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'limit')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'upCursor')),
          type: NamedTypeNode(
            name: NameNode(value: 'String'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'downCursor')),
          type: NamedTypeNode(
            name: NameNode(value: 'String'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'filterBySlice')),
          type: NamedTypeNode(
            name: NameNode(value: 'String'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'filterByUnit')),
          type: NamedTypeNode(
            name: NameNode(value: 'String'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'logs'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'paginated'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'limit'),
                      value: VariableNode(name: NameNode(value: 'limit')),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'upCursor'),
                      value: VariableNode(name: NameNode(value: 'upCursor')),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'downCursor'),
                      value: VariableNode(name: NameNode(value: 'downCursor')),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'filterBySlice'),
                      value: VariableNode(
                        name: NameNode(value: 'filterBySlice'),
                      ),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'filterByUnit'),
                      value: VariableNode(
                        name: NameNode(value: 'filterByUnit'),
                      ),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'pageMeta'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FieldNode(
                              name: NameNode(value: 'upCursor'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'downCursor'),
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
                        name: NameNode(value: 'entries'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'LogEntry'),
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
    fragmentDefinitionLogEntry,
  ],
);
Query$Logs _parserFn$Query$Logs(Map<String, dynamic> data) =>
    Query$Logs.fromJson(data);
typedef OnQueryComplete$Query$Logs =
    FutureOr<void> Function(Map<String, dynamic>?, Query$Logs?);

class Options$Query$Logs extends graphql.QueryOptions<Query$Logs> {
  Options$Query$Logs({
    String? operationName,
    required Variables$Query$Logs variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Logs? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$Logs? onComplete,
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
                   data == null ? null : _parserFn$Query$Logs(data),
                 ),
         onError: onError,
         document: documentNodeQueryLogs,
         parserFn: _parserFn$Query$Logs,
       );

  final OnQueryComplete$Query$Logs? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$Logs extends graphql.WatchQueryOptions<Query$Logs> {
  WatchOptions$Query$Logs({
    String? operationName,
    required Variables$Query$Logs variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Logs? typedOptimisticResult,
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
         document: documentNodeQueryLogs,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$Logs,
       );
}

class FetchMoreOptions$Query$Logs extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$Logs({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$Logs variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryLogs,
       );
}

extension ClientExtension$Query$Logs on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$Logs>> query$Logs(
    Options$Query$Logs options,
  ) async => await this.query(options);
  graphql.ObservableQuery<Query$Logs> watchQuery$Logs(
    WatchOptions$Query$Logs options,
  ) => this.watchQuery(options);
  void writeQuery$Logs({
    required Query$Logs data,
    required Variables$Query$Logs variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryLogs),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Query$Logs? readQuery$Logs({
    required Variables$Query$Logs variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryLogs),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$Logs.fromJson(result);
  }
}

class Query$Logs$logs {
  Query$Logs$logs({required this.paginated, this.$__typename = 'Logs'});

  factory Query$Logs$logs.fromJson(Map<String, dynamic> json) {
    final l$paginated = json['paginated'];
    final l$$__typename = json['__typename'];
    return Query$Logs$logs(
      paginated: Query$Logs$logs$paginated.fromJson(
        (l$paginated as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$Logs$logs$paginated paginated;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$paginated = paginated;
    _resultData['paginated'] = l$paginated.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$paginated = paginated;
    final l$$__typename = $__typename;
    return Object.hashAll([l$paginated, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Logs$logs || runtimeType != other.runtimeType) {
      return false;
    }
    final l$paginated = paginated;
    final lOther$paginated = other.paginated;
    if (l$paginated != lOther$paginated) {
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

extension UtilityExtension$Query$Logs$logs on Query$Logs$logs {
  CopyWith$Query$Logs$logs<Query$Logs$logs> get copyWith =>
      CopyWith$Query$Logs$logs(this, (i) => i);
}

abstract class CopyWith$Query$Logs$logs<TRes> {
  factory CopyWith$Query$Logs$logs(
    Query$Logs$logs instance,
    TRes Function(Query$Logs$logs) then,
  ) = _CopyWithImpl$Query$Logs$logs;

  factory CopyWith$Query$Logs$logs.stub(TRes res) =
      _CopyWithStubImpl$Query$Logs$logs;

  TRes call({Query$Logs$logs$paginated? paginated, String? $__typename});
  CopyWith$Query$Logs$logs$paginated<TRes> get paginated;
}

class _CopyWithImpl$Query$Logs$logs<TRes>
    implements CopyWith$Query$Logs$logs<TRes> {
  _CopyWithImpl$Query$Logs$logs(this._instance, this._then);

  final Query$Logs$logs _instance;

  final TRes Function(Query$Logs$logs) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? paginated = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$Logs$logs(
      paginated:
          paginated == _undefined || paginated == null
              ? _instance.paginated
              : (paginated as Query$Logs$logs$paginated),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$Logs$logs$paginated<TRes> get paginated {
    final local$paginated = _instance.paginated;
    return CopyWith$Query$Logs$logs$paginated(
      local$paginated,
      (e) => call(paginated: e),
    );
  }
}

class _CopyWithStubImpl$Query$Logs$logs<TRes>
    implements CopyWith$Query$Logs$logs<TRes> {
  _CopyWithStubImpl$Query$Logs$logs(this._res);

  TRes _res;

  call({Query$Logs$logs$paginated? paginated, String? $__typename}) => _res;

  CopyWith$Query$Logs$logs$paginated<TRes> get paginated =>
      CopyWith$Query$Logs$logs$paginated.stub(_res);
}

class Query$Logs$logs$paginated {
  Query$Logs$logs$paginated({
    required this.pageMeta,
    required this.entries,
    this.$__typename = 'PaginatedEntries',
  });

  factory Query$Logs$logs$paginated.fromJson(Map<String, dynamic> json) {
    final l$pageMeta = json['pageMeta'];
    final l$entries = json['entries'];
    final l$$__typename = json['__typename'];
    return Query$Logs$logs$paginated(
      pageMeta: Query$Logs$logs$paginated$pageMeta.fromJson(
        (l$pageMeta as Map<String, dynamic>),
      ),
      entries:
          (l$entries as List<dynamic>)
              .map(
                (e) => Fragment$LogEntry.fromJson((e as Map<String, dynamic>)),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$Logs$logs$paginated$pageMeta pageMeta;

  final List<Fragment$LogEntry> entries;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$pageMeta = pageMeta;
    _resultData['pageMeta'] = l$pageMeta.toJson();
    final l$entries = entries;
    _resultData['entries'] = l$entries.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$pageMeta = pageMeta;
    final l$entries = entries;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$pageMeta,
      Object.hashAll(l$entries.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Logs$logs$paginated ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$pageMeta = pageMeta;
    final lOther$pageMeta = other.pageMeta;
    if (l$pageMeta != lOther$pageMeta) {
      return false;
    }
    final l$entries = entries;
    final lOther$entries = other.entries;
    if (l$entries.length != lOther$entries.length) {
      return false;
    }
    for (int i = 0; i < l$entries.length; i++) {
      final l$entries$entry = l$entries[i];
      final lOther$entries$entry = lOther$entries[i];
      if (l$entries$entry != lOther$entries$entry) {
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

extension UtilityExtension$Query$Logs$logs$paginated
    on Query$Logs$logs$paginated {
  CopyWith$Query$Logs$logs$paginated<Query$Logs$logs$paginated> get copyWith =>
      CopyWith$Query$Logs$logs$paginated(this, (i) => i);
}

abstract class CopyWith$Query$Logs$logs$paginated<TRes> {
  factory CopyWith$Query$Logs$logs$paginated(
    Query$Logs$logs$paginated instance,
    TRes Function(Query$Logs$logs$paginated) then,
  ) = _CopyWithImpl$Query$Logs$logs$paginated;

  factory CopyWith$Query$Logs$logs$paginated.stub(TRes res) =
      _CopyWithStubImpl$Query$Logs$logs$paginated;

  TRes call({
    Query$Logs$logs$paginated$pageMeta? pageMeta,
    List<Fragment$LogEntry>? entries,
    String? $__typename,
  });
  CopyWith$Query$Logs$logs$paginated$pageMeta<TRes> get pageMeta;
  TRes entries(
    Iterable<Fragment$LogEntry> Function(
      Iterable<CopyWith$Fragment$LogEntry<Fragment$LogEntry>>,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$Logs$logs$paginated<TRes>
    implements CopyWith$Query$Logs$logs$paginated<TRes> {
  _CopyWithImpl$Query$Logs$logs$paginated(this._instance, this._then);

  final Query$Logs$logs$paginated _instance;

  final TRes Function(Query$Logs$logs$paginated) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? pageMeta = _undefined,
    Object? entries = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$Logs$logs$paginated(
      pageMeta:
          pageMeta == _undefined || pageMeta == null
              ? _instance.pageMeta
              : (pageMeta as Query$Logs$logs$paginated$pageMeta),
      entries:
          entries == _undefined || entries == null
              ? _instance.entries
              : (entries as List<Fragment$LogEntry>),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$Logs$logs$paginated$pageMeta<TRes> get pageMeta {
    final local$pageMeta = _instance.pageMeta;
    return CopyWith$Query$Logs$logs$paginated$pageMeta(
      local$pageMeta,
      (e) => call(pageMeta: e),
    );
  }

  TRes entries(
    Iterable<Fragment$LogEntry> Function(
      Iterable<CopyWith$Fragment$LogEntry<Fragment$LogEntry>>,
    )
    _fn,
  ) => call(
    entries:
        _fn(
          _instance.entries.map((e) => CopyWith$Fragment$LogEntry(e, (i) => i)),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$Logs$logs$paginated<TRes>
    implements CopyWith$Query$Logs$logs$paginated<TRes> {
  _CopyWithStubImpl$Query$Logs$logs$paginated(this._res);

  TRes _res;

  call({
    Query$Logs$logs$paginated$pageMeta? pageMeta,
    List<Fragment$LogEntry>? entries,
    String? $__typename,
  }) => _res;

  CopyWith$Query$Logs$logs$paginated$pageMeta<TRes> get pageMeta =>
      CopyWith$Query$Logs$logs$paginated$pageMeta.stub(_res);

  entries(_fn) => _res;
}

class Query$Logs$logs$paginated$pageMeta {
  Query$Logs$logs$paginated$pageMeta({
    this.upCursor,
    this.downCursor,
    this.$__typename = 'LogsPageMeta',
  });

  factory Query$Logs$logs$paginated$pageMeta.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$upCursor = json['upCursor'];
    final l$downCursor = json['downCursor'];
    final l$$__typename = json['__typename'];
    return Query$Logs$logs$paginated$pageMeta(
      upCursor: (l$upCursor as String?),
      downCursor: (l$downCursor as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? upCursor;

  final String? downCursor;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$upCursor = upCursor;
    _resultData['upCursor'] = l$upCursor;
    final l$downCursor = downCursor;
    _resultData['downCursor'] = l$downCursor;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$upCursor = upCursor;
    final l$downCursor = downCursor;
    final l$$__typename = $__typename;
    return Object.hashAll([l$upCursor, l$downCursor, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Logs$logs$paginated$pageMeta ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$upCursor = upCursor;
    final lOther$upCursor = other.upCursor;
    if (l$upCursor != lOther$upCursor) {
      return false;
    }
    final l$downCursor = downCursor;
    final lOther$downCursor = other.downCursor;
    if (l$downCursor != lOther$downCursor) {
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

extension UtilityExtension$Query$Logs$logs$paginated$pageMeta
    on Query$Logs$logs$paginated$pageMeta {
  CopyWith$Query$Logs$logs$paginated$pageMeta<
    Query$Logs$logs$paginated$pageMeta
  >
  get copyWith => CopyWith$Query$Logs$logs$paginated$pageMeta(this, (i) => i);
}

abstract class CopyWith$Query$Logs$logs$paginated$pageMeta<TRes> {
  factory CopyWith$Query$Logs$logs$paginated$pageMeta(
    Query$Logs$logs$paginated$pageMeta instance,
    TRes Function(Query$Logs$logs$paginated$pageMeta) then,
  ) = _CopyWithImpl$Query$Logs$logs$paginated$pageMeta;

  factory CopyWith$Query$Logs$logs$paginated$pageMeta.stub(TRes res) =
      _CopyWithStubImpl$Query$Logs$logs$paginated$pageMeta;

  TRes call({String? upCursor, String? downCursor, String? $__typename});
}

class _CopyWithImpl$Query$Logs$logs$paginated$pageMeta<TRes>
    implements CopyWith$Query$Logs$logs$paginated$pageMeta<TRes> {
  _CopyWithImpl$Query$Logs$logs$paginated$pageMeta(this._instance, this._then);

  final Query$Logs$logs$paginated$pageMeta _instance;

  final TRes Function(Query$Logs$logs$paginated$pageMeta) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? upCursor = _undefined,
    Object? downCursor = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$Logs$logs$paginated$pageMeta(
      upCursor:
          upCursor == _undefined ? _instance.upCursor : (upCursor as String?),
      downCursor:
          downCursor == _undefined
              ? _instance.downCursor
              : (downCursor as String?),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$Logs$logs$paginated$pageMeta<TRes>
    implements CopyWith$Query$Logs$logs$paginated$pageMeta<TRes> {
  _CopyWithStubImpl$Query$Logs$logs$paginated$pageMeta(this._res);

  TRes _res;

  call({String? upCursor, String? downCursor, String? $__typename}) => _res;
}

class Subscription$LogEntries {
  Subscription$LogEntries({required this.logEntries});

  factory Subscription$LogEntries.fromJson(Map<String, dynamic> json) {
    final l$logEntries = json['logEntries'];
    return Subscription$LogEntries(
      logEntries: Fragment$LogEntry.fromJson(
        (l$logEntries as Map<String, dynamic>),
      ),
    );
  }

  final Fragment$LogEntry logEntries;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$logEntries = logEntries;
    _resultData['logEntries'] = l$logEntries.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$logEntries = logEntries;
    return Object.hashAll([l$logEntries]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Subscription$LogEntries || runtimeType != other.runtimeType) {
      return false;
    }
    final l$logEntries = logEntries;
    final lOther$logEntries = other.logEntries;
    if (l$logEntries != lOther$logEntries) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Subscription$LogEntries on Subscription$LogEntries {
  CopyWith$Subscription$LogEntries<Subscription$LogEntries> get copyWith =>
      CopyWith$Subscription$LogEntries(this, (i) => i);
}

abstract class CopyWith$Subscription$LogEntries<TRes> {
  factory CopyWith$Subscription$LogEntries(
    Subscription$LogEntries instance,
    TRes Function(Subscription$LogEntries) then,
  ) = _CopyWithImpl$Subscription$LogEntries;

  factory CopyWith$Subscription$LogEntries.stub(TRes res) =
      _CopyWithStubImpl$Subscription$LogEntries;

  TRes call({Fragment$LogEntry? logEntries});
  CopyWith$Fragment$LogEntry<TRes> get logEntries;
}

class _CopyWithImpl$Subscription$LogEntries<TRes>
    implements CopyWith$Subscription$LogEntries<TRes> {
  _CopyWithImpl$Subscription$LogEntries(this._instance, this._then);

  final Subscription$LogEntries _instance;

  final TRes Function(Subscription$LogEntries) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? logEntries = _undefined}) => _then(
    Subscription$LogEntries(
      logEntries:
          logEntries == _undefined || logEntries == null
              ? _instance.logEntries
              : (logEntries as Fragment$LogEntry),
    ),
  );

  CopyWith$Fragment$LogEntry<TRes> get logEntries {
    final local$logEntries = _instance.logEntries;
    return CopyWith$Fragment$LogEntry(
      local$logEntries,
      (e) => call(logEntries: e),
    );
  }
}

class _CopyWithStubImpl$Subscription$LogEntries<TRes>
    implements CopyWith$Subscription$LogEntries<TRes> {
  _CopyWithStubImpl$Subscription$LogEntries(this._res);

  TRes _res;

  call({Fragment$LogEntry? logEntries}) => _res;

  CopyWith$Fragment$LogEntry<TRes> get logEntries =>
      CopyWith$Fragment$LogEntry.stub(_res);
}

const documentNodeSubscriptionLogEntries = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'LogEntries'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'logEntries'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'LogEntry'),
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
        ],
      ),
    ),
    fragmentDefinitionLogEntry,
  ],
);
Subscription$LogEntries _parserFn$Subscription$LogEntries(
  Map<String, dynamic> data,
) => Subscription$LogEntries.fromJson(data);

class Options$Subscription$LogEntries
    extends graphql.SubscriptionOptions<Subscription$LogEntries> {
  Options$Subscription$LogEntries({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Subscription$LogEntries? typedOptimisticResult,
    graphql.Context? context,
  }) : super(
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionLogEntries,
         parserFn: _parserFn$Subscription$LogEntries,
       );
}

class WatchOptions$Subscription$LogEntries
    extends graphql.WatchQueryOptions<Subscription$LogEntries> {
  WatchOptions$Subscription$LogEntries({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Subscription$LogEntries? typedOptimisticResult,
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
         document: documentNodeSubscriptionLogEntries,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Subscription$LogEntries,
       );
}

class FetchMoreOptions$Subscription$LogEntries
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Subscription$LogEntries({
    required graphql.UpdateQuery updateQuery,
  }) : super(
         updateQuery: updateQuery,
         document: documentNodeSubscriptionLogEntries,
       );
}

extension ClientExtension$Subscription$LogEntries on graphql.GraphQLClient {
  Stream<graphql.QueryResult<Subscription$LogEntries>> subscribe$LogEntries([
    Options$Subscription$LogEntries? options,
  ]) => this.subscribe(options ?? Options$Subscription$LogEntries());
  graphql.ObservableQuery<Subscription$LogEntries>
  watchSubscription$LogEntries([
    WatchOptions$Subscription$LogEntries? options,
  ]) => this.watchQuery(options ?? WatchOptions$Subscription$LogEntries());
}
