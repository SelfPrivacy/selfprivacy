import 'dart:async';
import 'disk_volumes.graphql.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/utils/scalars.dart';
import 'schema.graphql.dart';
part 'server_api.graphql.g.dart';

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
class Query$GetApiVersion {
  Query$GetApiVersion({required this.api, required this.$__typename});

  @override
  factory Query$GetApiVersion.fromJson(Map<String, dynamic> json) =>
      _$Query$GetApiVersionFromJson(json);

  final Query$GetApiVersion$api api;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetApiVersionToJson(this);
  int get hashCode {
    final l$api = api;
    final l$$__typename = $__typename;
    return Object.hashAll([l$api, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetApiVersion) || runtimeType != other.runtimeType)
      return false;
    final l$api = api;
    final lOther$api = other.api;
    if (l$api != lOther$api) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetApiVersion on Query$GetApiVersion {
  Query$GetApiVersion copyWith(
          {Query$GetApiVersion$api? api, String? $__typename}) =>
      Query$GetApiVersion(
          api: api == null ? this.api : api,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeQueryGetApiVersion = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetApiVersion'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'api'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'version'),
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
]);
Query$GetApiVersion _parserFn$Query$GetApiVersion(Map<String, dynamic> data) =>
    Query$GetApiVersion.fromJson(data);

class Options$Query$GetApiVersion
    extends graphql.QueryOptions<Query$GetApiVersion> {
  Options$Query$GetApiVersion(
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
            document: documentNodeQueryGetApiVersion,
            parserFn: _parserFn$Query$GetApiVersion);
}

class WatchOptions$Query$GetApiVersion
    extends graphql.WatchQueryOptions<Query$GetApiVersion> {
  WatchOptions$Query$GetApiVersion(
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
            document: documentNodeQueryGetApiVersion,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Query$GetApiVersion);
}

class FetchMoreOptions$Query$GetApiVersion extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetApiVersion(
      {required graphql.UpdateQuery updateQuery})
      : super(
            updateQuery: updateQuery, document: documentNodeQueryGetApiVersion);
}

extension ClientExtension$Query$GetApiVersion on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetApiVersion>> query$GetApiVersion(
          [Options$Query$GetApiVersion? options]) async =>
      await this.query(options ?? Options$Query$GetApiVersion());
  graphql.ObservableQuery<Query$GetApiVersion> watchQuery$GetApiVersion(
          [WatchOptions$Query$GetApiVersion? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetApiVersion());
  void writeQuery$GetApiVersion(
          {required Query$GetApiVersion data, bool broadcast = true}) =>
      this.writeQuery(
          graphql.Request(
              operation:
                  graphql.Operation(document: documentNodeQueryGetApiVersion)),
          data: data.toJson(),
          broadcast: broadcast);
  Query$GetApiVersion? readQuery$GetApiVersion({bool optimistic = true}) {
    final result = this.readQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryGetApiVersion)),
        optimistic: optimistic);
    return result == null ? null : Query$GetApiVersion.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Query$GetApiVersion$api {
  Query$GetApiVersion$api({required this.version, required this.$__typename});

  @override
  factory Query$GetApiVersion$api.fromJson(Map<String, dynamic> json) =>
      _$Query$GetApiVersion$apiFromJson(json);

  final String version;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetApiVersion$apiToJson(this);
  int get hashCode {
    final l$version = version;
    final l$$__typename = $__typename;
    return Object.hashAll([l$version, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetApiVersion$api) || runtimeType != other.runtimeType)
      return false;
    final l$version = version;
    final lOther$version = other.version;
    if (l$version != lOther$version) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetApiVersion$api on Query$GetApiVersion$api {
  Query$GetApiVersion$api copyWith({String? version, String? $__typename}) =>
      Query$GetApiVersion$api(
          version: version == null ? this.version : version,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Query$GetApiJobs {
  Query$GetApiJobs({required this.jobs, required this.$__typename});

  @override
  factory Query$GetApiJobs.fromJson(Map<String, dynamic> json) =>
      _$Query$GetApiJobsFromJson(json);

  final Query$GetApiJobs$jobs jobs;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetApiJobsToJson(this);
  int get hashCode {
    final l$jobs = jobs;
    final l$$__typename = $__typename;
    return Object.hashAll([l$jobs, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetApiJobs) || runtimeType != other.runtimeType)
      return false;
    final l$jobs = jobs;
    final lOther$jobs = other.jobs;
    if (l$jobs != lOther$jobs) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetApiJobs on Query$GetApiJobs {
  Query$GetApiJobs copyWith(
          {Query$GetApiJobs$jobs? jobs, String? $__typename}) =>
      Query$GetApiJobs(
          jobs: jobs == null ? this.jobs : jobs,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeQueryGetApiJobs = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetApiJobs'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'jobs'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'getJobs'),
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
]);
Query$GetApiJobs _parserFn$Query$GetApiJobs(Map<String, dynamic> data) =>
    Query$GetApiJobs.fromJson(data);

class Options$Query$GetApiJobs extends graphql.QueryOptions<Query$GetApiJobs> {
  Options$Query$GetApiJobs(
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
            document: documentNodeQueryGetApiJobs,
            parserFn: _parserFn$Query$GetApiJobs);
}

class WatchOptions$Query$GetApiJobs
    extends graphql.WatchQueryOptions<Query$GetApiJobs> {
  WatchOptions$Query$GetApiJobs(
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
            document: documentNodeQueryGetApiJobs,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Query$GetApiJobs);
}

class FetchMoreOptions$Query$GetApiJobs extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetApiJobs({required graphql.UpdateQuery updateQuery})
      : super(updateQuery: updateQuery, document: documentNodeQueryGetApiJobs);
}

extension ClientExtension$Query$GetApiJobs on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetApiJobs>> query$GetApiJobs(
          [Options$Query$GetApiJobs? options]) async =>
      await this.query(options ?? Options$Query$GetApiJobs());
  graphql.ObservableQuery<Query$GetApiJobs> watchQuery$GetApiJobs(
          [WatchOptions$Query$GetApiJobs? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetApiJobs());
  void writeQuery$GetApiJobs(
          {required Query$GetApiJobs data, bool broadcast = true}) =>
      this.writeQuery(
          graphql.Request(
              operation:
                  graphql.Operation(document: documentNodeQueryGetApiJobs)),
          data: data.toJson(),
          broadcast: broadcast);
  Query$GetApiJobs? readQuery$GetApiJobs({bool optimistic = true}) {
    final result = this.readQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryGetApiJobs)),
        optimistic: optimistic);
    return result == null ? null : Query$GetApiJobs.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Query$GetApiJobs$jobs {
  Query$GetApiJobs$jobs({required this.getJobs, required this.$__typename});

  @override
  factory Query$GetApiJobs$jobs.fromJson(Map<String, dynamic> json) =>
      _$Query$GetApiJobs$jobsFromJson(json);

  final List<Query$GetApiJobs$jobs$getJobs> getJobs;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetApiJobs$jobsToJson(this);
  int get hashCode {
    final l$getJobs = getJobs;
    final l$$__typename = $__typename;
    return Object.hashAll(
        [Object.hashAll(l$getJobs.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetApiJobs$jobs) || runtimeType != other.runtimeType)
      return false;
    final l$getJobs = getJobs;
    final lOther$getJobs = other.getJobs;
    if (l$getJobs.length != lOther$getJobs.length) return false;
    for (int i = 0; i < l$getJobs.length; i++) {
      final l$getJobs$entry = l$getJobs[i];
      final lOther$getJobs$entry = lOther$getJobs[i];
      if (l$getJobs$entry != lOther$getJobs$entry) return false;
    }

    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetApiJobs$jobs on Query$GetApiJobs$jobs {
  Query$GetApiJobs$jobs copyWith(
          {List<Query$GetApiJobs$jobs$getJobs>? getJobs,
          String? $__typename}) =>
      Query$GetApiJobs$jobs(
          getJobs: getJobs == null ? this.getJobs : getJobs,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Query$GetApiJobs$jobs$getJobs {
  Query$GetApiJobs$jobs$getJobs(
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
  factory Query$GetApiJobs$jobs$getJobs.fromJson(Map<String, dynamic> json) =>
      _$Query$GetApiJobs$jobs$getJobsFromJson(json);

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

  Map<String, dynamic> toJson() => _$Query$GetApiJobs$jobs$getJobsToJson(this);
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
    if (!(other is Query$GetApiJobs$jobs$getJobs) ||
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

extension UtilityExtension$Query$GetApiJobs$jobs$getJobs
    on Query$GetApiJobs$jobs$getJobs {
  Query$GetApiJobs$jobs$getJobs copyWith(
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
      Query$GetApiJobs$jobs$getJobs(
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

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$RemoveJob {
  Variables$Mutation$RemoveJob({required this.jobId});

  @override
  factory Variables$Mutation$RemoveJob.fromJson(Map<String, dynamic> json) =>
      _$Variables$Mutation$RemoveJobFromJson(json);

  final String jobId;

  Map<String, dynamic> toJson() => _$Variables$Mutation$RemoveJobToJson(this);
  int get hashCode {
    final l$jobId = jobId;
    return Object.hashAll([l$jobId]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$RemoveJob) ||
        runtimeType != other.runtimeType) return false;
    final l$jobId = jobId;
    final lOther$jobId = other.jobId;
    if (l$jobId != lOther$jobId) return false;
    return true;
  }

  Variables$Mutation$RemoveJob copyWith({String? jobId}) =>
      Variables$Mutation$RemoveJob(jobId: jobId == null ? this.jobId : jobId);
}

@JsonSerializable(explicitToJson: true)
class Mutation$RemoveJob {
  Mutation$RemoveJob({required this.removeJob, required this.$__typename});

  @override
  factory Mutation$RemoveJob.fromJson(Map<String, dynamic> json) =>
      _$Mutation$RemoveJobFromJson(json);

  final Mutation$RemoveJob$removeJob removeJob;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$RemoveJobToJson(this);
  int get hashCode {
    final l$removeJob = removeJob;
    final l$$__typename = $__typename;
    return Object.hashAll([l$removeJob, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$RemoveJob) || runtimeType != other.runtimeType)
      return false;
    final l$removeJob = removeJob;
    final lOther$removeJob = other.removeJob;
    if (l$removeJob != lOther$removeJob) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$RemoveJob on Mutation$RemoveJob {
  Mutation$RemoveJob copyWith(
          {Mutation$RemoveJob$removeJob? removeJob, String? $__typename}) =>
      Mutation$RemoveJob(
          removeJob: removeJob == null ? this.removeJob : removeJob,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationRemoveJob = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RemoveJob'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'jobId')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'removeJob'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'jobId'),
                  value: VariableNode(name: NameNode(value: 'jobId')))
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
Mutation$RemoveJob _parserFn$Mutation$RemoveJob(Map<String, dynamic> data) =>
    Mutation$RemoveJob.fromJson(data);
typedef OnMutationCompleted$Mutation$RemoveJob = FutureOr<void> Function(
    dynamic, Mutation$RemoveJob?);

class Options$Mutation$RemoveJob
    extends graphql.MutationOptions<Mutation$RemoveJob> {
  Options$Mutation$RemoveJob(
      {String? operationName,
      required Variables$Mutation$RemoveJob variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$RemoveJob? onCompleted,
      graphql.OnMutationUpdate<Mutation$RemoveJob>? update,
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
                    data == null ? null : _parserFn$Mutation$RemoveJob(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationRemoveJob,
            parserFn: _parserFn$Mutation$RemoveJob);

  final OnMutationCompleted$Mutation$RemoveJob? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$RemoveJob
    extends graphql.WatchQueryOptions<Mutation$RemoveJob> {
  WatchOptions$Mutation$RemoveJob(
      {String? operationName,
      required Variables$Mutation$RemoveJob variables,
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
            document: documentNodeMutationRemoveJob,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$RemoveJob);
}

extension ClientExtension$Mutation$RemoveJob on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RemoveJob>> mutate$RemoveJob(
          Options$Mutation$RemoveJob options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$RemoveJob> watchMutation$RemoveJob(
          WatchOptions$Mutation$RemoveJob options) =>
      this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$RemoveJob$removeJob
    implements Fragment$basicMutationReturnFields {
  Mutation$RemoveJob$removeJob(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$RemoveJob$removeJob.fromJson(Map<String, dynamic> json) =>
      _$Mutation$RemoveJob$removeJobFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$RemoveJob$removeJobToJson(this);
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
    if (!(other is Mutation$RemoveJob$removeJob) ||
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

extension UtilityExtension$Mutation$RemoveJob$removeJob
    on Mutation$RemoveJob$removeJob {
  Mutation$RemoveJob$removeJob copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$RemoveJob$removeJob(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Mutation$RunSystemRebuild {
  Mutation$RunSystemRebuild(
      {required this.runSystemRebuild, required this.$__typename});

  @override
  factory Mutation$RunSystemRebuild.fromJson(Map<String, dynamic> json) =>
      _$Mutation$RunSystemRebuildFromJson(json);

  final Mutation$RunSystemRebuild$runSystemRebuild runSystemRebuild;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$RunSystemRebuildToJson(this);
  int get hashCode {
    final l$runSystemRebuild = runSystemRebuild;
    final l$$__typename = $__typename;
    return Object.hashAll([l$runSystemRebuild, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$RunSystemRebuild) ||
        runtimeType != other.runtimeType) return false;
    final l$runSystemRebuild = runSystemRebuild;
    final lOther$runSystemRebuild = other.runSystemRebuild;
    if (l$runSystemRebuild != lOther$runSystemRebuild) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$RunSystemRebuild
    on Mutation$RunSystemRebuild {
  Mutation$RunSystemRebuild copyWith(
          {Mutation$RunSystemRebuild$runSystemRebuild? runSystemRebuild,
          String? $__typename}) =>
      Mutation$RunSystemRebuild(
          runSystemRebuild: runSystemRebuild == null
              ? this.runSystemRebuild
              : runSystemRebuild,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationRunSystemRebuild = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RunSystemRebuild'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'runSystemRebuild'),
            alias: null,
            arguments: [],
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
Mutation$RunSystemRebuild _parserFn$Mutation$RunSystemRebuild(
        Map<String, dynamic> data) =>
    Mutation$RunSystemRebuild.fromJson(data);
typedef OnMutationCompleted$Mutation$RunSystemRebuild = FutureOr<void> Function(
    dynamic, Mutation$RunSystemRebuild?);

class Options$Mutation$RunSystemRebuild
    extends graphql.MutationOptions<Mutation$RunSystemRebuild> {
  Options$Mutation$RunSystemRebuild(
      {String? operationName,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$RunSystemRebuild? onCompleted,
      graphql.OnMutationUpdate<Mutation$RunSystemRebuild>? update,
      graphql.OnError? onError})
      : onCompletedWithParsed = onCompleted,
        super(
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
                        : _parserFn$Mutation$RunSystemRebuild(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationRunSystemRebuild,
            parserFn: _parserFn$Mutation$RunSystemRebuild);

  final OnMutationCompleted$Mutation$RunSystemRebuild? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$RunSystemRebuild
    extends graphql.WatchQueryOptions<Mutation$RunSystemRebuild> {
  WatchOptions$Mutation$RunSystemRebuild(
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
            document: documentNodeMutationRunSystemRebuild,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$RunSystemRebuild);
}

extension ClientExtension$Mutation$RunSystemRebuild on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RunSystemRebuild>>
      mutate$RunSystemRebuild(
              [Options$Mutation$RunSystemRebuild? options]) async =>
          await this.mutate(options ?? Options$Mutation$RunSystemRebuild());
  graphql.ObservableQuery<
      Mutation$RunSystemRebuild> watchMutation$RunSystemRebuild(
          [WatchOptions$Mutation$RunSystemRebuild? options]) =>
      this.watchMutation(options ?? WatchOptions$Mutation$RunSystemRebuild());
}

@JsonSerializable(explicitToJson: true)
class Mutation$RunSystemRebuild$runSystemRebuild
    implements Fragment$basicMutationReturnFields {
  Mutation$RunSystemRebuild$runSystemRebuild(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$RunSystemRebuild$runSystemRebuild.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$RunSystemRebuild$runSystemRebuildFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$RunSystemRebuild$runSystemRebuildToJson(this);
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
    if (!(other is Mutation$RunSystemRebuild$runSystemRebuild) ||
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

extension UtilityExtension$Mutation$RunSystemRebuild$runSystemRebuild
    on Mutation$RunSystemRebuild$runSystemRebuild {
  Mutation$RunSystemRebuild$runSystemRebuild copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$RunSystemRebuild$runSystemRebuild(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Mutation$RunSystemRollback {
  Mutation$RunSystemRollback(
      {required this.runSystemRollback, required this.$__typename});

  @override
  factory Mutation$RunSystemRollback.fromJson(Map<String, dynamic> json) =>
      _$Mutation$RunSystemRollbackFromJson(json);

  final Mutation$RunSystemRollback$runSystemRollback runSystemRollback;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$RunSystemRollbackToJson(this);
  int get hashCode {
    final l$runSystemRollback = runSystemRollback;
    final l$$__typename = $__typename;
    return Object.hashAll([l$runSystemRollback, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$RunSystemRollback) ||
        runtimeType != other.runtimeType) return false;
    final l$runSystemRollback = runSystemRollback;
    final lOther$runSystemRollback = other.runSystemRollback;
    if (l$runSystemRollback != lOther$runSystemRollback) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$RunSystemRollback
    on Mutation$RunSystemRollback {
  Mutation$RunSystemRollback copyWith(
          {Mutation$RunSystemRollback$runSystemRollback? runSystemRollback,
          String? $__typename}) =>
      Mutation$RunSystemRollback(
          runSystemRollback: runSystemRollback == null
              ? this.runSystemRollback
              : runSystemRollback,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationRunSystemRollback = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RunSystemRollback'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'runSystemRollback'),
            alias: null,
            arguments: [],
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
Mutation$RunSystemRollback _parserFn$Mutation$RunSystemRollback(
        Map<String, dynamic> data) =>
    Mutation$RunSystemRollback.fromJson(data);
typedef OnMutationCompleted$Mutation$RunSystemRollback = FutureOr<void>
    Function(dynamic, Mutation$RunSystemRollback?);

class Options$Mutation$RunSystemRollback
    extends graphql.MutationOptions<Mutation$RunSystemRollback> {
  Options$Mutation$RunSystemRollback(
      {String? operationName,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$RunSystemRollback? onCompleted,
      graphql.OnMutationUpdate<Mutation$RunSystemRollback>? update,
      graphql.OnError? onError})
      : onCompletedWithParsed = onCompleted,
        super(
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
                        : _parserFn$Mutation$RunSystemRollback(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationRunSystemRollback,
            parserFn: _parserFn$Mutation$RunSystemRollback);

  final OnMutationCompleted$Mutation$RunSystemRollback? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$RunSystemRollback
    extends graphql.WatchQueryOptions<Mutation$RunSystemRollback> {
  WatchOptions$Mutation$RunSystemRollback(
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
            document: documentNodeMutationRunSystemRollback,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$RunSystemRollback);
}

extension ClientExtension$Mutation$RunSystemRollback on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RunSystemRollback>>
      mutate$RunSystemRollback(
              [Options$Mutation$RunSystemRollback? options]) async =>
          await this.mutate(options ?? Options$Mutation$RunSystemRollback());
  graphql.ObservableQuery<
      Mutation$RunSystemRollback> watchMutation$RunSystemRollback(
          [WatchOptions$Mutation$RunSystemRollback? options]) =>
      this.watchMutation(options ?? WatchOptions$Mutation$RunSystemRollback());
}

@JsonSerializable(explicitToJson: true)
class Mutation$RunSystemRollback$runSystemRollback
    implements Fragment$basicMutationReturnFields {
  Mutation$RunSystemRollback$runSystemRollback(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$RunSystemRollback$runSystemRollback.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$RunSystemRollback$runSystemRollbackFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$RunSystemRollback$runSystemRollbackToJson(this);
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
    if (!(other is Mutation$RunSystemRollback$runSystemRollback) ||
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

extension UtilityExtension$Mutation$RunSystemRollback$runSystemRollback
    on Mutation$RunSystemRollback$runSystemRollback {
  Mutation$RunSystemRollback$runSystemRollback copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$RunSystemRollback$runSystemRollback(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Mutation$RunSystemUpgrade {
  Mutation$RunSystemUpgrade(
      {required this.runSystemUpgrade, required this.$__typename});

  @override
  factory Mutation$RunSystemUpgrade.fromJson(Map<String, dynamic> json) =>
      _$Mutation$RunSystemUpgradeFromJson(json);

  final Mutation$RunSystemUpgrade$runSystemUpgrade runSystemUpgrade;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$RunSystemUpgradeToJson(this);
  int get hashCode {
    final l$runSystemUpgrade = runSystemUpgrade;
    final l$$__typename = $__typename;
    return Object.hashAll([l$runSystemUpgrade, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$RunSystemUpgrade) ||
        runtimeType != other.runtimeType) return false;
    final l$runSystemUpgrade = runSystemUpgrade;
    final lOther$runSystemUpgrade = other.runSystemUpgrade;
    if (l$runSystemUpgrade != lOther$runSystemUpgrade) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$RunSystemUpgrade
    on Mutation$RunSystemUpgrade {
  Mutation$RunSystemUpgrade copyWith(
          {Mutation$RunSystemUpgrade$runSystemUpgrade? runSystemUpgrade,
          String? $__typename}) =>
      Mutation$RunSystemUpgrade(
          runSystemUpgrade: runSystemUpgrade == null
              ? this.runSystemUpgrade
              : runSystemUpgrade,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationRunSystemUpgrade = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RunSystemUpgrade'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'runSystemUpgrade'),
            alias: null,
            arguments: [],
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
Mutation$RunSystemUpgrade _parserFn$Mutation$RunSystemUpgrade(
        Map<String, dynamic> data) =>
    Mutation$RunSystemUpgrade.fromJson(data);
typedef OnMutationCompleted$Mutation$RunSystemUpgrade = FutureOr<void> Function(
    dynamic, Mutation$RunSystemUpgrade?);

class Options$Mutation$RunSystemUpgrade
    extends graphql.MutationOptions<Mutation$RunSystemUpgrade> {
  Options$Mutation$RunSystemUpgrade(
      {String? operationName,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$RunSystemUpgrade? onCompleted,
      graphql.OnMutationUpdate<Mutation$RunSystemUpgrade>? update,
      graphql.OnError? onError})
      : onCompletedWithParsed = onCompleted,
        super(
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
                        : _parserFn$Mutation$RunSystemUpgrade(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationRunSystemUpgrade,
            parserFn: _parserFn$Mutation$RunSystemUpgrade);

  final OnMutationCompleted$Mutation$RunSystemUpgrade? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$RunSystemUpgrade
    extends graphql.WatchQueryOptions<Mutation$RunSystemUpgrade> {
  WatchOptions$Mutation$RunSystemUpgrade(
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
            document: documentNodeMutationRunSystemUpgrade,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$RunSystemUpgrade);
}

extension ClientExtension$Mutation$RunSystemUpgrade on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RunSystemUpgrade>>
      mutate$RunSystemUpgrade(
              [Options$Mutation$RunSystemUpgrade? options]) async =>
          await this.mutate(options ?? Options$Mutation$RunSystemUpgrade());
  graphql.ObservableQuery<
      Mutation$RunSystemUpgrade> watchMutation$RunSystemUpgrade(
          [WatchOptions$Mutation$RunSystemUpgrade? options]) =>
      this.watchMutation(options ?? WatchOptions$Mutation$RunSystemUpgrade());
}

@JsonSerializable(explicitToJson: true)
class Mutation$RunSystemUpgrade$runSystemUpgrade
    implements Fragment$basicMutationReturnFields {
  Mutation$RunSystemUpgrade$runSystemUpgrade(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$RunSystemUpgrade$runSystemUpgrade.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$RunSystemUpgrade$runSystemUpgradeFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$RunSystemUpgrade$runSystemUpgradeToJson(this);
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
    if (!(other is Mutation$RunSystemUpgrade$runSystemUpgrade) ||
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

extension UtilityExtension$Mutation$RunSystemUpgrade$runSystemUpgrade
    on Mutation$RunSystemUpgrade$runSystemUpgrade {
  Mutation$RunSystemUpgrade$runSystemUpgrade copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$RunSystemUpgrade$runSystemUpgrade(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Mutation$PullRepositoryChanges {
  Mutation$PullRepositoryChanges(
      {required this.pullRepositoryChanges, required this.$__typename});

  @override
  factory Mutation$PullRepositoryChanges.fromJson(Map<String, dynamic> json) =>
      _$Mutation$PullRepositoryChangesFromJson(json);

  final Mutation$PullRepositoryChanges$pullRepositoryChanges
      pullRepositoryChanges;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$PullRepositoryChangesToJson(this);
  int get hashCode {
    final l$pullRepositoryChanges = pullRepositoryChanges;
    final l$$__typename = $__typename;
    return Object.hashAll([l$pullRepositoryChanges, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$PullRepositoryChanges) ||
        runtimeType != other.runtimeType) return false;
    final l$pullRepositoryChanges = pullRepositoryChanges;
    final lOther$pullRepositoryChanges = other.pullRepositoryChanges;
    if (l$pullRepositoryChanges != lOther$pullRepositoryChanges) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$PullRepositoryChanges
    on Mutation$PullRepositoryChanges {
  Mutation$PullRepositoryChanges copyWith(
          {Mutation$PullRepositoryChanges$pullRepositoryChanges?
              pullRepositoryChanges,
          String? $__typename}) =>
      Mutation$PullRepositoryChanges(
          pullRepositoryChanges: pullRepositoryChanges == null
              ? this.pullRepositoryChanges
              : pullRepositoryChanges,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationPullRepositoryChanges = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'PullRepositoryChanges'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'pullRepositoryChanges'),
            alias: null,
            arguments: [],
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
Mutation$PullRepositoryChanges _parserFn$Mutation$PullRepositoryChanges(
        Map<String, dynamic> data) =>
    Mutation$PullRepositoryChanges.fromJson(data);
typedef OnMutationCompleted$Mutation$PullRepositoryChanges = FutureOr<void>
    Function(dynamic, Mutation$PullRepositoryChanges?);

class Options$Mutation$PullRepositoryChanges
    extends graphql.MutationOptions<Mutation$PullRepositoryChanges> {
  Options$Mutation$PullRepositoryChanges(
      {String? operationName,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$PullRepositoryChanges? onCompleted,
      graphql.OnMutationUpdate<Mutation$PullRepositoryChanges>? update,
      graphql.OnError? onError})
      : onCompletedWithParsed = onCompleted,
        super(
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
                        : _parserFn$Mutation$PullRepositoryChanges(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationPullRepositoryChanges,
            parserFn: _parserFn$Mutation$PullRepositoryChanges);

  final OnMutationCompleted$Mutation$PullRepositoryChanges?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$PullRepositoryChanges
    extends graphql.WatchQueryOptions<Mutation$PullRepositoryChanges> {
  WatchOptions$Mutation$PullRepositoryChanges(
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
            document: documentNodeMutationPullRepositoryChanges,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$PullRepositoryChanges);
}

extension ClientExtension$Mutation$PullRepositoryChanges
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$PullRepositoryChanges>>
      mutate$PullRepositoryChanges(
              [Options$Mutation$PullRepositoryChanges? options]) async =>
          await this
              .mutate(options ?? Options$Mutation$PullRepositoryChanges());
  graphql.ObservableQuery<Mutation$PullRepositoryChanges>
      watchMutation$PullRepositoryChanges(
              [WatchOptions$Mutation$PullRepositoryChanges? options]) =>
          this.watchMutation(
              options ?? WatchOptions$Mutation$PullRepositoryChanges());
}

@JsonSerializable(explicitToJson: true)
class Mutation$PullRepositoryChanges$pullRepositoryChanges
    implements Fragment$basicMutationReturnFields {
  Mutation$PullRepositoryChanges$pullRepositoryChanges(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$PullRepositoryChanges$pullRepositoryChanges.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$PullRepositoryChanges$pullRepositoryChangesFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$PullRepositoryChanges$pullRepositoryChangesToJson(this);
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
    if (!(other is Mutation$PullRepositoryChanges$pullRepositoryChanges) ||
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

extension UtilityExtension$Mutation$PullRepositoryChanges$pullRepositoryChanges
    on Mutation$PullRepositoryChanges$pullRepositoryChanges {
  Mutation$PullRepositoryChanges$pullRepositoryChanges copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$PullRepositoryChanges$pullRepositoryChanges(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Mutation$RebootSystem {
  Mutation$RebootSystem(
      {required this.rebootSystem, required this.$__typename});

  @override
  factory Mutation$RebootSystem.fromJson(Map<String, dynamic> json) =>
      _$Mutation$RebootSystemFromJson(json);

  final Mutation$RebootSystem$rebootSystem rebootSystem;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$RebootSystemToJson(this);
  int get hashCode {
    final l$rebootSystem = rebootSystem;
    final l$$__typename = $__typename;
    return Object.hashAll([l$rebootSystem, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$RebootSystem) || runtimeType != other.runtimeType)
      return false;
    final l$rebootSystem = rebootSystem;
    final lOther$rebootSystem = other.rebootSystem;
    if (l$rebootSystem != lOther$rebootSystem) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$RebootSystem on Mutation$RebootSystem {
  Mutation$RebootSystem copyWith(
          {Mutation$RebootSystem$rebootSystem? rebootSystem,
          String? $__typename}) =>
      Mutation$RebootSystem(
          rebootSystem: rebootSystem == null ? this.rebootSystem : rebootSystem,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationRebootSystem = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RebootSystem'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'rebootSystem'),
            alias: null,
            arguments: [],
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
Mutation$RebootSystem _parserFn$Mutation$RebootSystem(
        Map<String, dynamic> data) =>
    Mutation$RebootSystem.fromJson(data);
typedef OnMutationCompleted$Mutation$RebootSystem = FutureOr<void> Function(
    dynamic, Mutation$RebootSystem?);

class Options$Mutation$RebootSystem
    extends graphql.MutationOptions<Mutation$RebootSystem> {
  Options$Mutation$RebootSystem(
      {String? operationName,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$RebootSystem? onCompleted,
      graphql.OnMutationUpdate<Mutation$RebootSystem>? update,
      graphql.OnError? onError})
      : onCompletedWithParsed = onCompleted,
        super(
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
                        : _parserFn$Mutation$RebootSystem(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationRebootSystem,
            parserFn: _parserFn$Mutation$RebootSystem);

  final OnMutationCompleted$Mutation$RebootSystem? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$RebootSystem
    extends graphql.WatchQueryOptions<Mutation$RebootSystem> {
  WatchOptions$Mutation$RebootSystem(
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
            document: documentNodeMutationRebootSystem,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$RebootSystem);
}

extension ClientExtension$Mutation$RebootSystem on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RebootSystem>> mutate$RebootSystem(
          [Options$Mutation$RebootSystem? options]) async =>
      await this.mutate(options ?? Options$Mutation$RebootSystem());
  graphql.ObservableQuery<Mutation$RebootSystem> watchMutation$RebootSystem(
          [WatchOptions$Mutation$RebootSystem? options]) =>
      this.watchMutation(options ?? WatchOptions$Mutation$RebootSystem());
}

@JsonSerializable(explicitToJson: true)
class Mutation$RebootSystem$rebootSystem
    implements Fragment$basicMutationReturnFields {
  Mutation$RebootSystem$rebootSystem(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$RebootSystem$rebootSystem.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$RebootSystem$rebootSystemFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$RebootSystem$rebootSystemToJson(this);
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
    if (!(other is Mutation$RebootSystem$rebootSystem) ||
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

extension UtilityExtension$Mutation$RebootSystem$rebootSystem
    on Mutation$RebootSystem$rebootSystem {
  Mutation$RebootSystem$rebootSystem copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$RebootSystem$rebootSystem(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Query$GetApiTokens {
  Query$GetApiTokens({required this.api, required this.$__typename});

  @override
  factory Query$GetApiTokens.fromJson(Map<String, dynamic> json) =>
      _$Query$GetApiTokensFromJson(json);

  final Query$GetApiTokens$api api;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetApiTokensToJson(this);
  int get hashCode {
    final l$api = api;
    final l$$__typename = $__typename;
    return Object.hashAll([l$api, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetApiTokens) || runtimeType != other.runtimeType)
      return false;
    final l$api = api;
    final lOther$api = other.api;
    if (l$api != lOther$api) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetApiTokens on Query$GetApiTokens {
  Query$GetApiTokens copyWith(
          {Query$GetApiTokens$api? api, String? $__typename}) =>
      Query$GetApiTokens(
          api: api == null ? this.api : api,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeQueryGetApiTokens = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetApiTokens'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'api'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'devices'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'creationDate'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'isCaller'),
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
Query$GetApiTokens _parserFn$Query$GetApiTokens(Map<String, dynamic> data) =>
    Query$GetApiTokens.fromJson(data);

class Options$Query$GetApiTokens
    extends graphql.QueryOptions<Query$GetApiTokens> {
  Options$Query$GetApiTokens(
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
            document: documentNodeQueryGetApiTokens,
            parserFn: _parserFn$Query$GetApiTokens);
}

class WatchOptions$Query$GetApiTokens
    extends graphql.WatchQueryOptions<Query$GetApiTokens> {
  WatchOptions$Query$GetApiTokens(
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
            document: documentNodeQueryGetApiTokens,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Query$GetApiTokens);
}

class FetchMoreOptions$Query$GetApiTokens extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetApiTokens(
      {required graphql.UpdateQuery updateQuery})
      : super(
            updateQuery: updateQuery, document: documentNodeQueryGetApiTokens);
}

extension ClientExtension$Query$GetApiTokens on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetApiTokens>> query$GetApiTokens(
          [Options$Query$GetApiTokens? options]) async =>
      await this.query(options ?? Options$Query$GetApiTokens());
  graphql.ObservableQuery<Query$GetApiTokens> watchQuery$GetApiTokens(
          [WatchOptions$Query$GetApiTokens? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetApiTokens());
  void writeQuery$GetApiTokens(
          {required Query$GetApiTokens data, bool broadcast = true}) =>
      this.writeQuery(
          graphql.Request(
              operation:
                  graphql.Operation(document: documentNodeQueryGetApiTokens)),
          data: data.toJson(),
          broadcast: broadcast);
  Query$GetApiTokens? readQuery$GetApiTokens({bool optimistic = true}) {
    final result = this.readQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryGetApiTokens)),
        optimistic: optimistic);
    return result == null ? null : Query$GetApiTokens.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Query$GetApiTokens$api {
  Query$GetApiTokens$api({required this.devices, required this.$__typename});

  @override
  factory Query$GetApiTokens$api.fromJson(Map<String, dynamic> json) =>
      _$Query$GetApiTokens$apiFromJson(json);

  final List<Query$GetApiTokens$api$devices> devices;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetApiTokens$apiToJson(this);
  int get hashCode {
    final l$devices = devices;
    final l$$__typename = $__typename;
    return Object.hashAll(
        [Object.hashAll(l$devices.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetApiTokens$api) || runtimeType != other.runtimeType)
      return false;
    final l$devices = devices;
    final lOther$devices = other.devices;
    if (l$devices.length != lOther$devices.length) return false;
    for (int i = 0; i < l$devices.length; i++) {
      final l$devices$entry = l$devices[i];
      final lOther$devices$entry = lOther$devices[i];
      if (l$devices$entry != lOther$devices$entry) return false;
    }

    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetApiTokens$api on Query$GetApiTokens$api {
  Query$GetApiTokens$api copyWith(
          {List<Query$GetApiTokens$api$devices>? devices,
          String? $__typename}) =>
      Query$GetApiTokens$api(
          devices: devices == null ? this.devices : devices,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Query$GetApiTokens$api$devices {
  Query$GetApiTokens$api$devices(
      {required this.creationDate,
      required this.isCaller,
      required this.name,
      required this.$__typename});

  @override
  factory Query$GetApiTokens$api$devices.fromJson(Map<String, dynamic> json) =>
      _$Query$GetApiTokens$api$devicesFromJson(json);

  @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime creationDate;

  final bool isCaller;

  final String name;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$GetApiTokens$api$devicesToJson(this);
  int get hashCode {
    final l$creationDate = creationDate;
    final l$isCaller = isCaller;
    final l$name = name;
    final l$$__typename = $__typename;
    return Object.hashAll([l$creationDate, l$isCaller, l$name, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$GetApiTokens$api$devices) ||
        runtimeType != other.runtimeType) return false;
    final l$creationDate = creationDate;
    final lOther$creationDate = other.creationDate;
    if (l$creationDate != lOther$creationDate) return false;
    final l$isCaller = isCaller;
    final lOther$isCaller = other.isCaller;
    if (l$isCaller != lOther$isCaller) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$GetApiTokens$api$devices
    on Query$GetApiTokens$api$devices {
  Query$GetApiTokens$api$devices copyWith(
          {DateTime? creationDate,
          bool? isCaller,
          String? name,
          String? $__typename}) =>
      Query$GetApiTokens$api$devices(
          creationDate: creationDate == null ? this.creationDate : creationDate,
          isCaller: isCaller == null ? this.isCaller : isCaller,
          name: name == null ? this.name : name,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Query$RecoveryKey {
  Query$RecoveryKey({required this.api, required this.$__typename});

  @override
  factory Query$RecoveryKey.fromJson(Map<String, dynamic> json) =>
      _$Query$RecoveryKeyFromJson(json);

  final Query$RecoveryKey$api api;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$RecoveryKeyToJson(this);
  int get hashCode {
    final l$api = api;
    final l$$__typename = $__typename;
    return Object.hashAll([l$api, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$RecoveryKey) || runtimeType != other.runtimeType)
      return false;
    final l$api = api;
    final lOther$api = other.api;
    if (l$api != lOther$api) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$RecoveryKey on Query$RecoveryKey {
  Query$RecoveryKey copyWith(
          {Query$RecoveryKey$api? api, String? $__typename}) =>
      Query$RecoveryKey(
          api: api == null ? this.api : api,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeQueryRecoveryKey = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'RecoveryKey'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'api'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'recoveryKey'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'creationDate'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'exists'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'expirationDate'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'usesLeft'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'valid'),
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
Query$RecoveryKey _parserFn$Query$RecoveryKey(Map<String, dynamic> data) =>
    Query$RecoveryKey.fromJson(data);

class Options$Query$RecoveryKey
    extends graphql.QueryOptions<Query$RecoveryKey> {
  Options$Query$RecoveryKey(
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
            document: documentNodeQueryRecoveryKey,
            parserFn: _parserFn$Query$RecoveryKey);
}

class WatchOptions$Query$RecoveryKey
    extends graphql.WatchQueryOptions<Query$RecoveryKey> {
  WatchOptions$Query$RecoveryKey(
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
            document: documentNodeQueryRecoveryKey,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Query$RecoveryKey);
}

class FetchMoreOptions$Query$RecoveryKey extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$RecoveryKey({required graphql.UpdateQuery updateQuery})
      : super(updateQuery: updateQuery, document: documentNodeQueryRecoveryKey);
}

extension ClientExtension$Query$RecoveryKey on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$RecoveryKey>> query$RecoveryKey(
          [Options$Query$RecoveryKey? options]) async =>
      await this.query(options ?? Options$Query$RecoveryKey());
  graphql.ObservableQuery<Query$RecoveryKey> watchQuery$RecoveryKey(
          [WatchOptions$Query$RecoveryKey? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$RecoveryKey());
  void writeQuery$RecoveryKey(
          {required Query$RecoveryKey data, bool broadcast = true}) =>
      this.writeQuery(
          graphql.Request(
              operation:
                  graphql.Operation(document: documentNodeQueryRecoveryKey)),
          data: data.toJson(),
          broadcast: broadcast);
  Query$RecoveryKey? readQuery$RecoveryKey({bool optimistic = true}) {
    final result = this.readQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryRecoveryKey)),
        optimistic: optimistic);
    return result == null ? null : Query$RecoveryKey.fromJson(result);
  }
}

@JsonSerializable(explicitToJson: true)
class Query$RecoveryKey$api {
  Query$RecoveryKey$api({required this.recoveryKey, required this.$__typename});

  @override
  factory Query$RecoveryKey$api.fromJson(Map<String, dynamic> json) =>
      _$Query$RecoveryKey$apiFromJson(json);

  final Query$RecoveryKey$api$recoveryKey recoveryKey;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Query$RecoveryKey$apiToJson(this);
  int get hashCode {
    final l$recoveryKey = recoveryKey;
    final l$$__typename = $__typename;
    return Object.hashAll([l$recoveryKey, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$RecoveryKey$api) || runtimeType != other.runtimeType)
      return false;
    final l$recoveryKey = recoveryKey;
    final lOther$recoveryKey = other.recoveryKey;
    if (l$recoveryKey != lOther$recoveryKey) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$RecoveryKey$api on Query$RecoveryKey$api {
  Query$RecoveryKey$api copyWith(
          {Query$RecoveryKey$api$recoveryKey? recoveryKey,
          String? $__typename}) =>
      Query$RecoveryKey$api(
          recoveryKey: recoveryKey == null ? this.recoveryKey : recoveryKey,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Query$RecoveryKey$api$recoveryKey {
  Query$RecoveryKey$api$recoveryKey(
      {this.creationDate,
      required this.exists,
      this.expirationDate,
      this.usesLeft,
      required this.valid,
      required this.$__typename});

  @override
  factory Query$RecoveryKey$api$recoveryKey.fromJson(
          Map<String, dynamic> json) =>
      _$Query$RecoveryKey$api$recoveryKeyFromJson(json);

  @JsonKey(
      fromJson: _nullable$dateTimeFromJson, toJson: _nullable$dateTimeToJson)
  final DateTime? creationDate;

  final bool exists;

  @JsonKey(
      fromJson: _nullable$dateTimeFromJson, toJson: _nullable$dateTimeToJson)
  final DateTime? expirationDate;

  final int? usesLeft;

  final bool valid;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Query$RecoveryKey$api$recoveryKeyToJson(this);
  int get hashCode {
    final l$creationDate = creationDate;
    final l$exists = exists;
    final l$expirationDate = expirationDate;
    final l$usesLeft = usesLeft;
    final l$valid = valid;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$creationDate,
      l$exists,
      l$expirationDate,
      l$usesLeft,
      l$valid,
      l$$__typename
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Query$RecoveryKey$api$recoveryKey) ||
        runtimeType != other.runtimeType) return false;
    final l$creationDate = creationDate;
    final lOther$creationDate = other.creationDate;
    if (l$creationDate != lOther$creationDate) return false;
    final l$exists = exists;
    final lOther$exists = other.exists;
    if (l$exists != lOther$exists) return false;
    final l$expirationDate = expirationDate;
    final lOther$expirationDate = other.expirationDate;
    if (l$expirationDate != lOther$expirationDate) return false;
    final l$usesLeft = usesLeft;
    final lOther$usesLeft = other.usesLeft;
    if (l$usesLeft != lOther$usesLeft) return false;
    final l$valid = valid;
    final lOther$valid = other.valid;
    if (l$valid != lOther$valid) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Query$RecoveryKey$api$recoveryKey
    on Query$RecoveryKey$api$recoveryKey {
  Query$RecoveryKey$api$recoveryKey copyWith(
          {DateTime? Function()? creationDate,
          bool? exists,
          DateTime? Function()? expirationDate,
          int? Function()? usesLeft,
          bool? valid,
          String? $__typename}) =>
      Query$RecoveryKey$api$recoveryKey(
          creationDate:
              creationDate == null ? this.creationDate : creationDate(),
          exists: exists == null ? this.exists : exists,
          expirationDate:
              expirationDate == null ? this.expirationDate : expirationDate(),
          usesLeft: usesLeft == null ? this.usesLeft : usesLeft(),
          valid: valid == null ? this.valid : valid,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$GetNewRecoveryApiKey {
  Variables$Mutation$GetNewRecoveryApiKey({this.limits});

  @override
  factory Variables$Mutation$GetNewRecoveryApiKey.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$GetNewRecoveryApiKeyFromJson(json);

  final Input$RecoveryKeyLimitsInput? limits;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$GetNewRecoveryApiKeyToJson(this);
  int get hashCode {
    final l$limits = limits;
    return Object.hashAll([l$limits]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$GetNewRecoveryApiKey) ||
        runtimeType != other.runtimeType) return false;
    final l$limits = limits;
    final lOther$limits = other.limits;
    if (l$limits != lOther$limits) return false;
    return true;
  }

  Variables$Mutation$GetNewRecoveryApiKey copyWith(
          {Input$RecoveryKeyLimitsInput? Function()? limits}) =>
      Variables$Mutation$GetNewRecoveryApiKey(
          limits: limits == null ? this.limits : limits());
}

@JsonSerializable(explicitToJson: true)
class Mutation$GetNewRecoveryApiKey {
  Mutation$GetNewRecoveryApiKey(
      {required this.getNewRecoveryApiKey, required this.$__typename});

  @override
  factory Mutation$GetNewRecoveryApiKey.fromJson(Map<String, dynamic> json) =>
      _$Mutation$GetNewRecoveryApiKeyFromJson(json);

  final Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey getNewRecoveryApiKey;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$GetNewRecoveryApiKeyToJson(this);
  int get hashCode {
    final l$getNewRecoveryApiKey = getNewRecoveryApiKey;
    final l$$__typename = $__typename;
    return Object.hashAll([l$getNewRecoveryApiKey, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$GetNewRecoveryApiKey) ||
        runtimeType != other.runtimeType) return false;
    final l$getNewRecoveryApiKey = getNewRecoveryApiKey;
    final lOther$getNewRecoveryApiKey = other.getNewRecoveryApiKey;
    if (l$getNewRecoveryApiKey != lOther$getNewRecoveryApiKey) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$GetNewRecoveryApiKey
    on Mutation$GetNewRecoveryApiKey {
  Mutation$GetNewRecoveryApiKey copyWith(
          {Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey?
              getNewRecoveryApiKey,
          String? $__typename}) =>
      Mutation$GetNewRecoveryApiKey(
          getNewRecoveryApiKey: getNewRecoveryApiKey == null
              ? this.getNewRecoveryApiKey
              : getNewRecoveryApiKey,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationGetNewRecoveryApiKey = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'GetNewRecoveryApiKey'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limits')),
            type: NamedTypeNode(
                name: NameNode(value: 'RecoveryKeyLimitsInput'),
                isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'getNewRecoveryApiKey'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'limits'),
                  value: VariableNode(name: NameNode(value: 'limits')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
              FieldNode(
                  name: NameNode(value: 'key'),
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
Mutation$GetNewRecoveryApiKey _parserFn$Mutation$GetNewRecoveryApiKey(
        Map<String, dynamic> data) =>
    Mutation$GetNewRecoveryApiKey.fromJson(data);
typedef OnMutationCompleted$Mutation$GetNewRecoveryApiKey = FutureOr<void>
    Function(dynamic, Mutation$GetNewRecoveryApiKey?);

class Options$Mutation$GetNewRecoveryApiKey
    extends graphql.MutationOptions<Mutation$GetNewRecoveryApiKey> {
  Options$Mutation$GetNewRecoveryApiKey(
      {String? operationName,
      Variables$Mutation$GetNewRecoveryApiKey? variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$GetNewRecoveryApiKey? onCompleted,
      graphql.OnMutationUpdate<Mutation$GetNewRecoveryApiKey>? update,
      graphql.OnError? onError})
      : onCompletedWithParsed = onCompleted,
        super(
            variables: variables?.toJson() ?? {},
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
                        : _parserFn$Mutation$GetNewRecoveryApiKey(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationGetNewRecoveryApiKey,
            parserFn: _parserFn$Mutation$GetNewRecoveryApiKey);

  final OnMutationCompleted$Mutation$GetNewRecoveryApiKey?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$GetNewRecoveryApiKey
    extends graphql.WatchQueryOptions<Mutation$GetNewRecoveryApiKey> {
  WatchOptions$Mutation$GetNewRecoveryApiKey(
      {String? operationName,
      Variables$Mutation$GetNewRecoveryApiKey? variables,
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
            variables: variables?.toJson() ?? {},
            operationName: operationName,
            fetchPolicy: fetchPolicy,
            errorPolicy: errorPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            optimisticResult: optimisticResult,
            context: context,
            document: documentNodeMutationGetNewRecoveryApiKey,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$GetNewRecoveryApiKey);
}

extension ClientExtension$Mutation$GetNewRecoveryApiKey
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$GetNewRecoveryApiKey>>
      mutate$GetNewRecoveryApiKey(
              [Options$Mutation$GetNewRecoveryApiKey? options]) async =>
          await this.mutate(options ?? Options$Mutation$GetNewRecoveryApiKey());
  graphql.ObservableQuery<Mutation$GetNewRecoveryApiKey>
      watchMutation$GetNewRecoveryApiKey(
              [WatchOptions$Mutation$GetNewRecoveryApiKey? options]) =>
          this.watchMutation(
              options ?? WatchOptions$Mutation$GetNewRecoveryApiKey());
}

@JsonSerializable(explicitToJson: true)
class Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey
    implements Fragment$basicMutationReturnFields {
  Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename,
      this.key});

  @override
  factory Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKeyFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  final String? key;

  Map<String, dynamic> toJson() =>
      _$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKeyToJson(this);
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$key = key;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename, l$key]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey) ||
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
    final l$key = key;
    final lOther$key = other.key;
    if (l$key != lOther$key) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey
    on Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey {
  Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey copyWith(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          String? Function()? key}) =>
      Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename,
          key: key == null ? this.key : key());
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$UseRecoveryApiKey {
  Variables$Mutation$UseRecoveryApiKey({required this.input});

  @override
  factory Variables$Mutation$UseRecoveryApiKey.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$UseRecoveryApiKeyFromJson(json);

  final Input$UseRecoveryKeyInput input;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$UseRecoveryApiKeyToJson(this);
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$UseRecoveryApiKey) ||
        runtimeType != other.runtimeType) return false;
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) return false;
    return true;
  }

  Variables$Mutation$UseRecoveryApiKey copyWith(
          {Input$UseRecoveryKeyInput? input}) =>
      Variables$Mutation$UseRecoveryApiKey(
          input: input == null ? this.input : input);
}

@JsonSerializable(explicitToJson: true)
class Mutation$UseRecoveryApiKey {
  Mutation$UseRecoveryApiKey(
      {required this.useRecoveryApiKey, required this.$__typename});

  @override
  factory Mutation$UseRecoveryApiKey.fromJson(Map<String, dynamic> json) =>
      _$Mutation$UseRecoveryApiKeyFromJson(json);

  final Mutation$UseRecoveryApiKey$useRecoveryApiKey useRecoveryApiKey;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$UseRecoveryApiKeyToJson(this);
  int get hashCode {
    final l$useRecoveryApiKey = useRecoveryApiKey;
    final l$$__typename = $__typename;
    return Object.hashAll([l$useRecoveryApiKey, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$UseRecoveryApiKey) ||
        runtimeType != other.runtimeType) return false;
    final l$useRecoveryApiKey = useRecoveryApiKey;
    final lOther$useRecoveryApiKey = other.useRecoveryApiKey;
    if (l$useRecoveryApiKey != lOther$useRecoveryApiKey) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$UseRecoveryApiKey
    on Mutation$UseRecoveryApiKey {
  Mutation$UseRecoveryApiKey copyWith(
          {Mutation$UseRecoveryApiKey$useRecoveryApiKey? useRecoveryApiKey,
          String? $__typename}) =>
      Mutation$UseRecoveryApiKey(
          useRecoveryApiKey: useRecoveryApiKey == null
              ? this.useRecoveryApiKey
              : useRecoveryApiKey,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationUseRecoveryApiKey = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UseRecoveryApiKey'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type: NamedTypeNode(
                name: NameNode(value: 'UseRecoveryKeyInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'useRecoveryApiKey'),
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
                  name: NameNode(value: 'token'),
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
Mutation$UseRecoveryApiKey _parserFn$Mutation$UseRecoveryApiKey(
        Map<String, dynamic> data) =>
    Mutation$UseRecoveryApiKey.fromJson(data);
typedef OnMutationCompleted$Mutation$UseRecoveryApiKey = FutureOr<void>
    Function(dynamic, Mutation$UseRecoveryApiKey?);

class Options$Mutation$UseRecoveryApiKey
    extends graphql.MutationOptions<Mutation$UseRecoveryApiKey> {
  Options$Mutation$UseRecoveryApiKey(
      {String? operationName,
      required Variables$Mutation$UseRecoveryApiKey variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$UseRecoveryApiKey? onCompleted,
      graphql.OnMutationUpdate<Mutation$UseRecoveryApiKey>? update,
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
                        : _parserFn$Mutation$UseRecoveryApiKey(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationUseRecoveryApiKey,
            parserFn: _parserFn$Mutation$UseRecoveryApiKey);

  final OnMutationCompleted$Mutation$UseRecoveryApiKey? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$UseRecoveryApiKey
    extends graphql.WatchQueryOptions<Mutation$UseRecoveryApiKey> {
  WatchOptions$Mutation$UseRecoveryApiKey(
      {String? operationName,
      required Variables$Mutation$UseRecoveryApiKey variables,
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
            document: documentNodeMutationUseRecoveryApiKey,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$UseRecoveryApiKey);
}

extension ClientExtension$Mutation$UseRecoveryApiKey on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UseRecoveryApiKey>>
      mutate$UseRecoveryApiKey(
              Options$Mutation$UseRecoveryApiKey options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$UseRecoveryApiKey>
      watchMutation$UseRecoveryApiKey(
              WatchOptions$Mutation$UseRecoveryApiKey options) =>
          this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$UseRecoveryApiKey$useRecoveryApiKey
    implements Fragment$basicMutationReturnFields {
  Mutation$UseRecoveryApiKey$useRecoveryApiKey(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename,
      this.token});

  @override
  factory Mutation$UseRecoveryApiKey$useRecoveryApiKey.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$UseRecoveryApiKey$useRecoveryApiKeyFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  final String? token;

  Map<String, dynamic> toJson() =>
      _$Mutation$UseRecoveryApiKey$useRecoveryApiKeyToJson(this);
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$token = token;
    return Object.hashAll(
        [l$code, l$message, l$success, l$$__typename, l$token]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$UseRecoveryApiKey$useRecoveryApiKey) ||
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
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$UseRecoveryApiKey$useRecoveryApiKey
    on Mutation$UseRecoveryApiKey$useRecoveryApiKey {
  Mutation$UseRecoveryApiKey$useRecoveryApiKey copyWith(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          String? Function()? token}) =>
      Mutation$UseRecoveryApiKey$useRecoveryApiKey(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename,
          token: token == null ? this.token : token());
}

@JsonSerializable(explicitToJson: true)
class Mutation$RefreshDeviceApiToken {
  Mutation$RefreshDeviceApiToken(
      {required this.refreshDeviceApiToken, required this.$__typename});

  @override
  factory Mutation$RefreshDeviceApiToken.fromJson(Map<String, dynamic> json) =>
      _$Mutation$RefreshDeviceApiTokenFromJson(json);

  final Mutation$RefreshDeviceApiToken$refreshDeviceApiToken
      refreshDeviceApiToken;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$RefreshDeviceApiTokenToJson(this);
  int get hashCode {
    final l$refreshDeviceApiToken = refreshDeviceApiToken;
    final l$$__typename = $__typename;
    return Object.hashAll([l$refreshDeviceApiToken, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$RefreshDeviceApiToken) ||
        runtimeType != other.runtimeType) return false;
    final l$refreshDeviceApiToken = refreshDeviceApiToken;
    final lOther$refreshDeviceApiToken = other.refreshDeviceApiToken;
    if (l$refreshDeviceApiToken != lOther$refreshDeviceApiToken) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$RefreshDeviceApiToken
    on Mutation$RefreshDeviceApiToken {
  Mutation$RefreshDeviceApiToken copyWith(
          {Mutation$RefreshDeviceApiToken$refreshDeviceApiToken?
              refreshDeviceApiToken,
          String? $__typename}) =>
      Mutation$RefreshDeviceApiToken(
          refreshDeviceApiToken: refreshDeviceApiToken == null
              ? this.refreshDeviceApiToken
              : refreshDeviceApiToken,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationRefreshDeviceApiToken = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RefreshDeviceApiToken'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'refreshDeviceApiToken'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
              FieldNode(
                  name: NameNode(value: 'token'),
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
Mutation$RefreshDeviceApiToken _parserFn$Mutation$RefreshDeviceApiToken(
        Map<String, dynamic> data) =>
    Mutation$RefreshDeviceApiToken.fromJson(data);
typedef OnMutationCompleted$Mutation$RefreshDeviceApiToken = FutureOr<void>
    Function(dynamic, Mutation$RefreshDeviceApiToken?);

class Options$Mutation$RefreshDeviceApiToken
    extends graphql.MutationOptions<Mutation$RefreshDeviceApiToken> {
  Options$Mutation$RefreshDeviceApiToken(
      {String? operationName,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$RefreshDeviceApiToken? onCompleted,
      graphql.OnMutationUpdate<Mutation$RefreshDeviceApiToken>? update,
      graphql.OnError? onError})
      : onCompletedWithParsed = onCompleted,
        super(
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
                        : _parserFn$Mutation$RefreshDeviceApiToken(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationRefreshDeviceApiToken,
            parserFn: _parserFn$Mutation$RefreshDeviceApiToken);

  final OnMutationCompleted$Mutation$RefreshDeviceApiToken?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$RefreshDeviceApiToken
    extends graphql.WatchQueryOptions<Mutation$RefreshDeviceApiToken> {
  WatchOptions$Mutation$RefreshDeviceApiToken(
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
            document: documentNodeMutationRefreshDeviceApiToken,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$RefreshDeviceApiToken);
}

extension ClientExtension$Mutation$RefreshDeviceApiToken
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RefreshDeviceApiToken>>
      mutate$RefreshDeviceApiToken(
              [Options$Mutation$RefreshDeviceApiToken? options]) async =>
          await this
              .mutate(options ?? Options$Mutation$RefreshDeviceApiToken());
  graphql.ObservableQuery<Mutation$RefreshDeviceApiToken>
      watchMutation$RefreshDeviceApiToken(
              [WatchOptions$Mutation$RefreshDeviceApiToken? options]) =>
          this.watchMutation(
              options ?? WatchOptions$Mutation$RefreshDeviceApiToken());
}

@JsonSerializable(explicitToJson: true)
class Mutation$RefreshDeviceApiToken$refreshDeviceApiToken
    implements Fragment$basicMutationReturnFields {
  Mutation$RefreshDeviceApiToken$refreshDeviceApiToken(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename,
      this.token});

  @override
  factory Mutation$RefreshDeviceApiToken$refreshDeviceApiToken.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$RefreshDeviceApiToken$refreshDeviceApiTokenFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  final String? token;

  Map<String, dynamic> toJson() =>
      _$Mutation$RefreshDeviceApiToken$refreshDeviceApiTokenToJson(this);
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$token = token;
    return Object.hashAll(
        [l$code, l$message, l$success, l$$__typename, l$token]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$RefreshDeviceApiToken$refreshDeviceApiToken) ||
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
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken
    on Mutation$RefreshDeviceApiToken$refreshDeviceApiToken {
  Mutation$RefreshDeviceApiToken$refreshDeviceApiToken copyWith(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          String? Function()? token}) =>
      Mutation$RefreshDeviceApiToken$refreshDeviceApiToken(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename,
          token: token == null ? this.token : token());
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$DeleteDeviceApiToken {
  Variables$Mutation$DeleteDeviceApiToken({required this.device});

  @override
  factory Variables$Mutation$DeleteDeviceApiToken.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$DeleteDeviceApiTokenFromJson(json);

  final String device;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$DeleteDeviceApiTokenToJson(this);
  int get hashCode {
    final l$device = device;
    return Object.hashAll([l$device]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$DeleteDeviceApiToken) ||
        runtimeType != other.runtimeType) return false;
    final l$device = device;
    final lOther$device = other.device;
    if (l$device != lOther$device) return false;
    return true;
  }

  Variables$Mutation$DeleteDeviceApiToken copyWith({String? device}) =>
      Variables$Mutation$DeleteDeviceApiToken(
          device: device == null ? this.device : device);
}

@JsonSerializable(explicitToJson: true)
class Mutation$DeleteDeviceApiToken {
  Mutation$DeleteDeviceApiToken(
      {required this.deleteDeviceApiToken, required this.$__typename});

  @override
  factory Mutation$DeleteDeviceApiToken.fromJson(Map<String, dynamic> json) =>
      _$Mutation$DeleteDeviceApiTokenFromJson(json);

  final Mutation$DeleteDeviceApiToken$deleteDeviceApiToken deleteDeviceApiToken;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$DeleteDeviceApiTokenToJson(this);
  int get hashCode {
    final l$deleteDeviceApiToken = deleteDeviceApiToken;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deleteDeviceApiToken, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$DeleteDeviceApiToken) ||
        runtimeType != other.runtimeType) return false;
    final l$deleteDeviceApiToken = deleteDeviceApiToken;
    final lOther$deleteDeviceApiToken = other.deleteDeviceApiToken;
    if (l$deleteDeviceApiToken != lOther$deleteDeviceApiToken) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$DeleteDeviceApiToken
    on Mutation$DeleteDeviceApiToken {
  Mutation$DeleteDeviceApiToken copyWith(
          {Mutation$DeleteDeviceApiToken$deleteDeviceApiToken?
              deleteDeviceApiToken,
          String? $__typename}) =>
      Mutation$DeleteDeviceApiToken(
          deleteDeviceApiToken: deleteDeviceApiToken == null
              ? this.deleteDeviceApiToken
              : deleteDeviceApiToken,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationDeleteDeviceApiToken = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteDeviceApiToken'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'device')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'deleteDeviceApiToken'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'device'),
                  value: VariableNode(name: NameNode(value: 'device')))
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
Mutation$DeleteDeviceApiToken _parserFn$Mutation$DeleteDeviceApiToken(
        Map<String, dynamic> data) =>
    Mutation$DeleteDeviceApiToken.fromJson(data);
typedef OnMutationCompleted$Mutation$DeleteDeviceApiToken = FutureOr<void>
    Function(dynamic, Mutation$DeleteDeviceApiToken?);

class Options$Mutation$DeleteDeviceApiToken
    extends graphql.MutationOptions<Mutation$DeleteDeviceApiToken> {
  Options$Mutation$DeleteDeviceApiToken(
      {String? operationName,
      required Variables$Mutation$DeleteDeviceApiToken variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$DeleteDeviceApiToken? onCompleted,
      graphql.OnMutationUpdate<Mutation$DeleteDeviceApiToken>? update,
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
                        : _parserFn$Mutation$DeleteDeviceApiToken(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationDeleteDeviceApiToken,
            parserFn: _parserFn$Mutation$DeleteDeviceApiToken);

  final OnMutationCompleted$Mutation$DeleteDeviceApiToken?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$DeleteDeviceApiToken
    extends graphql.WatchQueryOptions<Mutation$DeleteDeviceApiToken> {
  WatchOptions$Mutation$DeleteDeviceApiToken(
      {String? operationName,
      required Variables$Mutation$DeleteDeviceApiToken variables,
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
            document: documentNodeMutationDeleteDeviceApiToken,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$DeleteDeviceApiToken);
}

extension ClientExtension$Mutation$DeleteDeviceApiToken
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$DeleteDeviceApiToken>>
      mutate$DeleteDeviceApiToken(
              Options$Mutation$DeleteDeviceApiToken options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$DeleteDeviceApiToken>
      watchMutation$DeleteDeviceApiToken(
              WatchOptions$Mutation$DeleteDeviceApiToken options) =>
          this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$DeleteDeviceApiToken$deleteDeviceApiToken
    implements Fragment$basicMutationReturnFields {
  Mutation$DeleteDeviceApiToken$deleteDeviceApiToken(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$DeleteDeviceApiToken$deleteDeviceApiToken.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$DeleteDeviceApiToken$deleteDeviceApiTokenFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$DeleteDeviceApiToken$deleteDeviceApiTokenToJson(this);
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
    if (!(other is Mutation$DeleteDeviceApiToken$deleteDeviceApiToken) ||
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

extension UtilityExtension$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken
    on Mutation$DeleteDeviceApiToken$deleteDeviceApiToken {
  Mutation$DeleteDeviceApiToken$deleteDeviceApiToken copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$DeleteDeviceApiToken$deleteDeviceApiToken(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Mutation$GetNewDeviceApiKey {
  Mutation$GetNewDeviceApiKey(
      {required this.getNewDeviceApiKey, required this.$__typename});

  @override
  factory Mutation$GetNewDeviceApiKey.fromJson(Map<String, dynamic> json) =>
      _$Mutation$GetNewDeviceApiKeyFromJson(json);

  final Mutation$GetNewDeviceApiKey$getNewDeviceApiKey getNewDeviceApiKey;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Mutation$GetNewDeviceApiKeyToJson(this);
  int get hashCode {
    final l$getNewDeviceApiKey = getNewDeviceApiKey;
    final l$$__typename = $__typename;
    return Object.hashAll([l$getNewDeviceApiKey, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$GetNewDeviceApiKey) ||
        runtimeType != other.runtimeType) return false;
    final l$getNewDeviceApiKey = getNewDeviceApiKey;
    final lOther$getNewDeviceApiKey = other.getNewDeviceApiKey;
    if (l$getNewDeviceApiKey != lOther$getNewDeviceApiKey) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$GetNewDeviceApiKey
    on Mutation$GetNewDeviceApiKey {
  Mutation$GetNewDeviceApiKey copyWith(
          {Mutation$GetNewDeviceApiKey$getNewDeviceApiKey? getNewDeviceApiKey,
          String? $__typename}) =>
      Mutation$GetNewDeviceApiKey(
          getNewDeviceApiKey: getNewDeviceApiKey == null
              ? this.getNewDeviceApiKey
              : getNewDeviceApiKey,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationGetNewDeviceApiKey = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'GetNewDeviceApiKey'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'getNewDeviceApiKey'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'basicMutationReturnFields'),
                  directives: []),
              FieldNode(
                  name: NameNode(value: 'key'),
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
Mutation$GetNewDeviceApiKey _parserFn$Mutation$GetNewDeviceApiKey(
        Map<String, dynamic> data) =>
    Mutation$GetNewDeviceApiKey.fromJson(data);
typedef OnMutationCompleted$Mutation$GetNewDeviceApiKey = FutureOr<void>
    Function(dynamic, Mutation$GetNewDeviceApiKey?);

class Options$Mutation$GetNewDeviceApiKey
    extends graphql.MutationOptions<Mutation$GetNewDeviceApiKey> {
  Options$Mutation$GetNewDeviceApiKey(
      {String? operationName,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$GetNewDeviceApiKey? onCompleted,
      graphql.OnMutationUpdate<Mutation$GetNewDeviceApiKey>? update,
      graphql.OnError? onError})
      : onCompletedWithParsed = onCompleted,
        super(
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
                        : _parserFn$Mutation$GetNewDeviceApiKey(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationGetNewDeviceApiKey,
            parserFn: _parserFn$Mutation$GetNewDeviceApiKey);

  final OnMutationCompleted$Mutation$GetNewDeviceApiKey? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$GetNewDeviceApiKey
    extends graphql.WatchQueryOptions<Mutation$GetNewDeviceApiKey> {
  WatchOptions$Mutation$GetNewDeviceApiKey(
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
            document: documentNodeMutationGetNewDeviceApiKey,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$GetNewDeviceApiKey);
}

extension ClientExtension$Mutation$GetNewDeviceApiKey on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$GetNewDeviceApiKey>>
      mutate$GetNewDeviceApiKey(
              [Options$Mutation$GetNewDeviceApiKey? options]) async =>
          await this.mutate(options ?? Options$Mutation$GetNewDeviceApiKey());
  graphql.ObservableQuery<
      Mutation$GetNewDeviceApiKey> watchMutation$GetNewDeviceApiKey(
          [WatchOptions$Mutation$GetNewDeviceApiKey? options]) =>
      this.watchMutation(options ?? WatchOptions$Mutation$GetNewDeviceApiKey());
}

@JsonSerializable(explicitToJson: true)
class Mutation$GetNewDeviceApiKey$getNewDeviceApiKey
    implements Fragment$basicMutationReturnFields {
  Mutation$GetNewDeviceApiKey$getNewDeviceApiKey(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename,
      this.key});

  @override
  factory Mutation$GetNewDeviceApiKey$getNewDeviceApiKey.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$GetNewDeviceApiKey$getNewDeviceApiKeyFromJson(json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  final String? key;

  Map<String, dynamic> toJson() =>
      _$Mutation$GetNewDeviceApiKey$getNewDeviceApiKeyToJson(this);
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$key = key;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename, l$key]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$GetNewDeviceApiKey$getNewDeviceApiKey) ||
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
    final l$key = key;
    final lOther$key = other.key;
    if (l$key != lOther$key) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey
    on Mutation$GetNewDeviceApiKey$getNewDeviceApiKey {
  Mutation$GetNewDeviceApiKey$getNewDeviceApiKey copyWith(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          String? Function()? key}) =>
      Mutation$GetNewDeviceApiKey$getNewDeviceApiKey(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename,
          key: key == null ? this.key : key());
}

@JsonSerializable(explicitToJson: true)
class Mutation$InvalidateNewDeviceApiKey {
  Mutation$InvalidateNewDeviceApiKey(
      {required this.invalidateNewDeviceApiKey, required this.$__typename});

  @override
  factory Mutation$InvalidateNewDeviceApiKey.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$InvalidateNewDeviceApiKeyFromJson(json);

  final Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey
      invalidateNewDeviceApiKey;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$InvalidateNewDeviceApiKeyToJson(this);
  int get hashCode {
    final l$invalidateNewDeviceApiKey = invalidateNewDeviceApiKey;
    final l$$__typename = $__typename;
    return Object.hashAll([l$invalidateNewDeviceApiKey, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$InvalidateNewDeviceApiKey) ||
        runtimeType != other.runtimeType) return false;
    final l$invalidateNewDeviceApiKey = invalidateNewDeviceApiKey;
    final lOther$invalidateNewDeviceApiKey = other.invalidateNewDeviceApiKey;
    if (l$invalidateNewDeviceApiKey != lOther$invalidateNewDeviceApiKey)
      return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$InvalidateNewDeviceApiKey
    on Mutation$InvalidateNewDeviceApiKey {
  Mutation$InvalidateNewDeviceApiKey copyWith(
          {Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey?
              invalidateNewDeviceApiKey,
          String? $__typename}) =>
      Mutation$InvalidateNewDeviceApiKey(
          invalidateNewDeviceApiKey: invalidateNewDeviceApiKey == null
              ? this.invalidateNewDeviceApiKey
              : invalidateNewDeviceApiKey,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationInvalidateNewDeviceApiKey =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'InvalidateNewDeviceApiKey'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'invalidateNewDeviceApiKey'),
            alias: null,
            arguments: [],
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
Mutation$InvalidateNewDeviceApiKey _parserFn$Mutation$InvalidateNewDeviceApiKey(
        Map<String, dynamic> data) =>
    Mutation$InvalidateNewDeviceApiKey.fromJson(data);
typedef OnMutationCompleted$Mutation$InvalidateNewDeviceApiKey = FutureOr<void>
    Function(dynamic, Mutation$InvalidateNewDeviceApiKey?);

class Options$Mutation$InvalidateNewDeviceApiKey
    extends graphql.MutationOptions<Mutation$InvalidateNewDeviceApiKey> {
  Options$Mutation$InvalidateNewDeviceApiKey(
      {String? operationName,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$InvalidateNewDeviceApiKey? onCompleted,
      graphql.OnMutationUpdate<Mutation$InvalidateNewDeviceApiKey>? update,
      graphql.OnError? onError})
      : onCompletedWithParsed = onCompleted,
        super(
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
                        : _parserFn$Mutation$InvalidateNewDeviceApiKey(data)),
            update: update,
            onError: onError,
            document: documentNodeMutationInvalidateNewDeviceApiKey,
            parserFn: _parserFn$Mutation$InvalidateNewDeviceApiKey);

  final OnMutationCompleted$Mutation$InvalidateNewDeviceApiKey?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$InvalidateNewDeviceApiKey
    extends graphql.WatchQueryOptions<Mutation$InvalidateNewDeviceApiKey> {
  WatchOptions$Mutation$InvalidateNewDeviceApiKey(
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
            document: documentNodeMutationInvalidateNewDeviceApiKey,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$InvalidateNewDeviceApiKey);
}

extension ClientExtension$Mutation$InvalidateNewDeviceApiKey
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$InvalidateNewDeviceApiKey>>
      mutate$InvalidateNewDeviceApiKey(
              [Options$Mutation$InvalidateNewDeviceApiKey? options]) async =>
          await this
              .mutate(options ?? Options$Mutation$InvalidateNewDeviceApiKey());
  graphql.ObservableQuery<Mutation$InvalidateNewDeviceApiKey>
      watchMutation$InvalidateNewDeviceApiKey(
              [WatchOptions$Mutation$InvalidateNewDeviceApiKey? options]) =>
          this.watchMutation(
              options ?? WatchOptions$Mutation$InvalidateNewDeviceApiKey());
}

@JsonSerializable(explicitToJson: true)
class Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey
    implements Fragment$basicMutationReturnFields {
  Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename});

  @override
  factory Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKeyFromJson(
          json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKeyToJson(
          this);
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
    if (!(other
            is Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey) ||
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

extension UtilityExtension$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey
    on Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey {
  Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey copyWith(
          {int? code, String? message, bool? success, String? $__typename}) =>
      Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

@JsonSerializable(explicitToJson: true)
class Variables$Mutation$AuthorizeWithNewDeviceApiKey {
  Variables$Mutation$AuthorizeWithNewDeviceApiKey({required this.input});

  @override
  factory Variables$Mutation$AuthorizeWithNewDeviceApiKey.fromJson(
          Map<String, dynamic> json) =>
      _$Variables$Mutation$AuthorizeWithNewDeviceApiKeyFromJson(json);

  final Input$UseNewDeviceKeyInput input;

  Map<String, dynamic> toJson() =>
      _$Variables$Mutation$AuthorizeWithNewDeviceApiKeyToJson(this);
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Variables$Mutation$AuthorizeWithNewDeviceApiKey) ||
        runtimeType != other.runtimeType) return false;
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) return false;
    return true;
  }

  Variables$Mutation$AuthorizeWithNewDeviceApiKey copyWith(
          {Input$UseNewDeviceKeyInput? input}) =>
      Variables$Mutation$AuthorizeWithNewDeviceApiKey(
          input: input == null ? this.input : input);
}

@JsonSerializable(explicitToJson: true)
class Mutation$AuthorizeWithNewDeviceApiKey {
  Mutation$AuthorizeWithNewDeviceApiKey(
      {required this.authorizeWithNewDeviceApiKey, required this.$__typename});

  @override
  factory Mutation$AuthorizeWithNewDeviceApiKey.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$AuthorizeWithNewDeviceApiKeyFromJson(json);

  final Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey
      authorizeWithNewDeviceApiKey;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() =>
      _$Mutation$AuthorizeWithNewDeviceApiKeyToJson(this);
  int get hashCode {
    final l$authorizeWithNewDeviceApiKey = authorizeWithNewDeviceApiKey;
    final l$$__typename = $__typename;
    return Object.hashAll([l$authorizeWithNewDeviceApiKey, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Mutation$AuthorizeWithNewDeviceApiKey) ||
        runtimeType != other.runtimeType) return false;
    final l$authorizeWithNewDeviceApiKey = authorizeWithNewDeviceApiKey;
    final lOther$authorizeWithNewDeviceApiKey =
        other.authorizeWithNewDeviceApiKey;
    if (l$authorizeWithNewDeviceApiKey != lOther$authorizeWithNewDeviceApiKey)
      return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$AuthorizeWithNewDeviceApiKey
    on Mutation$AuthorizeWithNewDeviceApiKey {
  Mutation$AuthorizeWithNewDeviceApiKey copyWith(
          {Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey?
              authorizeWithNewDeviceApiKey,
          String? $__typename}) =>
      Mutation$AuthorizeWithNewDeviceApiKey(
          authorizeWithNewDeviceApiKey: authorizeWithNewDeviceApiKey == null
              ? this.authorizeWithNewDeviceApiKey
              : authorizeWithNewDeviceApiKey,
          $__typename: $__typename == null ? this.$__typename : $__typename);
}

const documentNodeMutationAuthorizeWithNewDeviceApiKey =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AuthorizeWithNewDeviceApiKey'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type: NamedTypeNode(
                name: NameNode(value: 'UseNewDeviceKeyInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'authorizeWithNewDeviceApiKey'),
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
                  name: NameNode(value: 'token'),
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
Mutation$AuthorizeWithNewDeviceApiKey
    _parserFn$Mutation$AuthorizeWithNewDeviceApiKey(
            Map<String, dynamic> data) =>
        Mutation$AuthorizeWithNewDeviceApiKey.fromJson(data);
typedef OnMutationCompleted$Mutation$AuthorizeWithNewDeviceApiKey
    = FutureOr<void> Function(dynamic, Mutation$AuthorizeWithNewDeviceApiKey?);

class Options$Mutation$AuthorizeWithNewDeviceApiKey
    extends graphql.MutationOptions<Mutation$AuthorizeWithNewDeviceApiKey> {
  Options$Mutation$AuthorizeWithNewDeviceApiKey(
      {String? operationName,
      required Variables$Mutation$AuthorizeWithNewDeviceApiKey variables,
      graphql.FetchPolicy? fetchPolicy,
      graphql.ErrorPolicy? errorPolicy,
      graphql.CacheRereadPolicy? cacheRereadPolicy,
      Object? optimisticResult,
      graphql.Context? context,
      OnMutationCompleted$Mutation$AuthorizeWithNewDeviceApiKey? onCompleted,
      graphql.OnMutationUpdate<Mutation$AuthorizeWithNewDeviceApiKey>? update,
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
                        : _parserFn$Mutation$AuthorizeWithNewDeviceApiKey(
                            data)),
            update: update,
            onError: onError,
            document: documentNodeMutationAuthorizeWithNewDeviceApiKey,
            parserFn: _parserFn$Mutation$AuthorizeWithNewDeviceApiKey);

  final OnMutationCompleted$Mutation$AuthorizeWithNewDeviceApiKey?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed
      ];
}

class WatchOptions$Mutation$AuthorizeWithNewDeviceApiKey
    extends graphql.WatchQueryOptions<Mutation$AuthorizeWithNewDeviceApiKey> {
  WatchOptions$Mutation$AuthorizeWithNewDeviceApiKey(
      {String? operationName,
      required Variables$Mutation$AuthorizeWithNewDeviceApiKey variables,
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
            document: documentNodeMutationAuthorizeWithNewDeviceApiKey,
            pollInterval: pollInterval,
            eagerlyFetchResults: eagerlyFetchResults,
            carryForwardDataOnException: carryForwardDataOnException,
            fetchResults: fetchResults,
            parserFn: _parserFn$Mutation$AuthorizeWithNewDeviceApiKey);
}

extension ClientExtension$Mutation$AuthorizeWithNewDeviceApiKey
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$AuthorizeWithNewDeviceApiKey>>
      mutate$AuthorizeWithNewDeviceApiKey(
              Options$Mutation$AuthorizeWithNewDeviceApiKey options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$AuthorizeWithNewDeviceApiKey>
      watchMutation$AuthorizeWithNewDeviceApiKey(
              WatchOptions$Mutation$AuthorizeWithNewDeviceApiKey options) =>
          this.watchMutation(options);
}

@JsonSerializable(explicitToJson: true)
class Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey
    implements Fragment$basicMutationReturnFields {
  Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey(
      {required this.code,
      required this.message,
      required this.success,
      required this.$__typename,
      this.token});

  @override
  factory Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey.fromJson(
          Map<String, dynamic> json) =>
      _$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKeyFromJson(
          json);

  final int code;

  final String message;

  final bool success;

  @JsonKey(name: '__typename')
  final String $__typename;

  final String? token;

  Map<String, dynamic> toJson() =>
      _$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKeyToJson(
          this);
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$token = token;
    return Object.hashAll(
        [l$code, l$message, l$success, l$$__typename, l$token]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other
            is Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey) ||
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
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) return false;
    return true;
  }
}

extension UtilityExtension$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey
    on Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey {
  Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey copyWith(
          {int? code,
          String? message,
          bool? success,
          String? $__typename,
          String? Function()? token}) =>
      Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey(
          code: code == null ? this.code : code,
          message: message == null ? this.message : message,
          success: success == null ? this.success : success,
          $__typename: $__typename == null ? this.$__typename : $__typename,
          token: token == null ? this.token : token());
}

DateTime? _nullable$dateTimeFromJson(dynamic data) =>
    data == null ? null : dateTimeFromJson(data);
dynamic _nullable$dateTimeToJson(DateTime? data) =>
    data == null ? null : dateTimeToJson(data);
