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
  Fragment$basicMutationReturnFields copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Fragment$basicMutationReturnFields(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Query$SystemSettings copyWith(
          {Query$SystemSettings$system? system, String? $__typename}) =>
      Query$SystemSettings(
          system: system == null ? this.system : system,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Query$SystemSettings$system copyWith(
          {Query$SystemSettings$system$settings? settings,
          String? $__typename}) =>
      Query$SystemSettings$system(
          settings: settings == null ? this.settings : settings,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Query$SystemSettings$system$settings copyWith(
          {Query$SystemSettings$system$settings$autoUpgrade? autoUpgrade,
          Query$SystemSettings$system$settings$ssh? ssh,
          String? timezone,
          String? $__typename}) =>
      Query$SystemSettings$system$settings(
          autoUpgrade: autoUpgrade == null ? this.autoUpgrade : autoUpgrade,
          ssh: ssh == null ? this.ssh : ssh,
          timezone: timezone == null ? this.timezone : timezone,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Query$SystemSettings$system$settings$autoUpgrade copyWith(
          {bool? allowReboot, bool? enable, String? $__typename}) =>
      Query$SystemSettings$system$settings$autoUpgrade(
          allowReboot: allowReboot == null ? this.allowReboot : allowReboot,
          enable: enable == null ? this.enable : enable,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Query$SystemSettings$system$settings$ssh copyWith(
          {bool? enable,
          bool? passwordAuthentication,
          List<String>? rootSshKeys,
          String? $__typename}) =>
      Query$SystemSettings$system$settings$ssh(
          enable: enable == null ? this.enable : enable,
          passwordAuthentication: passwordAuthentication == null
              ? this.passwordAuthentication
              : passwordAuthentication,
          rootSshKeys: rootSshKeys == null ? this.rootSshKeys : rootSshKeys,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Query$DomainInfo copyWith(
          {Query$DomainInfo$system? system, String? $__typename}) =>
      Query$DomainInfo(
          system: system == null ? this.system : system,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Query$DomainInfo$system copyWith(
          {Query$DomainInfo$system$domainInfo? domainInfo,
          String? $__typename}) =>
      Query$DomainInfo$system(
          domainInfo: domainInfo == null ? this.domainInfo : domainInfo,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Query$DomainInfo$system$domainInfo copyWith(
          {String? domain,
          String? hostname,
          Enum$DnsProvider? provider,
          List<Query$DomainInfo$system$domainInfo$requiredDnsRecords>?
              requiredDnsRecords,
          String? $__typename}) =>
      Query$DomainInfo$system$domainInfo(
          domain: domain == null ? this.domain : domain,
          hostname: hostname == null ? this.hostname : hostname,
          provider: provider == null ? this.provider : provider,
          requiredDnsRecords: requiredDnsRecords == null
              ? this.requiredDnsRecords
              : requiredDnsRecords,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Query$DomainInfo$system$domainInfo$requiredDnsRecords copyWith(
          {String? content,
          String? name,
          int? Function()? priority,
          String? recordType,
          int? ttl,
          String? $__typename}) =>
      Query$DomainInfo$system$domainInfo$requiredDnsRecords(
          content: content == null ? this.content : content,
          name: name == null ? this.name : name,
          priority: priority == null ? this.priority : priority(),
          recordType: recordType == null ? this.recordType : recordType,
          ttl: ttl == null ? this.ttl : ttl,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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

  Variables$Mutation$ChangeTimezone copyWith({String? timezone}) =>
      Variables$Mutation$ChangeTimezone(
          timezone: timezone == null ? this.timezone : timezone);
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
  Mutation$ChangeTimezone copyWith(
          {Mutation$ChangeTimezone$changeTimezone? changeTimezone,
          String? $__typename}) =>
      Mutation$ChangeTimezone(
          changeTimezone:
              changeTimezone == null ? this.changeTimezone : changeTimezone,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Mutation$ChangeTimezone$changeTimezone copyWith(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          String? Function()? timezone}) =>
      Mutation$ChangeTimezone$changeTimezone(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename,
          timezone: timezone == null ? this.timezone : timezone());
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

  Variables$Mutation$ChangeAutoUpgradeSettings copyWith(
          {Input$AutoUpgradeSettingsInput? settings}) =>
      Variables$Mutation$ChangeAutoUpgradeSettings(
          settings: settings == null ? this.settings : settings);
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
  Mutation$ChangeAutoUpgradeSettings copyWith(
          {Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings?
              changeAutoUpgradeSettings,
          String? $__typename}) =>
      Mutation$ChangeAutoUpgradeSettings(
          changeAutoUpgradeSettings: changeAutoUpgradeSettings == null
              ? this.changeAutoUpgradeSettings
              : changeAutoUpgradeSettings,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings copyWith(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          bool? allowReboot,
          bool? enableAutoUpgrade}) =>
      Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename,
          allowReboot: allowReboot == null ? this.allowReboot : allowReboot,
          enableAutoUpgrade: enableAutoUpgrade == null
              ? this.enableAutoUpgrade
              : enableAutoUpgrade);
}
