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
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      error: json['error'] as String?,
      progress: json['progress'] as int?,
      result: json['result'] as String?,
      statusText: json['statusText'] as String?,
      finishedAt: json['finishedAt'] == null
          ? null
          : DateTime.parse(json['finishedAt'] as String),
    );

Map<String, dynamic> _$ServerJobToJson(ServerJob instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
      'uid': instance.uid,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'error': instance.error,
      'progress': instance.progress,
      'result': instance.result,
      'statusText': instance.statusText,
      'finishedAt': instance.finishedAt?.toIso8601String(),
    };
