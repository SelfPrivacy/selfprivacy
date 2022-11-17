import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/utils/scalars.dart';
import 'schema.graphql.dart';
import 'server_api.graphql.dart';
part 'services.graphql.g.dart';

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
class Query$AllServices {
  Query$AllServices({required this.services, required this.$__typename});

  @override
  factory Query$AllServices.fromJson(Map<String, dynamic> json) =>
      _$Query$AllServicesFromJson(json);

  final Query$AllServices$services services;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$AllServicesToJson(this);
  int get hashCode {
    final l$services = services;
    final l$$__typename = $__typename;
    return Object.hashAll([l$services, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$AllServices) || runtimeType != other.runtimeType)
      return false;
    final l$services = services;
    final lOther$services = other.services;
    if (l$services != lOther$services) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$AllServices on Query$AllServices {
  CopyWith$Query$AllServices<Query$AllServices> get copyWith =>
      CopyWith$Query$AllServices(this, (i) => i);
}

abstract class CopyWith$Query$AllServices<TRes> {
  factory CopyWith$Query$AllServices(
          Query$AllServices instance, TRes Function(Query$AllServices) then) =
      _CopyWithImpl$Query$AllServices;

  factory CopyWith$Query$AllServices.stub(TRes res) =
      _CopyWithStubImpl$Query$AllServices;

  TRes call({Query$AllServices$services? services, String? $__typename});
  CopyWith$Query$AllServices$services<TRes> get services;
}

class _CopyWithImpl$Query$AllServices<TRes>
    implements CopyWith$Query$AllServices<TRes> {
  _CopyWithImpl$Query$AllServices(this._instance, this._then);

  final Query$AllServices _instance;

  final TRes Function(Query$AllServices) _then;

  static const _undefined = {};

  TRes call(
          {Object? services = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$AllServices(
          services: services == _undefined || services == null
              ? _instance.services
              : (services as Query$AllServices$services),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Query$AllServices$services<TRes> get services {
    final local$services = _instance.services;
    return CopyWith$Query$AllServices$services(
        local$services, (e) => call(services: e));
  }
}

class _CopyWithStubImpl$Query$AllServices<TRes>
    implements CopyWith$Query$AllServices<TRes> {
  _CopyWithStubImpl$Query$AllServices(this._res);

  TRes _res;

  call({Query$AllServices$services? services, String? $__typename}) => _res;
  CopyWith$Query$AllServices$services<TRes> get services =>
      CopyWith$Query$AllServices$services.stub(_res);
}

const documentNodeQueryAllServices = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'AllServices'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'services'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'allServices'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'description'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'displayName'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'dnsRecords'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'dnsRecordFields'),
                              directives: []),
                          FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ])),
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'isEnabled'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'isMovable'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'isRequired'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'status'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'storageUsage'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'title'),
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
                              name: NameNode(value: 'volume'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
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
                        name: NameNode(value: 'svgIcon'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'url'),
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
  fragmentDefinitiondnsRecordFields,
]);
Query$AllServices _parserFn$Query$AllServices(Map<String, dynamic> data) =>
    Query$AllServices.fromJson(data);

class Options$Query$AllServices
    extends graphql.QueryOptions<Query$AllServices> {
  Options$Query$AllServices(
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
            document: documentNodeQueryAllServices,
            parserFn: _parserFn$Query$AllServices);
}

class WatchOptions$Query$AllServices
    extends graphql.WatchQueryOptions<Query$AllServices> {
  WatchOptions$Query$AllServices(
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
            document: documentNodeQueryAllServices,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Query$AllServices);
}

class FetchMoreOptions$Query$AllServices extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$AllServices({required graphql.UpdateQuery updateQuery})
      : super(updateQuery: updateQuery, document: documentNodeQueryAllServices);
}

