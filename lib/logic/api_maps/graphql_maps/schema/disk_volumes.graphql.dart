import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/utils/scalars.dart';
import 'schema.graphql.dart';
part 'disk_volumes.graphql.g.dart';

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
class Query$GetServerDiskVolumes {
  Query$GetServerDiskVolumes(
      {required this.storage, required this.$__typename});

  @override
  factory Query$GetServerDiskVolumes.fromJson(Map<String, dynamic> json) =>
      _$Query$GetServerDiskVolumesFromJson(json);

  final Query$GetServerDiskVolumes$storage storage;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetServerDiskVolumesToJson(this);
  int get hashCode {
    final l$storage = storage;
    final l$$__typename = $__typename;
    return Object.hashAll([l$storage, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetServerDiskVolumes) ||
        runtimeType != other.runtimeType) return false;
    final l$storage = storage;
    final lOther$storage = other.storage;
    if (l$storage != lOther$storage) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetServerDiskVolumes
    on Query$GetServerDiskVolumes {
  Query$GetServerDiskVolumes copyWith(
          {Query$GetServerDiskVolumes$storage? storage, String? $__typename}) =>
      Query$GetServerDiskVolumes(
          storage: storage == null ? this.storage : storage,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeQueryGetServerDiskVolumes = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetServerDiskVolumes'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'storage'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'volumes'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'freeSpace'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'model'),
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
                        name: NameNode(value: 'root'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'serial'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'totalSpace'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'type'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'usages'),
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
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          InlineFragmentNode(
                              typeCondition: TypeConditionNode(
                                  on: NamedTypeNode(
                                      name: NameNode(
                                          value: 'ServiceStorageUsage'),
                                      isNonNull: false)),
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'service'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'id'),
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
                                          name: NameNode(value: 'displayName'),
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
                              ]))
                        ])),
                    FieldNode(
                        name: NameNode(value: 'usedSpace'),
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
Query$GetServerDiskVolumes _parserFn$Query$GetServerDiskVolumes(
        Map<String, dynamic> data) =>
    Query$GetServerDiskVolumes.fromJson(data);

class Options$Query$GetServerDiskVolumes
    extends graphql.QueryOptions<Query$GetServerDiskVolumes> {
  Options$Query$GetServerDiskVolumes(
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
            document: documentNodeQueryGetServerDiskVolumes,
            parserFn: _parserFn$Query$GetServerDiskVolumes);
}

class WatchOptions$Query$GetServerDiskVolumes
    extends graphql.WatchQueryOptions<Query$GetServerDiskVolumes> {
  WatchOptions$Query$GetServerDiskVolumes(
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
            document: documentNodeQueryGetServerDiskVolumes,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Query$GetServerDiskVolumes);
}

class FetchMoreOptions$Query$GetServerDiskVolumes
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetServerDiskVolumes(
      {required graphql.UpdateQuery updateQuery})
      : super(
            updateQuery: updateQuery,
            document: documentNodeQueryGetServerDiskVolumes);
}

