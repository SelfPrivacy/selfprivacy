import 'dart:async';
import 'disk_volumes.graphql.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:json_annotation/json_annotation.dart';
import 'schema.graphql.dart';
part 'server_settings.graphql.g.dart';

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
class Query$SystemSettings {
  Query$SystemSettings({required this.system, required this.$__typename});

  @override
  factory Query$SystemSettings.fromJson(Map<String, dynamic> json) =>
      _$Query$SystemSettingsFromJson(json);

  final Query$SystemSettings$system system;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$SystemSettingsToJson(this);
  int get hashCode {
    final l$system = system;
    final l$$__typename = $__typename;
    return Object.hashAll([l$system, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$SystemSettings) || runtimeType != other.runtimeType)
      return false;
    final l$system = system;
    final lOther$system = other.system;
    if (l$system != lOther$system) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$SystemSettings on Query$SystemSettings {
  CopyWith$Query$SystemSettings<Query$SystemSettings> get copyWith =>
      CopyWith$Query$SystemSettings(this, (i) => i);
}

abstract class CopyWith$Query$SystemSettings<TRes> {
  factory CopyWith$Query$SystemSettings(Query$SystemSettings instance,
          TRes Function(Query$SystemSettings) then) =
      _CopyWithImpl$Query$SystemSettings;

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

  static const _undefined = {};

  TRes call({Object? system = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$SystemSettings(
          system: system == _undefined || system == null
              ? _instance.system
              : (system as Query$SystemSettings$system),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Query$SystemSettings$system<TRes> get system {
    final local$system = _instance.system;
    return CopyWith$Query$SystemSettings$system(
        local$system, (e) => call(system: e));
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

const documentNodeQuerySystemSettings = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SystemSettings'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'system'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'settings'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'autoUpgrade'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'allowReboot'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'enable'),
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
                        name: NameNode(value: 'ssh'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'enable'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'passwordAuthentication'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'rootSshKeys'),
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
                        name: NameNode(value: 'timezone'),
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
Query$SystemSettings _parserFn$Query$SystemSettings(
        Map<String, dynamic> data) =>
    Query$SystemSettings.fromJson(data);

class Options$Query$SystemSettings
    extends graphql.QueryOptions<Query$SystemSettings> {
  Options$Query$SystemSettings(
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
            document: documentNodeQuerySystemSettings,
            parserFn: _parserFn$Query$SystemSettings);
}

class WatchOptions$Query$SystemSettings
    extends graphql.WatchQueryOptions<Query$SystemSettings> {
  WatchOptions$Query$SystemSettings(
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
            document: documentNodeQuerySystemSettings,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Query$SystemSettings);
}

class FetchMoreOptions$Query$SystemSettings extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$SystemSettings(
      {required graphql.UpdateQuery updateQuery})
      : super(
            updateQuery: updateQuery,
            document: documentNodeQuerySystemSettings);
}

extension ClientExtension$Query$SystemSettings on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$SystemSettings>> query$SystemSettings(
          [Options$Query$SystemSettings? options]) async =>
      await this.query(options ?? Options$Query$SystemSettings());
  graphql.ObservableQuery<Query$SystemSettings> watchQuery$SystemSettings(
          [WatchOptions$Query$SystemSettings? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$SystemSettings());
  void writeQuery$SystemSettings(
          {required Query$SystemSettings data, bool broadcast = true}) =>
      this.writeQuery(
          graphql.Request(
              operation:
                  graphql.Operation(document: documentNodeQuerySystemSettings)),
          data: data.toJson(),
          broadcast: broadcast);
  Query$SystemSettings? readQuery$SystemSettings({bool optimistic = true}) {
    final result = this.readQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQuerySystemSettings)),
        optimistic: optimistic);
    return result == null ? null : Query$SystemSettings.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Query$SystemSettings$system {
  Query$SystemSettings$system(
      {required this.settings, required this.$__typename});

  @override
  factory Query$SystemSettings$system.fromJson(Map<String, dynamic> json) =>
      _$Query$SystemSettings$systemFromJson(json);

  final Query$SystemSettings$system$settings settings;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$SystemSettings$systemToJson(this);
  int get hashCode {
    final l$settings = settings;
    final l$$__typename = $__typename;
    return Object.hashAll([l$settings, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$SystemSettings$system) ||
        runtimeType != other.runtimeType) return false;
    final l$settings = settings;
    final lOther$settings = other.settings;
    if (l$settings != lOther$settings) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
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
          TRes Function(Query$SystemSettings$system) then) =
      _CopyWithImpl$Query$SystemSettings$system;

  factory CopyWith$Query$SystemSettings$system.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemSettings$system;

  TRes call(
      {Query$SystemSettings$system$settings? settings, String? $__typename});
  CopyWith$Query$SystemSettings$system$settings<TRes> get settings;
}

class _CopyWithImpl$Query$SystemSettings$system<TRes>
    implements CopyWith$Query$SystemSettings$system<TRes> {
  _CopyWithImpl$Query$SystemSettings$system(this._instance, this._then);

  final Query$SystemSettings$system _instance;

  final TRes Function(Query$SystemSettings$system) _then;

  static const _undefined = {};

  TRes call(
          {Object? settings = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$SystemSettings$system(
          settings: settings == _undefined || settings == null
              ? _instance.settings
              : (settings as Query$SystemSettings$system$settings),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Query$SystemSettings$system$settings<TRes> get settings {
    final local$settings = _instance.settings;
    return CopyWith$Query$SystemSettings$system$settings(
        local$settings, (e) => call(settings: e));
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

@JsonSerializable(explicitToJson: true)
class Query$SystemSettings$system$settings {
  Query$SystemSettings$system$settings(
      {required this.autoUpgrade,
      required this.ssh,
      required this.timezone,
      required this.$__typename});

  @override
  factory Query$SystemSettings$system$settings.fromJson(
          Map<String, dynamic> json) =>
      _$Query$SystemSettings$system$settingsFromJson(json);

  final Query$SystemSettings$system$settings$autoUpgrade autoUpgrade;

  final Query$SystemSettings$system$settings$ssh ssh;

  final String timezone;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$SystemSettings$system$settingsToJson(this);
  int get hashCode {
    final l$autoUpgrade = autoUpgrade;
    final l$ssh = ssh;
    final l$timezone = timezone;
    final l$$__typename = $__typename;
    return Object.hashAll([l$autoUpgrade, l$ssh, l$timezone, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$SystemSettings$system$settings) ||
        runtimeType != other.runtimeType) return false;
    final l$autoUpgrade = autoUpgrade;
    final lOther$autoUpgrade = other.autoUpgrade;
    if (l$autoUpgrade != lOther$autoUpgrade) return false;
    final l$ssh = ssh;
    final lOther$ssh = other.ssh;
    if (l$ssh != lOther$ssh) return false;
    final l$timezone = timezone;
    final lOther$timezone = other.timezone;
    if (l$timezone != lOther$timezone) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$SystemSettings$system$settings
    on Query$SystemSettings$system$settings {
  CopyWith$Query$SystemSettings$system$settings<
          Query$SystemSettings$system$settings>
      get copyWith =>
          CopyWith$Query$SystemSettings$system$settings(this, (i) => i);
}

abstract class CopyWith$Query$SystemSettings$system$settings<TRes> {
  factory CopyWith$Query$SystemSettings$system$settings(
          Query$SystemSettings$system$settings instance,
          TRes Function(Query$SystemSettings$system$settings) then) =
      _CopyWithImpl$Query$SystemSettings$system$settings;

  factory CopyWith$Query$SystemSettings$system$settings.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemSettings$system$settings;

  TRes call(
      {Query$SystemSettings$system$settings$autoUpgrade? autoUpgrade,
      Query$SystemSettings$system$settings$ssh? ssh,
      String? timezone,
      String? $__typename});
  CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes>
      get autoUpgrade;
  CopyWith$Query$SystemSettings$system$settings$ssh<TRes> get ssh;
}

class _CopyWithImpl$Query$SystemSettings$system$settings<TRes>
    implements CopyWith$Query$SystemSettings$system$settings<TRes> {
  _CopyWithImpl$Query$SystemSettings$system$settings(
      this._instance, this._then);

  final Query$SystemSettings$system$settings _instance;

  final TRes Function(Query$SystemSettings$system$settings) _then;

  static const _undefined = {};

  TRes call(
          {Object? autoUpgrade = _undefined,
          Object? ssh = _undefined,
          Object? timezone = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$SystemSettings$system$settings(
          autoUpgrade: autoUpgrade == _undefined || autoUpgrade == null
              ? _instance.autoUpgrade
              : (autoUpgrade
                  as Query$SystemSettings$system$settings$autoUpgrade),
          ssh: ssh == _undefined || ssh == null
              ? _instance.ssh
              : (ssh as Query$SystemSettings$system$settings$ssh),
          timezone: timezone == _undefined || timezone == null
              ? _instance.timezone
              : (timezone as String),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes>
      get autoUpgrade {
    final local$autoUpgrade = _instance.autoUpgrade;
    return CopyWith$Query$SystemSettings$system$settings$autoUpgrade(
        local$autoUpgrade, (e) => call(autoUpgrade: e));
  }

  CopyWith$Query$SystemSettings$system$settings$ssh<TRes> get ssh {
    final local$ssh = _instance.ssh;
    return CopyWith$Query$SystemSettings$system$settings$ssh(
        local$ssh, (e) => call(ssh: e));
  }
}

class _CopyWithStubImpl$Query$SystemSettings$system$settings<TRes>
    implements CopyWith$Query$SystemSettings$system$settings<TRes> {
  _CopyWithStubImpl$Query$SystemSettings$system$settings(this._res);

  TRes _res;

  call(
          {Query$SystemSettings$system$settings$autoUpgrade? autoUpgrade,
          Query$SystemSettings$system$settings$ssh? ssh,
          String? timezone,
          String? $__typename}) =>
      _res;
  CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes>
      get autoUpgrade =>
          CopyWith$Query$SystemSettings$system$settings$autoUpgrade.stub(_res);
  CopyWith$Query$SystemSettings$system$settings$ssh<TRes> get ssh =>
      CopyWith$Query$SystemSettings$system$settings$ssh.stub(_res);
}

@JsonSerializable(explicitToJson: true)
class Query$SystemSettings$system$settings$autoUpgrade {
  Query$SystemSettings$system$settings$autoUpgrade(
      {required this.allowReboot,
      required this.enable,
      required this.$__typename});

  @override
  factory Query$SystemSettings$system$settings$autoUpgrade.fromJson(
          Map<String, dynamic> json) =>
      _$Query$SystemSettings$system$settings$autoUpgradeFromJson(json);

  final bool allowReboot;

  final bool enable;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$SystemSettings$system$settings$autoUpgradeToJson(this);
  int get hashCode {
    final l$allowReboot = allowReboot;
    final l$enable = enable;
    final l$$__typename = $__typename;
    return Object.hashAll([l$allowReboot, l$enable, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$SystemSettings$system$settings$autoUpgrade) ||
        runtimeType != other.runtimeType) return false;
    final l$allowReboot = allowReboot;
    final lOther$allowReboot = other.allowReboot;
    if (l$allowReboot != lOther$allowReboot) return false;
    final l$enable = enable;
    final lOther$enable = other.enable;
    if (l$enable != lOther$enable) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$SystemSettings$system$settings$autoUpgrade
    on Query$SystemSettings$system$settings$autoUpgrade {
  CopyWith$Query$SystemSettings$system$settings$autoUpgrade<
          Query$SystemSettings$system$settings$autoUpgrade>
      get copyWith => CopyWith$Query$SystemSettings$system$settings$autoUpgrade(
          this, (i) => i);
}

abstract class CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes> {
  factory CopyWith$Query$SystemSettings$system$settings$autoUpgrade(
          Query$SystemSettings$system$settings$autoUpgrade instance,
          TRes Function(Query$SystemSettings$system$settings$autoUpgrade)
              then) =
      _CopyWithImpl$Query$SystemSettings$system$settings$autoUpgrade;

  factory CopyWith$Query$SystemSettings$system$settings$autoUpgrade.stub(
          TRes res) =
      _CopyWithStubImpl$Query$SystemSettings$system$settings$autoUpgrade;

  TRes call({bool? allowReboot, bool? enable, String? $__typename});
}

class _CopyWithImpl$Query$SystemSettings$system$settings$autoUpgrade<TRes>
    implements CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes> {
  _CopyWithImpl$Query$SystemSettings$system$settings$autoUpgrade(
      this._instance, this._then);

  final Query$SystemSettings$system$settings$autoUpgrade _instance;

  final TRes Function(Query$SystemSettings$system$settings$autoUpgrade) _then;

  static const _undefined = {};

  TRes call(
          {Object? allowReboot = _undefined,
          Object? enable = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$SystemSettings$system$settings$autoUpgrade(
          allowReboot: allowReboot == _undefined || allowReboot == null
              ? _instance.allowReboot
              : (allowReboot as bool),
          enable: enable == _undefined || enable == null
              ? _instance.enable
              : (enable as bool),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
}

class _CopyWithStubImpl$Query$SystemSettings$system$settings$autoUpgrade<TRes>
    implements CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes> {
  _CopyWithStubImpl$Query$SystemSettings$system$settings$autoUpgrade(this._res);

  TRes _res;

  call({bool? allowReboot, bool? enable, String? $__typename}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Query$SystemSettings$system$settings$ssh {
  Query$SystemSettings$system$settings$ssh(
      {required this.enable,
      required this.passwordAuthentication,
      required this.rootSshKeys,
      required this.$__typename});

  @override
  factory Query$SystemSettings$system$settings$ssh.fromJson(
          Map<String, dynamic> json) =>
      _$Query$SystemSettings$system$settings$sshFromJson(json);

  final bool enable;

  final bool passwordAuthentication;

  final List<String> rootSshKeys;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$SystemSettings$system$settings$sshToJson(this);
  int get hashCode {
    final l$enable = enable;
    final l$passwordAuthentication = passwordAuthentication;
    final l$rootSshKeys = rootSshKeys;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$enable,
      l$passwordAuthentication,
      Object.hashAll(l$rootSshKeys.map((v) => v)),
      l$$__typename
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$SystemSettings$system$settings$ssh) ||
        runtimeType != other.runtimeType) return false;
    final l$enable = enable;
    final lOther$enable = other.enable;
    if (l$enable != lOther$enable) return false;
    final l$passwordAuthentication = passwordAuthentication;
    final lOther$passwordAuthentication = other.passwordAuthentication;
    if (l$passwordAuthentication != lOther$passwordAuthentication) return false;
    final l$rootSshKeys = rootSshKeys;
    final lOther$rootSshKeys = other.rootSshKeys;
    if (l$rootSshKeys.length != lOther$rootSshKeys.length) return false;
    for (int i = 0; i < l$rootSshKeys.length; i++) {
      final l$rootSshKeys$entry = l$rootSshKeys[i];
      final lOther$rootSshKeys$entry = lOther$rootSshKeys[i];
      if (l$rootSshKeys$entry != lOther$rootSshKeys$entry) return false;
    }

    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$SystemSettings$system$settings$ssh
    on Query$SystemSettings$system$settings$ssh {
  CopyWith$Query$SystemSettings$system$settings$ssh<
          Query$SystemSettings$system$settings$ssh>
      get copyWith =>
          CopyWith$Query$SystemSettings$system$settings$ssh(this, (i) => i);
}

abstract class CopyWith$Query$SystemSettings$system$settings$ssh<TRes> {
  factory CopyWith$Query$SystemSettings$system$settings$ssh(
          Query$SystemSettings$system$settings$ssh instance,
          TRes Function(Query$SystemSettings$system$settings$ssh) then) =
      _CopyWithImpl$Query$SystemSettings$system$settings$ssh;

  factory CopyWith$Query$SystemSettings$system$settings$ssh.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemSettings$system$settings$ssh;

  TRes call(
      {bool? enable,
      bool? passwordAuthentication,
      List<String>? rootSshKeys,
      String? $__typename});
}

class _CopyWithImpl$Query$SystemSettings$system$settings$ssh<TRes>
    implements CopyWith$Query$SystemSettings$system$settings$ssh<TRes> {
  _CopyWithImpl$Query$SystemSettings$system$settings$ssh(
      this._instance, this._then);

  final Query$SystemSettings$system$settings$ssh _instance;

  final TRes Function(Query$SystemSettings$system$settings$ssh) _then;

  static const _undefined = {};

  TRes call(
          {Object? enable = _undefined,
          Object? passwordAuthentication = _undefined,
          Object? rootSshKeys = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$SystemSettings$system$settings$ssh(
          enable: enable == _undefined || enable == null
              ? _instance.enable
              : (enable as bool),
          passwordAuthentication: passwordAuthentication == _undefined ||
                  passwordAuthentication == null
              ? _instance.passwordAuthentication
              : (passwordAuthentication as bool),
          rootSshKeys: rootSshKeys == _undefined || rootSshKeys == null
              ? _instance.rootSshKeys
              : (rootSshKeys as List<String>),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
}

class _CopyWithStubImpl$Query$SystemSettings$system$settings$ssh<TRes>
    implements CopyWith$Query$SystemSettings$system$settings$ssh<TRes> {
  _CopyWithStubImpl$Query$SystemSettings$system$settings$ssh(this._res);

  TRes _res;

  call(
          {bool? enable,
          bool? passwordAuthentication,
          List<String>? rootSshKeys,
          String? $__typename}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Query$SystemIsUsingBinds {
  Query$SystemIsUsingBinds({required this.system, required this.$__typename});

  @override
  factory Query$SystemIsUsingBinds.fromJson(Map<String, dynamic> json) =>
      _$Query$SystemIsUsingBindsFromJson(json);

  final Query$SystemIsUsingBinds$system system;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$SystemIsUsingBindsToJson(this);
  int get hashCode {
    final l$system = system;
    final l$$__typename = $__typename;
    return Object.hashAll([l$system, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$SystemIsUsingBinds) ||
        runtimeType != other.runtimeType) return false;
    final l$system = system;
    final lOther$system = other.system;
    if (l$system != lOther$system) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$SystemIsUsingBinds
    on Query$SystemIsUsingBinds {
  CopyWith$Query$SystemIsUsingBinds<Query$SystemIsUsingBinds> get copyWith =>
      CopyWith$Query$SystemIsUsingBinds(this, (i) => i);
}

abstract class CopyWith$Query$SystemIsUsingBinds<TRes> {
  factory CopyWith$Query$SystemIsUsingBinds(Query$SystemIsUsingBinds instance,
          TRes Function(Query$SystemIsUsingBinds) then) =
      _CopyWithImpl$Query$SystemIsUsingBinds;

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

  static const _undefined = {};

  TRes call({Object? system = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$SystemIsUsingBinds(
          system: system == _undefined || system == null
              ? _instance.system
              : (system as Query$SystemIsUsingBinds$system),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Query$SystemIsUsingBinds$system<TRes> get system {
    final local$system = _instance.system;
    return CopyWith$Query$SystemIsUsingBinds$system(
        local$system, (e) => call(system: e));
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

const documentNodeQuerySystemIsUsingBinds = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SystemIsUsingBinds'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'system'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'info'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'usingBinds'),
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
Query$SystemIsUsingBinds _parserFn$Query$SystemIsUsingBinds(
        Map<String, dynamic> data) =>
    Query$SystemIsUsingBinds.fromJson(data);

class Options$Query$SystemIsUsingBinds
    extends graphql.QueryOptions<Query$SystemIsUsingBinds> {
  Options$Query$SystemIsUsingBinds(
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
            document: documentNodeQuerySystemIsUsingBinds,
            parserFn: _parserFn$Query$SystemIsUsingBinds);
}

class WatchOptions$Query$SystemIsUsingBinds
    extends graphql.WatchQueryOptions<Query$SystemIsUsingBinds> {
  WatchOptions$Query$SystemIsUsingBinds(
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
            document: documentNodeQuerySystemIsUsingBinds,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Query$SystemIsUsingBinds);
}

class FetchMoreOptions$Query$SystemIsUsingBinds
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$SystemIsUsingBinds(
      {required graphql.UpdateQuery updateQuery})
      : super(
            updateQuery: updateQuery,
            document: documentNodeQuerySystemIsUsingBinds);
}

extension ClientExtension$Query$SystemIsUsingBinds on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$SystemIsUsingBinds>>
      query$SystemIsUsingBinds(
              [Options$Query$SystemIsUsingBinds? options]) async =>
          await this.query(options ?? Options$Query$SystemIsUsingBinds());
  graphql.ObservableQuery<Query$SystemIsUsingBinds>
      watchQuery$SystemIsUsingBinds(
              [WatchOptions$Query$SystemIsUsingBinds? options]) =>
          this.watchQuery(options ?? WatchOptions$Query$SystemIsUsingBinds());
  void writeQuery$SystemIsUsingBinds(
          {required Query$SystemIsUsingBinds data, bool broadcast = true}) =>
      this.writeQuery(
          graphql.Request(
              operation: graphql.Operation(
                  document: documentNodeQuerySystemIsUsingBinds)),
          data: data.toJson(),
          broadcast: broadcast);
  Query$SystemIsUsingBinds? readQuery$SystemIsUsingBinds(
      {bool optimistic = true}) {
    final result = this.readQuery(
        graphql.Request(
            operation: graphql.Operation(
                document: documentNodeQuerySystemIsUsingBinds)),
        optimistic: optimistic);
    return result == null ? null : Query$SystemIsUsingBinds.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Query$SystemIsUsingBinds$system {
  Query$SystemIsUsingBinds$system(
      {required this.info, required this.$__typename});

  @override
  factory Query$SystemIsUsingBinds$system.fromJson(Map<String, dynamic> json) =>
      _$Query$SystemIsUsingBinds$systemFromJson(json);

  final Query$SystemIsUsingBinds$system$info info;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$SystemIsUsingBinds$systemToJson(this);
  int get hashCode {
    final l$info = info;
    final l$$__typename = $__typename;
    return Object.hashAll([l$info, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$SystemIsUsingBinds$system) ||
        runtimeType != other.runtimeType) return false;
    final l$info = info;
    final lOther$info = other.info;
    if (l$info != lOther$info) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
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
          TRes Function(Query$SystemIsUsingBinds$system) then) =
      _CopyWithImpl$Query$SystemIsUsingBinds$system;

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

  static const _undefined = {};

  TRes call({Object? info = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$SystemIsUsingBinds$system(
          info: info == _undefined || info == null
              ? _instance.info
              : (info as Query$SystemIsUsingBinds$system$info),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Query$SystemIsUsingBinds$system$info<TRes> get info {
    final local$info = _instance.info;
    return CopyWith$Query$SystemIsUsingBinds$system$info(
        local$info, (e) => call(info: e));
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

@JsonSerializable(explicitToJson: true)
class Query$SystemIsUsingBinds$system$info {
  Query$SystemIsUsingBinds$system$info(
      {required this.usingBinds, required this.$__typename});

  @override
  factory Query$SystemIsUsingBinds$system$info.fromJson(
          Map<String, dynamic> json) =>
      _$Query$SystemIsUsingBinds$system$infoFromJson(json);

  final bool usingBinds;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$SystemIsUsingBinds$system$infoToJson(this);
  int get hashCode {
    final l$usingBinds = usingBinds;
    final l$$__typename = $__typename;
    return Object.hashAll([l$usingBinds, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$SystemIsUsingBinds$system$info) ||
        runtimeType != other.runtimeType) return false;
    final l$usingBinds = usingBinds;
    final lOther$usingBinds = other.usingBinds;
    if (l$usingBinds != lOther$usingBinds) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$SystemIsUsingBinds$system$info
    on Query$SystemIsUsingBinds$system$info {
  CopyWith$Query$SystemIsUsingBinds$system$info<
          Query$SystemIsUsingBinds$system$info>
      get copyWith =>
          CopyWith$Query$SystemIsUsingBinds$system$info(this, (i) => i);
}

abstract class CopyWith$Query$SystemIsUsingBinds$system$info<TRes> {
  factory CopyWith$Query$SystemIsUsingBinds$system$info(
          Query$SystemIsUsingBinds$system$info instance,
          TRes Function(Query$SystemIsUsingBinds$system$info) then) =
      _CopyWithImpl$Query$SystemIsUsingBinds$system$info;

  factory CopyWith$Query$SystemIsUsingBinds$system$info.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemIsUsingBinds$system$info;

  TRes call({bool? usingBinds, String? $__typename});
}

class _CopyWithImpl$Query$SystemIsUsingBinds$system$info<TRes>
    implements CopyWith$Query$SystemIsUsingBinds$system$info<TRes> {
  _CopyWithImpl$Query$SystemIsUsingBinds$system$info(
      this._instance, this._then);

  final Query$SystemIsUsingBinds$system$info _instance;

  final TRes Function(Query$SystemIsUsingBinds$system$info) _then;

  static const _undefined = {};

  TRes call(
          {Object? usingBinds = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$SystemIsUsingBinds$system$info(
          usingBinds: usingBinds == _undefined || usingBinds == null
              ? _instance.usingBinds
              : (usingBinds as bool),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
}

class _CopyWithStubImpl$Query$SystemIsUsingBinds$system$info<TRes>
    implements CopyWith$Query$SystemIsUsingBinds$system$info<TRes> {
  _CopyWithStubImpl$Query$SystemIsUsingBinds$system$info(this._res);

  TRes _res;

  call({bool? usingBinds, String? $__typename}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Query$DomainInfo {
  Query$DomainInfo({required this.system, required this.$__typename});

  @override
  factory Query$DomainInfo.fromJson(Map<String, dynamic> json) =>
      _$Query$DomainInfoFromJson(json);

  final Query$DomainInfo$system system;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$DomainInfoToJson(this);
  int get hashCode {
    final l$system = system;
    final l$$__typename = $__typename;
    return Object.hashAll([l$system, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$DomainInfo) || runtimeType != other.runtimeType)
      return false;
    final l$system = system;
    final lOther$system = other.system;
    if (l$system != lOther$system) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$DomainInfo on Query$DomainInfo {
  CopyWith$Query$DomainInfo<Query$DomainInfo> get copyWith =>
      CopyWith$Query$DomainInfo(this, (i) => i);
}

abstract class CopyWith$Query$DomainInfo<TRes> {
  factory CopyWith$Query$DomainInfo(
          Query$DomainInfo instance, TRes Function(Query$DomainInfo) then) =
      _CopyWithImpl$Query$DomainInfo;

  factory CopyWith$Query$DomainInfo.stub(TRes res) =
      _CopyWithStubImpl$Query$DomainInfo;

  TRes call({Query$DomainInfo$system? system, String? $__typename});
  CopyWith$Query$DomainInfo$system<TRes> get system;
}

class _CopyWithImpl$Query$DomainInfo<TRes>
    implements CopyWith$Query$DomainInfo<TRes> {
  _CopyWithImpl$Query$DomainInfo(this._instance, this._then);

  final Query$DomainInfo _instance;

  final TRes Function(Query$DomainInfo) _then;

  static const _undefined = {};

  TRes call({Object? system = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$DomainInfo(
          system: system == _undefined || system == null
              ? _instance.system
              : (system as Query$DomainInfo$system),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Query$DomainInfo$system<TRes> get system {
    final local$system = _instance.system;
    return CopyWith$Query$DomainInfo$system(
        local$system, (e) => call(system: e));
  }
}

class _CopyWithStubImpl$Query$DomainInfo<TRes>
    implements CopyWith$Query$DomainInfo<TRes> {
  _CopyWithStubImpl$Query$DomainInfo(this._res);

  TRes _res;

  call({Query$DomainInfo$system? system, String? $__typename}) => _res;
  CopyWith$Query$DomainInfo$system<TRes> get system =>
      CopyWith$Query$DomainInfo$system.stub(_res);
}

const documentNodeQueryDomainInfo = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'DomainInfo'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'system'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'domainInfo'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'domain'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'hostname'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'provider'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'requiredDnsRecords'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'content'),
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
                              name: NameNode(value: 'priority'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'recordType'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'ttl'),
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
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
]);
Query$DomainInfo _parserFn$Query$DomainInfo(Map<String, dynamic> data) =>
    Query$DomainInfo.fromJson(data);

class Options$Query$DomainInfo extends graphql.QueryOptions<Query$DomainInfo> {
  Options$Query$DomainInfo(
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
            document: documentNodeQueryDomainInfo,
            parserFn: _parserFn$Query$DomainInfo);
}

class WatchOptions$Query$DomainInfo
    extends graphql.WatchQueryOptions<Query$DomainInfo> {
  WatchOptions$Query$DomainInfo(
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
            document: documentNodeQueryDomainInfo,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Query$DomainInfo);
}

class FetchMoreOptions$Query$DomainInfo extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$DomainInfo({required graphql.UpdateQuery updateQuery})
      : super(updateQuery: updateQuery, document: documentNodeQueryDomainInfo);
}

extension ClientExtension$Query$DomainInfo on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$DomainInfo>> query$DomainInfo(
          [Options$Query$DomainInfo? options]) async =>
      await this.query(options ?? Options$Query$DomainInfo());
  graphql.ObservableQuery<Query$DomainInfo> watchQuery$DomainInfo(
          [WatchOptions$Query$DomainInfo? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$DomainInfo());
  void writeQuery$DomainInfo(
          {required Query$DomainInfo data, bool broadcast = true}) =>
      this.writeQuery(
          graphql.Request(
              operation:
                  graphql.Operation(document: documentNodeQueryDomainInfo)),
          data: data.toJson(),
          broadcast: broadcast);
  Query$DomainInfo? readQuery$DomainInfo({bool optimistic = true}) {
    final result = this.readQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryDomainInfo)),
        optimistic: optimistic);
    return result == null ? null : Query$DomainInfo.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Query$DomainInfo$system {
  Query$DomainInfo$system(
      {required this.domainInfo, required this.$__typename});

  @override
  factory Query$DomainInfo$system.fromJson(Map<String, dynamic> json) =>
      _$Query$DomainInfo$systemFromJson(json);

  final Query$DomainInfo$system$domainInfo domainInfo;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$DomainInfo$systemToJson(this);
  int get hashCode {
    final l$domainInfo = domainInfo;
    final l$$__typename = $__typename;
    return Object.hashAll([l$domainInfo, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$DomainInfo$system) || runtimeType != other.runtimeType)
      return false;
    final l$domainInfo = domainInfo;
    final lOther$domainInfo = other.domainInfo;
    if (l$domainInfo != lOther$domainInfo) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$DomainInfo$system on Query$DomainInfo$system {
  CopyWith$Query$DomainInfo$system<Query$DomainInfo$system> get copyWith =>
      CopyWith$Query$DomainInfo$system(this, (i) => i);
}

abstract class CopyWith$Query$DomainInfo$system<TRes> {
  factory CopyWith$Query$DomainInfo$system(Query$DomainInfo$system instance,
          TRes Function(Query$DomainInfo$system) then) =
      _CopyWithImpl$Query$DomainInfo$system;

  factory CopyWith$Query$DomainInfo$system.stub(TRes res) =
      _CopyWithStubImpl$Query$DomainInfo$system;

  TRes call(
      {Query$DomainInfo$system$domainInfo? domainInfo, String? $__typename});
  CopyWith$Query$DomainInfo$system$domainInfo<TRes> get domainInfo;
}

class _CopyWithImpl$Query$DomainInfo$system<TRes>
    implements CopyWith$Query$DomainInfo$system<TRes> {
  _CopyWithImpl$Query$DomainInfo$system(this._instance, this._then);

  final Query$DomainInfo$system _instance;

  final TRes Function(Query$DomainInfo$system) _then;

  static const _undefined = {};

  TRes call(
          {Object? domainInfo = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$DomainInfo$system(
          domainInfo: domainInfo == _undefined || domainInfo == null
              ? _instance.domainInfo
              : (domainInfo as Query$DomainInfo$system$domainInfo),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Query$DomainInfo$system$domainInfo<TRes> get domainInfo {
    final local$domainInfo = _instance.domainInfo;
    return CopyWith$Query$DomainInfo$system$domainInfo(
        local$domainInfo, (e) => call(domainInfo: e));
  }
}

class _CopyWithStubImpl$Query$DomainInfo$system<TRes>
    implements CopyWith$Query$DomainInfo$system<TRes> {
  _CopyWithStubImpl$Query$DomainInfo$system(this._res);

  TRes _res;

  call({Query$DomainInfo$system$domainInfo? domainInfo, String? $__typename}) =>
      _res;
  CopyWith$Query$DomainInfo$system$domainInfo<TRes> get domainInfo =>
      CopyWith$Query$DomainInfo$system$domainInfo.stub(_res);
}

@JsonSerializable(explicitToJson: true)
class Query$DomainInfo$system$domainInfo {
  Query$DomainInfo$system$domainInfo(
      {required this.domain,
      required this.hostname,
      required this.provider,
      required this.requiredDnsRecords,
      required this.$__typename});

  @override
  factory Query$DomainInfo$system$domainInfo.fromJson(
          Map<String, dynamic> json) =>
      _$Query$DomainInfo$system$domainInfoFromJson(json);

  final String domain;

  final String hostname;

  @JsonKey(unknownEnumValue: Enum$DnsProvider.$unknown)
  final Enum$DnsProvider provider;

  final List<Query$DomainInfo$system$domainInfo$requiredDnsRecords>
      requiredDnsRecords;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$DomainInfo$system$domainInfoToJson(this);
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
      l$$__typename
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$DomainInfo$system$domainInfo) ||
        runtimeType != other.runtimeType) return false;
    final l$domain = domain;
    final lOther$domain = other.domain;
    if (l$domain != lOther$domain) return false;
    final l$hostname = hostname;
    final lOther$hostname = other.hostname;
    if (l$hostname != lOther$hostname) return false;
    final l$provider = provider;
    final lOther$provider = other.provider;
    if (l$provider != lOther$provider) return false;
    final l$requiredDnsRecords = requiredDnsRecords;
    final lOther$requiredDnsRecords = other.requiredDnsRecords;
    if (l$requiredDnsRecords.length != lOther$requiredDnsRecords.length)
      return false;
    for (int i = 0; i < l$requiredDnsRecords.length; i++) {
      final l$requiredDnsRecords$entry = l$requiredDnsRecords[i];
      final lOther$requiredDnsRecords$entry = lOther$requiredDnsRecords[i];
      if (l$requiredDnsRecords$entry != lOther$requiredDnsRecords$entry)
        return false;
    }

    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$DomainInfo$system$domainInfo
    on Query$DomainInfo$system$domainInfo {
  CopyWith$Query$DomainInfo$system$domainInfo<
          Query$DomainInfo$system$domainInfo>
      get copyWith =>
          CopyWith$Query$DomainInfo$system$domainInfo(this, (i) => i);
}

abstract class CopyWith$Query$DomainInfo$system$domainInfo<TRes> {
  factory CopyWith$Query$DomainInfo$system$domainInfo(
          Query$DomainInfo$system$domainInfo instance,
          TRes Function(Query$DomainInfo$system$domainInfo) then) =
      _CopyWithImpl$Query$DomainInfo$system$domainInfo;

  factory CopyWith$Query$DomainInfo$system$domainInfo.stub(TRes res) =
      _CopyWithStubImpl$Query$DomainInfo$system$domainInfo;

  TRes call(
      {String? domain,
      String? hostname,
      Enum$DnsProvider? provider,
      List<Query$DomainInfo$system$domainInfo$requiredDnsRecords>?
          requiredDnsRecords,
      String? $__typename});
  TRes requiredDnsRecords(
      Iterable<Query$DomainInfo$system$domainInfo$requiredDnsRecords> Function(
              Iterable<
                  CopyWith$Query$DomainInfo$system$domainInfo$requiredDnsRecords<
                      Query$DomainInfo$system$domainInfo$requiredDnsRecords>>)
          _fn);
}

class _CopyWithImpl$Query$DomainInfo$system$domainInfo<TRes>
    implements CopyWith$Query$DomainInfo$system$domainInfo<TRes> {
  _CopyWithImpl$Query$DomainInfo$system$domainInfo(this._instance, this._then);

  final Query$DomainInfo$system$domainInfo _instance;

  final TRes Function(Query$DomainInfo$system$domainInfo) _then;

  static const _undefined = {};

  TRes call(
          {Object? domain = _undefined,
          Object? hostname = _undefined,
          Object? provider = _undefined,
          Object? requiredDnsRecords = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$DomainInfo$system$domainInfo(
          domain: domain == _undefined || domain == null
              ? _instance.domain
              : (domain as String),
          hostname: hostname == _undefined || hostname == null
              ? _instance.hostname
              : (hostname as String),
          provider: provider == _undefined || provider == null
              ? _instance.provider
              : (provider as Enum$DnsProvider),
          requiredDnsRecords:
              requiredDnsRecords == _undefined || requiredDnsRecords == null
                  ? _instance.requiredDnsRecords
                  : (requiredDnsRecords as List<
                      Query$DomainInfo$system$domainInfo$requiredDnsRecords>),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  TRes requiredDnsRecords(
          Iterable<Query$DomainInfo$system$domainInfo$requiredDnsRecords> Function(
                  Iterable<
                      CopyWith$Query$DomainInfo$system$domainInfo$requiredDnsRecords<
                          Query$DomainInfo$system$domainInfo$requiredDnsRecords>>)
              _fn) =>
      call(
          requiredDnsRecords: _fn(_instance.requiredDnsRecords.map((e) =>
              CopyWith$Query$DomainInfo$system$domainInfo$requiredDnsRecords(
                  e, (i) => i))).toList());
}

class _CopyWithStubImpl$Query$DomainInfo$system$domainInfo<TRes>
    implements CopyWith$Query$DomainInfo$system$domainInfo<TRes> {
  _CopyWithStubImpl$Query$DomainInfo$system$domainInfo(this._res);

  TRes _res;

  call(
          {String? domain,
          String? hostname,
          Enum$DnsProvider? provider,
          List<Query$DomainInfo$system$domainInfo$requiredDnsRecords>?
              requiredDnsRecords,
          String? $__typename}) =>
      _res;
  requiredDnsRecords(_fn) => _res;
}

@JsonSerializable(explicitToJson: true)
class Query$DomainInfo$system$domainInfo$requiredDnsRecords {
  Query$DomainInfo$system$domainInfo$requiredDnsRecords(
      {required this.content,
      required this.name,
      this.priority,
      required this.recordType,
      required this.ttl,
      required this.$__typename});

  @override
  factory Query$DomainInfo$system$domainInfo$requiredDnsRecords.fromJson(
          Map<String, dynamic> json) =>
      _$Query$DomainInfo$system$domainInfo$requiredDnsRecordsFromJson(json);

  final String content;

  final String name;

  final int? priority;

  final String recordType;

  final int ttl;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$DomainInfo$system$domainInfo$requiredDnsRecordsToJson(this);
  int get hashCode {
    final l$content = content;
    final l$name = name;
    final l$priority = priority;
    final l$recordType = recordType;
    final l$ttl = ttl;
    final l$$__typename = $__typename;
    return Object.hashAll(
        [l$content, l$name, l$priority, l$recordType, l$ttl, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$DomainInfo$system$domainInfo$requiredDnsRecords) ||
        runtimeType != other.runtimeType) return false;
    final l$content = content;
    final lOther$content = other.content;
    if (l$content != lOther$content) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    final l$priority = priority;
    final lOther$priority = other.priority;
    if (l$priority != lOther$priority) return false;
    final l$recordType = recordType;
    final lOther$recordType = other.recordType;
    if (l$recordType != lOther$recordType) return false;
    final l$ttl = ttl;
    final lOther$ttl = other.ttl;
    if (l$ttl != lOther$ttl) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$DomainInfo$system$domainInfo$requiredDnsRecords
    on Query$DomainInfo$system$domainInfo$requiredDnsRecords {
  CopyWith$Query$DomainInfo$system$domainInfo$requiredDnsRecords<
          Query$DomainInfo$system$domainInfo$requiredDnsRecords>
      get copyWith =>
          CopyWith$Query$DomainInfo$system$domainInfo$requiredDnsRecords(
              this, (i) => i);
}

abstract class CopyWith$Query$DomainInfo$system$domainInfo$requiredDnsRecords<
    TRes> {
  factory CopyWith$Query$DomainInfo$system$domainInfo$requiredDnsRecords(
          Query$DomainInfo$system$domainInfo$requiredDnsRecords instance,
          TRes Function(Query$DomainInfo$system$domainInfo$requiredDnsRecords)
              then) =
      _CopyWithImpl$Query$DomainInfo$system$domainInfo$requiredDnsRecords;

  factory CopyWith$Query$DomainInfo$system$domainInfo$requiredDnsRecords.stub(
          TRes res) =
      _CopyWithStubImpl$Query$DomainInfo$system$domainInfo$requiredDnsRecords;

  TRes call(
      {String? content,
      String? name,
      int? priority,
      String? recordType,
      int? ttl,
      String? $__typename});
}

class _CopyWithImpl$Query$DomainInfo$system$domainInfo$requiredDnsRecords<TRes>
    implements
        CopyWith$Query$DomainInfo$system$domainInfo$requiredDnsRecords<TRes> {
  _CopyWithImpl$Query$DomainInfo$system$domainInfo$requiredDnsRecords(
      this._instance, this._then);

  final Query$DomainInfo$system$domainInfo$requiredDnsRecords _instance;

  final TRes Function(Query$DomainInfo$system$domainInfo$requiredDnsRecords)
      _then;

  static const _undefined = {};

  TRes call(
          {Object? content = _undefined,
          Object? name = _undefined,
          Object? priority = _undefined,
          Object? recordType = _undefined,
          Object? ttl = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$DomainInfo$system$domainInfo$requiredDnsRecords(
          content: content == _undefined || content == null
              ? _instance.content
              : (content as String),
          name: name == _undefined || name == null
              ? _instance.name
              : (name as String),
          priority:
              priority == _undefined ? _instance.priority : (priority as int?),
          recordType: recordType == _undefined || recordType == null
              ? _instance.recordType
              : (recordType as String),
          ttl: ttl == _undefined || ttl == null ? _instance.ttl : (ttl as int),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
}

class _CopyWithStubImpl$Query$DomainInfo$system$domainInfo$requiredDnsRecords<
        TRes>
    implements
        CopyWith$Query$DomainInfo$system$domainInfo$requiredDnsRecords<TRes> {
  _CopyWithStubImpl$Query$DomainInfo$system$domainInfo$requiredDnsRecords(
      this._res);

  TRes _res;

  call(
          {String? content,
          String? name,
          int? priority,
          String? recordType,
          int? ttl,
          String? $__typename}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$ChangeTimezone {
  Variables$Mutation$ChangeTimezone({required this.timezone});

  @override
  factory Variables$Mutation$ChangeTimezone.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$ChangeTimezoneFromJson(json);

  final String timezone;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$ChangeTimezoneToJson(this);
  int get hashCode {
    final l$timezone = timezone;
    return Object.hashAll([l$timezone]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$ChangeTimezone) ||
        runtimeType != other.runtimeType) return false;
    final l$timezone = timezone;
    final lOther$timezone = other.timezone;
    if (l$timezone != lOther$timezone) return false;
    return true;
  }

  CopyWith$Variables$Mutation$ChangeTimezone<Variables$Mutation$ChangeTimezone>
      get copyWith =>
          CopyWith$Variables$Mutation$ChangeTimezone(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$ChangeTimezone<TRes> {
  factory CopyWith$Variables$Mutation$ChangeTimezone(
          Variables$Mutation$ChangeTimezone instance,
          TRes Function(Variables$Mutation$ChangeTimezone) then) =
      _CopyWithImpl$Variables$Mutation$ChangeTimezone;

  factory CopyWith$Variables$Mutation$ChangeTimezone.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ChangeTimezone;

  TRes call({String? timezone});
}

class _CopyWithImpl$Variables$Mutation$ChangeTimezone<TRes>
    implements CopyWith$Variables$Mutation$ChangeTimezone<TRes> {
  _CopyWithImpl$Variables$Mutation$ChangeTimezone(this._instance, this._then);

  final Variables$Mutation$ChangeTimezone _instance;

  final TRes Function(Variables$Mutation$ChangeTimezone) _then;

  static const _undefined = {};

  TRes call({Object? timezone = _undefined}) =>
      _then(Variables$Mutation$ChangeTimezone(
          timezone: timezone == _undefined || timezone == null
              ? _instance.timezone
              : (timezone as String)));
}

class _CopyWithStubImpl$Variables$Mutation$ChangeTimezone<TRes>
    implements CopyWith$Variables$Mutation$ChangeTimezone<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ChangeTimezone(this._res);

  TRes _res;

  call({String? timezone}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Mutation$ChangeTimezone {
  Mutation$ChangeTimezone(
      {required this.changeTimezone, required this.$__typename});

  @override
  factory Mutation$ChangeTimezone.fromJson(Map<String, dynamic> json) =>
      _$Mutation$ChangeTimezoneFromJson(json);

  final Mutation$ChangeTimezone$changeTimezone changeTimezone;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$ChangeTimezoneToJson(this);
  int get hashCode {
    final l$changeTimezone = changeTimezone;
    final l$$__typename = $__typename;
    return Object.hashAll([l$changeTimezone, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$ChangeTimezone) || runtimeType != other.runtimeType)
      return false;
    final l$changeTimezone = changeTimezone;
    final lOther$changeTimezone = other.changeTimezone;
    if (l$changeTimezone != lOther$changeTimezone) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$ChangeTimezone on Mutation$ChangeTimezone {
  CopyWith$Mutation$ChangeTimezone<Mutation$ChangeTimezone> get copyWith =>
      CopyWith$Mutation$ChangeTimezone(this, (i) => i);
}

abstract class CopyWith$Mutation$ChangeTimezone<TRes> {
  factory CopyWith$Mutation$ChangeTimezone(Mutation$ChangeTimezone instance,
          TRes Function(Mutation$ChangeTimezone) then) =
      _CopyWithImpl$Mutation$ChangeTimezone;

  factory CopyWith$Mutation$ChangeTimezone.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ChangeTimezone;

  TRes call(
      {Mutation$ChangeTimezone$changeTimezone? changeTimezone,
      String? $__typename});
  CopyWith$Mutation$ChangeTimezone$changeTimezone<TRes> get changeTimezone;
}

class _CopyWithImpl$Mutation$ChangeTimezone<TRes>
    implements CopyWith$Mutation$ChangeTimezone<TRes> {
  _CopyWithImpl$Mutation$ChangeTimezone(this._instance, this._then);

  final Mutation$ChangeTimezone _instance;

  final TRes Function(Mutation$ChangeTimezone) _then;

  static const _undefined = {};

  TRes call(
          {Object? changeTimezone = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$ChangeTimezone(
          changeTimezone: changeTimezone == _undefined || changeTimezone == null
              ? _instance.changeTimezone
              : (changeTimezone as Mutation$ChangeTimezone$changeTimezone),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$ChangeTimezone$changeTimezone<TRes> get changeTimezone {
    final local$changeTimezone = _instance.changeTimezone;
    return CopyWith$Mutation$ChangeTimezone$changeTimezone(
        local$changeTimezone, (e) => call(changeTimezone: e));
  }
}

class _CopyWithStubImpl$Mutation$ChangeTimezone<TRes>
    implements CopyWith$Mutation$ChangeTimezone<TRes> {
  _CopyWithStubImpl$Mutation$ChangeTimezone(this._res);

  TRes _res;

  call(
          {Mutation$ChangeTimezone$changeTimezone? changeTimezone,
          String? $__typename}) =>
      _res;
  CopyWith$Mutation$ChangeTimezone$changeTimezone<TRes> get changeTimezone =>
      CopyWith$Mutation$ChangeTimezone$changeTimezone.stub(_res);
}

const documentNodeMutationChangeTimezone = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ChangeTimezone'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'timezone')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'changeTimezone'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'timezone'),
                  value: VariableNode(name: NameNode(value: 'timezone')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
              FieldNode(
                  name: NameNode(value: 'timezone'),
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
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$ChangeTimezone _parserFn$Mutation$ChangeTimezone(
        Map<String, dynamic> data) =>
    Mutation$ChangeTimezone.fromJson(data);
typedef OnMutationCompleted$Mutation$ChangeTimezone = FutureOr<void> Function(
    dynamic, Mutation$ChangeTimezone?);

class Options$Mutation$ChangeTimezone
    extends graphql.MutationOptions<Mutation$ChangeTimezone> {
  Options$Mutation$ChangeTimezone(
      {String? operationName,
      required Variables$Mutation$ChangeTimezone variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$ChangeTimezone? onCompleted,
      graphql.OnMutationUpdate<Mutation$ChangeTimezone>? update,
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
                        : _parserFn$Mutation$ChangeTimezone(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationChangeTimezone,
            parserFn: _parserFn$Mutation$ChangeTimezone);

  final OnMutationCompleted$Mutation$ChangeTimezone? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$ChangeTimezone
    extends graphql.WatchQueryOptions<Mutation$ChangeTimezone> {
  WatchOptions$Mutation$ChangeTimezone(
      {String? operationName,
      required Variables$Mutation$ChangeTimezone variables,
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
            document: documentNodeMutationChangeTimezone,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$ChangeTimezone);
}

extension ClientExtension$Mutation$ChangeTimezone on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ChangeTimezone>> mutate$ChangeTimezone(
          Options$Mutation$ChangeTimezone options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$ChangeTimezone> watchMutation$ChangeTimezone(
          WatchOptions$Mutation$ChangeTimezone options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$ChangeTimezone$changeTimezone
    implements Fragment$basicMutationReturnFields {
  Mutation$ChangeTimezone$changeTimezone(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename,
      this.timezone});

  @override
  factory Mutation$ChangeTimezone$changeTimezone.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$ChangeTimezone$changeTimezoneFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  final String? timezone;

  Map<String, dynamic> toJson() =>
      _$Mutation$ChangeTimezone$changeTimezoneToJson(this);
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$timezone = timezone;
    return Object.hashAll(
        [l$code, l$message, l$success, l$$__typename, l$timezone]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$ChangeTimezone$changeTimezone) ||
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
    final l$timezone = timezone;
    final lOther$timezone = other.timezone;
    if (l$timezone != lOther$timezone) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$ChangeTimezone$changeTimezone
    on Mutation$ChangeTimezone$changeTimezone {
  CopyWith$Mutation$ChangeTimezone$changeTimezone<
          Mutation$ChangeTimezone$changeTimezone>
      get copyWith =>
          CopyWith$Mutation$ChangeTimezone$changeTimezone(this, (i) => i);
}

abstract class CopyWith$Mutation$ChangeTimezone$changeTimezone<TRes> {
  factory CopyWith$Mutation$ChangeTimezone$changeTimezone(
          Mutation$ChangeTimezone$changeTimezone instance,
          TRes Function(Mutation$ChangeTimezone$changeTimezone) then) =
      _CopyWithImpl$Mutation$ChangeTimezone$changeTimezone;

  factory CopyWith$Mutation$ChangeTimezone$changeTimezone.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ChangeTimezone$changeTimezone;

  TRes call(
      {int? code,
      String? message,
      bool? success,
      String? $__typename,
      String? timezone});
}

class _CopyWithImpl$Mutation$ChangeTimezone$changeTimezone<TRes>
    implements CopyWith$Mutation$ChangeTimezone$changeTimezone<TRes> {
  _CopyWithImpl$Mutation$ChangeTimezone$changeTimezone(
      this._instance, this._then);

  final Mutation$ChangeTimezone$changeTimezone _instance;

  final TRes Function(Mutation$ChangeTimezone$changeTimezone) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined,
          Object? timezone = _undefined}) =>
      _then(Mutation$ChangeTimezone$changeTimezone(
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
          timezone: timezone == _undefined
              ? _instance.timezone
              : (timezone as String?)));
}

class _CopyWithStubImpl$Mutation$ChangeTimezone$changeTimezone<TRes>
    implements CopyWith$Mutation$ChangeTimezone$changeTimezone<TRes> {
  _CopyWithStubImpl$Mutation$ChangeTimezone$changeTimezone(this._res);

  TRes _res;

  call(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          String? timezone}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$ChangeAutoUpgradeSettings {
  Variables$Mutation$ChangeAutoUpgradeSettings({required this.settings});

  @override
  factory Variables$Mutation$ChangeAutoUpgradeSettings.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$ChangeAutoUpgradeSettingsFromJson(json);

  final Input$AutoUpgradeSettingsInput settings;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$ChangeAutoUpgradeSettingsToJson(this);
  int get hashCode {
    final l$settings = settings;
    return Object.hashAll([l$settings]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$ChangeAutoUpgradeSettings) ||
        runtimeType != other.runtimeType) return false;
    final l$settings = settings;
    final lOther$settings = other.settings;
    if (l$settings != lOther$settings) return false;
    return true;
  }

  CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings<
          Variables$Mutation$ChangeAutoUpgradeSettings>
      get copyWith =>
          CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings<TRes> {
  factory CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings(
          Variables$Mutation$ChangeAutoUpgradeSettings instance,
          TRes Function(Variables$Mutation$ChangeAutoUpgradeSettings) then) =
      _CopyWithImpl$Variables$Mutation$ChangeAutoUpgradeSettings;

  factory CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ChangeAutoUpgradeSettings;

  TRes call({Input$AutoUpgradeSettingsInput? settings});
}

class _CopyWithImpl$Variables$Mutation$ChangeAutoUpgradeSettings<TRes>
    implements CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings<TRes> {
  _CopyWithImpl$Variables$Mutation$ChangeAutoUpgradeSettings(
      this._instance, this._then);

  final Variables$Mutation$ChangeAutoUpgradeSettings _instance;

  final TRes Function(Variables$Mutation$ChangeAutoUpgradeSettings) _then;

  static const _undefined = {};

  TRes call({Object? settings = _undefined}) =>
      _then(Variables$Mutation$ChangeAutoUpgradeSettings(
          settings: settings == _undefined || settings == null
              ? _instance.settings
              : (settings as Input$AutoUpgradeSettingsInput)));
}

class _CopyWithStubImpl$Variables$Mutation$ChangeAutoUpgradeSettings<TRes>
    implements CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ChangeAutoUpgradeSettings(this._res);

  TRes _res;

  call({Input$AutoUpgradeSettingsInput? settings}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Mutation$ChangeAutoUpgradeSettings {
  Mutation$ChangeAutoUpgradeSettings(
      {required this.changeAutoUpgradeSettings, required this.$__typename});

  @override
  factory Mutation$ChangeAutoUpgradeSettings.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$ChangeAutoUpgradeSettingsFromJson(json);

  final Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings
      changeAutoUpgradeSettings;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$ChangeAutoUpgradeSettingsToJson(this);
  int get hashCode {
    final l$changeAutoUpgradeSettings = changeAutoUpgradeSettings;
    final l$$__typename = $__typename;
    return Object.hashAll([l$changeAutoUpgradeSettings, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$ChangeAutoUpgradeSettings) ||
        runtimeType != other.runtimeType) return false;
    final l$changeAutoUpgradeSettings = changeAutoUpgradeSettings;
    final lOther$changeAutoUpgradeSettings = other.changeAutoUpgradeSettings;
    if (l$changeAutoUpgradeSettings != lOther$changeAutoUpgradeSettings)
      return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$ChangeAutoUpgradeSettings
    on Mutation$ChangeAutoUpgradeSettings {
  CopyWith$Mutation$ChangeAutoUpgradeSettings<
          Mutation$ChangeAutoUpgradeSettings>
      get copyWith =>
          CopyWith$Mutation$ChangeAutoUpgradeSettings(this, (i) => i);
}

abstract class CopyWith$Mutation$ChangeAutoUpgradeSettings<TRes> {
  factory CopyWith$Mutation$ChangeAutoUpgradeSettings(
          Mutation$ChangeAutoUpgradeSettings instance,
          TRes Function(Mutation$ChangeAutoUpgradeSettings) then) =
      _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings;

  factory CopyWith$Mutation$ChangeAutoUpgradeSettings.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings;

  TRes call(
      {Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings?
          changeAutoUpgradeSettings,
      String? $__typename});
  CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<TRes>
      get changeAutoUpgradeSettings;
}

class _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings<TRes>
    implements CopyWith$Mutation$ChangeAutoUpgradeSettings<TRes> {
  _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings(this._instance, this._then);

  final Mutation$ChangeAutoUpgradeSettings _instance;

  final TRes Function(Mutation$ChangeAutoUpgradeSettings) _then;

  static const _undefined = {};

  TRes call(
          {Object? changeAutoUpgradeSettings = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$ChangeAutoUpgradeSettings(
          changeAutoUpgradeSettings: changeAutoUpgradeSettings == _undefined ||
                  changeAutoUpgradeSettings == null
              ? _instance.changeAutoUpgradeSettings
              : (changeAutoUpgradeSettings
                  as Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<TRes>
      get changeAutoUpgradeSettings {
    final local$changeAutoUpgradeSettings = _instance.changeAutoUpgradeSettings;
    return CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
        local$changeAutoUpgradeSettings,
        (e) => call(changeAutoUpgradeSettings: e));
  }
}

class _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings<TRes>
    implements CopyWith$Mutation$ChangeAutoUpgradeSettings<TRes> {
  _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings(this._res);

  TRes _res;

  call(
          {Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings?
              changeAutoUpgradeSettings,
          String? $__typename}) =>
      _res;
  CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<TRes>
      get changeAutoUpgradeSettings =>
          CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings
              .stub(_res);
}

const documentNodeMutationChangeAutoUpgradeSettings =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ChangeAutoUpgradeSettings'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'settings')),
            type: NamedTypeNode(
                name: NameNode(value: 'AutoUpgradeSettingsInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'changeAutoUpgradeSettings'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'settings'),
                  value: VariableNode(name: NameNode(value: 'settings')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
              FieldNode(
                  name: NameNode(value: 'allowReboot'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'enableAutoUpgrade'),
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
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$ChangeAutoUpgradeSettings _parserFn$Mutation$ChangeAutoUpgradeSettings(
        Map<String, dynamic> data) =>
    Mutation$ChangeAutoUpgradeSettings.fromJson(data);
typedef OnMutationCompleted$Mutation$ChangeAutoUpgradeSettings = FutureOr<void>
    Function(dynamic, Mutation$ChangeAutoUpgradeSettings?);

class Options$Mutation$ChangeAutoUpgradeSettings
    extends graphql.MutationOptions<Mutation$ChangeAutoUpgradeSettings> {
  Options$Mutation$ChangeAutoUpgradeSettings(
      {String? operationName,
      required Variables$Mutation$ChangeAutoUpgradeSettings variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$ChangeAutoUpgradeSettings? onCompleted,
      graphql.OnMutationUpdate<Mutation$ChangeAutoUpgradeSettings>? update,
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
                        : _parserFn$Mutation$ChangeAutoUpgradeSettings(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationChangeAutoUpgradeSettings,
            parserFn: _parserFn$Mutation$ChangeAutoUpgradeSettings);

  final OnMutationCompleted$Mutation$ChangeAutoUpgradeSettings?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$ChangeAutoUpgradeSettings
    extends graphql.WatchQueryOptions<Mutation$ChangeAutoUpgradeSettings> {
  WatchOptions$Mutation$ChangeAutoUpgradeSettings(
      {String? operationName,
      required Variables$Mutation$ChangeAutoUpgradeSettings variables,
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
            document: documentNodeMutationChangeAutoUpgradeSettings,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$ChangeAutoUpgradeSettings);
}

extension ClientExtension$Mutation$ChangeAutoUpgradeSettings
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ChangeAutoUpgradeSettings>>
      mutate$ChangeAutoUpgradeSettings(
              Options$Mutation$ChangeAutoUpgradeSettings options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$ChangeAutoUpgradeSettings>
      watchMutation$ChangeAutoUpgradeSettings(
              WatchOptions$Mutation$ChangeAutoUpgradeSettings options) =>
          this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings
    implements Fragment$basicMutationReturnFields {
  Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename,
      required this.allowReboot,
      required this.enableAutoUpgrade});

  @override
  factory Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettingsFromJson(
          json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  final bool allowReboot;

  final bool enableAutoUpgrade;

  Map<String, dynamic> toJson() =>
      _$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettingsToJson(
          this);
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
      l$enableAutoUpgrade
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other
            is Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings) ||
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
    final l$allowReboot = allowReboot;
    final lOther$allowReboot = other.allowReboot;
    if (l$allowReboot != lOther$allowReboot) return false;
    final l$enableAutoUpgrade = enableAutoUpgrade;
    final lOther$enableAutoUpgrade = other.enableAutoUpgrade;
    if (l$enableAutoUpgrade != lOther$enableAutoUpgrade) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings
    on Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings {
  CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<
          Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings>
      get copyWith =>
          CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
              this, (i) => i);
}

abstract class CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<
    TRes> {
  factory CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
          Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings instance,
          TRes Function(
                  Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings)
              then) =
      _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings;

  factory CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings;

  TRes call(
      {int? code,
      String? message,
      bool? success,
      String? $__typename,
      bool? allowReboot,
      bool? enableAutoUpgrade});
}

class _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<
        TRes>
    implements
        CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<
            TRes> {
  _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
      this._instance, this._then);

  final Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings _instance;

  final TRes Function(
      Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined,
          Object? allowReboot = _undefined,
          Object? enableAutoUpgrade = _undefined}) =>
      _then(Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
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
          allowReboot: allowReboot == _undefined || allowReboot == null
              ? _instance.allowReboot
              : (allowReboot as bool),
          enableAutoUpgrade:
              enableAutoUpgrade == _undefined || enableAutoUpgrade == null
                  ? _instance.enableAutoUpgrade
                  : (enableAutoUpgrade as bool)));
}

class _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<
        TRes>
    implements
        CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<
            TRes> {
  _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
      this._res);

  TRes _res;

  call(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          bool? allowReboot,
          bool? enableAutoUpgrade}) =>
      _res;
}
