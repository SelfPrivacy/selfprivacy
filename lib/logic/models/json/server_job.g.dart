// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerJob _$ServerJobFromJson(Map<String, dynamic> json) => ServerJob(
      name: json['name'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      uid: json['uid'] as String,
      updatedAt: json['updated_at'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      error: json['error'] as String?,
      progress: json['progress'] as int?,
      result: json['result'] as String?,
      statusText: json['status_text'] as String?,
      finishedAt: json['finished_at'] as String?,
    );

Map<String, dynamic> _$ServerJobToJson(ServerJob instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
      'uid': instance.uid,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt.toIso8601String(),
      'error': instance.error,
      'progress': instance.progress,
      'result': instance.result,
      'status_text': instance.statusText,
      'finished_at': instance.finishedAt,
    };