extension ClientExtension$Query$GetServerDiskVolumes on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetServerDiskVolumes>>
      query$GetServerDiskVolumes(
              [Options$Query$GetServerDiskVolumes? options]) async =>
          await this.query(options ?? Options$Query$GetServerDiskVolumes());
  graphql.ObservableQuery<Query$GetServerDiskVolumes>
      watchQuery$GetServerDiskVolumes(
              [WatchOptions$Query$GetServerDiskVolumes? options]) =>
          this.watchQuery(options ?? WatchOptions$Query$GetServerDiskVolumes());
  void writeQuery$GetServerDiskVolumes(
          {required Query$GetServerDiskVolumes data, bool broadcast = true}) =>
      this.writeQuery(
          graphql.Request(
              operation: graphql.Operation(
                  document: documentNodeQueryGetServerDiskVolumes)),
          data: data.toJson(),
          broadcast: broadcast);
  Query$GetServerDiskVolumes? readQuery$GetServerDiskVolumes(
      {bool optimistic = true}) {
    final result = this.readQuery(
        graphql.Request(
            operation: graphql.Operation(
                document: documentNodeQueryGetServerDiskVolumes)),
        optimistic: optimistic);
    return result == null ? null : Query$GetServerDiskVolumes.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Query$GetServerDiskVolumes$storage {
  Query$GetServerDiskVolumes$storage(
      {required this.volumes, required this.$__typename});

  @override
  factory Query$GetServerDiskVolumes$storage.fromJson(
          Map<String, dynamic> json) =>
      _$Query$GetServerDiskVolumes$storageFromJson(json);

  final List<Query$GetServerDiskVolumes$storage$volumes> volumes;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$GetServerDiskVolumes$storageToJson(this);
  int get hashCode {
    final l$volumes = volumes;
    final l$$__typename = $__typename;
    return Object.hashAll(
        [Object.hashAll(l$volumes.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetServerDiskVolumes$storage) ||
        runtimeType != other.runtimeType) return false;
    final l$volumes = volumes;
    final lOther$volumes = other.volumes;
    if (l$volumes.length != lOther$volumes.length) return false;
    for (int i = 0; i < l$volumes.length; i++) {
      final l$volumes$entry = l$volumes[i];
      final lOther$volumes$entry = lOther$volumes[i];
      if (l$volumes$entry != lOther$volumes$entry) return false;
    }

    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetServerDiskVolumes$storage
    on Query$GetServerDiskVolumes$storage {
  Query$GetServerDiskVolumes$storage copyWith(
          {List<Query$GetServerDiskVolumes$storage$volumes>? volumes,
          String? $__typename}) =>
      Query$GetServerDiskVolumes$storage(
          volumes: volumes == null ? this.volumes : volumes,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Query$GetServerDiskVolumes$storage$volumes {
  Query$GetServerDiskVolumes$storage$volumes(
      {required this.freeSpace,
      this.model,
      required this.name,
      required this.root,
      this.serial,
      required this.totalSpace,
      required this.type,
      required this.usages,
      required this.usedSpace,
      required this.$__typename});

  @override
  factory Query$GetServerDiskVolumes$storage$volumes.fromJson(
          Map<String, dynamic> json) =>
      _$Query$GetServerDiskVolumes$storage$volumesFromJson(json);

  final String freeSpace;

  final String? model;

  final String name;

  final bool root;

  final String? serial;

  final String totalSpace;

  final String type;

  final List<Query$GetServerDiskVolumes$storage$volumes$usages> usages;

  final String usedSpace;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$GetServerDiskVolumes$storage$volumesToJson(this);
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
      l$$__typename
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetServerDiskVolumes$storage$volumes) ||
        runtimeType != other.runtimeType) return false;
    final l$freeSpace = freeSpace;
    final lOther$freeSpace = other.freeSpace;
    if (l$freeSpace != lOther$freeSpace) return false;
    final l$model = model;
    final lOther$model = other.model;
    if (l$model != lOther$model) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    final l$root = root;
    final lOther$root = other.root;
    if (l$root != lOther$root) return false;
    final l$serial = serial;
    final lOther$serial = other.serial;
    if (l$serial != lOther$serial) return false;
    final l$totalSpace = totalSpace;
    final lOther$totalSpace = other.totalSpace;
    if (l$totalSpace != lOther$totalSpace) return false;
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) return false;
    final l$usages = usages;
    final lOther$usages = other.usages;
    if (l$usages.length != lOther$usages.length) return false;
    for (int i = 0; i < l$usages.length; i++) {
      final l$usages$entry = l$usages[i];
      final lOther$usages$entry = lOther$usages[i];
      if (l$usages$entry != lOther$usages$entry) return false;
    }

    final l$usedSpace = usedSpace;
    final lOther$usedSpace = other.usedSpace;
    if (l$usedSpace != lOther$usedSpace) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetServerDiskVolumes$storage$volumes
    on Query$GetServerDiskVolumes$storage$volumes {
  Query$GetServerDiskVolumes$storage$volumes copyWith(
          {String? freeSpace,
          String? Function()? model,
          String? name,
          bool? root,
          String? Function()? serial,
          String? totalSpace,
          String? type,
          List<Query$GetServerDiskVolumes$storage$volumes$usages>? usages,
          String? usedSpace,
          String? $__typename}) =>
      Query$GetServerDiskVolumes$storage$volumes(
          freeSpace: freeSpace == null ? this.freeSpace : freeSpace,
          model: model == null ? this.model : model(),
          name: name == null ? this.name : name,
          root: root == null ? this.root : root,
          serial: serial == null ? this.serial : serial(),
          totalSpace: totalSpace == null ? this.totalSpace : totalSpace,
          type: type == null ? this.type : type,
          usages: usages == null ? this.usages : usages,
          usedSpace: usedSpace == null ? this.usedSpace : usedSpace,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Query$GetServerDiskVolumes$storage$volumes$usages {
  Query$GetServerDiskVolumes$storage$volumes$usages(
      {required this.title,
      required this.usedSpace,
      required this.$__typename});

  @override
  factory Query$GetServerDiskVolumes$storage$volumes$usages.fromJson(
      Map<String, dynamic> json) {
    switch (json["__typename"] as String) {
      case "ServiceStorageUsage":
        return Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage
            .fromJson(json);
      default:
        return _$Query$GetServerDiskVolumes$storage$volumes$usagesFromJson(
            json);
    }
  }

  final String title;

  final String usedSpace;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$GetServerDiskVolumes$storage$volumes$usagesToJson(this);
  int get hashCode {
    final l$title = title;
    final l$usedSpace = usedSpace;
    final l$$__typename = $__typename;
    return Object.hashAll([l$title, l$usedSpace, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetServerDiskVolumes$storage$volumes$usages) ||
        runtimeType != other.runtimeType) return false;
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) return false;
    final l$usedSpace = usedSpace;
    final lOther$usedSpace = other.usedSpace;
    if (l$usedSpace != lOther$usedSpace) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetServerDiskVolumes$storage$volumes$usages
    on Query$GetServerDiskVolumes$storage$volumes$usages {
  Query$GetServerDiskVolumes$storage$volumes$usages copyWith(
          {String? title, String? usedSpace, String? $__typename}) =>
      Query$GetServerDiskVolumes$storage$volumes$usages(
          title: title == null ? this.title : title,
          usedSpace: usedSpace == null ? this.usedSpace : usedSpace,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage
    implements Query$GetServerDiskVolumes$storage$volumes$usages {
  Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage(
      {required this.title,
      required this.usedSpace,
      required this.$__typename,
      this.service});

  @override
  factory Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage.fromJson(
          Map<String, dynamic> json) =>
      _$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsageFromJson(
          json);

  final String title;

  final String usedSpace;

  @JsonKey(name: '__typename')
  final String $__typename;

  final Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service?
      service;

  Map<String, dynamic> toJson() =>
      _$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsageToJson(
          this);
  int get hashCode {
    final l$title = title;
    final l$usedSpace = usedSpace;
    final l$$__typename = $__typename;
    final l$service = service;
    return Object.hashAll([l$title, l$usedSpace, l$$__typename, l$service]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other
            is Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage) ||
        runtimeType != other.runtimeType) return false;
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) return false;
    final l$usedSpace = usedSpace;
    final lOther$usedSpace = other.usedSpace;
    if (l$usedSpace != lOther$usedSpace) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    final l$service = service;
    final lOther$service = other.service;
    if (l$service != lOther$service) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage
    on Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage {
  Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage copyWith(
          {String? title,
          String? usedSpace,
          String? $__typename,
          Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service?
                  Function()?
              service}) =>
      Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage(
          title: title == null ? this.title : title,
          usedSpace: usedSpace == null ? this.usedSpace : usedSpace,
          $__typename: $__typename == null ? this.$__typename : $__typename,
          service: service == null ? this.service : service());
}

@JsonSerializable(explicitToJson: true)
class Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service {
  Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
      {required this.id,
      required this.isMovable,
      required this.displayName,
      required this.$__typename});

  @override
  factory Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service.fromJson(
          Map<String, dynamic> json) =>
      _$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$serviceFromJson(
          json);

  final String id;

  final bool isMovable;

  final String displayName;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$serviceToJson(
          this);
  int get hashCode {
    final l$id = id;
    final l$isMovable = isMovable;
    final l$displayName = displayName;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$isMovable, l$displayName, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other
            is Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service) ||
        runtimeType != other.runtimeType) return false;
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) return false;
    final l$isMovable = isMovable;
    final lOther$isMovable = other.isMovable;
    if (l$isMovable != lOther$isMovable) return false;
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service
    on Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service {
  Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service
      copyWith(
              {String? id,
              bool? isMovable,
              String? displayName,
              String? $__typename}) =>
          Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
              id: id == null ? this.id : id,
              isMovable: isMovable == null ? this.isMovable : isMovable,
              displayName: displayName == null ? this.displayName : displayName,
              $__typename:
                  $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$MountVolume {
  Variables$Mutation$MountVolume({required this.name});

  @override
  factory Variables$Mutation$MountVolume.fromJson(Map<String, dynamic> json) =>
      _$Variables$Mutation$MountVolumeFromJson(json);

  final String name;

  Map<String, dynamic> toJson() => _$Variables$Mutation$MountVolumeToJson(this);
  int get hashCode {
    final l$name = name;
    return Object.hashAll([l$name]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$MountVolume) ||
        runtimeType != other.runtimeType) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    return true;
  }

  Variables$Mutation$MountVolume copyWith({String? name}) =>
      Variables$Mutation$MountVolume(name: name == null ? this.name : name);
}

@JsonSerializable(explicitToJson: true)
class Mutation$MountVolume {
  Mutation$MountVolume({required this.mountVolume, required this.$__typename});

  @override
  factory Mutation$MountVolume.fromJson(Map<String, dynamic> json) =>
      _$Mutation$MountVolumeFromJson(json);

  final Mutation$MountVolume$mountVolume mountVolume;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$MountVolumeToJson(this);
  int get hashCode {
    final l$mountVolume = mountVolume;
    final l$$__typename = $__typename;
    return Object.hashAll([l$mountVolume, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$MountVolume) || runtimeType != other.runtimeType)
      return false;
    final l$mountVolume = mountVolume;
    final lOther$mountVolume = other.mountVolume;
    if (l$mountVolume != lOther$mountVolume) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$MountVolume on Mutation$MountVolume {
  Mutation$MountVolume copyWith(
          {Mutation$MountVolume$mountVolume? mountVolume,
          String? $__typename}) =>
      Mutation$MountVolume(
          mountVolume: mountVolume == null ? this.mountVolume : mountVolume,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationMountVolume = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'MountVolume'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'name')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'mountVolume'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'name'),
                  value: VariableNode(name: NameNode(value: 'name')))
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
Mutation$MountVolume _parserFn$Mutation$MountVolume(
        Map<String, dynamic> data) =>
    Mutation$MountVolume.fromJson(data);
typedef OnMutationCompleted$Mutation$MountVolume = FutureOr<void> Function(
    dynamic, Mutation$MountVolume?);

class Options$Mutation$MountVolume
    extends graphql.MutationOptions<Mutation$MountVolume> {
  Options$Mutation$MountVolume(
      {String? operationName,
      required Variables$Mutation$MountVolume variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$MountVolume? onCompleted,
      graphql.OnMutationUpdate<Mutation$MountVolume>? update,
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
                    data == null ? null : _parserFn$Mutation$MountVolume(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationMountVolume,
            parserFn: _parserFn$Mutation$MountVolume);

  final OnMutationCompleted$Mutation$MountVolume? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$MountVolume
    extends graphql.WatchQueryOptions<Mutation$MountVolume> {
  WatchOptions$Mutation$MountVolume(
      {String? operationName,
      required Variables$Mutation$MountVolume variables,
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
            document: documentNodeMutationMountVolume,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$MountVolume);
}

extension ClientExtension$Mutation$MountVolume on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$MountVolume>> mutate$MountVolume(
          Options$Mutation$MountVolume options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$MountVolume> watchMutation$MountVolume(
          WatchOptions$Mutation$MountVolume options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$MountVolume$mountVolume
    implements Fragment$basicMutationReturnFields {
  Mutation$MountVolume$mountVolume(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$MountVolume$mountVolume.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$MountVolume$mountVolumeFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$MountVolume$mountVolumeToJson(this);
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
    if (!(other is Mutation$MountVolume$mountVolume) ||
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

extension UtilityExtension$Mutation$MountVolume$mountVolume
    on Mutation$MountVolume$mountVolume {
  Mutation$MountVolume$mountVolume copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$MountVolume$mountVolume(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$ResizeVolume {
  Variables$Mutation$ResizeVolume({required this.name});

  @override
  factory Variables$Mutation$ResizeVolume.fromJson(Map<String, dynamic> json) =>
      _$Variables$Mutation$ResizeVolumeFromJson(json);

  final String name;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$ResizeVolumeToJson(this);
  int get hashCode {
    final l$name = name;
    return Object.hashAll([l$name]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$ResizeVolume) ||
        runtimeType != other.runtimeType) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    return true;
  }

  Variables$Mutation$ResizeVolume copyWith({String? name}) =>
      Variables$Mutation$ResizeVolume(name: name == null ? this.name : name);
}

@JsonSerializable(explicitToJson: true)
class Mutation$ResizeVolume {
  Mutation$ResizeVolume(
      {required this.resizeVolume, required this.$__typename});

  @override
  factory Mutation$ResizeVolume.fromJson(Map<String, dynamic> json) =>
      _$Mutation$ResizeVolumeFromJson(json);

  final Mutation$ResizeVolume$resizeVolume resizeVolume;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$ResizeVolumeToJson(this);
  int get hashCode {
    final l$resizeVolume = resizeVolume;
    final l$$__typename = $__typename;
    return Object.hashAll([l$resizeVolume, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$ResizeVolume) || runtimeType != other.runtimeType)
      return false;
    final l$resizeVolume = resizeVolume;
    final lOther$resizeVolume = other.resizeVolume;
    if (l$resizeVolume != lOther$resizeVolume) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$ResizeVolume on Mutation$ResizeVolume {
  Mutation$ResizeVolume copyWith(
          {Mutation$ResizeVolume$resizeVolume? resizeVolume,
          String? $__typename}) =>
      Mutation$ResizeVolume(
          resizeVolume: resizeVolume == null ? this.resizeVolume : resizeVolume,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationResizeVolume = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ResizeVolume'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'name')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'resizeVolume'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'name'),
                  value: VariableNode(name: NameNode(value: 'name')))
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
Mutation$ResizeVolume _parserFn$Mutation$ResizeVolume(
        Map<String, dynamic> data) =>
    Mutation$ResizeVolume.fromJson(data);
typedef OnMutationCompleted$Mutation$ResizeVolume = FutureOr<void> Function(
    dynamic, Mutation$ResizeVolume?);

class Options$Mutation$ResizeVolume
    extends graphql.MutationOptions<Mutation$ResizeVolume> {
  Options$Mutation$ResizeVolume(
      {String? operationName,
      required Variables$Mutation$ResizeVolume variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$ResizeVolume? onCompleted,
      graphql.OnMutationUpdate<Mutation$ResizeVolume>? update,
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
                        : _parserFn$Mutation$ResizeVolume(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationResizeVolume,
            parserFn: _parserFn$Mutation$ResizeVolume);

  final OnMutationCompleted$Mutation$ResizeVolume? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$ResizeVolume
    extends graphql.WatchQueryOptions<Mutation$ResizeVolume> {
  WatchOptions$Mutation$ResizeVolume(
      {String? operationName,
      required Variables$Mutation$ResizeVolume variables,
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
            document: documentNodeMutationResizeVolume,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$ResizeVolume);
}

extension ClientExtension$Mutation$ResizeVolume on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ResizeVolume>> mutate$ResizeVolume(
          Options$Mutation$ResizeVolume options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$ResizeVolume> watchMutation$ResizeVolume(
          WatchOptions$Mutation$ResizeVolume options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$ResizeVolume$resizeVolume
    implements Fragment$basicMutationReturnFields {
  Mutation$ResizeVolume$resizeVolume(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$ResizeVolume$resizeVolume.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$ResizeVolume$resizeVolumeFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$ResizeVolume$resizeVolumeToJson(this);
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
    if (!(other is Mutation$ResizeVolume$resizeVolume) ||
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

extension UtilityExtension$Mutation$ResizeVolume$resizeVolume
    on Mutation$ResizeVolume$resizeVolume {
  Mutation$ResizeVolume$resizeVolume copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$ResizeVolume$resizeVolume(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$UnmountVolume {
  Variables$Mutation$UnmountVolume({required this.name});

  @override
  factory Variables$Mutation$UnmountVolume.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$UnmountVolumeFromJson(json);

  final String name;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$UnmountVolumeToJson(this);
  int get hashCode {
    final l$name = name;
    return Object.hashAll([l$name]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$UnmountVolume) ||
        runtimeType != other.runtimeType) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    return true;
  }

  Variables$Mutation$UnmountVolume copyWith({String? name}) =>
      Variables$Mutation$UnmountVolume(name: name == null ? this.name : name);
}

@JsonSerializable(explicitToJson: true)
class Mutation$UnmountVolume {
  Mutation$UnmountVolume(
      {required this.unmountVolume, required this.$__typename});

  @override
  factory Mutation$UnmountVolume.fromJson(Map<String, dynamic> json) =>
      _$Mutation$UnmountVolumeFromJson(json);

  final Mutation$UnmountVolume$unmountVolume unmountVolume;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$UnmountVolumeToJson(this);
  int get hashCode {
    final l$unmountVolume = unmountVolume;
    final l$$__typename = $__typename;
    return Object.hashAll([l$unmountVolume, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$UnmountVolume) || runtimeType != other.runtimeType)
      return false;
    final l$unmountVolume = unmountVolume;
    final lOther$unmountVolume = other.unmountVolume;
    if (l$unmountVolume != lOther$unmountVolume) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$UnmountVolume on Mutation$UnmountVolume {
  Mutation$UnmountVolume copyWith(
          {Mutation$UnmountVolume$unmountVolume? unmountVolume,
          String? $__typename}) =>
      Mutation$UnmountVolume(
          unmountVolume:
              unmountVolume == null ? this.unmountVolume : unmountVolume,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationUnmountVolume = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UnmountVolume'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'name')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'unmountVolume'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'name'),
                  value: VariableNode(name: NameNode(value: 'name')))
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
Mutation$UnmountVolume _parserFn$Mutation$UnmountVolume(
        Map<String, dynamic> data) =>
    Mutation$UnmountVolume.fromJson(data);
typedef OnMutationCompleted$Mutation$UnmountVolume = FutureOr<void> Function(
    dynamic, Mutation$UnmountVolume?);

class Options$Mutation$UnmountVolume
    extends graphql.MutationOptions<Mutation$UnmountVolume> {
  Options$Mutation$UnmountVolume(
      {String? operationName,
      required Variables$Mutation$UnmountVolume variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$UnmountVolume? onCompleted,
      graphql.OnMutationUpdate<Mutation$UnmountVolume>? update,
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
                        : _parserFn$Mutation$UnmountVolume(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationUnmountVolume,
            parserFn: _parserFn$Mutation$UnmountVolume);

  final OnMutationCompleted$Mutation$UnmountVolume? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$UnmountVolume
    extends graphql.WatchQueryOptions<Mutation$UnmountVolume> {
  WatchOptions$Mutation$UnmountVolume(
      {String? operationName,
      required Variables$Mutation$UnmountVolume variables,
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
            document: documentNodeMutationUnmountVolume,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$UnmountVolume);
}

extension ClientExtension$Mutation$UnmountVolume on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UnmountVolume>> mutate$UnmountVolume(
          Options$Mutation$UnmountVolume options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$UnmountVolume> watchMutation$UnmountVolume(
          WatchOptions$Mutation$UnmountVolume options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$UnmountVolume$unmountVolume
    implements Fragment$basicMutationReturnFields {
  Mutation$UnmountVolume$unmountVolume(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$UnmountVolume$unmountVolume.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$UnmountVolume$unmountVolumeFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$UnmountVolume$unmountVolumeToJson(this);
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
    if (!(other is Mutation$UnmountVolume$unmountVolume) ||
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

extension UtilityExtension$Mutation$UnmountVolume$unmountVolume
    on Mutation$UnmountVolume$unmountVolume {
  Mutation$UnmountVolume$unmountVolume copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$UnmountVolume$unmountVolume(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$MigrateToBinds {
  Variables$Mutation$MigrateToBinds({required this.input});

  @override
  factory Variables$Mutation$MigrateToBinds.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$MigrateToBindsFromJson(json);

  final Input$MigrateToBindsInput input;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$MigrateToBindsToJson(this);
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$MigrateToBinds) ||
        runtimeType != other.runtimeType) return false;
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) return false;
    return true;
  }

  Variables$Mutation$MigrateToBinds copyWith(
          {Input$MigrateToBindsInput? input}) =>
      Variables$Mutation$MigrateToBinds(
          input: input == null ? this.input : input);
}

@JsonSerializable(explicitToJson: true)
class Mutation$MigrateToBinds {
  Mutation$MigrateToBinds(
      {required this.migrateToBinds, required this.$__typename});

  @override
  factory Mutation$MigrateToBinds.fromJson(Map<String, dynamic> json) =>
      _$Mutation$MigrateToBindsFromJson(json);

  final Mutation$MigrateToBinds$migrateToBinds migrateToBinds;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$MigrateToBindsToJson(this);
  int get hashCode {
    final l$migrateToBinds = migrateToBinds;
    final l$$__typename = $__typename;
    return Object.hashAll([l$migrateToBinds, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$MigrateToBinds) || runtimeType != other.runtimeType)
      return false;
    final l$migrateToBinds = migrateToBinds;
    final lOther$migrateToBinds = other.migrateToBinds;
    if (l$migrateToBinds != lOther$migrateToBinds) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$MigrateToBinds on Mutation$MigrateToBinds {
  Mutation$MigrateToBinds copyWith(
          {Mutation$MigrateToBinds$migrateToBinds? migrateToBinds,
          String? $__typename}) =>
      Mutation$MigrateToBinds(
          migrateToBinds:
              migrateToBinds == null ? this.migrateToBinds : migrateToBinds,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationMigrateToBinds = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'MigrateToBinds'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type: NamedTypeNode(
                name: NameNode(value: 'MigrateToBindsInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'migrateToBinds'),
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
Mutation$MigrateToBinds _parserFn$Mutation$MigrateToBinds(
        Map<String, dynamic> data) =>
    Mutation$MigrateToBinds.fromJson(data);
typedef OnMutationCompleted$Mutation$MigrateToBinds = FutureOr<void> Function(
    dynamic, Mutation$MigrateToBinds?);

class Options$Mutation$MigrateToBinds
    extends graphql.MutationOptions<Mutation$MigrateToBinds> {
  Options$Mutation$MigrateToBinds(
      {String? operationName,
      required Variables$Mutation$MigrateToBinds variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$MigrateToBinds? onCompleted,
      graphql.OnMutationUpdate<Mutation$MigrateToBinds>? update,
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
                        : _parserFn$Mutation$MigrateToBinds(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationMigrateToBinds,
            parserFn: _parserFn$Mutation$MigrateToBinds);

  final OnMutationCompleted$Mutation$MigrateToBinds? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$MigrateToBinds
    extends graphql.WatchQueryOptions<Mutation$MigrateToBinds> {
  WatchOptions$Mutation$MigrateToBinds(
      {String? operationName,
      required Variables$Mutation$MigrateToBinds variables,
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
            document: documentNodeMutationMigrateToBinds,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$MigrateToBinds);
}

extension ClientExtension$Mutation$MigrateToBinds on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$MigrateToBinds>> mutate$MigrateToBinds(
          Options$Mutation$MigrateToBinds options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$MigrateToBinds> watchMutation$MigrateToBinds(
          WatchOptions$Mutation$MigrateToBinds options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$MigrateToBinds$migrateToBinds
    implements Fragment$basicMutationReturnFields {
  Mutation$MigrateToBinds$migrateToBinds(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename,
      this.job});

  @override
  factory Mutation$MigrateToBinds$migrateToBinds.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$MigrateToBinds$migrateToBindsFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  final Mutation$MigrateToBinds$migrateToBinds$job? job;

  Map<String, dynamic> toJson() =>
      _$Mutation$MigrateToBinds$migrateToBindsToJson(this);
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
    if (!(other is Mutation$MigrateToBinds$migrateToBinds) ||
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

extension UtilityExtension$Mutation$MigrateToBinds$migrateToBinds
    on Mutation$MigrateToBinds$migrateToBinds {
  Mutation$MigrateToBinds$migrateToBinds copyWith(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          Mutation$MigrateToBinds$migrateToBinds$job? Function()? job}) =>
      Mutation$MigrateToBinds$migrateToBinds(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename,
          job: job == null ? this.job : job());
}

@JsonSerializable(explicitToJson: true)
class Mutation$MigrateToBinds$migrateToBinds$job {
  Mutation$MigrateToBinds$migrateToBinds$job(
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
  factory Mutation$MigrateToBinds$migrateToBinds$job.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$MigrateToBinds$migrateToBinds$jobFromJson(json);

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
      _$Mutation$MigrateToBinds$migrateToBinds$jobToJson(this);
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
    if (!(other is Mutation$MigrateToBinds$migrateToBinds$job) ||
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

extension UtilityExtension$Mutation$MigrateToBinds$migrateToBinds$job
    on Mutation$MigrateToBinds$migrateToBinds$job {
  Mutation$MigrateToBinds$migrateToBinds$job copyWith(
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
      Mutation$MigrateToBinds$migrateToBinds$job(
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
