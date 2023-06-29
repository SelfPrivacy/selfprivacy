import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';

part 'server_job.g.dart';

@JsonSerializable()
class ServerJob {
  factory ServerJob.fromJson(final Map<String, dynamic> json) =>
      _$ServerJobFromJson(json);
  ServerJob({
    required this.name,
    required this.description,
    required this.status,
    required this.uid,
    required this.typeId,
    required this.updatedAt,
    required this.createdAt,
    this.error,
    this.progress,
    this.result,
    this.statusText,
    this.finishedAt,
  });

  ServerJob.fromGraphQL(final Query$GetApiJobs$jobs$getJobs serverJob)
      : this(
          createdAt: serverJob.createdAt,
          description: serverJob.description,
          error: serverJob.error,
          finishedAt: serverJob.finishedAt,
          name: serverJob.name,
          progress: serverJob.progress,
          result: serverJob.result,
          status: JobStatusEnum.fromString(serverJob.status),
          statusText: serverJob.statusText,
          uid: serverJob.uid,
          typeId: serverJob.typeId,
          updatedAt: serverJob.updatedAt,
        );
  final String name;
  final String description;
  final JobStatusEnum status;
  final String uid;
  final String typeId;
  final DateTime updatedAt;
  final DateTime createdAt;

  final String? error;
  final int? progress;
  final String? result;
  final String? statusText;
  final DateTime? finishedAt;
  bool isHidden = false;
}

enum JobStatusEnum {
  @JsonValue('CREATED')
  created,
  @JsonValue('RUNNING')
  running,
  @JsonValue('FINISHED')
  finished,
  @JsonValue('ERROR')
  error;

  factory JobStatusEnum.fromString(final String status) {
    switch (status) {
      case 'CREATED':
        return created;
      case 'RUNNING':
        return running;
      case 'FINISHED':
        return finished;
      case 'ERROR':
        return error;
      default:
        throw Exception('Unknown status: $status');
    }
  }
}