extension ClientExtension$Query$AllServices on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$AllServices>> query$AllServices(
          [Options$Query$AllServices? options]) async =>
      await this.query(options ?? Options$Query$AllServices());
  graphql.ObservableQuery<Query$AllServices> watchQuery$AllServices(
          [WatchOptions$Query$AllServices? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$AllServices());
  void writeQuery$AllServices(
          {required Query$AllServices data, bool broadcast = true}) =>
      this.writeQuery(
          graphql.Request(
              operation:
                  graphql.Operation(document: documentNodeQueryAllServices)),
          data: data.toJson(),
          broadcast: broadcast);
  Query$AllServices? readQuery$AllServices({bool optimistic = true}) {
    final result = this.readQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryAllServices)),
        optimistic: optimistic);
    return result == null ? null : Query$AllServices.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Query$AllServices$services {
  Query$AllServices$services(
      {required this.allServices, required this.$__typename});

  @override
  factory Query$AllServices$services.fromJson(Map<String, dynamic> json) =>
      _$Query$AllServices$servicesFromJson(json);

  final List<Query$AllServices$services$allServices> allServices;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$AllServices$servicesToJson(this);
  int get hashCode {
    final l$allServices = allServices;
    final l$$__typename = $__typename;
    return Object.hashAll(
        [Object.hashAll(l$allServices.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$AllServices$services) ||
        runtimeType != other.runtimeType) return false;
    final l$allServices = allServices;
    final lOther$allServices = other.allServices;
    if (l$allServices.length != lOther$allServices.length) return false;
    for (int i = 0; i < l$allServices.length; i++) {
      final l$allServices$entry = l$allServices[i];
      final lOther$allServices$entry = lOther$allServices[i];
      if (l$allServices$entry != lOther$allServices$entry) return false;
    }

    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$AllServices$services
    on Query$AllServices$services {
  CopyWith$Query$AllServices$services<Query$AllServices$services>
      get copyWith => CopyWith$Query$AllServices$services(this, (i) => i);
}

abstract class CopyWith$Query$AllServices$services<TRes> {
  factory CopyWith$Query$AllServices$services(
          Query$AllServices$services instance,
          TRes Function(Query$AllServices$services) then) =
      _CopyWithImpl$Query$AllServices$services;

  factory CopyWith$Query$AllServices$services.stub(TRes res) =
      _CopyWithStubImpl$Query$AllServices$services;

  TRes call(
      {List<Query$AllServices$services$allServices>? allServices,
      String? $__typename});
  TRes allServices(
      Iterable<Query$AllServices$services$allServices> Function(
              Iterable<
                  CopyWith$Query$AllServices$services$allServices<
                      Query$AllServices$services$allServices>>)
          _fn);
}

class _CopyWithImpl$Query$AllServices$services<TRes>
    implements CopyWith$Query$AllServices$services<TRes> {
  _CopyWithImpl$Query$AllServices$services(this._instance, this._then);

  final Query$AllServices$services _instance;

  final TRes Function(Query$AllServices$services) _then;

  static const _undefined = {};

  TRes call(
          {Object? allServices = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$AllServices$services(
          allServices: allServices == _undefined || allServices == null
              ? _instance.allServices
              : (allServices as List<Query$AllServices$services$allServices>),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  TRes allServices(
          Iterable<Query$AllServices$services$allServices> Function(
                  Iterable<
                      CopyWith$Query$AllServices$services$allServices<
                          Query$AllServices$services$allServices>>)
              _fn) =>
      call(
          allServices: _fn(_instance.allServices.map((e) =>
                  CopyWith$Query$AllServices$services$allServices(e, (i) => i)))
              .toList());
}

class _CopyWithStubImpl$Query$AllServices$services<TRes>
    implements CopyWith$Query$AllServices$services<TRes> {
  _CopyWithStubImpl$Query$AllServices$services(this._res);

  TRes _res;

  call(
          {List<Query$AllServices$services$allServices>? allServices,
          String? $__typename}) =>
      _res;
  allServices(_fn) => _res;
}

@JsonSerializable(explicitToJson: true)
class Query$AllServices$services$allServices {
  Query$AllServices$services$allServices(
      {required this.description,
      required this.displayName,
      this.dnsRecords,
      required this.id,
      required this.isEnabled,
      required this.isMovable,
      required this.isRequired,
      required this.status,
      required this.storageUsage,
      required this.svgIcon,
      this.url,
      required this.$__typename});

  @override
  factory Query$AllServices$services$allServices.fromJson(
          Map<String, dynamic> json) =>
      _$Query$AllServices$services$allServicesFromJson(json);

  final String description;

  final String displayName;

  final List<Fragment$dnsRecordFields>? dnsRecords;

  final String id;

  final bool isEnabled;

  final bool isMovable;

  final bool isRequired;

  @JsonKey(unknownEnumValue: Enum$ServiceStatusEnum.$unknown)
  final Enum$ServiceStatusEnum status;

  final Query$AllServices$services$allServices$storageUsage storageUsage;

  final String svgIcon;

  final String? url;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$AllServices$services$allServicesToJson(this);
  int get hashCode {
    final l$description = description;
    final l$displayName = displayName;
    final l$dnsRecords = dnsRecords;
    final l$id = id;
    final l$isEnabled = isEnabled;
    final l$isMovable = isMovable;
    final l$isRequired = isRequired;
    final l$status = status;
    final l$storageUsage = storageUsage;
    final l$svgIcon = svgIcon;
    final l$url = url;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$description,
      l$displayName,
      l$dnsRecords == null ? null : Object.hashAll(l$dnsRecords.map((v) => v)),
      l$id,
      l$isEnabled,
      l$isMovable,
      l$isRequired,
      l$status,
      l$storageUsage,
      l$svgIcon,
      l$url,
      l$$__typename
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$AllServices$services$allServices) ||
        runtimeType != other.runtimeType) return false;
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) return false;
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) return false;
    final l$dnsRecords = dnsRecords;
    final lOther$dnsRecords = other.dnsRecords;
    if (l$dnsRecords != null && lOther$dnsRecords != null) {
      if (l$dnsRecords.length != lOther$dnsRecords.length) return false;
      for (int i = 0; i < l$dnsRecords.length; i++) {
        final l$dnsRecords$entry = l$dnsRecords[i];
        final lOther$dnsRecords$entry = lOther$dnsRecords[i];
        if (l$dnsRecords$entry != lOther$dnsRecords$entry) return false;
      }
    } else if (l$dnsRecords != lOther$dnsRecords) {
      return false;
    }

    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) return false;
    final l$isEnabled = isEnabled;
    final lOther$isEnabled = other.isEnabled;
    if (l$isEnabled != lOther$isEnabled) return false;
    final l$isMovable = isMovable;
    final lOther$isMovable = other.isMovable;
    if (l$isMovable != lOther$isMovable) return false;
    final l$isRequired = isRequired;
    final lOther$isRequired = other.isRequired;
    if (l$isRequired != lOther$isRequired) return false;
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) return false;
    final l$storageUsage = storageUsage;
    final lOther$storageUsage = other.storageUsage;
    if (l$storageUsage != lOther$storageUsage) return false;
    final l$svgIcon = svgIcon;
    final lOther$svgIcon = other.svgIcon;
    if (l$svgIcon != lOther$svgIcon) return false;
    final l$url = url;
    final lOther$url = other.url;
    if (l$url != lOther$url) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$AllServices$services$allServices
    on Query$AllServices$services$allServices {
  CopyWith$Query$AllServices$services$allServices<
          Query$AllServices$services$allServices>
      get copyWith =>
          CopyWith$Query$AllServices$services$allServices(this, (i) => i);
}

abstract class CopyWith$Query$AllServices$services$allServices<TRes> {
  factory CopyWith$Query$AllServices$services$allServices(
          Query$AllServices$services$allServices instance,
          TRes Function(Query$AllServices$services$allServices) then) =
      _CopyWithImpl$Query$AllServices$services$allServices;

  factory CopyWith$Query$AllServices$services$allServices.stub(TRes res) =
      _CopyWithStubImpl$Query$AllServices$services$allServices;

  TRes call(
      {String? description,
      String? displayName,
      List<Fragment$dnsRecordFields>? dnsRecords,
      String? id,
      bool? isEnabled,
      bool? isMovable,
      bool? isRequired,
      Enum$ServiceStatusEnum? status,
      Query$AllServices$services$allServices$storageUsage? storageUsage,
      String? svgIcon,
      String? url,
      String? $__typename});
  TRes dnsRecords(
      Iterable<Fragment$dnsRecordFields>? Function(
              Iterable<
                  CopyWith$Fragment$dnsRecordFields<Fragment$dnsRecordFields>>?)
          _fn);
  CopyWith$Query$AllServices$services$allServices$storageUsage<TRes>
      get storageUsage;
}

class _CopyWithImpl$Query$AllServices$services$allServices<TRes>
    implements CopyWith$Query$AllServices$services$allServices<TRes> {
  _CopyWithImpl$Query$AllServices$services$allServices(
      this._instance, this._then);

  final Query$AllServices$services$allServices _instance;

  final TRes Function(Query$AllServices$services$allServices) _then;

  static const _undefined = {};

  TRes call(
          {Object? description = _undefined,
          Object? displayName = _undefined,
          Object? dnsRecords = _undefined,
          Object? id = _undefined,
          Object? isEnabled = _undefined,
          Object? isMovable = _undefined,
          Object? isRequired = _undefined,
          Object? status = _undefined,
          Object? storageUsage = _undefined,
          Object? svgIcon = _undefined,
          Object? url = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$AllServices$services$allServices(
          description: description == _undefined || description == null
              ? _instance.description
              : (description as String),
          displayName: displayName == _undefined || displayName == null
              ? _instance.displayName
              : (displayName as String),
          dnsRecords: dnsRecords == _undefined
              ? _instance.dnsRecords
              : (dnsRecords as List<Fragment$dnsRecordFields>?),
          id: id == _undefined || id == null ? _instance.id : (id as String),
          isEnabled: isEnabled == _undefined || isEnabled == null
              ? _instance.isEnabled
              : (isEnabled as bool),
          isMovable: isMovable == _undefined || isMovable == null
              ? _instance.isMovable
              : (isMovable as bool),
          isRequired: isRequired == _undefined || isRequired == null
              ? _instance.isRequired
              : (isRequired as bool),
          status: status == _undefined || status == null
              ? _instance.status
              : (status as Enum$ServiceStatusEnum),
          storageUsage: storageUsage == _undefined || storageUsage == null
              ? _instance.storageUsage
              : (storageUsage
                  as Query$AllServices$services$allServices$storageUsage),
          svgIcon: svgIcon == _undefined || svgIcon == null
              ? _instance.svgIcon
              : (svgIcon as String),
          url: url == _undefined ? _instance.url : (url as String?),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  TRes dnsRecords(
          Iterable<Fragment$dnsRecordFields>? Function(
                  Iterable<
                      CopyWith$Fragment$dnsRecordFields<
                          Fragment$dnsRecordFields>>?)
              _fn) =>
      call(
          dnsRecords: _fn(_instance.dnsRecords
                  ?.map((e) => CopyWith$Fragment$dnsRecordFields(e, (i) => i)))
              ?.toList());
  CopyWith$Query$AllServices$services$allServices$storageUsage<TRes>
      get storageUsage {
    final local$storageUsage = _instance.storageUsage;
    return CopyWith$Query$AllServices$services$allServices$storageUsage(
        local$storageUsage, (e) => call(storageUsage: e));
  }
}

class _CopyWithStubImpl$Query$AllServices$services$allServices<TRes>
    implements CopyWith$Query$AllServices$services$allServices<TRes> {
  _CopyWithStubImpl$Query$AllServices$services$allServices(this._res);

  TRes _res;

  call(
          {String? description,
          String? displayName,
          List<Fragment$dnsRecordFields>? dnsRecords,
          String? id,
          bool? isEnabled,
          bool? isMovable,
          bool? isRequired,
          Enum$ServiceStatusEnum? status,
          Query$AllServices$services$allServices$storageUsage? storageUsage,
          String? svgIcon,
          String? url,
          String? $__typename}) =>
      _res;
  dnsRecords(_fn) => _res;
  CopyWith$Query$AllServices$services$allServices$storageUsage<TRes>
      get storageUsage =>
          CopyWith$Query$AllServices$services$allServices$storageUsage.stub(
              _res);
}

@JsonSerializable(explicitToJson: true)
class Query$AllServices$services$allServices$storageUsage {
  Query$AllServices$services$allServices$storageUsage(
      {required this.title,
      required this.usedSpace,
      this.volume,
      required this.$__typename});

  @override
  factory Query$AllServices$services$allServices$storageUsage.fromJson(
          Map<String, dynamic> json) =>
      _$Query$AllServices$services$allServices$storageUsageFromJson(json);

  final String title;

  final String usedSpace;

  final Query$AllServices$services$allServices$storageUsage$volume? volume;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$AllServices$services$allServices$storageUsageToJson(this);
  int get hashCode {
    final l$title = title;
    final l$usedSpace = usedSpace;
    final l$volume = volume;
    final l$$__typename = $__typename;
    return Object.hashAll([l$title, l$usedSpace, l$volume, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$AllServices$services$allServices$storageUsage) ||
        runtimeType != other.runtimeType) return false;
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) return false;
    final l$usedSpace = usedSpace;
    final lOther$usedSpace = other.usedSpace;
    if (l$usedSpace != lOther$usedSpace) return false;
    final l$volume = volume;
    final lOther$volume = other.volume;
    if (l$volume != lOther$volume) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$AllServices$services$allServices$storageUsage
    on Query$AllServices$services$allServices$storageUsage {
  CopyWith$Query$AllServices$services$allServices$storageUsage<
          Query$AllServices$services$allServices$storageUsage>
      get copyWith =>
          CopyWith$Query$AllServices$services$allServices$storageUsage(
              this, (i) => i);
}

abstract class CopyWith$Query$AllServices$services$allServices$storageUsage<
    TRes> {
  factory CopyWith$Query$AllServices$services$allServices$storageUsage(
          Query$AllServices$services$allServices$storageUsage instance,
          TRes Function(Query$AllServices$services$allServices$storageUsage)
              then) =
      _CopyWithImpl$Query$AllServices$services$allServices$storageUsage;

  factory CopyWith$Query$AllServices$services$allServices$storageUsage.stub(
          TRes res) =
      _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage;

  TRes call(
      {String? title,
      String? usedSpace,
      Query$AllServices$services$allServices$storageUsage$volume? volume,
      String? $__typename});
  CopyWith$Query$AllServices$services$allServices$storageUsage$volume<TRes>
      get volume;
}

class _CopyWithImpl$Query$AllServices$services$allServices$storageUsage<TRes>
    implements
        CopyWith$Query$AllServices$services$allServices$storageUsage<TRes> {
  _CopyWithImpl$Query$AllServices$services$allServices$storageUsage(
      this._instance, this._then);

  final Query$AllServices$services$allServices$storageUsage _instance;

  final TRes Function(Query$AllServices$services$allServices$storageUsage)
      _then;

  static const _undefined = {};

  TRes call(
          {Object? title = _undefined,
          Object? usedSpace = _undefined,
          Object? volume = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Query$AllServices$services$allServices$storageUsage(
          title: title == _undefined || title == null
              ? _instance.title
              : (title as String),
          usedSpace: usedSpace == _undefined || usedSpace == null
              ? _instance.usedSpace
              : (usedSpace as String),
          volume: volume == _undefined
              ? _instance.volume
              : (volume
                  as Query$AllServices$services$allServices$storageUsage$volume?),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Query$AllServices$services$allServices$storageUsage$volume<TRes>
      get volume {
    final local$volume = _instance.volume;
    return local$volume == null
        ? CopyWith$Query$AllServices$services$allServices$storageUsage$volume
            .stub(_then(_instance))
        : CopyWith$Query$AllServices$services$allServices$storageUsage$volume(
            local$volume, (e) => call(volume: e));
  }
}

class _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage<
        TRes>
    implements
        CopyWith$Query$AllServices$services$allServices$storageUsage<TRes> {
  _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage(
      this._res);

  TRes _res;

  call(
          {String? title,
          String? usedSpace,
          Query$AllServices$services$allServices$storageUsage$volume? volume,
          String? $__typename}) =>
      _res;
  CopyWith$Query$AllServices$services$allServices$storageUsage$volume<TRes>
      get volume =>
          CopyWith$Query$AllServices$services$allServices$storageUsage$volume
              .stub(_res);
}

@JsonSerializable(explicitToJson: true)
class Query$AllServices$services$allServices$storageUsage$volume {
  Query$AllServices$services$allServices$storageUsage$volume(
      {required this.name, required this.$__typename});

  @override
  factory Query$AllServices$services$allServices$storageUsage$volume.fromJson(
          Map<String, dynamic> json) =>
      _$Query$AllServices$services$allServices$storageUsage$volumeFromJson(
          json);

  final String name;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$AllServices$services$allServices$storageUsage$volumeToJson(this);
  int get hashCode {
    final l$name = name;
    final l$$__typename = $__typename;
    return Object.hashAll([l$name, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other
            is Query$AllServices$services$allServices$storageUsage$volume) ||
        runtimeType != other.runtimeType) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$AllServices$services$allServices$storageUsage$volume
    on Query$AllServices$services$allServices$storageUsage$volume {
  CopyWith$Query$AllServices$services$allServices$storageUsage$volume<
          Query$AllServices$services$allServices$storageUsage$volume>
      get copyWith =>
          CopyWith$Query$AllServices$services$allServices$storageUsage$volume(
              this, (i) => i);
}

abstract class CopyWith$Query$AllServices$services$allServices$storageUsage$volume<
    TRes> {
  factory CopyWith$Query$AllServices$services$allServices$storageUsage$volume(
          Query$AllServices$services$allServices$storageUsage$volume instance,
          TRes Function(
                  Query$AllServices$services$allServices$storageUsage$volume)
              then) =
      _CopyWithImpl$Query$AllServices$services$allServices$storageUsage$volume;

  factory CopyWith$Query$AllServices$services$allServices$storageUsage$volume.stub(
          TRes res) =
      _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage$volume;

  TRes call({String? name, String? $__typename});
}

class _CopyWithImpl$Query$AllServices$services$allServices$storageUsage$volume<
        TRes>
    implements
        CopyWith$Query$AllServices$services$allServices$storageUsage$volume<
            TRes> {
  _CopyWithImpl$Query$AllServices$services$allServices$storageUsage$volume(
      this._instance, this._then);

  final Query$AllServices$services$allServices$storageUsage$volume _instance;

  final TRes Function(
      Query$AllServices$services$allServices$storageUsage$volume) _then;

  static const _undefined = {};

  TRes call({Object? name = _undefined, Object? $__typename = _undefined}) =>
      _then(Query$AllServices$services$allServices$storageUsage$volume(
          name: name == _undefined || name == null
              ? _instance.name
              : (name as String),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
}

class _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage$volume<
        TRes>
    implements
        CopyWith$Query$AllServices$services$allServices$storageUsage$volume<
            TRes> {
  _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage$volume(
      this._res);

  TRes _res;

  call({String? name, String? $__typename}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$EnableService {
  Variables$Mutation$EnableService({required this.serviceId});

  @override
  factory Variables$Mutation$EnableService.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$EnableServiceFromJson(json);

  final String serviceId;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$EnableServiceToJson(this);
  int get hashCode {
    final l$serviceId = serviceId;
    return Object.hashAll([l$serviceId]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$EnableService) ||
        runtimeType != other.runtimeType) return false;
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (l$serviceId != lOther$serviceId) return false;
    return true;
  }

  CopyWith$Variables$Mutation$EnableService<Variables$Mutation$EnableService>
      get copyWith => CopyWith$Variables$Mutation$EnableService(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$EnableService<TRes> {
  factory CopyWith$Variables$Mutation$EnableService(
          Variables$Mutation$EnableService instance,
          TRes Function(Variables$Mutation$EnableService) then) =
      _CopyWithImpl$Variables$Mutation$EnableService;

  factory CopyWith$Variables$Mutation$EnableService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$EnableService;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$EnableService<TRes>
    implements CopyWith$Variables$Mutation$EnableService<TRes> {
  _CopyWithImpl$Variables$Mutation$EnableService(this._instance, this._then);

  final Variables$Mutation$EnableService _instance;

  final TRes Function(Variables$Mutation$EnableService) _then;

  static const _undefined = {};

  TRes call({Object? serviceId = _undefined}) =>
      _then(Variables$Mutation$EnableService(
          serviceId: serviceId == _undefined || serviceId == null
              ? _instance.serviceId
              : (serviceId as String)));
}

class _CopyWithStubImpl$Variables$Mutation$EnableService<TRes>
    implements CopyWith$Variables$Mutation$EnableService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$EnableService(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Mutation$EnableService {
  Mutation$EnableService(
      {required this.enableService, required this.$__typename});

  @override
  factory Mutation$EnableService.fromJson(Map<String, dynamic> json) =>
      _$Mutation$EnableServiceFromJson(json);

  final Mutation$EnableService$enableService enableService;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$EnableServiceToJson(this);
  int get hashCode {
    final l$enableService = enableService;
    final l$$__typename = $__typename;
    return Object.hashAll([l$enableService, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$EnableService) || runtimeType != other.runtimeType)
      return false;
    final l$enableService = enableService;
    final lOther$enableService = other.enableService;
    if (l$enableService != lOther$enableService) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$EnableService on Mutation$EnableService {
  CopyWith$Mutation$EnableService<Mutation$EnableService> get copyWith =>
      CopyWith$Mutation$EnableService(this, (i) => i);
}

abstract class CopyWith$Mutation$EnableService<TRes> {
  factory CopyWith$Mutation$EnableService(Mutation$EnableService instance,
          TRes Function(Mutation$EnableService) then) =
      _CopyWithImpl$Mutation$EnableService;

  factory CopyWith$Mutation$EnableService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$EnableService;

  TRes call(
      {Mutation$EnableService$enableService? enableService,
      String? $__typename});
  CopyWith$Mutation$EnableService$enableService<TRes> get enableService;
}

class _CopyWithImpl$Mutation$EnableService<TRes>
    implements CopyWith$Mutation$EnableService<TRes> {
  _CopyWithImpl$Mutation$EnableService(this._instance, this._then);

  final Mutation$EnableService _instance;

  final TRes Function(Mutation$EnableService) _then;

  static const _undefined = {};

  TRes call(
          {Object? enableService = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$EnableService(
          enableService: enableService == _undefined || enableService == null
              ? _instance.enableService
              : (enableService as Mutation$EnableService$enableService),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$EnableService$enableService<TRes> get enableService {
    final local$enableService = _instance.enableService;
    return CopyWith$Mutation$EnableService$enableService(
        local$enableService, (e) => call(enableService: e));
  }
}

class _CopyWithStubImpl$Mutation$EnableService<TRes>
    implements CopyWith$Mutation$EnableService<TRes> {
  _CopyWithStubImpl$Mutation$EnableService(this._res);

  TRes _res;

  call(
          {Mutation$EnableService$enableService? enableService,
          String? $__typename}) =>
      _res;
  CopyWith$Mutation$EnableService$enableService<TRes> get enableService =>
      CopyWith$Mutation$EnableService$enableService.stub(_res);
}

const documentNodeMutationEnableService = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'EnableService'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'serviceId')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'enableService'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'serviceId'),
                  value: VariableNode(name: NameNode(value: 'serviceId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
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
Mutation$EnableService _parserFn$Mutation$EnableService(
        Map<String, dynamic> data) =>
    Mutation$EnableService.fromJson(data);
typedef OnMutationCompleted$Mutation$EnableService = FutureOr<void> Function(
    dynamic, Mutation$EnableService?);

class Options$Mutation$EnableService
    extends graphql.MutationOptions<Mutation$EnableService> {
  Options$Mutation$EnableService(
      {String? operationName,
      required Variables$Mutation$EnableService variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$EnableService? onCompleted,
      graphql.OnMutationUpdate<Mutation$EnableService>? update,
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
                        : _parserFn$Mutation$EnableService(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationEnableService,
            parserFn: _parserFn$Mutation$EnableService);

  final OnMutationCompleted$Mutation$EnableService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$EnableService
    extends graphql.WatchQueryOptions<Mutation$EnableService> {
  WatchOptions$Mutation$EnableService(
      {String? operationName,
      required Variables$Mutation$EnableService variables,
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
            document: documentNodeMutationEnableService,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$EnableService);
}

extension ClientExtension$Mutation$EnableService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$EnableService>> mutate$EnableService(
          Options$Mutation$EnableService options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$EnableService> watchMutation$EnableService(
          WatchOptions$Mutation$EnableService options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$EnableService$enableService
    implements Fragment$basicMutationReturnFields {
  Mutation$EnableService$enableService(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$EnableService$enableService.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$EnableService$enableServiceFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$EnableService$enableServiceToJson(this);
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
    if (!(other is Mutation$EnableService$enableService) ||
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

extension UtilityExtension$Mutation$EnableService$enableService
    on Mutation$EnableService$enableService {
  CopyWith$Mutation$EnableService$enableService<
          Mutation$EnableService$enableService>
      get copyWith =>
          CopyWith$Mutation$EnableService$enableService(this, (i) => i);
}

abstract class CopyWith$Mutation$EnableService$enableService<TRes> {
  factory CopyWith$Mutation$EnableService$enableService(
          Mutation$EnableService$enableService instance,
          TRes Function(Mutation$EnableService$enableService) then) =
      _CopyWithImpl$Mutation$EnableService$enableService;

  factory CopyWith$Mutation$EnableService$enableService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$EnableService$enableService;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$EnableService$enableService<TRes>
    implements CopyWith$Mutation$EnableService$enableService<TRes> {
  _CopyWithImpl$Mutation$EnableService$enableService(
      this._instance, this._then);

  final Mutation$EnableService$enableService _instance;

  final TRes Function(Mutation$EnableService$enableService) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$EnableService$enableService(
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

class _CopyWithStubImpl$Mutation$EnableService$enableService<TRes>
    implements CopyWith$Mutation$EnableService$enableService<TRes> {
  _CopyWithStubImpl$Mutation$EnableService$enableService(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$DisableService {
  Variables$Mutation$DisableService({required this.serviceId});

  @override
  factory Variables$Mutation$DisableService.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$DisableServiceFromJson(json);

  final String serviceId;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$DisableServiceToJson(this);
  int get hashCode {
    final l$serviceId = serviceId;
    return Object.hashAll([l$serviceId]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$DisableService) ||
        runtimeType != other.runtimeType) return false;
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (l$serviceId != lOther$serviceId) return false;
    return true;
  }

  CopyWith$Variables$Mutation$DisableService<Variables$Mutation$DisableService>
      get copyWith =>
          CopyWith$Variables$Mutation$DisableService(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$DisableService<TRes> {
  factory CopyWith$Variables$Mutation$DisableService(
          Variables$Mutation$DisableService instance,
          TRes Function(Variables$Mutation$DisableService) then) =
      _CopyWithImpl$Variables$Mutation$DisableService;

  factory CopyWith$Variables$Mutation$DisableService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$DisableService;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$DisableService<TRes>
    implements CopyWith$Variables$Mutation$DisableService<TRes> {
  _CopyWithImpl$Variables$Mutation$DisableService(this._instance, this._then);

  final Variables$Mutation$DisableService _instance;

  final TRes Function(Variables$Mutation$DisableService) _then;

  static const _undefined = {};

  TRes call({Object? serviceId = _undefined}) =>
      _then(Variables$Mutation$DisableService(
          serviceId: serviceId == _undefined || serviceId == null
              ? _instance.serviceId
              : (serviceId as String)));
}

class _CopyWithStubImpl$Variables$Mutation$DisableService<TRes>
    implements CopyWith$Variables$Mutation$DisableService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$DisableService(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Mutation$DisableService {
  Mutation$DisableService(
      {required this.disableService, required this.$__typename});

  @override
  factory Mutation$DisableService.fromJson(Map<String, dynamic> json) =>
      _$Mutation$DisableServiceFromJson(json);

  final Mutation$DisableService$disableService disableService;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$DisableServiceToJson(this);
  int get hashCode {
    final l$disableService = disableService;
    final l$$__typename = $__typename;
    return Object.hashAll([l$disableService, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$DisableService) || runtimeType != other.runtimeType)
      return false;
    final l$disableService = disableService;
    final lOther$disableService = other.disableService;
    if (l$disableService != lOther$disableService) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$DisableService on Mutation$DisableService {
  CopyWith$Mutation$DisableService<Mutation$DisableService> get copyWith =>
      CopyWith$Mutation$DisableService(this, (i) => i);
}

abstract class CopyWith$Mutation$DisableService<TRes> {
  factory CopyWith$Mutation$DisableService(Mutation$DisableService instance,
          TRes Function(Mutation$DisableService) then) =
      _CopyWithImpl$Mutation$DisableService;

  factory CopyWith$Mutation$DisableService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DisableService;

  TRes call(
      {Mutation$DisableService$disableService? disableService,
      String? $__typename});
  CopyWith$Mutation$DisableService$disableService<TRes> get disableService;
}

class _CopyWithImpl$Mutation$DisableService<TRes>
    implements CopyWith$Mutation$DisableService<TRes> {
  _CopyWithImpl$Mutation$DisableService(this._instance, this._then);

  final Mutation$DisableService _instance;

  final TRes Function(Mutation$DisableService) _then;

  static const _undefined = {};

  TRes call(
          {Object? disableService = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$DisableService(
          disableService: disableService == _undefined || disableService == null
              ? _instance.disableService
              : (disableService as Mutation$DisableService$disableService),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$DisableService$disableService<TRes> get disableService {
    final local$disableService = _instance.disableService;
    return CopyWith$Mutation$DisableService$disableService(
        local$disableService, (e) => call(disableService: e));
  }
}

class _CopyWithStubImpl$Mutation$DisableService<TRes>
    implements CopyWith$Mutation$DisableService<TRes> {
  _CopyWithStubImpl$Mutation$DisableService(this._res);

  TRes _res;

  call(
          {Mutation$DisableService$disableService? disableService,
          String? $__typename}) =>
      _res;
  CopyWith$Mutation$DisableService$disableService<TRes> get disableService =>
      CopyWith$Mutation$DisableService$disableService.stub(_res);
}

const documentNodeMutationDisableService = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DisableService'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'serviceId')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'disableService'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'serviceId'),
                  value: VariableNode(name: NameNode(value: 'serviceId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
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
Mutation$DisableService _parserFn$Mutation$DisableService(
        Map<String, dynamic> data) =>
    Mutation$DisableService.fromJson(data);
typedef OnMutationCompleted$Mutation$DisableService = FutureOr<void> Function(
    dynamic, Mutation$DisableService?);

class Options$Mutation$DisableService
    extends graphql.MutationOptions<Mutation$DisableService> {
  Options$Mutation$DisableService(
      {String? operationName,
      required Variables$Mutation$DisableService variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$DisableService? onCompleted,
      graphql.OnMutationUpdate<Mutation$DisableService>? update,
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
                        : _parserFn$Mutation$DisableService(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationDisableService,
            parserFn: _parserFn$Mutation$DisableService);

  final OnMutationCompleted$Mutation$DisableService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$DisableService
    extends graphql.WatchQueryOptions<Mutation$DisableService> {
  WatchOptions$Mutation$DisableService(
      {String? operationName,
      required Variables$Mutation$DisableService variables,
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
            document: documentNodeMutationDisableService,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$DisableService);
}

extension ClientExtension$Mutation$DisableService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$DisableService>> mutate$DisableService(
          Options$Mutation$DisableService options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$DisableService> watchMutation$DisableService(
          WatchOptions$Mutation$DisableService options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$DisableService$disableService
    implements Fragment$basicMutationReturnFields {
  Mutation$DisableService$disableService(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$DisableService$disableService.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$DisableService$disableServiceFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$DisableService$disableServiceToJson(this);
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
    if (!(other is Mutation$DisableService$disableService) ||
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

extension UtilityExtension$Mutation$DisableService$disableService
    on Mutation$DisableService$disableService {
  CopyWith$Mutation$DisableService$disableService<
          Mutation$DisableService$disableService>
      get copyWith =>
          CopyWith$Mutation$DisableService$disableService(this, (i) => i);
}

abstract class CopyWith$Mutation$DisableService$disableService<TRes> {
  factory CopyWith$Mutation$DisableService$disableService(
          Mutation$DisableService$disableService instance,
          TRes Function(Mutation$DisableService$disableService) then) =
      _CopyWithImpl$Mutation$DisableService$disableService;

  factory CopyWith$Mutation$DisableService$disableService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DisableService$disableService;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$DisableService$disableService<TRes>
    implements CopyWith$Mutation$DisableService$disableService<TRes> {
  _CopyWithImpl$Mutation$DisableService$disableService(
      this._instance, this._then);

  final Mutation$DisableService$disableService _instance;

  final TRes Function(Mutation$DisableService$disableService) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$DisableService$disableService(
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

class _CopyWithStubImpl$Mutation$DisableService$disableService<TRes>
    implements CopyWith$Mutation$DisableService$disableService<TRes> {
  _CopyWithStubImpl$Mutation$DisableService$disableService(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$StopService {
  Variables$Mutation$StopService({required this.serviceId});

  @override
  factory Variables$Mutation$StopService.fromJson(Map<String, dynamic> json) =>
      _$Variables$Mutation$StopServiceFromJson(json);

  final String serviceId;

  Map<String, dynamic> toJson() => _$Variables$Mutation$StopServiceToJson(this);
  int get hashCode {
    final l$serviceId = serviceId;
    return Object.hashAll([l$serviceId]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$StopService) ||
        runtimeType != other.runtimeType) return false;
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (l$serviceId != lOther$serviceId) return false;
    return true;
  }

  CopyWith$Variables$Mutation$StopService<Variables$Mutation$StopService>
      get copyWith => CopyWith$Variables$Mutation$StopService(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$StopService<TRes> {
  factory CopyWith$Variables$Mutation$StopService(
          Variables$Mutation$StopService instance,
          TRes Function(Variables$Mutation$StopService) then) =
      _CopyWithImpl$Variables$Mutation$StopService;

  factory CopyWith$Variables$Mutation$StopService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$StopService;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$StopService<TRes>
    implements CopyWith$Variables$Mutation$StopService<TRes> {
  _CopyWithImpl$Variables$Mutation$StopService(this._instance, this._then);

  final Variables$Mutation$StopService _instance;

  final TRes Function(Variables$Mutation$StopService) _then;

  static const _undefined = {};

  TRes call({Object? serviceId = _undefined}) =>
      _then(Variables$Mutation$StopService(
          serviceId: serviceId == _undefined || serviceId == null
              ? _instance.serviceId
              : (serviceId as String)));
}

class _CopyWithStubImpl$Variables$Mutation$StopService<TRes>
    implements CopyWith$Variables$Mutation$StopService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$StopService(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Mutation$StopService {
  Mutation$StopService({required this.stopService, required this.$__typename});

  @override
  factory Mutation$StopService.fromJson(Map<String, dynamic> json) =>
      _$Mutation$StopServiceFromJson(json);

  final Mutation$StopService$stopService stopService;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$StopServiceToJson(this);
  int get hashCode {
    final l$stopService = stopService;
    final l$$__typename = $__typename;
    return Object.hashAll([l$stopService, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$StopService) || runtimeType != other.runtimeType)
      return false;
    final l$stopService = stopService;
    final lOther$stopService = other.stopService;
    if (l$stopService != lOther$stopService) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$StopService on Mutation$StopService {
  CopyWith$Mutation$StopService<Mutation$StopService> get copyWith =>
      CopyWith$Mutation$StopService(this, (i) => i);
}

abstract class CopyWith$Mutation$StopService<TRes> {
  factory CopyWith$Mutation$StopService(Mutation$StopService instance,
          TRes Function(Mutation$StopService) then) =
      _CopyWithImpl$Mutation$StopService;

  factory CopyWith$Mutation$StopService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StopService;

  TRes call(
      {Mutation$StopService$stopService? stopService, String? $__typename});
  CopyWith$Mutation$StopService$stopService<TRes> get stopService;
}

class _CopyWithImpl$Mutation$StopService<TRes>
    implements CopyWith$Mutation$StopService<TRes> {
  _CopyWithImpl$Mutation$StopService(this._instance, this._then);

  final Mutation$StopService _instance;

  final TRes Function(Mutation$StopService) _then;

  static const _undefined = {};

  TRes call(
          {Object? stopService = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$StopService(
          stopService: stopService == _undefined || stopService == null
              ? _instance.stopService
              : (stopService as Mutation$StopService$stopService),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$StopService$stopService<TRes> get stopService {
    final local$stopService = _instance.stopService;
    return CopyWith$Mutation$StopService$stopService(
        local$stopService, (e) => call(stopService: e));
  }
}

class _CopyWithStubImpl$Mutation$StopService<TRes>
    implements CopyWith$Mutation$StopService<TRes> {
  _CopyWithStubImpl$Mutation$StopService(this._res);

  TRes _res;

  call({Mutation$StopService$stopService? stopService, String? $__typename}) =>
      _res;
  CopyWith$Mutation$StopService$stopService<TRes> get stopService =>
      CopyWith$Mutation$StopService$stopService.stub(_res);
}

const documentNodeMutationStopService = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'StopService'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'serviceId')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'stopService'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'serviceId'),
                  value: VariableNode(name: NameNode(value: 'serviceId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
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
Mutation$StopService _parserFn$Mutation$StopService(
        Map<String, dynamic> data) =>
    Mutation$StopService.fromJson(data);
typedef OnMutationCompleted$Mutation$StopService = FutureOr<void> Function(
    dynamic, Mutation$StopService?);

class Options$Mutation$StopService
    extends graphql.MutationOptions<Mutation$StopService> {
  Options$Mutation$StopService(
      {String? operationName,
      required Variables$Mutation$StopService variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$StopService? onCompleted,
      graphql.OnMutationUpdate<Mutation$StopService>? update,
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
                : (data) => onCompleted(data,
                    data == null ? null : _parserFn$Mutation$StopService(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationStopService,
            parserFn: _parserFn$Mutation$StopService);

  final OnMutationCompleted$Mutation$StopService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$StopService
    extends graphql.WatchQueryOptions<Mutation$StopService> {
  WatchOptions$Mutation$StopService(
      {String? operationName,
      required Variables$Mutation$StopService variables,
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
            document: documentNodeMutationStopService,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$StopService);
}

extension ClientExtension$Mutation$StopService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$StopService>> mutate$StopService(
          Options$Mutation$StopService options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$StopService> watchMutation$StopService(
          WatchOptions$Mutation$StopService options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$StopService$stopService
    implements Fragment$basicMutationReturnFields {
  Mutation$StopService$stopService(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$StopService$stopService.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$StopService$stopServiceFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$StopService$stopServiceToJson(this);
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
    if (!(other is Mutation$StopService$stopService) ||
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

extension UtilityExtension$Mutation$StopService$stopService
    on Mutation$StopService$stopService {
  CopyWith$Mutation$StopService$stopService<Mutation$StopService$stopService>
      get copyWith => CopyWith$Mutation$StopService$stopService(this, (i) => i);
}

abstract class CopyWith$Mutation$StopService$stopService<TRes> {
  factory CopyWith$Mutation$StopService$stopService(
          Mutation$StopService$stopService instance,
          TRes Function(Mutation$StopService$stopService) then) =
      _CopyWithImpl$Mutation$StopService$stopService;

  factory CopyWith$Mutation$StopService$stopService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StopService$stopService;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$StopService$stopService<TRes>
    implements CopyWith$Mutation$StopService$stopService<TRes> {
  _CopyWithImpl$Mutation$StopService$stopService(this._instance, this._then);

  final Mutation$StopService$stopService _instance;

  final TRes Function(Mutation$StopService$stopService) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$StopService$stopService(
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

class _CopyWithStubImpl$Mutation$StopService$stopService<TRes>
    implements CopyWith$Mutation$StopService$stopService<TRes> {
  _CopyWithStubImpl$Mutation$StopService$stopService(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$StartService {
  Variables$Mutation$StartService({required this.serviceId});

  @override
  factory Variables$Mutation$StartService.fromJson(Map<String, dynamic> json) =>
      _$Variables$Mutation$StartServiceFromJson(json);

  final String serviceId;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$StartServiceToJson(this);
  int get hashCode {
    final l$serviceId = serviceId;
    return Object.hashAll([l$serviceId]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$StartService) ||
        runtimeType != other.runtimeType) return false;
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (l$serviceId != lOther$serviceId) return false;
    return true;
  }

  CopyWith$Variables$Mutation$StartService<Variables$Mutation$StartService>
      get copyWith => CopyWith$Variables$Mutation$StartService(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$StartService<TRes> {
  factory CopyWith$Variables$Mutation$StartService(
          Variables$Mutation$StartService instance,
          TRes Function(Variables$Mutation$StartService) then) =
      _CopyWithImpl$Variables$Mutation$StartService;

  factory CopyWith$Variables$Mutation$StartService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$StartService;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$StartService<TRes>
    implements CopyWith$Variables$Mutation$StartService<TRes> {
  _CopyWithImpl$Variables$Mutation$StartService(this._instance, this._then);

  final Variables$Mutation$StartService _instance;

  final TRes Function(Variables$Mutation$StartService) _then;

  static const _undefined = {};

  TRes call({Object? serviceId = _undefined}) =>
      _then(Variables$Mutation$StartService(
          serviceId: serviceId == _undefined || serviceId == null
              ? _instance.serviceId
              : (serviceId as String)));
}

class _CopyWithStubImpl$Variables$Mutation$StartService<TRes>
    implements CopyWith$Variables$Mutation$StartService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$StartService(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Mutation$StartService {
  Mutation$StartService(
      {required this.startService, required this.$__typename});

  @override
  factory Mutation$StartService.fromJson(Map<String, dynamic> json) =>
      _$Mutation$StartServiceFromJson(json);

  final Mutation$StartService$startService startService;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$StartServiceToJson(this);
  int get hashCode {
    final l$startService = startService;
    final l$$__typename = $__typename;
    return Object.hashAll([l$startService, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$StartService) || runtimeType != other.runtimeType)
      return false;
    final l$startService = startService;
    final lOther$startService = other.startService;
    if (l$startService != lOther$startService) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$StartService on Mutation$StartService {
  CopyWith$Mutation$StartService<Mutation$StartService> get copyWith =>
      CopyWith$Mutation$StartService(this, (i) => i);
}

abstract class CopyWith$Mutation$StartService<TRes> {
  factory CopyWith$Mutation$StartService(Mutation$StartService instance,
          TRes Function(Mutation$StartService) then) =
      _CopyWithImpl$Mutation$StartService;

  factory CopyWith$Mutation$StartService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StartService;

  TRes call(
      {Mutation$StartService$startService? startService, String? $__typename});
  CopyWith$Mutation$StartService$startService<TRes> get startService;
}

class _CopyWithImpl$Mutation$StartService<TRes>
    implements CopyWith$Mutation$StartService<TRes> {
  _CopyWithImpl$Mutation$StartService(this._instance, this._then);

  final Mutation$StartService _instance;

  final TRes Function(Mutation$StartService) _then;

  static const _undefined = {};

  TRes call(
          {Object? startService = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$StartService(
          startService: startService == _undefined || startService == null
              ? _instance.startService
              : (startService as Mutation$StartService$startService),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$StartService$startService<TRes> get startService {
    final local$startService = _instance.startService;
    return CopyWith$Mutation$StartService$startService(
        local$startService, (e) => call(startService: e));
  }
}

class _CopyWithStubImpl$Mutation$StartService<TRes>
    implements CopyWith$Mutation$StartService<TRes> {
  _CopyWithStubImpl$Mutation$StartService(this._res);

  TRes _res;

  call(
          {Mutation$StartService$startService? startService,
          String? $__typename}) =>
      _res;
  CopyWith$Mutation$StartService$startService<TRes> get startService =>
      CopyWith$Mutation$StartService$startService.stub(_res);
}

const documentNodeMutationStartService = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'StartService'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'serviceId')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'startService'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'serviceId'),
                  value: VariableNode(name: NameNode(value: 'serviceId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
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
Mutation$StartService _parserFn$Mutation$StartService(
        Map<String, dynamic> data) =>
    Mutation$StartService.fromJson(data);
typedef OnMutationCompleted$Mutation$StartService = FutureOr<void> Function(
    dynamic, Mutation$StartService?);

class Options$Mutation$StartService
    extends graphql.MutationOptions<Mutation$StartService> {
  Options$Mutation$StartService(
      {String? operationName,
      required Variables$Mutation$StartService variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$StartService? onCompleted,
      graphql.OnMutationUpdate<Mutation$StartService>? update,
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
                        : _parserFn$Mutation$StartService(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationStartService,
            parserFn: _parserFn$Mutation$StartService);

  final OnMutationCompleted$Mutation$StartService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$StartService
    extends graphql.WatchQueryOptions<Mutation$StartService> {
  WatchOptions$Mutation$StartService(
      {String? operationName,
      required Variables$Mutation$StartService variables,
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
            document: documentNodeMutationStartService,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$StartService);
}

extension ClientExtension$Mutation$StartService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$StartService>> mutate$StartService(
          Options$Mutation$StartService options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$StartService> watchMutation$StartService(
          WatchOptions$Mutation$StartService options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$StartService$startService
    implements Fragment$basicMutationReturnFields {
  Mutation$StartService$startService(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$StartService$startService.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$StartService$startServiceFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$StartService$startServiceToJson(this);
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
    if (!(other is Mutation$StartService$startService) ||
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

extension UtilityExtension$Mutation$StartService$startService
    on Mutation$StartService$startService {
  CopyWith$Mutation$StartService$startService<
          Mutation$StartService$startService>
      get copyWith =>
          CopyWith$Mutation$StartService$startService(this, (i) => i);
}

abstract class CopyWith$Mutation$StartService$startService<TRes> {
  factory CopyWith$Mutation$StartService$startService(
          Mutation$StartService$startService instance,
          TRes Function(Mutation$StartService$startService) then) =
      _CopyWithImpl$Mutation$StartService$startService;

  factory CopyWith$Mutation$StartService$startService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StartService$startService;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$StartService$startService<TRes>
    implements CopyWith$Mutation$StartService$startService<TRes> {
  _CopyWithImpl$Mutation$StartService$startService(this._instance, this._then);

  final Mutation$StartService$startService _instance;

  final TRes Function(Mutation$StartService$startService) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$StartService$startService(
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

class _CopyWithStubImpl$Mutation$StartService$startService<TRes>
    implements CopyWith$Mutation$StartService$startService<TRes> {
  _CopyWithStubImpl$Mutation$StartService$startService(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$RestartService {
  Variables$Mutation$RestartService({required this.serviceId});

  @override
  factory Variables$Mutation$RestartService.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$RestartServiceFromJson(json);

  final String serviceId;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$RestartServiceToJson(this);
  int get hashCode {
    final l$serviceId = serviceId;
    return Object.hashAll([l$serviceId]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$RestartService) ||
        runtimeType != other.runtimeType) return false;
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (l$serviceId != lOther$serviceId) return false;
    return true;
  }

  CopyWith$Variables$Mutation$RestartService<Variables$Mutation$RestartService>
      get copyWith =>
          CopyWith$Variables$Mutation$RestartService(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$RestartService<TRes> {
  factory CopyWith$Variables$Mutation$RestartService(
          Variables$Mutation$RestartService instance,
          TRes Function(Variables$Mutation$RestartService) then) =
      _CopyWithImpl$Variables$Mutation$RestartService;

  factory CopyWith$Variables$Mutation$RestartService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$RestartService;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$RestartService<TRes>
    implements CopyWith$Variables$Mutation$RestartService<TRes> {
  _CopyWithImpl$Variables$Mutation$RestartService(this._instance, this._then);

  final Variables$Mutation$RestartService _instance;

  final TRes Function(Variables$Mutation$RestartService) _then;

  static const _undefined = {};

  TRes call({Object? serviceId = _undefined}) =>
      _then(Variables$Mutation$RestartService(
          serviceId: serviceId == _undefined || serviceId == null
              ? _instance.serviceId
              : (serviceId as String)));
}

class _CopyWithStubImpl$Variables$Mutation$RestartService<TRes>
    implements CopyWith$Variables$Mutation$RestartService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$RestartService(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Mutation$RestartService {
  Mutation$RestartService(
      {required this.restartService, required this.$__typename});

  @override
  factory Mutation$RestartService.fromJson(Map<String, dynamic> json) =>
      _$Mutation$RestartServiceFromJson(json);

  final Mutation$RestartService$restartService restartService;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$RestartServiceToJson(this);
  int get hashCode {
    final l$restartService = restartService;
    final l$$__typename = $__typename;
    return Object.hashAll([l$restartService, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$RestartService) || runtimeType != other.runtimeType)
      return false;
    final l$restartService = restartService;
    final lOther$restartService = other.restartService;
    if (l$restartService != lOther$restartService) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$RestartService on Mutation$RestartService {
  CopyWith$Mutation$RestartService<Mutation$RestartService> get copyWith =>
      CopyWith$Mutation$RestartService(this, (i) => i);
}

abstract class CopyWith$Mutation$RestartService<TRes> {
  factory CopyWith$Mutation$RestartService(Mutation$RestartService instance,
          TRes Function(Mutation$RestartService) then) =
      _CopyWithImpl$Mutation$RestartService;

  factory CopyWith$Mutation$RestartService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RestartService;

  TRes call(
      {Mutation$RestartService$restartService? restartService,
      String? $__typename});
  CopyWith$Mutation$RestartService$restartService<TRes> get restartService;
}

class _CopyWithImpl$Mutation$RestartService<TRes>
    implements CopyWith$Mutation$RestartService<TRes> {
  _CopyWithImpl$Mutation$RestartService(this._instance, this._then);

  final Mutation$RestartService _instance;

  final TRes Function(Mutation$RestartService) _then;

  static const _undefined = {};

  TRes call(
          {Object? restartService = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$RestartService(
          restartService: restartService == _undefined || restartService == null
              ? _instance.restartService
              : (restartService as Mutation$RestartService$restartService),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$RestartService$restartService<TRes> get restartService {
    final local$restartService = _instance.restartService;
    return CopyWith$Mutation$RestartService$restartService(
        local$restartService, (e) => call(restartService: e));
  }
}

class _CopyWithStubImpl$Mutation$RestartService<TRes>
    implements CopyWith$Mutation$RestartService<TRes> {
  _CopyWithStubImpl$Mutation$RestartService(this._res);

  TRes _res;

  call(
          {Mutation$RestartService$restartService? restartService,
          String? $__typename}) =>
      _res;
  CopyWith$Mutation$RestartService$restartService<TRes> get restartService =>
      CopyWith$Mutation$RestartService$restartService.stub(_res);
}

const documentNodeMutationRestartService = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RestartService'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'serviceId')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'restartService'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'serviceId'),
                  value: VariableNode(name: NameNode(value: 'serviceId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
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
Mutation$RestartService _parserFn$Mutation$RestartService(
        Map<String, dynamic> data) =>
    Mutation$RestartService.fromJson(data);
typedef OnMutationCompleted$Mutation$RestartService = FutureOr<void> Function(
    dynamic, Mutation$RestartService?);

class Options$Mutation$RestartService
    extends graphql.MutationOptions<Mutation$RestartService> {
  Options$Mutation$RestartService(
      {String? operationName,
      required Variables$Mutation$RestartService variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$RestartService? onCompleted,
      graphql.OnMutationUpdate<Mutation$RestartService>? update,
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
                        : _parserFn$Mutation$RestartService(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationRestartService,
            parserFn: _parserFn$Mutation$RestartService);

  final OnMutationCompleted$Mutation$RestartService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$RestartService
    extends graphql.WatchQueryOptions<Mutation$RestartService> {
  WatchOptions$Mutation$RestartService(
      {String? operationName,
      required Variables$Mutation$RestartService variables,
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
            document: documentNodeMutationRestartService,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$RestartService);
}

extension ClientExtension$Mutation$RestartService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RestartService>> mutate$RestartService(
          Options$Mutation$RestartService options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$RestartService> watchMutation$RestartService(
          WatchOptions$Mutation$RestartService options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$RestartService$restartService
    implements Fragment$basicMutationReturnFields {
  Mutation$RestartService$restartService(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$RestartService$restartService.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$RestartService$restartServiceFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$RestartService$restartServiceToJson(this);
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
    if (!(other is Mutation$RestartService$restartService) ||
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

extension UtilityExtension$Mutation$RestartService$restartService
    on Mutation$RestartService$restartService {
  CopyWith$Mutation$RestartService$restartService<
          Mutation$RestartService$restartService>
      get copyWith =>
          CopyWith$Mutation$RestartService$restartService(this, (i) => i);
}

abstract class CopyWith$Mutation$RestartService$restartService<TRes> {
  factory CopyWith$Mutation$RestartService$restartService(
          Mutation$RestartService$restartService instance,
          TRes Function(Mutation$RestartService$restartService) then) =
      _CopyWithImpl$Mutation$RestartService$restartService;

  factory CopyWith$Mutation$RestartService$restartService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RestartService$restartService;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$RestartService$restartService<TRes>
    implements CopyWith$Mutation$RestartService$restartService<TRes> {
  _CopyWithImpl$Mutation$RestartService$restartService(
      this._instance, this._then);

  final Mutation$RestartService$restartService _instance;

  final TRes Function(Mutation$RestartService$restartService) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$RestartService$restartService(
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

class _CopyWithStubImpl$Mutation$RestartService$restartService<TRes>
    implements CopyWith$Mutation$RestartService$restartService<TRes> {
  _CopyWithStubImpl$Mutation$RestartService$restartService(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$MoveService {
  Variables$Mutation$MoveService({required this.input});

  @override
  factory Variables$Mutation$MoveService.fromJson(Map<String, dynamic> json) =>
      _$Variables$Mutation$MoveServiceFromJson(json);

  final Input$MoveServiceInput input;

  Map<String, dynamic> toJson() => _$Variables$Mutation$MoveServiceToJson(this);
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$MoveService) ||
        runtimeType != other.runtimeType) return false;
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) return false;
    return true;
  }

  CopyWith$Variables$Mutation$MoveService<Variables$Mutation$MoveService>
      get copyWith => CopyWith$Variables$Mutation$MoveService(this, (i) => i);
}

abstract class CopyWith$Variables$Mutation$MoveService<TRes> {
  factory CopyWith$Variables$Mutation$MoveService(
          Variables$Mutation$MoveService instance,
          TRes Function(Variables$Mutation$MoveService) then) =
      _CopyWithImpl$Variables$Mutation$MoveService;

  factory CopyWith$Variables$Mutation$MoveService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$MoveService;

  TRes call({Input$MoveServiceInput? input});
}

class _CopyWithImpl$Variables$Mutation$MoveService<TRes>
    implements CopyWith$Variables$Mutation$MoveService<TRes> {
  _CopyWithImpl$Variables$Mutation$MoveService(this._instance, this._then);

  final Variables$Mutation$MoveService _instance;

  final TRes Function(Variables$Mutation$MoveService) _then;

  static const _undefined = {};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$MoveService(
          input: input == _undefined || input == null
              ? _instance.input
              : (input as Input$MoveServiceInput)));
}

class _CopyWithStubImpl$Variables$Mutation$MoveService<TRes>
    implements CopyWith$Variables$Mutation$MoveService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$MoveService(this._res);

  TRes _res;

  call({Input$MoveServiceInput? input}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Mutation$MoveService {
  Mutation$MoveService({required this.moveService, required this.$__typename});

  @override
  factory Mutation$MoveService.fromJson(Map<String, dynamic> json) =>
      _$Mutation$MoveServiceFromJson(json);

  final Mutation$MoveService$moveService moveService;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$MoveServiceToJson(this);
  int get hashCode {
    final l$moveService = moveService;
    final l$$__typename = $__typename;
    return Object.hashAll([l$moveService, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$MoveService) || runtimeType != other.runtimeType)
      return false;
    final l$moveService = moveService;
    final lOther$moveService = other.moveService;
    if (l$moveService != lOther$moveService) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$MoveService on Mutation$MoveService {
  CopyWith$Mutation$MoveService<Mutation$MoveService> get copyWith =>
      CopyWith$Mutation$MoveService(this, (i) => i);
}

abstract class CopyWith$Mutation$MoveService<TRes> {
  factory CopyWith$Mutation$MoveService(Mutation$MoveService instance,
          TRes Function(Mutation$MoveService) then) =
      _CopyWithImpl$Mutation$MoveService;

  factory CopyWith$Mutation$MoveService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MoveService;

  TRes call(
      {Mutation$MoveService$moveService? moveService, String? $__typename});
  CopyWith$Mutation$MoveService$moveService<TRes> get moveService;
}

class _CopyWithImpl$Mutation$MoveService<TRes>
    implements CopyWith$Mutation$MoveService<TRes> {
  _CopyWithImpl$Mutation$MoveService(this._instance, this._then);

  final Mutation$MoveService _instance;

  final TRes Function(Mutation$MoveService) _then;

  static const _undefined = {};

  TRes call(
          {Object? moveService = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$MoveService(
          moveService: moveService == _undefined || moveService == null
              ? _instance.moveService
              : (moveService as Mutation$MoveService$moveService),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
  CopyWith$Mutation$MoveService$moveService<TRes> get moveService {
    final local$moveService = _instance.moveService;
    return CopyWith$Mutation$MoveService$moveService(
        local$moveService, (e) => call(moveService: e));
  }
}

class _CopyWithStubImpl$Mutation$MoveService<TRes>
    implements CopyWith$Mutation$MoveService<TRes> {
  _CopyWithStubImpl$Mutation$MoveService(this._res);

  TRes _res;

  call({Mutation$MoveService$moveService? moveService, String? $__typename}) =>
      _res;
  CopyWith$Mutation$MoveService$moveService<TRes> get moveService =>
      CopyWith$Mutation$MoveService$moveService.stub(_res);
}

const documentNodeMutationMoveService = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'MoveService'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type: NamedTypeNode(
                name: NameNode(value: 'MoveServiceInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'moveService'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'input'),
                  value: VariableNode(name: NameNode(value: 'input')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
              FieldNode(
                  name: NameNode(value: 'job'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'createdAt'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'description'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'finishedAt'),
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
                        name: NameNode(value: 'progress'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'result'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'status'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'statusText'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'uid'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'updatedAt'),
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
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$MoveService _parserFn$Mutation$MoveService(
        Map<String, dynamic> data) =>
    Mutation$MoveService.fromJson(data);
typedef OnMutationCompleted$Mutation$MoveService = FutureOr<void> Function(
    dynamic, Mutation$MoveService?);

class Options$Mutation$MoveService
    extends graphql.MutationOptions<Mutation$MoveService> {
  Options$Mutation$MoveService(
      {String? operationName,
      required Variables$Mutation$MoveService variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$MoveService? onCompleted,
      graphql.OnMutationUpdate<Mutation$MoveService>? update,
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
                : (data) => onCompleted(data,
                    data == null ? null : _parserFn$Mutation$MoveService(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationMoveService,
            parserFn: _parserFn$Mutation$MoveService);

  final OnMutationCompleted$Mutation$MoveService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$MoveService
    extends graphql.WatchQueryOptions<Mutation$MoveService> {
  WatchOptions$Mutation$MoveService(
      {String? operationName,
      required Variables$Mutation$MoveService variables,
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
            document: documentNodeMutationMoveService,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$MoveService);
}

extension ClientExtension$Mutation$MoveService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$MoveService>> mutate$MoveService(
          Options$Mutation$MoveService options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$MoveService> watchMutation$MoveService(
          WatchOptions$Mutation$MoveService options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$MoveService$moveService
    implements Fragment$basicMutationReturnFields {
  Mutation$MoveService$moveService(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename,
      this.job});

  @override
  factory Mutation$MoveService$moveService.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$MoveService$moveServiceFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  final Mutation$MoveService$moveService$job? job;

  Map<String, dynamic> toJson() =>
      _$Mutation$MoveService$moveServiceToJson(this);
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
    if (identical(this, other)) return true;
    if (!(other is Mutation$MoveService$moveService) ||
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
    final l$job = job;
    final lOther$job = other.job;
    if (l$job != lOther$job) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$MoveService$moveService
    on Mutation$MoveService$moveService {
  CopyWith$Mutation$MoveService$moveService<Mutation$MoveService$moveService>
      get copyWith => CopyWith$Mutation$MoveService$moveService(this, (i) => i);
}

abstract class CopyWith$Mutation$MoveService$moveService<TRes> {
  factory CopyWith$Mutation$MoveService$moveService(
          Mutation$MoveService$moveService instance,
          TRes Function(Mutation$MoveService$moveService) then) =
      _CopyWithImpl$Mutation$MoveService$moveService;

  factory CopyWith$Mutation$MoveService$moveService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MoveService$moveService;

  TRes call(
      {int? code,
      String? message,
      bool? success,
      String? $__typename,
      Mutation$MoveService$moveService$job? job});
  CopyWith$Mutation$MoveService$moveService$job<TRes> get job;
}

class _CopyWithImpl$Mutation$MoveService$moveService<TRes>
    implements CopyWith$Mutation$MoveService$moveService<TRes> {
  _CopyWithImpl$Mutation$MoveService$moveService(this._instance, this._then);

  final Mutation$MoveService$moveService _instance;

  final TRes Function(Mutation$MoveService$moveService) _then;

  static const _undefined = {};

  TRes call(
          {Object? code = _undefined,
          Object? message = _undefined,
          Object? success = _undefined,
          Object? $__typename = _undefined,
          Object? job = _undefined}) =>
      _then(Mutation$MoveService$moveService(
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
          job: job == _undefined
              ? _instance.job
              : (job as Mutation$MoveService$moveService$job?)));
  CopyWith$Mutation$MoveService$moveService$job<TRes> get job {
    final local$job = _instance.job;
    return local$job == null
        ? CopyWith$Mutation$MoveService$moveService$job.stub(_then(_instance))
        : CopyWith$Mutation$MoveService$moveService$job(
            local$job, (e) => call(job: e));
  }
}

class _CopyWithStubImpl$Mutation$MoveService$moveService<TRes>
    implements CopyWith$Mutation$MoveService$moveService<TRes> {
  _CopyWithStubImpl$Mutation$MoveService$moveService(this._res);

  TRes _res;

  call(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          Mutation$MoveService$moveService$job? job}) =>
      _res;
  CopyWith$Mutation$MoveService$moveService$job<TRes> get job =>
      CopyWith$Mutation$MoveService$moveService$job.stub(_res);
}

@JsonSerializable(explicitToJson: true)
class Mutation$MoveService$moveService$job {
  Mutation$MoveService$moveService$job(
      {required this.createdAt,
      required this.description,
      this.error,
      this.finishedAt,
      required this.name,
      this.progress,
      this.result,
      required this.status,
      this.statusText,
      required this.uid,
      required this.updatedAt,
      required this.$__typename});

  @override
  factory Mutation$MoveService$moveService$job.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$MoveService$moveService$jobFromJson(json);

  @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime createdAt;

  final String description;

  final String? error;

  @JsonKey(
      fromJson: _nullable$dateTimeFromJson, toJson: _nullable$dateTimeToJson)
  final DateTime? finishedAt;

  final String name;

  final int? progress;

  final String? result;

  final String status;

  final String? statusText;

  final String uid;

  @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime updatedAt;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$MoveService$moveService$jobToJson(this);
  int get hashCode {
    final l$createdAt = createdAt;
    final l$description = description;
    final l$error = error;
    final l$finishedAt = finishedAt;
    final l$name = name;
    final l$progress = progress;
    final l$result = result;
    final l$status = status;
    final l$statusText = statusText;
    final l$uid = uid;
    final l$updatedAt = updatedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createdAt,
      l$description,
      l$error,
      l$finishedAt,
      l$name,
      l$progress,
      l$result,
      l$status,
      l$statusText,
      l$uid,
      l$updatedAt,
      l$$__typename
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$MoveService$moveService$job) ||
        runtimeType != other.runtimeType) return false;
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) return false;
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) return false;
    final l$error = error;
    final lOther$error = other.error;
    if (l$error != lOther$error) return false;
    final l$finishedAt = finishedAt;
    final lOther$finishedAt = other.finishedAt;
    if (l$finishedAt != lOther$finishedAt) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    final l$progress = progress;
    final lOther$progress = other.progress;
    if (l$progress != lOther$progress) return false;
    final l$result = result;
    final lOther$result = other.result;
    if (l$result != lOther$result) return false;
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) return false;
    final l$statusText = statusText;
    final lOther$statusText = other.statusText;
    if (l$statusText != lOther$statusText) return false;
    final l$uid = uid;
    final lOther$uid = other.uid;
    if (l$uid != lOther$uid) return false;
    final l$updatedAt = updatedAt;
    final lOther$updatedAt = other.updatedAt;
    if (l$updatedAt != lOther$updatedAt) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$MoveService$moveService$job
    on Mutation$MoveService$moveService$job {
  CopyWith$Mutation$MoveService$moveService$job<
          Mutation$MoveService$moveService$job>
      get copyWith =>
          CopyWith$Mutation$MoveService$moveService$job(this, (i) => i);
}

abstract class CopyWith$Mutation$MoveService$moveService$job<TRes> {
  factory CopyWith$Mutation$MoveService$moveService$job(
          Mutation$MoveService$moveService$job instance,
          TRes Function(Mutation$MoveService$moveService$job) then) =
      _CopyWithImpl$Mutation$MoveService$moveService$job;

  factory CopyWith$Mutation$MoveService$moveService$job.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MoveService$moveService$job;

  TRes call(
      {DateTime? createdAt,
      String? description,
      String? error,
      DateTime? finishedAt,
      String? name,
      int? progress,
      String? result,
      String? status,
      String? statusText,
      String? uid,
      DateTime? updatedAt,
      String? $__typename});
}

class _CopyWithImpl$Mutation$MoveService$moveService$job<TRes>
    implements CopyWith$Mutation$MoveService$moveService$job<TRes> {
  _CopyWithImpl$Mutation$MoveService$moveService$job(
      this._instance, this._then);

  final Mutation$MoveService$moveService$job _instance;

  final TRes Function(Mutation$MoveService$moveService$job) _then;

  static const _undefined = {};

  TRes call(
          {Object? createdAt = _undefined,
          Object? description = _undefined,
          Object? error = _undefined,
          Object? finishedAt = _undefined,
          Object? name = _undefined,
          Object? progress = _undefined,
          Object? result = _undefined,
          Object? status = _undefined,
          Object? statusText = _undefined,
          Object? uid = _undefined,
          Object? updatedAt = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Mutation$MoveService$moveService$job(
          createdAt: createdAt == _undefined || createdAt == null
              ? _instance.createdAt
              : (createdAt as DateTime),
          description: description == _undefined || description == null
              ? _instance.description
              : (description as String),
          error: error == _undefined ? _instance.error : (error as String?),
          finishedAt: finishedAt == _undefined
              ? _instance.finishedAt
              : (finishedAt as DateTime?),
          name: name == _undefined || name == null
              ? _instance.name
              : (name as String),
          progress:
              progress == _undefined ? _instance.progress : (progress as int?),
          result: result == _undefined ? _instance.result : (result as String?),
          status: status == _undefined || status == null
              ? _instance.status
              : (status as String),
          statusText: statusText == _undefined
              ? _instance.statusText
              : (statusText as String?),
          uid: uid == _undefined || uid == null
              ? _instance.uid
              : (uid as String),
          updatedAt: updatedAt == _undefined || updatedAt == null
              ? _instance.updatedAt
              : (updatedAt as DateTime),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
}

class _CopyWithStubImpl$Mutation$MoveService$moveService$job<TRes>
    implements CopyWith$Mutation$MoveService$moveService$job<TRes> {
  _CopyWithStubImpl$Mutation$MoveService$moveService$job(this._res);

  TRes _res;

  call(
          {DateTime? createdAt,
          String? description,
          String? error,
          DateTime? finishedAt,
          String? name,
          int? progress,
          String? result,
          String? status,
          String? statusText,
          String? uid,
          DateTime? updatedAt,
          String? $__typename}) =>
      _res;
}

DateTime? _nullable$dateTimeFromJson(dynamic data) =>
    data == null ? null : dateTimeFromJson(data);
dynamic _nullable$dateTimeToJson(DateTime? data) =>
    data == null ? null : dateTimeToJson(data);
