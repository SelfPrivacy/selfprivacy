import 'dart:async';
import 'disk_volumes.graphql.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/utils/scalars.dart';
import 'schema.graphql.dart';
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
  Query$AllServices copyWith(
          {Query$AllServices$services? services, String? $__typename}) =>
      Query$AllServices(
          services: services == null ? this.services : services,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Query$AllServices$services copyWith(
          {List<Query$AllServices$services$allServices>? allServices,
          String? $__typename}) =>
      Query$AllServices$services(
          allServices: allServices == null ? this.allServices : allServices,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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

  final List<Query$AllServices$services$allServices$dnsRecords>? dnsRecords;

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
  Query$AllServices$services$allServices copyWith(
          {String? description,
          String? displayName,
          List<Query$AllServices$services$allServices$dnsRecords>? Function()?
              dnsRecords,
          String? id,
          bool? isEnabled,
          bool? isMovable,
          bool? isRequired,
          Enum$ServiceStatusEnum? status,
          Query$AllServices$services$allServices$storageUsage? storageUsage,
          String? svgIcon,
          String? Function()? url,
          String? $__typename}) =>
      Query$AllServices$services$allServices(
          description: description == null ? this.description : description,
          displayName: displayName == null ? this.displayName : displayName,
          dnsRecords: dnsRecords == null ? this.dnsRecords : dnsRecords(),
          id: id == null ? this.id : id,
          isEnabled: isEnabled == null ? this.isEnabled : isEnabled,
          isMovable: isMovable == null ? this.isMovable : isMovable,
          isRequired: isRequired == null ? this.isRequired : isRequired,
          status: status == null ? this.status : status,
          storageUsage: storageUsage == null ? this.storageUsage : storageUsage,
          svgIcon: svgIcon == null ? this.svgIcon : svgIcon,
          url: url == null ? this.url : url(),
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Query$AllServices$services$allServices$dnsRecords {
  Query$AllServices$services$allServices$dnsRecords(
      {required this.content,
      required this.name,
      this.priority,
      required this.recordType,
      required this.ttl,
      required this.$__typename});

  @override
  factory Query$AllServices$services$allServices$dnsRecords.fromJson(
          Map<String, dynamic> json) =>
      _$Query$AllServices$services$allServices$dnsRecordsFromJson(json);

  final String content;

  final String name;

  final int? priority;

  final String recordType;

  final int ttl;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$AllServices$services$allServices$dnsRecordsToJson(this);
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
    if (!(other is Query$AllServices$services$allServices$dnsRecords) ||
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

extension UtilityExtension$Query$AllServices$services$allServices$dnsRecords
    on Query$AllServices$services$allServices$dnsRecords {
  Query$AllServices$services$allServices$dnsRecords copyWith(
          {String? content,
          String? name,
          int? Function()? priority,
          String? recordType,
          int? ttl,
          String? $__typename}) =>
      Query$AllServices$services$allServices$dnsRecords(
          content: content == null ? this.content : content,
          name: name == null ? this.name : name,
          priority: priority == null ? this.priority : priority(),
          recordType: recordType == null ? this.recordType : recordType,
          ttl: ttl == null ? this.ttl : ttl,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Query$AllServices$services$allServices$storageUsage copyWith(
          {String? title,
          String? usedSpace,
          Query$AllServices$services$allServices$storageUsage$volume?
                  Function()?
              volume,
          String? $__typename}) =>
      Query$AllServices$services$allServices$storageUsage(
          title: title == null ? this.title : title,
          usedSpace: usedSpace == null ? this.usedSpace : usedSpace,
          volume: volume == null ? this.volume : volume(),
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Query$AllServices$services$allServices$storageUsage$volume copyWith(
          {String? name, String? $__typename}) =>
      Query$AllServices$services$allServices$storageUsage$volume(
          name: name == null ? this.name : name,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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

  Variables$Mutation$EnableService copyWith({String? serviceId}) =>
      Variables$Mutation$EnableService(
          serviceId: serviceId == null ? this.serviceId : serviceId);
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
  Mutation$EnableService copyWith(
          {Mutation$EnableService$enableService? enableService,
          String? $__typename}) =>
      Mutation$EnableService(
          enableService:
              enableService == null ? this.enableService : enableService,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Mutation$EnableService$enableService copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$EnableService$enableService(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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

  Variables$Mutation$DisableService copyWith({String? serviceId}) =>
      Variables$Mutation$DisableService(
          serviceId: serviceId == null ? this.serviceId : serviceId);
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
  Mutation$DisableService copyWith(
          {Mutation$DisableService$disableService? disableService,
          String? $__typename}) =>
      Mutation$DisableService(
          disableService:
              disableService == null ? this.disableService : disableService,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Mutation$DisableService$disableService copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$DisableService$disableService(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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

  Variables$Mutation$StopService copyWith({String? serviceId}) =>
      Variables$Mutation$StopService(
          serviceId: serviceId == null ? this.serviceId : serviceId);
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
  Mutation$StopService copyWith(
          {Mutation$StopService$stopService? stopService,
          String? $__typename}) =>
      Mutation$StopService(
          stopService: stopService == null ? this.stopService : stopService,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Mutation$StopService$stopService copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$StopService$stopService(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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

  Variables$Mutation$StartService copyWith({String? serviceId}) =>
      Variables$Mutation$StartService(
          serviceId: serviceId == null ? this.serviceId : serviceId);
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
  Mutation$StartService copyWith(
          {Mutation$StartService$startService? startService,
          String? $__typename}) =>
      Mutation$StartService(
          startService: startService == null ? this.startService : startService,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Mutation$StartService$startService copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$StartService$startService(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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

  Variables$Mutation$RestartService copyWith({String? serviceId}) =>
      Variables$Mutation$RestartService(
          serviceId: serviceId == null ? this.serviceId : serviceId);
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
  Mutation$RestartService copyWith(
          {Mutation$RestartService$restartService? restartService,
          String? $__typename}) =>
      Mutation$RestartService(
          restartService:
              restartService == null ? this.restartService : restartService,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Mutation$RestartService$restartService copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$RestartService$restartService(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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

  Variables$Mutation$MoveService copyWith({Input$MoveServiceInput? input}) =>
      Variables$Mutation$MoveService(input: input == null ? this.input : input);
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
  Mutation$MoveService copyWith(
          {Mutation$MoveService$moveService? moveService,
          String? $__typename}) =>
      Mutation$MoveService(
          moveService: moveService == null ? this.moveService : moveService,
          $__typename: $__typename == null ? this.$__typename : $__typename);
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
  Mutation$MoveService$moveService copyWith(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          Mutation$MoveService$moveService$job? Function()? job}) =>
      Mutation$MoveService$moveService(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename,
          job: job == null ? this.job : job());
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
  Mutation$MoveService$moveService$job copyWith(
          {DateTime? createdAt,
          String? description,
          String? Function()? error,
          DateTime? Function()? finishedAt,
          String? name,
          int? Function()? progress,
          String? Function()? result,
          String? status,
          String? Function()? statusText,
          String? uid,
          DateTime? updatedAt,
          String? $__typename}) =>
      Mutation$MoveService$moveService$job(
          createdAt: createdAt == null ? this.createdAt : createdAt,
          description: description == null ? this.description : description,
          error: error == null ? this.error : error(),
          finishedAt: finishedAt == null ? this.finishedAt : finishedAt(),
          name: name == null ? this.name : name,
          progress: progress == null ? this.progress : progress(),
          result: result == null ? this.result : result(),
          status: status == null ? this.status : status,
          statusText: statusText == null ? this.statusText : statusText(),
          uid: uid == null ? this.uid : uid,
          updatedAt: updatedAt == null ? this.updatedAt : updatedAt,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

DateTime? _nullable$dateTimeFromJson(dynamic data) =>
    data == null ? null : dateTimeFromJson(data);
dynamic _nullable$dateTimeToJson(DateTime? data) =>
    data == null ? null : dateTimeToJson(data);
