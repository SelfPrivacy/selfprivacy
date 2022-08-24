import 'package:json_annotation/json_annotation.dart';

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
    required this.updatedAt,
    required this.createdAt,
    final this.error,
    final this.progress,
    final this.result,
    final this.statusText,
    final this.finishedAt,
  });

  final String name;
  final String description;
  final String status;
  final String uid;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  final String? error;
  final int? progress;
  final String? result;
  @JsonKey(name: 'status_text')
  final String? statusText;
  @JsonKey(name: 'finished_at')
  final String? finishedAt;
}
