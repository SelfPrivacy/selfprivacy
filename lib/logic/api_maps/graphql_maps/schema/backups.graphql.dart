import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:selfprivacy/utils/scalars.dart';
import 'schema.graphql.dart';

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
