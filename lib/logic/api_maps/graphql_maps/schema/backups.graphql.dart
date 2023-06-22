import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:selfprivacy/utils/scalars.dart';
import 'schema.graphql.dart';
import 'services.graphql.dart';

class Fragment$genericBackupConfigReturn {
  Fragment$genericBackupConfigReturn({
    required this.code,
    required this.message,
    required this.success,
    this.configuration,
    this.$__typename = 'GenericBackupConfigReturn',
  });

  factory Fragment$genericBackupConfigReturn.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$configuration = json['configuration'];
    final l$$__typename = json['__typename'];
    return Fragment$genericBackupConfigReturn(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      configuration: l$configuration == null
          ? null
          : Fragment$genericBackupConfigReturn$configuration.fromJson(
              (l$configuration as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final int code;

  final String message;

  final bool success;

  final Fragment$genericBackupConfigReturn$configuration? configuration;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$configuration = configuration;
    _resultData['configuration'] = l$configuration?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$configuration = configuration;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$configuration,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$genericBackupConfigReturn) ||
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
    final l$configuration = configuration;
    final lOther$configuration = other.configuration;
    if (l$configuration != lOther$configuration) {
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

extension UtilityExtension$Fragment$genericBackupConfigReturn
    on Fragment$genericBackupConfigReturn {
  CopyWith$Fragment$genericBackupConfigReturn<
          Fragment$genericBackupConfigReturn>
      get copyWith => CopyWith$Fragment$genericBackupConfigReturn(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Fragment$genericBackupConfigReturn<TRes> {
  factory CopyWith$Fragment$genericBackupConfigReturn(
    Fragment$genericBackupConfigReturn instance,
    TRes Function(Fragment$genericBackupConfigReturn) then,
  ) = _CopyWithImpl$Fragment$genericBackupConfigReturn;

  factory CopyWith$Fragment$genericBackupConfigReturn.stub(TRes res) =
      _CopyWithStubImpl$Fragment$genericBackupConfigReturn;

  TRes call({
    int? code,
    String? message,
    bool? success,
    Fragment$genericBackupConfigReturn$configuration? configuration,
    String? $__typename,
  });
  CopyWith$Fragment$genericBackupConfigReturn$configuration<TRes>
      get configuration;
}

class _CopyWithImpl$Fragment$genericBackupConfigReturn<TRes>
    implements CopyWith$Fragment$genericBackupConfigReturn<TRes> {
  _CopyWithImpl$Fragment$genericBackupConfigReturn(
    this._instance,
    this._then,
  );

  final Fragment$genericBackupConfigReturn _instance;

  final TRes Function(Fragment$genericBackupConfigReturn) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? configuration = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$genericBackupConfigReturn(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        configuration: configuration == _undefined
            ? _instance.configuration
            : (configuration
                as Fragment$genericBackupConfigReturn$configuration?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Fragment$genericBackupConfigReturn$configuration<TRes>
      get configuration {
    final local$configuration = _instance.configuration;
    return local$configuration == null
        ? CopyWith$Fragment$genericBackupConfigReturn$configuration.stub(
            _then(_instance))
        : CopyWith$Fragment$genericBackupConfigReturn$configuration(
            local$configuration, (e) => call(configuration: e));
  }
}

class _CopyWithStubImpl$Fragment$genericBackupConfigReturn<TRes>
    implements CopyWith$Fragment$genericBackupConfigReturn<TRes> {
  _CopyWithStubImpl$Fragment$genericBackupConfigReturn(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    Fragment$genericBackupConfigReturn$configuration? configuration,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Fragment$genericBackupConfigReturn$configuration<TRes>
      get configuration =>
          CopyWith$Fragment$genericBackupConfigReturn$configuration.stub(_res);
}

const fragmentDefinitiongenericBackupConfigReturn = FragmentDefinitionNode(
  name: NameNode(value: 'genericBackupConfigReturn'),
  typeCondition: TypeConditionNode(
      on: NamedTypeNode(
    name: NameNode(value: 'GenericBackupConfigReturn'),
    isNonNull: false,
  )),
  directives: [],
  selectionSet: SelectionSetNode(selections: [
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
      name: NameNode(value: 'configuration'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
          name: NameNode(value: 'provider'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        FieldNode(
          name: NameNode(value: 'encryptionKey'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        FieldNode(
          name: NameNode(value: 'isInitialized'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        FieldNode(
          name: NameNode(value: 'autobackupPeriod'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        FieldNode(
          name: NameNode(value: 'locationName'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null,
        ),
        FieldNode(
          name: NameNode(value: 'locationId'),
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
const documentNodeFragmentgenericBackupConfigReturn =
    DocumentNode(definitions: [
  fragmentDefinitiongenericBackupConfigReturn,
]);

extension ClientExtension$Fragment$genericBackupConfigReturn
    on graphql.GraphQLClient {
  void writeFragment$genericBackupConfigReturn({
    required Fragment$genericBackupConfigReturn data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) =>
      this.writeFragment(
        graphql.FragmentRequest(
          idFields: idFields,
          fragment: const graphql.Fragment(
            fragmentName: 'genericBackupConfigReturn',
            document: documentNodeFragmentgenericBackupConfigReturn,
          ),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Fragment$genericBackupConfigReturn? readFragment$genericBackupConfigReturn({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'genericBackupConfigReturn',
          document: documentNodeFragmentgenericBackupConfigReturn,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null
        ? null
        : Fragment$genericBackupConfigReturn.fromJson(result);
  }
}

class Fragment$genericBackupConfigReturn$configuration {
  Fragment$genericBackupConfigReturn$configuration({
    required this.provider,
    required this.encryptionKey,
    required this.isInitialized,
    this.autobackupPeriod,
    this.locationName,
    this.locationId,
    this.$__typename = 'BackupConfiguration',
  });

  factory Fragment$genericBackupConfigReturn$configuration.fromJson(
      Map<String, dynamic> json) {
    final l$provider = json['provider'];
    final l$encryptionKey = json['encryptionKey'];
    final l$isInitialized = json['isInitialized'];
    final l$autobackupPeriod = json['autobackupPeriod'];
    final l$locationName = json['locationName'];
    final l$locationId = json['locationId'];
    final l$$__typename = json['__typename'];
    return Fragment$genericBackupConfigReturn$configuration(
      provider: fromJson$Enum$BackupProvider((l$provider as String)),
      encryptionKey: (l$encryptionKey as String),
      isInitialized: (l$isInitialized as bool),
      autobackupPeriod: (l$autobackupPeriod as int?),
      locationName: (l$locationName as String?),
      locationId: (l$locationId as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final Enum$BackupProvider provider;

  final String encryptionKey;

  final bool isInitialized;

  final int? autobackupPeriod;

  final String? locationName;

  final String? locationId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$provider = provider;
    _resultData['provider'] = toJson$Enum$BackupProvider(l$provider);
    final l$encryptionKey = encryptionKey;
    _resultData['encryptionKey'] = l$encryptionKey;
    final l$isInitialized = isInitialized;
    _resultData['isInitialized'] = l$isInitialized;
    final l$autobackupPeriod = autobackupPeriod;
    _resultData['autobackupPeriod'] = l$autobackupPeriod;
    final l$locationName = locationName;
    _resultData['locationName'] = l$locationName;
    final l$locationId = locationId;
    _resultData['locationId'] = l$locationId;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$provider = provider;
    final l$encryptionKey = encryptionKey;
    final l$isInitialized = isInitialized;
    final l$autobackupPeriod = autobackupPeriod;
    final l$locationName = locationName;
    final l$locationId = locationId;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$provider,
      l$encryptionKey,
      l$isInitialized,
      l$autobackupPeriod,
      l$locationName,
      l$locationId,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$genericBackupConfigReturn$configuration) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$provider = provider;
    final lOther$provider = other.provider;
    if (l$provider != lOther$provider) {
      return false;
    }
    final l$encryptionKey = encryptionKey;
    final lOther$encryptionKey = other.encryptionKey;
    if (l$encryptionKey != lOther$encryptionKey) {
      return false;
    }
    final l$isInitialized = isInitialized;
    final lOther$isInitialized = other.isInitialized;
    if (l$isInitialized != lOther$isInitialized) {
      return false;
    }
    final l$autobackupPeriod = autobackupPeriod;
    final lOther$autobackupPeriod = other.autobackupPeriod;
    if (l$autobackupPeriod != lOther$autobackupPeriod) {
      return false;
    }
    final l$locationName = locationName;
    final lOther$locationName = other.locationName;
    if (l$locationName != lOther$locationName) {
      return false;
    }
    final l$locationId = locationId;
    final lOther$locationId = other.locationId;
    if (l$locationId != lOther$locationId) {
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

extension UtilityExtension$Fragment$genericBackupConfigReturn$configuration
    on Fragment$genericBackupConfigReturn$configuration {
  CopyWith$Fragment$genericBackupConfigReturn$configuration<
          Fragment$genericBackupConfigReturn$configuration>
      get copyWith => CopyWith$Fragment$genericBackupConfigReturn$configuration(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Fragment$genericBackupConfigReturn$configuration<TRes> {
  factory CopyWith$Fragment$genericBackupConfigReturn$configuration(
    Fragment$genericBackupConfigReturn$configuration instance,
    TRes Function(Fragment$genericBackupConfigReturn$configuration) then,
  ) = _CopyWithImpl$Fragment$genericBackupConfigReturn$configuration;

  factory CopyWith$Fragment$genericBackupConfigReturn$configuration.stub(
          TRes res) =
      _CopyWithStubImpl$Fragment$genericBackupConfigReturn$configuration;

  TRes call({
    Enum$BackupProvider? provider,
    String? encryptionKey,
    bool? isInitialized,
    int? autobackupPeriod,
    String? locationName,
    String? locationId,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$genericBackupConfigReturn$configuration<TRes>
    implements CopyWith$Fragment$genericBackupConfigReturn$configuration<TRes> {
  _CopyWithImpl$Fragment$genericBackupConfigReturn$configuration(
    this._instance,
    this._then,
  );

  final Fragment$genericBackupConfigReturn$configuration _instance;

  final TRes Function(Fragment$genericBackupConfigReturn$configuration) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? provider = _undefined,
    Object? encryptionKey = _undefined,
    Object? isInitialized = _undefined,
    Object? autobackupPeriod = _undefined,
    Object? locationName = _undefined,
    Object? locationId = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$genericBackupConfigReturn$configuration(
        provider: provider == _undefined || provider == null
            ? _instance.provider
            : (provider as Enum$BackupProvider),
        encryptionKey: encryptionKey == _undefined || encryptionKey == null
            ? _instance.encryptionKey
            : (encryptionKey as String),
        isInitialized: isInitialized == _undefined || isInitialized == null
            ? _instance.isInitialized
            : (isInitialized as bool),
        autobackupPeriod: autobackupPeriod == _undefined
            ? _instance.autobackupPeriod
            : (autobackupPeriod as int?),
        locationName: locationName == _undefined
            ? _instance.locationName
            : (locationName as String?),
        locationId: locationId == _undefined
            ? _instance.locationId
            : (locationId as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$genericBackupConfigReturn$configuration<TRes>
    implements CopyWith$Fragment$genericBackupConfigReturn$configuration<TRes> {
  _CopyWithStubImpl$Fragment$genericBackupConfigReturn$configuration(this._res);

  TRes _res;

  call({
    Enum$BackupProvider? provider,
    String? encryptionKey,
    bool? isInitialized,
    int? autobackupPeriod,
    String? locationName,
    String? locationId,
    String? $__typename,
  }) =>
      _res;
}

class Query$BackupConfiguration {
  Query$BackupConfiguration({
    required this.backup,
    this.$__typename = 'Query',
  });

  factory Query$BackupConfiguration.fromJson(Map<String, dynamic> json) {
    final l$backup = json['backup'];
    final l$$__typename = json['__typename'];
    return Query$BackupConfiguration(
      backup: Query$BackupConfiguration$backup.fromJson(
          (l$backup as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$BackupConfiguration$backup backup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$backup = backup;
    _resultData['backup'] = l$backup.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$backup = backup;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$backup,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$BackupConfiguration) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$backup = backup;
    final lOther$backup = other.backup;
    if (l$backup != lOther$backup) {
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

extension UtilityExtension$Query$BackupConfiguration
    on Query$BackupConfiguration {
  CopyWith$Query$BackupConfiguration<Query$BackupConfiguration> get copyWith =>
      CopyWith$Query$BackupConfiguration(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$BackupConfiguration<TRes> {
  factory CopyWith$Query$BackupConfiguration(
    Query$BackupConfiguration instance,
    TRes Function(Query$BackupConfiguration) then,
  ) = _CopyWithImpl$Query$BackupConfiguration;

  factory CopyWith$Query$BackupConfiguration.stub(TRes res) =
      _CopyWithStubImpl$Query$BackupConfiguration;

  TRes call({
    Query$BackupConfiguration$backup? backup,
    String? $__typename,
  });
  CopyWith$Query$BackupConfiguration$backup<TRes> get backup;
}

class _CopyWithImpl$Query$BackupConfiguration<TRes>
    implements CopyWith$Query$BackupConfiguration<TRes> {
  _CopyWithImpl$Query$BackupConfiguration(
    this._instance,
    this._then,
  );

  final Query$BackupConfiguration _instance;

  final TRes Function(Query$BackupConfiguration) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? backup = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$BackupConfiguration(
        backup: backup == _undefined || backup == null
            ? _instance.backup
            : (backup as Query$BackupConfiguration$backup),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$BackupConfiguration$backup<TRes> get backup {
    final local$backup = _instance.backup;
    return CopyWith$Query$BackupConfiguration$backup(
        local$backup, (e) => call(backup: e));
  }
}

class _CopyWithStubImpl$Query$BackupConfiguration<TRes>
    implements CopyWith$Query$BackupConfiguration<TRes> {
  _CopyWithStubImpl$Query$BackupConfiguration(this._res);

  TRes _res;

  call({
    Query$BackupConfiguration$backup? backup,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$BackupConfiguration$backup<TRes> get backup =>
      CopyWith$Query$BackupConfiguration$backup.stub(_res);
}

const documentNodeQueryBackupConfiguration = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'BackupConfiguration'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'backup'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'configuration'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'autobackupPeriod'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'encryptionKey'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'isInitialized'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'locationId'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'locationName'),
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
]);
Query$BackupConfiguration _parserFn$Query$BackupConfiguration(
        Map<String, dynamic> data) =>
    Query$BackupConfiguration.fromJson(data);
typedef OnQueryComplete$Query$BackupConfiguration = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$BackupConfiguration?,
);

class Options$Query$BackupConfiguration
    extends graphql.QueryOptions<Query$BackupConfiguration> {
  Options$Query$BackupConfiguration({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$BackupConfiguration? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$BackupConfiguration? onComplete,
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
                    data == null
                        ? null
                        : _parserFn$Query$BackupConfiguration(data),
                  ),
          onError: onError,
          document: documentNodeQueryBackupConfiguration,
          parserFn: _parserFn$Query$BackupConfiguration,
        );

  final OnQueryComplete$Query$BackupConfiguration? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$BackupConfiguration
    extends graphql.WatchQueryOptions<Query$BackupConfiguration> {
  WatchOptions$Query$BackupConfiguration({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$BackupConfiguration? typedOptimisticResult,
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
          document: documentNodeQueryBackupConfiguration,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$BackupConfiguration,
        );
}

class FetchMoreOptions$Query$BackupConfiguration
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$BackupConfiguration(
      {required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryBackupConfiguration,
        );
}

extension ClientExtension$Query$BackupConfiguration on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$BackupConfiguration>>
      query$BackupConfiguration(
              [Options$Query$BackupConfiguration? options]) async =>
          await this.query(options ?? Options$Query$BackupConfiguration());
  graphql.ObservableQuery<Query$BackupConfiguration>
      watchQuery$BackupConfiguration(
              [WatchOptions$Query$BackupConfiguration? options]) =>
          this.watchQuery(options ?? WatchOptions$Query$BackupConfiguration());
  void writeQuery$BackupConfiguration({
    required Query$BackupConfiguration data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation: graphql.Operation(
                document: documentNodeQueryBackupConfiguration)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$BackupConfiguration? readQuery$BackupConfiguration(
      {bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation: graphql.Operation(
              document: documentNodeQueryBackupConfiguration)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$BackupConfiguration.fromJson(result);
  }
}

class Query$BackupConfiguration$backup {
  Query$BackupConfiguration$backup({
    required this.configuration,
    this.$__typename = 'Backup',
  });

  factory Query$BackupConfiguration$backup.fromJson(Map<String, dynamic> json) {
    final l$configuration = json['configuration'];
    final l$$__typename = json['__typename'];
    return Query$BackupConfiguration$backup(
      configuration: Query$BackupConfiguration$backup$configuration.fromJson(
          (l$configuration as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$BackupConfiguration$backup$configuration configuration;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$configuration = configuration;
    _resultData['configuration'] = l$configuration.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$configuration = configuration;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$configuration,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$BackupConfiguration$backup) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$configuration = configuration;
    final lOther$configuration = other.configuration;
    if (l$configuration != lOther$configuration) {
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

extension UtilityExtension$Query$BackupConfiguration$backup
    on Query$BackupConfiguration$backup {
  CopyWith$Query$BackupConfiguration$backup<Query$BackupConfiguration$backup>
      get copyWith => CopyWith$Query$BackupConfiguration$backup(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$BackupConfiguration$backup<TRes> {
  factory CopyWith$Query$BackupConfiguration$backup(
    Query$BackupConfiguration$backup instance,
    TRes Function(Query$BackupConfiguration$backup) then,
  ) = _CopyWithImpl$Query$BackupConfiguration$backup;

  factory CopyWith$Query$BackupConfiguration$backup.stub(TRes res) =
      _CopyWithStubImpl$Query$BackupConfiguration$backup;

  TRes call({
    Query$BackupConfiguration$backup$configuration? configuration,
    String? $__typename,
  });
  CopyWith$Query$BackupConfiguration$backup$configuration<TRes>
      get configuration;
}

class _CopyWithImpl$Query$BackupConfiguration$backup<TRes>
    implements CopyWith$Query$BackupConfiguration$backup<TRes> {
  _CopyWithImpl$Query$BackupConfiguration$backup(
    this._instance,
    this._then,
  );

  final Query$BackupConfiguration$backup _instance;

  final TRes Function(Query$BackupConfiguration$backup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? configuration = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$BackupConfiguration$backup(
        configuration: configuration == _undefined || configuration == null
            ? _instance.configuration
            : (configuration as Query$BackupConfiguration$backup$configuration),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$BackupConfiguration$backup$configuration<TRes>
      get configuration {
    final local$configuration = _instance.configuration;
    return CopyWith$Query$BackupConfiguration$backup$configuration(
        local$configuration, (e) => call(configuration: e));
  }
}

class _CopyWithStubImpl$Query$BackupConfiguration$backup<TRes>
    implements CopyWith$Query$BackupConfiguration$backup<TRes> {
  _CopyWithStubImpl$Query$BackupConfiguration$backup(this._res);

  TRes _res;

  call({
    Query$BackupConfiguration$backup$configuration? configuration,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$BackupConfiguration$backup$configuration<TRes>
      get configuration =>
          CopyWith$Query$BackupConfiguration$backup$configuration.stub(_res);
}

class Query$BackupConfiguration$backup$configuration {
  Query$BackupConfiguration$backup$configuration({
    this.autobackupPeriod,
    required this.encryptionKey,
    required this.isInitialized,
    this.locationId,
    this.locationName,
    required this.provider,
    this.$__typename = 'BackupConfiguration',
  });

  factory Query$BackupConfiguration$backup$configuration.fromJson(
      Map<String, dynamic> json) {
    final l$autobackupPeriod = json['autobackupPeriod'];
    final l$encryptionKey = json['encryptionKey'];
    final l$isInitialized = json['isInitialized'];
    final l$locationId = json['locationId'];
    final l$locationName = json['locationName'];
    final l$provider = json['provider'];
    final l$$__typename = json['__typename'];
    return Query$BackupConfiguration$backup$configuration(
      autobackupPeriod: (l$autobackupPeriod as int?),
      encryptionKey: (l$encryptionKey as String),
      isInitialized: (l$isInitialized as bool),
      locationId: (l$locationId as String?),
      locationName: (l$locationName as String?),
      provider: fromJson$Enum$BackupProvider((l$provider as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final int? autobackupPeriod;

  final String encryptionKey;

  final bool isInitialized;

  final String? locationId;

  final String? locationName;

  final Enum$BackupProvider provider;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$autobackupPeriod = autobackupPeriod;
    _resultData['autobackupPeriod'] = l$autobackupPeriod;
    final l$encryptionKey = encryptionKey;
    _resultData['encryptionKey'] = l$encryptionKey;
    final l$isInitialized = isInitialized;
    _resultData['isInitialized'] = l$isInitialized;
    final l$locationId = locationId;
    _resultData['locationId'] = l$locationId;
    final l$locationName = locationName;
    _resultData['locationName'] = l$locationName;
    final l$provider = provider;
    _resultData['provider'] = toJson$Enum$BackupProvider(l$provider);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$autobackupPeriod = autobackupPeriod;
    final l$encryptionKey = encryptionKey;
    final l$isInitialized = isInitialized;
    final l$locationId = locationId;
    final l$locationName = locationName;
    final l$provider = provider;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$autobackupPeriod,
      l$encryptionKey,
      l$isInitialized,
      l$locationId,
      l$locationName,
      l$provider,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$BackupConfiguration$backup$configuration) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$autobackupPeriod = autobackupPeriod;
    final lOther$autobackupPeriod = other.autobackupPeriod;
    if (l$autobackupPeriod != lOther$autobackupPeriod) {
      return false;
    }
    final l$encryptionKey = encryptionKey;
    final lOther$encryptionKey = other.encryptionKey;
    if (l$encryptionKey != lOther$encryptionKey) {
      return false;
    }
    final l$isInitialized = isInitialized;
    final lOther$isInitialized = other.isInitialized;
    if (l$isInitialized != lOther$isInitialized) {
      return false;
    }
    final l$locationId = locationId;
    final lOther$locationId = other.locationId;
    if (l$locationId != lOther$locationId) {
      return false;
    }
    final l$locationName = locationName;
    final lOther$locationName = other.locationName;
    if (l$locationName != lOther$locationName) {
      return false;
    }
    final l$provider = provider;
    final lOther$provider = other.provider;
    if (l$provider != lOther$provider) {
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

extension UtilityExtension$Query$BackupConfiguration$backup$configuration
    on Query$BackupConfiguration$backup$configuration {
  CopyWith$Query$BackupConfiguration$backup$configuration<
          Query$BackupConfiguration$backup$configuration>
      get copyWith => CopyWith$Query$BackupConfiguration$backup$configuration(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$BackupConfiguration$backup$configuration<TRes> {
  factory CopyWith$Query$BackupConfiguration$backup$configuration(
    Query$BackupConfiguration$backup$configuration instance,
    TRes Function(Query$BackupConfiguration$backup$configuration) then,
  ) = _CopyWithImpl$Query$BackupConfiguration$backup$configuration;

  factory CopyWith$Query$BackupConfiguration$backup$configuration.stub(
          TRes res) =
      _CopyWithStubImpl$Query$BackupConfiguration$backup$configuration;

  TRes call({
    int? autobackupPeriod,
    String? encryptionKey,
    bool? isInitialized,
    String? locationId,
    String? locationName,
    Enum$BackupProvider? provider,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$BackupConfiguration$backup$configuration<TRes>
    implements CopyWith$Query$BackupConfiguration$backup$configuration<TRes> {
  _CopyWithImpl$Query$BackupConfiguration$backup$configuration(
    this._instance,
    this._then,
  );

  final Query$BackupConfiguration$backup$configuration _instance;

  final TRes Function(Query$BackupConfiguration$backup$configuration) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? autobackupPeriod = _undefined,
    Object? encryptionKey = _undefined,
    Object? isInitialized = _undefined,
    Object? locationId = _undefined,
    Object? locationName = _undefined,
    Object? provider = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$BackupConfiguration$backup$configuration(
        autobackupPeriod: autobackupPeriod == _undefined
            ? _instance.autobackupPeriod
            : (autobackupPeriod as int?),
        encryptionKey: encryptionKey == _undefined || encryptionKey == null
            ? _instance.encryptionKey
            : (encryptionKey as String),
        isInitialized: isInitialized == _undefined || isInitialized == null
            ? _instance.isInitialized
            : (isInitialized as bool),
        locationId: locationId == _undefined
            ? _instance.locationId
            : (locationId as String?),
        locationName: locationName == _undefined
            ? _instance.locationName
            : (locationName as String?),
        provider: provider == _undefined || provider == null
            ? _instance.provider
            : (provider as Enum$BackupProvider),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$BackupConfiguration$backup$configuration<TRes>
    implements CopyWith$Query$BackupConfiguration$backup$configuration<TRes> {
  _CopyWithStubImpl$Query$BackupConfiguration$backup$configuration(this._res);

  TRes _res;

  call({
    int? autobackupPeriod,
    String? encryptionKey,
    bool? isInitialized,
    String? locationId,
    String? locationName,
    Enum$BackupProvider? provider,
    String? $__typename,
  }) =>
      _res;
}

class Query$AllBackupSnapshots {
  Query$AllBackupSnapshots({
    required this.backup,
    this.$__typename = 'Query',
  });

  factory Query$AllBackupSnapshots.fromJson(Map<String, dynamic> json) {
    final l$backup = json['backup'];
    final l$$__typename = json['__typename'];
    return Query$AllBackupSnapshots(
      backup: Query$AllBackupSnapshots$backup.fromJson(
          (l$backup as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$AllBackupSnapshots$backup backup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$backup = backup;
    _resultData['backup'] = l$backup.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$backup = backup;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$backup,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$AllBackupSnapshots) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$backup = backup;
    final lOther$backup = other.backup;
    if (l$backup != lOther$backup) {
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

extension UtilityExtension$Query$AllBackupSnapshots
    on Query$AllBackupSnapshots {
  CopyWith$Query$AllBackupSnapshots<Query$AllBackupSnapshots> get copyWith =>
      CopyWith$Query$AllBackupSnapshots(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$AllBackupSnapshots<TRes> {
  factory CopyWith$Query$AllBackupSnapshots(
    Query$AllBackupSnapshots instance,
    TRes Function(Query$AllBackupSnapshots) then,
  ) = _CopyWithImpl$Query$AllBackupSnapshots;

  factory CopyWith$Query$AllBackupSnapshots.stub(TRes res) =
      _CopyWithStubImpl$Query$AllBackupSnapshots;

  TRes call({
    Query$AllBackupSnapshots$backup? backup,
    String? $__typename,
  });
  CopyWith$Query$AllBackupSnapshots$backup<TRes> get backup;
}

class _CopyWithImpl$Query$AllBackupSnapshots<TRes>
    implements CopyWith$Query$AllBackupSnapshots<TRes> {
  _CopyWithImpl$Query$AllBackupSnapshots(
    this._instance,
    this._then,
  );

  final Query$AllBackupSnapshots _instance;

  final TRes Function(Query$AllBackupSnapshots) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? backup = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$AllBackupSnapshots(
        backup: backup == _undefined || backup == null
            ? _instance.backup
            : (backup as Query$AllBackupSnapshots$backup),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$AllBackupSnapshots$backup<TRes> get backup {
    final local$backup = _instance.backup;
    return CopyWith$Query$AllBackupSnapshots$backup(
        local$backup, (e) => call(backup: e));
  }
}

class _CopyWithStubImpl$Query$AllBackupSnapshots<TRes>
    implements CopyWith$Query$AllBackupSnapshots<TRes> {
  _CopyWithStubImpl$Query$AllBackupSnapshots(this._res);

  TRes _res;

  call({
    Query$AllBackupSnapshots$backup? backup,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$AllBackupSnapshots$backup<TRes> get backup =>
      CopyWith$Query$AllBackupSnapshots$backup.stub(_res);
}

const documentNodeQueryAllBackupSnapshots = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'AllBackupSnapshots'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'backup'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'allSnapshots'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                name: NameNode(value: 'backupSnapshotFields'),
                directives: [],
              ),
              FieldNode(
                name: NameNode(value: 'service'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'displayName'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'id'),
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
  fragmentDefinitionbackupSnapshotFields,
]);
Query$AllBackupSnapshots _parserFn$Query$AllBackupSnapshots(
        Map<String, dynamic> data) =>
    Query$AllBackupSnapshots.fromJson(data);
typedef OnQueryComplete$Query$AllBackupSnapshots = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$AllBackupSnapshots?,
);

class Options$Query$AllBackupSnapshots
    extends graphql.QueryOptions<Query$AllBackupSnapshots> {
  Options$Query$AllBackupSnapshots({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$AllBackupSnapshots? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$AllBackupSnapshots? onComplete,
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
                    data == null
                        ? null
                        : _parserFn$Query$AllBackupSnapshots(data),
                  ),
          onError: onError,
          document: documentNodeQueryAllBackupSnapshots,
          parserFn: _parserFn$Query$AllBackupSnapshots,
        );

  final OnQueryComplete$Query$AllBackupSnapshots? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$AllBackupSnapshots
    extends graphql.WatchQueryOptions<Query$AllBackupSnapshots> {
  WatchOptions$Query$AllBackupSnapshots({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$AllBackupSnapshots? typedOptimisticResult,
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
          document: documentNodeQueryAllBackupSnapshots,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$AllBackupSnapshots,
        );
}

class FetchMoreOptions$Query$AllBackupSnapshots
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$AllBackupSnapshots(
      {required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryAllBackupSnapshots,
        );
}

extension ClientExtension$Query$AllBackupSnapshots on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$AllBackupSnapshots>>
      query$AllBackupSnapshots(
              [Options$Query$AllBackupSnapshots? options]) async =>
          await this.query(options ?? Options$Query$AllBackupSnapshots());
  graphql.ObservableQuery<Query$AllBackupSnapshots>
      watchQuery$AllBackupSnapshots(
              [WatchOptions$Query$AllBackupSnapshots? options]) =>
          this.watchQuery(options ?? WatchOptions$Query$AllBackupSnapshots());
  void writeQuery$AllBackupSnapshots({
    required Query$AllBackupSnapshots data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation: graphql.Operation(
                document: documentNodeQueryAllBackupSnapshots)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$AllBackupSnapshots? readQuery$AllBackupSnapshots(
      {bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryAllBackupSnapshots)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$AllBackupSnapshots.fromJson(result);
  }
}

class Query$AllBackupSnapshots$backup {
  Query$AllBackupSnapshots$backup({
    required this.allSnapshots,
    this.$__typename = 'Backup',
  });

  factory Query$AllBackupSnapshots$backup.fromJson(Map<String, dynamic> json) {
    final l$allSnapshots = json['allSnapshots'];
    final l$$__typename = json['__typename'];
    return Query$AllBackupSnapshots$backup(
      allSnapshots: (l$allSnapshots as List<dynamic>)
          .map((e) => Query$AllBackupSnapshots$backup$allSnapshots.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$AllBackupSnapshots$backup$allSnapshots> allSnapshots;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$allSnapshots = allSnapshots;
    _resultData['allSnapshots'] =
        l$allSnapshots.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$allSnapshots = allSnapshots;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$allSnapshots.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$AllBackupSnapshots$backup) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$allSnapshots = allSnapshots;
    final lOther$allSnapshots = other.allSnapshots;
    if (l$allSnapshots.length != lOther$allSnapshots.length) {
      return false;
    }
    for (int i = 0; i < l$allSnapshots.length; i++) {
      final l$allSnapshots$entry = l$allSnapshots[i];
      final lOther$allSnapshots$entry = lOther$allSnapshots[i];
      if (l$allSnapshots$entry != lOther$allSnapshots$entry) {
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

extension UtilityExtension$Query$AllBackupSnapshots$backup
    on Query$AllBackupSnapshots$backup {
  CopyWith$Query$AllBackupSnapshots$backup<Query$AllBackupSnapshots$backup>
      get copyWith => CopyWith$Query$AllBackupSnapshots$backup(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$AllBackupSnapshots$backup<TRes> {
  factory CopyWith$Query$AllBackupSnapshots$backup(
    Query$AllBackupSnapshots$backup instance,
    TRes Function(Query$AllBackupSnapshots$backup) then,
  ) = _CopyWithImpl$Query$AllBackupSnapshots$backup;

  factory CopyWith$Query$AllBackupSnapshots$backup.stub(TRes res) =
      _CopyWithStubImpl$Query$AllBackupSnapshots$backup;

  TRes call({
    List<Query$AllBackupSnapshots$backup$allSnapshots>? allSnapshots,
    String? $__typename,
  });
  TRes allSnapshots(
      Iterable<Query$AllBackupSnapshots$backup$allSnapshots> Function(
              Iterable<
                  CopyWith$Query$AllBackupSnapshots$backup$allSnapshots<
                      Query$AllBackupSnapshots$backup$allSnapshots>>)
          _fn);
}

class _CopyWithImpl$Query$AllBackupSnapshots$backup<TRes>
    implements CopyWith$Query$AllBackupSnapshots$backup<TRes> {
  _CopyWithImpl$Query$AllBackupSnapshots$backup(
    this._instance,
    this._then,
  );

  final Query$AllBackupSnapshots$backup _instance;

  final TRes Function(Query$AllBackupSnapshots$backup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? allSnapshots = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$AllBackupSnapshots$backup(
        allSnapshots: allSnapshots == _undefined || allSnapshots == null
            ? _instance.allSnapshots
            : (allSnapshots
                as List<Query$AllBackupSnapshots$backup$allSnapshots>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  TRes allSnapshots(
          Iterable<Query$AllBackupSnapshots$backup$allSnapshots> Function(
                  Iterable<
                      CopyWith$Query$AllBackupSnapshots$backup$allSnapshots<
                          Query$AllBackupSnapshots$backup$allSnapshots>>)
              _fn) =>
      call(
          allSnapshots: _fn(_instance.allSnapshots
              .map((e) => CopyWith$Query$AllBackupSnapshots$backup$allSnapshots(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$AllBackupSnapshots$backup<TRes>
    implements CopyWith$Query$AllBackupSnapshots$backup<TRes> {
  _CopyWithStubImpl$Query$AllBackupSnapshots$backup(this._res);

  TRes _res;

  call({
    List<Query$AllBackupSnapshots$backup$allSnapshots>? allSnapshots,
    String? $__typename,
  }) =>
      _res;
  allSnapshots(_fn) => _res;
}

class Query$AllBackupSnapshots$backup$allSnapshots
    implements Fragment$backupSnapshotFields {
  Query$AllBackupSnapshots$backup$allSnapshots({
    required this.id,
    required this.createdAt,
    this.$__typename = 'SnapshotInfo',
    required this.service,
  });

  factory Query$AllBackupSnapshots$backup$allSnapshots.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    final l$service = json['service'];
    return Query$AllBackupSnapshots$backup$allSnapshots(
      id: (l$id as String),
      createdAt: dateTimeFromJson(l$createdAt),
      $__typename: (l$$__typename as String),
      service: Query$AllBackupSnapshots$backup$allSnapshots$service.fromJson(
          (l$service as Map<String, dynamic>)),
    );
  }

  final String id;

  final DateTime createdAt;

  final String $__typename;

  final Query$AllBackupSnapshots$backup$allSnapshots$service service;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = dateTimeToJson(l$createdAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    final l$service = service;
    _resultData['service'] = l$service.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    final l$service = service;
    return Object.hashAll([
      l$id,
      l$createdAt,
      l$$__typename,
      l$service,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$AllBackupSnapshots$backup$allSnapshots) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    final l$service = service;
    final lOther$service = other.service;
    if (l$service != lOther$service) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$AllBackupSnapshots$backup$allSnapshots
    on Query$AllBackupSnapshots$backup$allSnapshots {
  CopyWith$Query$AllBackupSnapshots$backup$allSnapshots<
          Query$AllBackupSnapshots$backup$allSnapshots>
      get copyWith => CopyWith$Query$AllBackupSnapshots$backup$allSnapshots(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$AllBackupSnapshots$backup$allSnapshots<TRes> {
  factory CopyWith$Query$AllBackupSnapshots$backup$allSnapshots(
    Query$AllBackupSnapshots$backup$allSnapshots instance,
    TRes Function(Query$AllBackupSnapshots$backup$allSnapshots) then,
  ) = _CopyWithImpl$Query$AllBackupSnapshots$backup$allSnapshots;

  factory CopyWith$Query$AllBackupSnapshots$backup$allSnapshots.stub(TRes res) =
      _CopyWithStubImpl$Query$AllBackupSnapshots$backup$allSnapshots;

  TRes call({
    String? id,
    DateTime? createdAt,
    String? $__typename,
    Query$AllBackupSnapshots$backup$allSnapshots$service? service,
  });
  CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service<TRes>
      get service;
}

class _CopyWithImpl$Query$AllBackupSnapshots$backup$allSnapshots<TRes>
    implements CopyWith$Query$AllBackupSnapshots$backup$allSnapshots<TRes> {
  _CopyWithImpl$Query$AllBackupSnapshots$backup$allSnapshots(
    this._instance,
    this._then,
  );

  final Query$AllBackupSnapshots$backup$allSnapshots _instance;

  final TRes Function(Query$AllBackupSnapshots$backup$allSnapshots) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? createdAt = _undefined,
    Object? $__typename = _undefined,
    Object? service = _undefined,
  }) =>
      _then(Query$AllBackupSnapshots$backup$allSnapshots(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        createdAt: createdAt == _undefined || createdAt == null
            ? _instance.createdAt
            : (createdAt as DateTime),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
        service: service == _undefined || service == null
            ? _instance.service
            : (service as Query$AllBackupSnapshots$backup$allSnapshots$service),
      ));
  CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service<TRes>
      get service {
    final local$service = _instance.service;
    return CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service(
        local$service, (e) => call(service: e));
  }
}

class _CopyWithStubImpl$Query$AllBackupSnapshots$backup$allSnapshots<TRes>
    implements CopyWith$Query$AllBackupSnapshots$backup$allSnapshots<TRes> {
  _CopyWithStubImpl$Query$AllBackupSnapshots$backup$allSnapshots(this._res);

  TRes _res;

  call({
    String? id,
    DateTime? createdAt,
    String? $__typename,
    Query$AllBackupSnapshots$backup$allSnapshots$service? service,
  }) =>
      _res;
  CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service<TRes>
      get service =>
          CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service.stub(
              _res);
}

class Query$AllBackupSnapshots$backup$allSnapshots$service {
  Query$AllBackupSnapshots$backup$allSnapshots$service({
    required this.displayName,
    required this.id,
    this.$__typename = 'Service',
  });

  factory Query$AllBackupSnapshots$backup$allSnapshots$service.fromJson(
      Map<String, dynamic> json) {
    final l$displayName = json['displayName'];
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return Query$AllBackupSnapshots$backup$allSnapshots$service(
      displayName: (l$displayName as String),
      id: (l$id as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String displayName;

  final String id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$displayName = displayName;
    _resultData['displayName'] = l$displayName;
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$displayName = displayName;
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$displayName,
      l$id,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$AllBackupSnapshots$backup$allSnapshots$service) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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

extension UtilityExtension$Query$AllBackupSnapshots$backup$allSnapshots$service
    on Query$AllBackupSnapshots$backup$allSnapshots$service {
  CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service<
          Query$AllBackupSnapshots$backup$allSnapshots$service>
      get copyWith =>
          CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service<
    TRes> {
  factory CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service(
    Query$AllBackupSnapshots$backup$allSnapshots$service instance,
    TRes Function(Query$AllBackupSnapshots$backup$allSnapshots$service) then,
  ) = _CopyWithImpl$Query$AllBackupSnapshots$backup$allSnapshots$service;

  factory CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service.stub(
          TRes res) =
      _CopyWithStubImpl$Query$AllBackupSnapshots$backup$allSnapshots$service;

  TRes call({
    String? displayName,
    String? id,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$AllBackupSnapshots$backup$allSnapshots$service<TRes>
    implements
        CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service<TRes> {
  _CopyWithImpl$Query$AllBackupSnapshots$backup$allSnapshots$service(
    this._instance,
    this._then,
  );

  final Query$AllBackupSnapshots$backup$allSnapshots$service _instance;

  final TRes Function(Query$AllBackupSnapshots$backup$allSnapshots$service)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? displayName = _undefined,
    Object? id = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$AllBackupSnapshots$backup$allSnapshots$service(
        displayName: displayName == _undefined || displayName == null
            ? _instance.displayName
            : (displayName as String),
        id: id == _undefined || id == null ? _instance.id : (id as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$AllBackupSnapshots$backup$allSnapshots$service<
        TRes>
    implements
        CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service<TRes> {
  _CopyWithStubImpl$Query$AllBackupSnapshots$backup$allSnapshots$service(
      this._res);

  TRes _res;

  call({
    String? displayName,
    String? id,
    String? $__typename,
  }) =>
      _res;
}

class Mutation$ForceSnapshotsReload {
  Mutation$ForceSnapshotsReload({
    required this.forceSnapshotsReload,
    this.$__typename = 'Mutation',
  });

  factory Mutation$ForceSnapshotsReload.fromJson(Map<String, dynamic> json) {
    final l$forceSnapshotsReload = json['forceSnapshotsReload'];
    final l$$__typename = json['__typename'];
    return Mutation$ForceSnapshotsReload(
      forceSnapshotsReload:
          Mutation$ForceSnapshotsReload$forceSnapshotsReload.fromJson(
              (l$forceSnapshotsReload as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ForceSnapshotsReload$forceSnapshotsReload forceSnapshotsReload;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$forceSnapshotsReload = forceSnapshotsReload;
    _resultData['forceSnapshotsReload'] = l$forceSnapshotsReload.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$forceSnapshotsReload = forceSnapshotsReload;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$forceSnapshotsReload,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$ForceSnapshotsReload) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$forceSnapshotsReload = forceSnapshotsReload;
    final lOther$forceSnapshotsReload = other.forceSnapshotsReload;
    if (l$forceSnapshotsReload != lOther$forceSnapshotsReload) {
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

extension UtilityExtension$Mutation$ForceSnapshotsReload
    on Mutation$ForceSnapshotsReload {
  CopyWith$Mutation$ForceSnapshotsReload<Mutation$ForceSnapshotsReload>
      get copyWith => CopyWith$Mutation$ForceSnapshotsReload(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$ForceSnapshotsReload<TRes> {
  factory CopyWith$Mutation$ForceSnapshotsReload(
    Mutation$ForceSnapshotsReload instance,
    TRes Function(Mutation$ForceSnapshotsReload) then,
  ) = _CopyWithImpl$Mutation$ForceSnapshotsReload;

  factory CopyWith$Mutation$ForceSnapshotsReload.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ForceSnapshotsReload;

  TRes call({
    Mutation$ForceSnapshotsReload$forceSnapshotsReload? forceSnapshotsReload,
    String? $__typename,
  });
  CopyWith$Mutation$ForceSnapshotsReload$forceSnapshotsReload<TRes>
      get forceSnapshotsReload;
}

class _CopyWithImpl$Mutation$ForceSnapshotsReload<TRes>
    implements CopyWith$Mutation$ForceSnapshotsReload<TRes> {
  _CopyWithImpl$Mutation$ForceSnapshotsReload(
    this._instance,
    this._then,
  );

  final Mutation$ForceSnapshotsReload _instance;

  final TRes Function(Mutation$ForceSnapshotsReload) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? forceSnapshotsReload = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$ForceSnapshotsReload(
        forceSnapshotsReload:
            forceSnapshotsReload == _undefined || forceSnapshotsReload == null
                ? _instance.forceSnapshotsReload
                : (forceSnapshotsReload
                    as Mutation$ForceSnapshotsReload$forceSnapshotsReload),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$ForceSnapshotsReload$forceSnapshotsReload<TRes>
      get forceSnapshotsReload {
    final local$forceSnapshotsReload = _instance.forceSnapshotsReload;
    return CopyWith$Mutation$ForceSnapshotsReload$forceSnapshotsReload(
        local$forceSnapshotsReload, (e) => call(forceSnapshotsReload: e));
  }
}

class _CopyWithStubImpl$Mutation$ForceSnapshotsReload<TRes>
    implements CopyWith$Mutation$ForceSnapshotsReload<TRes> {
  _CopyWithStubImpl$Mutation$ForceSnapshotsReload(this._res);

  TRes _res;

  call({
    Mutation$ForceSnapshotsReload$forceSnapshotsReload? forceSnapshotsReload,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$ForceSnapshotsReload$forceSnapshotsReload<TRes>
      get forceSnapshotsReload =>
          CopyWith$Mutation$ForceSnapshotsReload$forceSnapshotsReload.stub(
              _res);
}

const documentNodeMutationForceSnapshotsReload = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'ForceSnapshotsReload'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'forceSnapshotsReload'),
        alias: null,
        arguments: [],
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
Mutation$ForceSnapshotsReload _parserFn$Mutation$ForceSnapshotsReload(
        Map<String, dynamic> data) =>
    Mutation$ForceSnapshotsReload.fromJson(data);
typedef OnMutationCompleted$Mutation$ForceSnapshotsReload = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$ForceSnapshotsReload?,
);

class Options$Mutation$ForceSnapshotsReload
    extends graphql.MutationOptions<Mutation$ForceSnapshotsReload> {
  Options$Mutation$ForceSnapshotsReload({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ForceSnapshotsReload? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$ForceSnapshotsReload? onCompleted,
    graphql.OnMutationUpdate<Mutation$ForceSnapshotsReload>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
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
                    data == null
                        ? null
                        : _parserFn$Mutation$ForceSnapshotsReload(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationForceSnapshotsReload,
          parserFn: _parserFn$Mutation$ForceSnapshotsReload,
        );

  final OnMutationCompleted$Mutation$ForceSnapshotsReload?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$ForceSnapshotsReload
    extends graphql.WatchQueryOptions<Mutation$ForceSnapshotsReload> {
  WatchOptions$Mutation$ForceSnapshotsReload({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ForceSnapshotsReload? typedOptimisticResult,
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
          document: documentNodeMutationForceSnapshotsReload,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$ForceSnapshotsReload,
        );
}

extension ClientExtension$Mutation$ForceSnapshotsReload
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ForceSnapshotsReload>>
      mutate$ForceSnapshotsReload(
              [Options$Mutation$ForceSnapshotsReload? options]) async =>
          await this.mutate(options ?? Options$Mutation$ForceSnapshotsReload());
  graphql.ObservableQuery<Mutation$ForceSnapshotsReload>
      watchMutation$ForceSnapshotsReload(
              [WatchOptions$Mutation$ForceSnapshotsReload? options]) =>
          this.watchMutation(
              options ?? WatchOptions$Mutation$ForceSnapshotsReload());
}

class Mutation$ForceSnapshotsReload$forceSnapshotsReload
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$ForceSnapshotsReload$forceSnapshotsReload({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$ForceSnapshotsReload$forceSnapshotsReload.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$ForceSnapshotsReload$forceSnapshotsReload(
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
    if (!(other is Mutation$ForceSnapshotsReload$forceSnapshotsReload) ||
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

extension UtilityExtension$Mutation$ForceSnapshotsReload$forceSnapshotsReload
    on Mutation$ForceSnapshotsReload$forceSnapshotsReload {
  CopyWith$Mutation$ForceSnapshotsReload$forceSnapshotsReload<
          Mutation$ForceSnapshotsReload$forceSnapshotsReload>
      get copyWith =>
          CopyWith$Mutation$ForceSnapshotsReload$forceSnapshotsReload(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$ForceSnapshotsReload$forceSnapshotsReload<
    TRes> {
  factory CopyWith$Mutation$ForceSnapshotsReload$forceSnapshotsReload(
    Mutation$ForceSnapshotsReload$forceSnapshotsReload instance,
    TRes Function(Mutation$ForceSnapshotsReload$forceSnapshotsReload) then,
  ) = _CopyWithImpl$Mutation$ForceSnapshotsReload$forceSnapshotsReload;

  factory CopyWith$Mutation$ForceSnapshotsReload$forceSnapshotsReload.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$ForceSnapshotsReload$forceSnapshotsReload;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$ForceSnapshotsReload$forceSnapshotsReload<TRes>
    implements
        CopyWith$Mutation$ForceSnapshotsReload$forceSnapshotsReload<TRes> {
  _CopyWithImpl$Mutation$ForceSnapshotsReload$forceSnapshotsReload(
    this._instance,
    this._then,
  );

  final Mutation$ForceSnapshotsReload$forceSnapshotsReload _instance;

  final TRes Function(Mutation$ForceSnapshotsReload$forceSnapshotsReload) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$ForceSnapshotsReload$forceSnapshotsReload(
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

class _CopyWithStubImpl$Mutation$ForceSnapshotsReload$forceSnapshotsReload<TRes>
    implements
        CopyWith$Mutation$ForceSnapshotsReload$forceSnapshotsReload<TRes> {
  _CopyWithStubImpl$Mutation$ForceSnapshotsReload$forceSnapshotsReload(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$StartBackup {
  factory Variables$Mutation$StartBackup({String? serviceId}) =>
      Variables$Mutation$StartBackup._({
        if (serviceId != null) r'serviceId': serviceId,
      });

  Variables$Mutation$StartBackup._(this._$data);

  factory Variables$Mutation$StartBackup.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('serviceId')) {
      final l$serviceId = data['serviceId'];
      result$data['serviceId'] = (l$serviceId as String?);
    }
    return Variables$Mutation$StartBackup._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get serviceId => (_$data['serviceId'] as String?);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('serviceId')) {
      final l$serviceId = serviceId;
      result$data['serviceId'] = l$serviceId;
    }
    return result$data;
  }

  CopyWith$Variables$Mutation$StartBackup<Variables$Mutation$StartBackup>
      get copyWith => CopyWith$Variables$Mutation$StartBackup(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$StartBackup) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (_$data.containsKey('serviceId') !=
        other._$data.containsKey('serviceId')) {
      return false;
    }
    if (l$serviceId != lOther$serviceId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$serviceId = serviceId;
    return Object.hashAll(
        [_$data.containsKey('serviceId') ? l$serviceId : const {}]);
  }
}

abstract class CopyWith$Variables$Mutation$StartBackup<TRes> {
  factory CopyWith$Variables$Mutation$StartBackup(
    Variables$Mutation$StartBackup instance,
    TRes Function(Variables$Mutation$StartBackup) then,
  ) = _CopyWithImpl$Variables$Mutation$StartBackup;

  factory CopyWith$Variables$Mutation$StartBackup.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$StartBackup;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$StartBackup<TRes>
    implements CopyWith$Variables$Mutation$StartBackup<TRes> {
  _CopyWithImpl$Variables$Mutation$StartBackup(
    this._instance,
    this._then,
  );

  final Variables$Mutation$StartBackup _instance;

  final TRes Function(Variables$Mutation$StartBackup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? serviceId = _undefined}) =>
      _then(Variables$Mutation$StartBackup._({
        ..._instance._$data,
        if (serviceId != _undefined) 'serviceId': (serviceId as String?),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$StartBackup<TRes>
    implements CopyWith$Variables$Mutation$StartBackup<TRes> {
  _CopyWithStubImpl$Variables$Mutation$StartBackup(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

class Mutation$StartBackup {
  Mutation$StartBackup({
    required this.startBackup,
    this.$__typename = 'Mutation',
  });

  factory Mutation$StartBackup.fromJson(Map<String, dynamic> json) {
    final l$startBackup = json['startBackup'];
    final l$$__typename = json['__typename'];
    return Mutation$StartBackup(
      startBackup: Mutation$StartBackup$startBackup.fromJson(
          (l$startBackup as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$StartBackup$startBackup startBackup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$startBackup = startBackup;
    _resultData['startBackup'] = l$startBackup.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$startBackup = startBackup;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$startBackup,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$StartBackup) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$startBackup = startBackup;
    final lOther$startBackup = other.startBackup;
    if (l$startBackup != lOther$startBackup) {
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

extension UtilityExtension$Mutation$StartBackup on Mutation$StartBackup {
  CopyWith$Mutation$StartBackup<Mutation$StartBackup> get copyWith =>
      CopyWith$Mutation$StartBackup(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$StartBackup<TRes> {
  factory CopyWith$Mutation$StartBackup(
    Mutation$StartBackup instance,
    TRes Function(Mutation$StartBackup) then,
  ) = _CopyWithImpl$Mutation$StartBackup;

  factory CopyWith$Mutation$StartBackup.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StartBackup;

  TRes call({
    Mutation$StartBackup$startBackup? startBackup,
    String? $__typename,
  });
  CopyWith$Mutation$StartBackup$startBackup<TRes> get startBackup;
}

class _CopyWithImpl$Mutation$StartBackup<TRes>
    implements CopyWith$Mutation$StartBackup<TRes> {
  _CopyWithImpl$Mutation$StartBackup(
    this._instance,
    this._then,
  );

  final Mutation$StartBackup _instance;

  final TRes Function(Mutation$StartBackup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? startBackup = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$StartBackup(
        startBackup: startBackup == _undefined || startBackup == null
            ? _instance.startBackup
            : (startBackup as Mutation$StartBackup$startBackup),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$StartBackup$startBackup<TRes> get startBackup {
    final local$startBackup = _instance.startBackup;
    return CopyWith$Mutation$StartBackup$startBackup(
        local$startBackup, (e) => call(startBackup: e));
  }
}

class _CopyWithStubImpl$Mutation$StartBackup<TRes>
    implements CopyWith$Mutation$StartBackup<TRes> {
  _CopyWithStubImpl$Mutation$StartBackup(this._res);

  TRes _res;

  call({
    Mutation$StartBackup$startBackup? startBackup,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$StartBackup$startBackup<TRes> get startBackup =>
      CopyWith$Mutation$StartBackup$startBackup.stub(_res);
}

const documentNodeMutationStartBackup = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'StartBackup'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'serviceId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: NullValueNode()),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'startBackup'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'serviceId'),
            value: VariableNode(name: NameNode(value: 'serviceId')),
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
Mutation$StartBackup _parserFn$Mutation$StartBackup(
        Map<String, dynamic> data) =>
    Mutation$StartBackup.fromJson(data);
typedef OnMutationCompleted$Mutation$StartBackup = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$StartBackup?,
);

class Options$Mutation$StartBackup
    extends graphql.MutationOptions<Mutation$StartBackup> {
  Options$Mutation$StartBackup({
    String? operationName,
    Variables$Mutation$StartBackup? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$StartBackup? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$StartBackup? onCompleted,
    graphql.OnMutationUpdate<Mutation$StartBackup>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables?.toJson() ?? {},
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
                    data == null ? null : _parserFn$Mutation$StartBackup(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationStartBackup,
          parserFn: _parserFn$Mutation$StartBackup,
        );

  final OnMutationCompleted$Mutation$StartBackup? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$StartBackup
    extends graphql.WatchQueryOptions<Mutation$StartBackup> {
  WatchOptions$Mutation$StartBackup({
    String? operationName,
    Variables$Mutation$StartBackup? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$StartBackup? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables?.toJson() ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeMutationStartBackup,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$StartBackup,
        );
}

extension ClientExtension$Mutation$StartBackup on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$StartBackup>> mutate$StartBackup(
          [Options$Mutation$StartBackup? options]) async =>
      await this.mutate(options ?? Options$Mutation$StartBackup());
  graphql.ObservableQuery<Mutation$StartBackup> watchMutation$StartBackup(
          [WatchOptions$Mutation$StartBackup? options]) =>
      this.watchMutation(options ?? WatchOptions$Mutation$StartBackup());
}

class Mutation$StartBackup$startBackup
    implements Fragment$basicMutationReturnFields$$GenericJobMutationReturn {
  Mutation$StartBackup$startBackup({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericJobMutationReturn',
  });

  factory Mutation$StartBackup$startBackup.fromJson(Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$StartBackup$startBackup(
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
    if (!(other is Mutation$StartBackup$startBackup) ||
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

extension UtilityExtension$Mutation$StartBackup$startBackup
    on Mutation$StartBackup$startBackup {
  CopyWith$Mutation$StartBackup$startBackup<Mutation$StartBackup$startBackup>
      get copyWith => CopyWith$Mutation$StartBackup$startBackup(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$StartBackup$startBackup<TRes> {
  factory CopyWith$Mutation$StartBackup$startBackup(
    Mutation$StartBackup$startBackup instance,
    TRes Function(Mutation$StartBackup$startBackup) then,
  ) = _CopyWithImpl$Mutation$StartBackup$startBackup;

  factory CopyWith$Mutation$StartBackup$startBackup.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StartBackup$startBackup;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$StartBackup$startBackup<TRes>
    implements CopyWith$Mutation$StartBackup$startBackup<TRes> {
  _CopyWithImpl$Mutation$StartBackup$startBackup(
    this._instance,
    this._then,
  );

  final Mutation$StartBackup$startBackup _instance;

  final TRes Function(Mutation$StartBackup$startBackup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$StartBackup$startBackup(
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

class _CopyWithStubImpl$Mutation$StartBackup$startBackup<TRes>
    implements CopyWith$Mutation$StartBackup$startBackup<TRes> {
  _CopyWithStubImpl$Mutation$StartBackup$startBackup(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$SetAutobackupPeriod {
  factory Variables$Mutation$SetAutobackupPeriod({int? period}) =>
      Variables$Mutation$SetAutobackupPeriod._({
        if (period != null) r'period': period,
      });

  Variables$Mutation$SetAutobackupPeriod._(this._$data);

  factory Variables$Mutation$SetAutobackupPeriod.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('period')) {
      final l$period = data['period'];
      result$data['period'] = (l$period as int?);
    }
    return Variables$Mutation$SetAutobackupPeriod._(result$data);
  }

  Map<String, dynamic> _$data;

  int? get period => (_$data['period'] as int?);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('period')) {
      final l$period = period;
      result$data['period'] = l$period;
    }
    return result$data;
  }

  CopyWith$Variables$Mutation$SetAutobackupPeriod<
          Variables$Mutation$SetAutobackupPeriod>
      get copyWith => CopyWith$Variables$Mutation$SetAutobackupPeriod(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$SetAutobackupPeriod) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$period = period;
    final lOther$period = other.period;
    if (_$data.containsKey('period') != other._$data.containsKey('period')) {
      return false;
    }
    if (l$period != lOther$period) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$period = period;
    return Object.hashAll([_$data.containsKey('period') ? l$period : const {}]);
  }
}

abstract class CopyWith$Variables$Mutation$SetAutobackupPeriod<TRes> {
  factory CopyWith$Variables$Mutation$SetAutobackupPeriod(
    Variables$Mutation$SetAutobackupPeriod instance,
    TRes Function(Variables$Mutation$SetAutobackupPeriod) then,
  ) = _CopyWithImpl$Variables$Mutation$SetAutobackupPeriod;

  factory CopyWith$Variables$Mutation$SetAutobackupPeriod.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$SetAutobackupPeriod;

  TRes call({int? period});
}

class _CopyWithImpl$Variables$Mutation$SetAutobackupPeriod<TRes>
    implements CopyWith$Variables$Mutation$SetAutobackupPeriod<TRes> {
  _CopyWithImpl$Variables$Mutation$SetAutobackupPeriod(
    this._instance,
    this._then,
  );

  final Variables$Mutation$SetAutobackupPeriod _instance;

  final TRes Function(Variables$Mutation$SetAutobackupPeriod) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? period = _undefined}) =>
      _then(Variables$Mutation$SetAutobackupPeriod._({
        ..._instance._$data,
        if (period != _undefined) 'period': (period as int?),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$SetAutobackupPeriod<TRes>
    implements CopyWith$Variables$Mutation$SetAutobackupPeriod<TRes> {
  _CopyWithStubImpl$Variables$Mutation$SetAutobackupPeriod(this._res);

  TRes _res;

  call({int? period}) => _res;
}

class Mutation$SetAutobackupPeriod {
  Mutation$SetAutobackupPeriod({
    required this.setAutobackupPeriod,
    this.$__typename = 'Mutation',
  });

  factory Mutation$SetAutobackupPeriod.fromJson(Map<String, dynamic> json) {
    final l$setAutobackupPeriod = json['setAutobackupPeriod'];
    final l$$__typename = json['__typename'];
    return Mutation$SetAutobackupPeriod(
      setAutobackupPeriod: Fragment$genericBackupConfigReturn.fromJson(
          (l$setAutobackupPeriod as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$genericBackupConfigReturn setAutobackupPeriod;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$setAutobackupPeriod = setAutobackupPeriod;
    _resultData['setAutobackupPeriod'] = l$setAutobackupPeriod.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$setAutobackupPeriod = setAutobackupPeriod;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$setAutobackupPeriod,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$SetAutobackupPeriod) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$setAutobackupPeriod = setAutobackupPeriod;
    final lOther$setAutobackupPeriod = other.setAutobackupPeriod;
    if (l$setAutobackupPeriod != lOther$setAutobackupPeriod) {
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

extension UtilityExtension$Mutation$SetAutobackupPeriod
    on Mutation$SetAutobackupPeriod {
  CopyWith$Mutation$SetAutobackupPeriod<Mutation$SetAutobackupPeriod>
      get copyWith => CopyWith$Mutation$SetAutobackupPeriod(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$SetAutobackupPeriod<TRes> {
  factory CopyWith$Mutation$SetAutobackupPeriod(
    Mutation$SetAutobackupPeriod instance,
    TRes Function(Mutation$SetAutobackupPeriod) then,
  ) = _CopyWithImpl$Mutation$SetAutobackupPeriod;

  factory CopyWith$Mutation$SetAutobackupPeriod.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SetAutobackupPeriod;

  TRes call({
    Fragment$genericBackupConfigReturn? setAutobackupPeriod,
    String? $__typename,
  });
  CopyWith$Fragment$genericBackupConfigReturn<TRes> get setAutobackupPeriod;
}

class _CopyWithImpl$Mutation$SetAutobackupPeriod<TRes>
    implements CopyWith$Mutation$SetAutobackupPeriod<TRes> {
  _CopyWithImpl$Mutation$SetAutobackupPeriod(
    this._instance,
    this._then,
  );

  final Mutation$SetAutobackupPeriod _instance;

  final TRes Function(Mutation$SetAutobackupPeriod) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? setAutobackupPeriod = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$SetAutobackupPeriod(
        setAutobackupPeriod:
            setAutobackupPeriod == _undefined || setAutobackupPeriod == null
                ? _instance.setAutobackupPeriod
                : (setAutobackupPeriod as Fragment$genericBackupConfigReturn),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Fragment$genericBackupConfigReturn<TRes> get setAutobackupPeriod {
    final local$setAutobackupPeriod = _instance.setAutobackupPeriod;
    return CopyWith$Fragment$genericBackupConfigReturn(
        local$setAutobackupPeriod, (e) => call(setAutobackupPeriod: e));
  }
}

class _CopyWithStubImpl$Mutation$SetAutobackupPeriod<TRes>
    implements CopyWith$Mutation$SetAutobackupPeriod<TRes> {
  _CopyWithStubImpl$Mutation$SetAutobackupPeriod(this._res);

  TRes _res;

  call({
    Fragment$genericBackupConfigReturn? setAutobackupPeriod,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Fragment$genericBackupConfigReturn<TRes> get setAutobackupPeriod =>
      CopyWith$Fragment$genericBackupConfigReturn.stub(_res);
}

const documentNodeMutationSetAutobackupPeriod = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'SetAutobackupPeriod'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'period')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: NullValueNode()),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'setAutobackupPeriod'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'period'),
            value: VariableNode(name: NameNode(value: 'period')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'genericBackupConfigReturn'),
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
  fragmentDefinitiongenericBackupConfigReturn,
]);
Mutation$SetAutobackupPeriod _parserFn$Mutation$SetAutobackupPeriod(
        Map<String, dynamic> data) =>
    Mutation$SetAutobackupPeriod.fromJson(data);
typedef OnMutationCompleted$Mutation$SetAutobackupPeriod = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$SetAutobackupPeriod?,
);

class Options$Mutation$SetAutobackupPeriod
    extends graphql.MutationOptions<Mutation$SetAutobackupPeriod> {
  Options$Mutation$SetAutobackupPeriod({
    String? operationName,
    Variables$Mutation$SetAutobackupPeriod? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$SetAutobackupPeriod? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$SetAutobackupPeriod? onCompleted,
    graphql.OnMutationUpdate<Mutation$SetAutobackupPeriod>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables?.toJson() ?? {},
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
                    data == null
                        ? null
                        : _parserFn$Mutation$SetAutobackupPeriod(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationSetAutobackupPeriod,
          parserFn: _parserFn$Mutation$SetAutobackupPeriod,
        );

  final OnMutationCompleted$Mutation$SetAutobackupPeriod? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$SetAutobackupPeriod
    extends graphql.WatchQueryOptions<Mutation$SetAutobackupPeriod> {
  WatchOptions$Mutation$SetAutobackupPeriod({
    String? operationName,
    Variables$Mutation$SetAutobackupPeriod? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$SetAutobackupPeriod? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables?.toJson() ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeMutationSetAutobackupPeriod,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$SetAutobackupPeriod,
        );
}

extension ClientExtension$Mutation$SetAutobackupPeriod
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$SetAutobackupPeriod>>
      mutate$SetAutobackupPeriod(
              [Options$Mutation$SetAutobackupPeriod? options]) async =>
          await this.mutate(options ?? Options$Mutation$SetAutobackupPeriod());
  graphql.ObservableQuery<Mutation$SetAutobackupPeriod>
      watchMutation$SetAutobackupPeriod(
              [WatchOptions$Mutation$SetAutobackupPeriod? options]) =>
          this.watchMutation(
              options ?? WatchOptions$Mutation$SetAutobackupPeriod());
}

class Mutation$RemoveRepository {
  Mutation$RemoveRepository({
    required this.removeRepository,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RemoveRepository.fromJson(Map<String, dynamic> json) {
    final l$removeRepository = json['removeRepository'];
    final l$$__typename = json['__typename'];
    return Mutation$RemoveRepository(
      removeRepository: Fragment$genericBackupConfigReturn.fromJson(
          (l$removeRepository as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$genericBackupConfigReturn removeRepository;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$removeRepository = removeRepository;
    _resultData['removeRepository'] = l$removeRepository.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$removeRepository = removeRepository;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$removeRepository,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RemoveRepository) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$removeRepository = removeRepository;
    final lOther$removeRepository = other.removeRepository;
    if (l$removeRepository != lOther$removeRepository) {
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

extension UtilityExtension$Mutation$RemoveRepository
    on Mutation$RemoveRepository {
  CopyWith$Mutation$RemoveRepository<Mutation$RemoveRepository> get copyWith =>
      CopyWith$Mutation$RemoveRepository(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$RemoveRepository<TRes> {
  factory CopyWith$Mutation$RemoveRepository(
    Mutation$RemoveRepository instance,
    TRes Function(Mutation$RemoveRepository) then,
  ) = _CopyWithImpl$Mutation$RemoveRepository;

  factory CopyWith$Mutation$RemoveRepository.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RemoveRepository;

  TRes call({
    Fragment$genericBackupConfigReturn? removeRepository,
    String? $__typename,
  });
  CopyWith$Fragment$genericBackupConfigReturn<TRes> get removeRepository;
}

class _CopyWithImpl$Mutation$RemoveRepository<TRes>
    implements CopyWith$Mutation$RemoveRepository<TRes> {
  _CopyWithImpl$Mutation$RemoveRepository(
    this._instance,
    this._then,
  );

  final Mutation$RemoveRepository _instance;

  final TRes Function(Mutation$RemoveRepository) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? removeRepository = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RemoveRepository(
        removeRepository:
            removeRepository == _undefined || removeRepository == null
                ? _instance.removeRepository
                : (removeRepository as Fragment$genericBackupConfigReturn),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Fragment$genericBackupConfigReturn<TRes> get removeRepository {
    final local$removeRepository = _instance.removeRepository;
    return CopyWith$Fragment$genericBackupConfigReturn(
        local$removeRepository, (e) => call(removeRepository: e));
  }
}

class _CopyWithStubImpl$Mutation$RemoveRepository<TRes>
    implements CopyWith$Mutation$RemoveRepository<TRes> {
  _CopyWithStubImpl$Mutation$RemoveRepository(this._res);

  TRes _res;

  call({
    Fragment$genericBackupConfigReturn? removeRepository,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Fragment$genericBackupConfigReturn<TRes> get removeRepository =>
      CopyWith$Fragment$genericBackupConfigReturn.stub(_res);
}

const documentNodeMutationRemoveRepository = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'RemoveRepository'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'removeRepository'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'genericBackupConfigReturn'),
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
  fragmentDefinitiongenericBackupConfigReturn,
]);
Mutation$RemoveRepository _parserFn$Mutation$RemoveRepository(
        Map<String, dynamic> data) =>
    Mutation$RemoveRepository.fromJson(data);
typedef OnMutationCompleted$Mutation$RemoveRepository = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$RemoveRepository?,
);

class Options$Mutation$RemoveRepository
    extends graphql.MutationOptions<Mutation$RemoveRepository> {
  Options$Mutation$RemoveRepository({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RemoveRepository? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$RemoveRepository? onCompleted,
    graphql.OnMutationUpdate<Mutation$RemoveRepository>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
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
                    data == null
                        ? null
                        : _parserFn$Mutation$RemoveRepository(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationRemoveRepository,
          parserFn: _parserFn$Mutation$RemoveRepository,
        );

  final OnMutationCompleted$Mutation$RemoveRepository? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$RemoveRepository
    extends graphql.WatchQueryOptions<Mutation$RemoveRepository> {
  WatchOptions$Mutation$RemoveRepository({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RemoveRepository? typedOptimisticResult,
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
          document: documentNodeMutationRemoveRepository,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$RemoveRepository,
        );
}

extension ClientExtension$Mutation$RemoveRepository on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RemoveRepository>>
      mutate$RemoveRepository(
              [Options$Mutation$RemoveRepository? options]) async =>
          await this.mutate(options ?? Options$Mutation$RemoveRepository());
  graphql.ObservableQuery<
      Mutation$RemoveRepository> watchMutation$RemoveRepository(
          [WatchOptions$Mutation$RemoveRepository? options]) =>
      this.watchMutation(options ?? WatchOptions$Mutation$RemoveRepository());
}

class Variables$Mutation$InitializeRepository {
  factory Variables$Mutation$InitializeRepository(
          {required Input$InitializeRepositoryInput repository}) =>
      Variables$Mutation$InitializeRepository._({
        r'repository': repository,
      });

  Variables$Mutation$InitializeRepository._(this._$data);

  factory Variables$Mutation$InitializeRepository.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$repository = data['repository'];
    result$data['repository'] = Input$InitializeRepositoryInput.fromJson(
        (l$repository as Map<String, dynamic>));
    return Variables$Mutation$InitializeRepository._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$InitializeRepositoryInput get repository =>
      (_$data['repository'] as Input$InitializeRepositoryInput);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$repository = repository;
    result$data['repository'] = l$repository.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$InitializeRepository<
          Variables$Mutation$InitializeRepository>
      get copyWith => CopyWith$Variables$Mutation$InitializeRepository(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$InitializeRepository) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$repository = repository;
    final lOther$repository = other.repository;
    if (l$repository != lOther$repository) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$repository = repository;
    return Object.hashAll([l$repository]);
  }
}

abstract class CopyWith$Variables$Mutation$InitializeRepository<TRes> {
  factory CopyWith$Variables$Mutation$InitializeRepository(
    Variables$Mutation$InitializeRepository instance,
    TRes Function(Variables$Mutation$InitializeRepository) then,
  ) = _CopyWithImpl$Variables$Mutation$InitializeRepository;

  factory CopyWith$Variables$Mutation$InitializeRepository.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$InitializeRepository;

  TRes call({Input$InitializeRepositoryInput? repository});
}

class _CopyWithImpl$Variables$Mutation$InitializeRepository<TRes>
    implements CopyWith$Variables$Mutation$InitializeRepository<TRes> {
  _CopyWithImpl$Variables$Mutation$InitializeRepository(
    this._instance,
    this._then,
  );

  final Variables$Mutation$InitializeRepository _instance;

  final TRes Function(Variables$Mutation$InitializeRepository) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? repository = _undefined}) =>
      _then(Variables$Mutation$InitializeRepository._({
        ..._instance._$data,
        if (repository != _undefined && repository != null)
          'repository': (repository as Input$InitializeRepositoryInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$InitializeRepository<TRes>
    implements CopyWith$Variables$Mutation$InitializeRepository<TRes> {
  _CopyWithStubImpl$Variables$Mutation$InitializeRepository(this._res);

  TRes _res;

  call({Input$InitializeRepositoryInput? repository}) => _res;
}

class Mutation$InitializeRepository {
  Mutation$InitializeRepository({
    required this.initializeRepository,
    this.$__typename = 'Mutation',
  });

  factory Mutation$InitializeRepository.fromJson(Map<String, dynamic> json) {
    final l$initializeRepository = json['initializeRepository'];
    final l$$__typename = json['__typename'];
    return Mutation$InitializeRepository(
      initializeRepository: Fragment$genericBackupConfigReturn.fromJson(
          (l$initializeRepository as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$genericBackupConfigReturn initializeRepository;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$initializeRepository = initializeRepository;
    _resultData['initializeRepository'] = l$initializeRepository.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$initializeRepository = initializeRepository;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$initializeRepository,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$InitializeRepository) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$initializeRepository = initializeRepository;
    final lOther$initializeRepository = other.initializeRepository;
    if (l$initializeRepository != lOther$initializeRepository) {
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

extension UtilityExtension$Mutation$InitializeRepository
    on Mutation$InitializeRepository {
  CopyWith$Mutation$InitializeRepository<Mutation$InitializeRepository>
      get copyWith => CopyWith$Mutation$InitializeRepository(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$InitializeRepository<TRes> {
  factory CopyWith$Mutation$InitializeRepository(
    Mutation$InitializeRepository instance,
    TRes Function(Mutation$InitializeRepository) then,
  ) = _CopyWithImpl$Mutation$InitializeRepository;

  factory CopyWith$Mutation$InitializeRepository.stub(TRes res) =
      _CopyWithStubImpl$Mutation$InitializeRepository;

  TRes call({
    Fragment$genericBackupConfigReturn? initializeRepository,
    String? $__typename,
  });
  CopyWith$Fragment$genericBackupConfigReturn<TRes> get initializeRepository;
}

class _CopyWithImpl$Mutation$InitializeRepository<TRes>
    implements CopyWith$Mutation$InitializeRepository<TRes> {
  _CopyWithImpl$Mutation$InitializeRepository(
    this._instance,
    this._then,
  );

  final Mutation$InitializeRepository _instance;

  final TRes Function(Mutation$InitializeRepository) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? initializeRepository = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$InitializeRepository(
        initializeRepository:
            initializeRepository == _undefined || initializeRepository == null
                ? _instance.initializeRepository
                : (initializeRepository as Fragment$genericBackupConfigReturn),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Fragment$genericBackupConfigReturn<TRes> get initializeRepository {
    final local$initializeRepository = _instance.initializeRepository;
    return CopyWith$Fragment$genericBackupConfigReturn(
        local$initializeRepository, (e) => call(initializeRepository: e));
  }
}

class _CopyWithStubImpl$Mutation$InitializeRepository<TRes>
    implements CopyWith$Mutation$InitializeRepository<TRes> {
  _CopyWithStubImpl$Mutation$InitializeRepository(this._res);

  TRes _res;

  call({
    Fragment$genericBackupConfigReturn? initializeRepository,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Fragment$genericBackupConfigReturn<TRes> get initializeRepository =>
      CopyWith$Fragment$genericBackupConfigReturn.stub(_res);
}

const documentNodeMutationInitializeRepository = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'InitializeRepository'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'repository')),
        type: NamedTypeNode(
          name: NameNode(value: 'InitializeRepositoryInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'initializeRepository'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'repository'),
            value: VariableNode(name: NameNode(value: 'repository')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'genericBackupConfigReturn'),
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
  fragmentDefinitiongenericBackupConfigReturn,
]);
Mutation$InitializeRepository _parserFn$Mutation$InitializeRepository(
        Map<String, dynamic> data) =>
    Mutation$InitializeRepository.fromJson(data);
typedef OnMutationCompleted$Mutation$InitializeRepository = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$InitializeRepository?,
);

class Options$Mutation$InitializeRepository
    extends graphql.MutationOptions<Mutation$InitializeRepository> {
  Options$Mutation$InitializeRepository({
    String? operationName,
    required Variables$Mutation$InitializeRepository variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$InitializeRepository? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$InitializeRepository? onCompleted,
    graphql.OnMutationUpdate<Mutation$InitializeRepository>? update,
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
                    data == null
                        ? null
                        : _parserFn$Mutation$InitializeRepository(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationInitializeRepository,
          parserFn: _parserFn$Mutation$InitializeRepository,
        );

  final OnMutationCompleted$Mutation$InitializeRepository?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$InitializeRepository
    extends graphql.WatchQueryOptions<Mutation$InitializeRepository> {
  WatchOptions$Mutation$InitializeRepository({
    String? operationName,
    required Variables$Mutation$InitializeRepository variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$InitializeRepository? typedOptimisticResult,
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
          document: documentNodeMutationInitializeRepository,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$InitializeRepository,
        );
}

extension ClientExtension$Mutation$InitializeRepository
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$InitializeRepository>>
      mutate$InitializeRepository(
              Options$Mutation$InitializeRepository options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$InitializeRepository>
      watchMutation$InitializeRepository(
              WatchOptions$Mutation$InitializeRepository options) =>
          this.watchMutation(options);
}
