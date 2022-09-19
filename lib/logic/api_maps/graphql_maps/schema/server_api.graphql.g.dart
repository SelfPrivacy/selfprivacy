// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fragment$basicMutationReturnFields _$Fragment$basicMutationReturnFieldsFromJson(
        Map<String, dynamic> json) =>
    Fragment$basicMutationReturnFields(
      code: json['code'] as int,
      message: json['message'] as String,
      success: json['success'] as bool,
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Fragment$basicMutationReturnFieldsToJson(
        Fragment$basicMutationReturnFields instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Query$GetApiVersion _$Query$GetApiVersionFromJson(Map<String, dynamic> json) =>
    Query$GetApiVersion(
      api:
          Query$GetApiVersion$api.fromJson(json['api'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$GetApiVersionToJson(
        Query$GetApiVersion instance) =>
    <String, dynamic>{
      'api': instance.api.toJson(),
      '__typename': instance.$__typename,
    };

Query$GetApiVersion$api _$Query$GetApiVersion$apiFromJson(
        Map<String, dynamic> json) =>
    Query$GetApiVersion$api(
      version: json['version'] as String,
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$GetApiVersion$apiToJson(
        Query$GetApiVersion$api instance) =>
    <String, dynamic>{
      'version': instance.version,
      '__typename': instance.$__typename,
    };

Query$GetApiJobs _$Query$GetApiJobsFromJson(Map<String, dynamic> json) =>
    Query$GetApiJobs(
      jobs:
          Query$GetApiJobs$jobs.fromJson(json['jobs'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$GetApiJobsToJson(Query$GetApiJobs instance) =>
    <String, dynamic>{
      'jobs': instance.jobs.toJson(),
      '__typename': instance.$__typename,
    };

Query$GetApiJobs$jobs _$Query$GetApiJobs$jobsFromJson(
        Map<String, dynamic> json) =>
    Query$GetApiJobs$jobs(
      getJobs: (json['getJobs'] as List<dynamic>)
          .map((e) =>
              Query$GetApiJobs$jobs$getJobs.fromJson(e as Map<String, dynamic>))
          .toList(),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$GetApiJobs$jobsToJson(
        Query$GetApiJobs$jobs instance) =>
    <String, dynamic>{
      'getJobs': instance.getJobs.map((e) => e.toJson()).toList(),
      '__typename': instance.$__typename,
    };

Query$GetApiJobs$jobs$getJobs _$Query$GetApiJobs$jobs$getJobsFromJson(
        Map<String, dynamic> json) =>
    Query$GetApiJobs$jobs$getJobs(
      createdAt: dateTimeFromJson(json['createdAt']),
      description: json['description'] as String,
      error: json['error'] as String?,
      finishedAt: _nullable$dateTimeFromJson(json['finishedAt']),
      name: json['name'] as String,
      progress: json['progress'] as int?,
      result: json['result'] as String?,
      status: json['status'] as String,
      statusText: json['statusText'] as String?,
      uid: json['uid'] as String,
      updatedAt: dateTimeFromJson(json['updatedAt']),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$GetApiJobs$jobs$getJobsToJson(
        Query$GetApiJobs$jobs$getJobs instance) =>
    <String, dynamic>{
      'createdAt': dateTimeToJson(instance.createdAt),
      'description': instance.description,
      'error': instance.error,
      'finishedAt': _nullable$dateTimeToJson(instance.finishedAt),
      'name': instance.name,
      'progress': instance.progress,
      'result': instance.result,
      'status': instance.status,
      'statusText': instance.statusText,
      'uid': instance.uid,
      'updatedAt': dateTimeToJson(instance.updatedAt),
      '__typename': instance.$__typename,
    };

Variables$Mutation$RemoveJob _$Variables$Mutation$RemoveJobFromJson(
        Map<String, dynamic> json) =>
    Variables$Mutation$RemoveJob(
      jobId: json['jobId'] as String,
    );

Map<String, dynamic> _$Variables$Mutation$RemoveJobToJson(
        Variables$Mutation$RemoveJob instance) =>
    <String, dynamic>{
      'jobId': instance.jobId,
    };

Mutation$RemoveJob _$Mutation$RemoveJobFromJson(Map<String, dynamic> json) =>
    Mutation$RemoveJob(
      removeJob: Mutation$RemoveJob$removeJob.fromJson(
          json['removeJob'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$RemoveJobToJson(Mutation$RemoveJob instance) =>
    <String, dynamic>{
      'removeJob': instance.removeJob.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$RemoveJob$removeJob _$Mutation$RemoveJob$removeJobFromJson(
        Map<String, dynamic> json) =>
    Mutation$RemoveJob$removeJob(
      code: json['code'] as int,
      message: json['message'] as String,
      success: json['success'] as bool,
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$RemoveJob$removeJobToJson(
        Mutation$RemoveJob$removeJob instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Mutation$RunSystemRebuild _$Mutation$RunSystemRebuildFromJson(
        Map<String, dynamic> json) =>
    Mutation$RunSystemRebuild(
      runSystemRebuild: Mutation$RunSystemRebuild$runSystemRebuild.fromJson(
          json['runSystemRebuild'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$RunSystemRebuildToJson(
        Mutation$RunSystemRebuild instance) =>
    <String, dynamic>{
      'runSystemRebuild': instance.runSystemRebuild.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$RunSystemRebuild$runSystemRebuild
    _$Mutation$RunSystemRebuild$runSystemRebuildFromJson(
            Map<String, dynamic> json) =>
        Mutation$RunSystemRebuild$runSystemRebuild(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Mutation$RunSystemRebuild$runSystemRebuildToJson(
        Mutation$RunSystemRebuild$runSystemRebuild instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Mutation$RunSystemRollback _$Mutation$RunSystemRollbackFromJson(
        Map<String, dynamic> json) =>
    Mutation$RunSystemRollback(
      runSystemRollback: Mutation$RunSystemRollback$runSystemRollback.fromJson(
          json['runSystemRollback'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$RunSystemRollbackToJson(
        Mutation$RunSystemRollback instance) =>
    <String, dynamic>{
      'runSystemRollback': instance.runSystemRollback.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$RunSystemRollback$runSystemRollback
    _$Mutation$RunSystemRollback$runSystemRollbackFromJson(
            Map<String, dynamic> json) =>
        Mutation$RunSystemRollback$runSystemRollback(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Mutation$RunSystemRollback$runSystemRollbackToJson(
        Mutation$RunSystemRollback$runSystemRollback instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Mutation$RunSystemUpgrade _$Mutation$RunSystemUpgradeFromJson(
        Map<String, dynamic> json) =>
    Mutation$RunSystemUpgrade(
      runSystemUpgrade: Mutation$RunSystemUpgrade$runSystemUpgrade.fromJson(
          json['runSystemUpgrade'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$RunSystemUpgradeToJson(
        Mutation$RunSystemUpgrade instance) =>
    <String, dynamic>{
      'runSystemUpgrade': instance.runSystemUpgrade.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$RunSystemUpgrade$runSystemUpgrade
    _$Mutation$RunSystemUpgrade$runSystemUpgradeFromJson(
            Map<String, dynamic> json) =>
        Mutation$RunSystemUpgrade$runSystemUpgrade(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Mutation$RunSystemUpgrade$runSystemUpgradeToJson(
        Mutation$RunSystemUpgrade$runSystemUpgrade instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Mutation$PullRepositoryChanges _$Mutation$PullRepositoryChangesFromJson(
        Map<String, dynamic> json) =>
    Mutation$PullRepositoryChanges(
      pullRepositoryChanges:
          Mutation$PullRepositoryChanges$pullRepositoryChanges.fromJson(
              json['pullRepositoryChanges'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$PullRepositoryChangesToJson(
        Mutation$PullRepositoryChanges instance) =>
    <String, dynamic>{
      'pullRepositoryChanges': instance.pullRepositoryChanges.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$PullRepositoryChanges$pullRepositoryChanges
    _$Mutation$PullRepositoryChanges$pullRepositoryChangesFromJson(
            Map<String, dynamic> json) =>
        Mutation$PullRepositoryChanges$pullRepositoryChanges(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic>
    _$Mutation$PullRepositoryChanges$pullRepositoryChangesToJson(
            Mutation$PullRepositoryChanges$pullRepositoryChanges instance) =>
        <String, dynamic>{
          'code': instance.code,
          'message': instance.message,
          'success': instance.success,
          '__typename': instance.$__typename,
        };

Mutation$RebootSystem _$Mutation$RebootSystemFromJson(
        Map<String, dynamic> json) =>
    Mutation$RebootSystem(
      rebootSystem: Mutation$RebootSystem$rebootSystem.fromJson(
          json['rebootSystem'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$RebootSystemToJson(
        Mutation$RebootSystem instance) =>
    <String, dynamic>{
      'rebootSystem': instance.rebootSystem.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$RebootSystem$rebootSystem _$Mutation$RebootSystem$rebootSystemFromJson(
        Map<String, dynamic> json) =>
    Mutation$RebootSystem$rebootSystem(
      code: json['code'] as int,
      message: json['message'] as String,
      success: json['success'] as bool,
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$RebootSystem$rebootSystemToJson(
        Mutation$RebootSystem$rebootSystem instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Query$GetApiTokens _$Query$GetApiTokensFromJson(Map<String, dynamic> json) =>
    Query$GetApiTokens(
      api: Query$GetApiTokens$api.fromJson(json['api'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$GetApiTokensToJson(Query$GetApiTokens instance) =>
    <String, dynamic>{
      'api': instance.api.toJson(),
      '__typename': instance.$__typename,
    };

Query$GetApiTokens$api _$Query$GetApiTokens$apiFromJson(
        Map<String, dynamic> json) =>
    Query$GetApiTokens$api(
      devices: (json['devices'] as List<dynamic>)
          .map((e) => Query$GetApiTokens$api$devices.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$GetApiTokens$apiToJson(
        Query$GetApiTokens$api instance) =>
    <String, dynamic>{
      'devices': instance.devices.map((e) => e.toJson()).toList(),
      '__typename': instance.$__typename,
    };

Query$GetApiTokens$api$devices _$Query$GetApiTokens$api$devicesFromJson(
        Map<String, dynamic> json) =>
    Query$GetApiTokens$api$devices(
      creationDate: dateTimeFromJson(json['creationDate']),
      isCaller: json['isCaller'] as bool,
      name: json['name'] as String,
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$GetApiTokens$api$devicesToJson(
        Query$GetApiTokens$api$devices instance) =>
    <String, dynamic>{
      'creationDate': dateTimeToJson(instance.creationDate),
      'isCaller': instance.isCaller,
      'name': instance.name,
      '__typename': instance.$__typename,
    };

Query$RecoveryKey _$Query$RecoveryKeyFromJson(Map<String, dynamic> json) =>
    Query$RecoveryKey(
      api: Query$RecoveryKey$api.fromJson(json['api'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$RecoveryKeyToJson(Query$RecoveryKey instance) =>
    <String, dynamic>{
      'api': instance.api.toJson(),
      '__typename': instance.$__typename,
    };

Query$RecoveryKey$api _$Query$RecoveryKey$apiFromJson(
        Map<String, dynamic> json) =>
    Query$RecoveryKey$api(
      recoveryKey: Query$RecoveryKey$api$recoveryKey.fromJson(
          json['recoveryKey'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$RecoveryKey$apiToJson(
        Query$RecoveryKey$api instance) =>
    <String, dynamic>{
      'recoveryKey': instance.recoveryKey.toJson(),
      '__typename': instance.$__typename,
    };

Query$RecoveryKey$api$recoveryKey _$Query$RecoveryKey$api$recoveryKeyFromJson(
        Map<String, dynamic> json) =>
    Query$RecoveryKey$api$recoveryKey(
      creationDate: _nullable$dateTimeFromJson(json['creationDate']),
      exists: json['exists'] as bool,
      expirationDate: _nullable$dateTimeFromJson(json['expirationDate']),
      usesLeft: json['usesLeft'] as int?,
      valid: json['valid'] as bool,
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$RecoveryKey$api$recoveryKeyToJson(
        Query$RecoveryKey$api$recoveryKey instance) =>
    <String, dynamic>{
      'creationDate': _nullable$dateTimeToJson(instance.creationDate),
      'exists': instance.exists,
      'expirationDate': _nullable$dateTimeToJson(instance.expirationDate),
      'usesLeft': instance.usesLeft,
      'valid': instance.valid,
      '__typename': instance.$__typename,
    };

Variables$Mutation$GetNewRecoveryApiKey
    _$Variables$Mutation$GetNewRecoveryApiKeyFromJson(
            Map<String, dynamic> json) =>
        Variables$Mutation$GetNewRecoveryApiKey(
          limits: json['limits'] == null
              ? null
              : Input$RecoveryKeyLimitsInput.fromJson(
                  json['limits'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$Variables$Mutation$GetNewRecoveryApiKeyToJson(
        Variables$Mutation$GetNewRecoveryApiKey instance) =>
    <String, dynamic>{
      'limits': instance.limits?.toJson(),
    };

Mutation$GetNewRecoveryApiKey _$Mutation$GetNewRecoveryApiKeyFromJson(
        Map<String, dynamic> json) =>
    Mutation$GetNewRecoveryApiKey(
      getNewRecoveryApiKey:
          Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey.fromJson(
              json['getNewRecoveryApiKey'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$GetNewRecoveryApiKeyToJson(
        Mutation$GetNewRecoveryApiKey instance) =>
    <String, dynamic>{
      'getNewRecoveryApiKey': instance.getNewRecoveryApiKey.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey
    _$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKeyFromJson(
            Map<String, dynamic> json) =>
        Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
          key: json['key'] as String?,
        );

Map<String, dynamic> _$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKeyToJson(
        Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
      'key': instance.key,
    };

Variables$Mutation$UseRecoveryApiKey
    _$Variables$Mutation$UseRecoveryApiKeyFromJson(Map<String, dynamic> json) =>
        Variables$Mutation$UseRecoveryApiKey(
          input: Input$UseRecoveryKeyInput.fromJson(
              json['input'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$Variables$Mutation$UseRecoveryApiKeyToJson(
        Variables$Mutation$UseRecoveryApiKey instance) =>
    <String, dynamic>{
      'input': instance.input.toJson(),
    };

Mutation$UseRecoveryApiKey _$Mutation$UseRecoveryApiKeyFromJson(
        Map<String, dynamic> json) =>
    Mutation$UseRecoveryApiKey(
      useRecoveryApiKey: Mutation$UseRecoveryApiKey$useRecoveryApiKey.fromJson(
          json['useRecoveryApiKey'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$UseRecoveryApiKeyToJson(
        Mutation$UseRecoveryApiKey instance) =>
    <String, dynamic>{
      'useRecoveryApiKey': instance.useRecoveryApiKey.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$UseRecoveryApiKey$useRecoveryApiKey
    _$Mutation$UseRecoveryApiKey$useRecoveryApiKeyFromJson(
            Map<String, dynamic> json) =>
        Mutation$UseRecoveryApiKey$useRecoveryApiKey(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
          token: json['token'] as String?,
        );

Map<String, dynamic> _$Mutation$UseRecoveryApiKey$useRecoveryApiKeyToJson(
        Mutation$UseRecoveryApiKey$useRecoveryApiKey instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
      'token': instance.token,
    };

Mutation$RefreshDeviceApiToken _$Mutation$RefreshDeviceApiTokenFromJson(
        Map<String, dynamic> json) =>
    Mutation$RefreshDeviceApiToken(
      refreshDeviceApiToken:
          Mutation$RefreshDeviceApiToken$refreshDeviceApiToken.fromJson(
              json['refreshDeviceApiToken'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$RefreshDeviceApiTokenToJson(
        Mutation$RefreshDeviceApiToken instance) =>
    <String, dynamic>{
      'refreshDeviceApiToken': instance.refreshDeviceApiToken.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$RefreshDeviceApiToken$refreshDeviceApiToken
    _$Mutation$RefreshDeviceApiToken$refreshDeviceApiTokenFromJson(
            Map<String, dynamic> json) =>
        Mutation$RefreshDeviceApiToken$refreshDeviceApiToken(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
          token: json['token'] as String?,
        );

Map<String, dynamic>
    _$Mutation$RefreshDeviceApiToken$refreshDeviceApiTokenToJson(
            Mutation$RefreshDeviceApiToken$refreshDeviceApiToken instance) =>
        <String, dynamic>{
          'code': instance.code,
          'message': instance.message,
          'success': instance.success,
          '__typename': instance.$__typename,
          'token': instance.token,
        };

Variables$Mutation$DeleteDeviceApiToken
    _$Variables$Mutation$DeleteDeviceApiTokenFromJson(
            Map<String, dynamic> json) =>
        Variables$Mutation$DeleteDeviceApiToken(
          device: json['device'] as String,
        );

Map<String, dynamic> _$Variables$Mutation$DeleteDeviceApiTokenToJson(
        Variables$Mutation$DeleteDeviceApiToken instance) =>
    <String, dynamic>{
      'device': instance.device,
    };

Mutation$DeleteDeviceApiToken _$Mutation$DeleteDeviceApiTokenFromJson(
        Map<String, dynamic> json) =>
    Mutation$DeleteDeviceApiToken(
      deleteDeviceApiToken:
          Mutation$DeleteDeviceApiToken$deleteDeviceApiToken.fromJson(
              json['deleteDeviceApiToken'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$DeleteDeviceApiTokenToJson(
        Mutation$DeleteDeviceApiToken instance) =>
    <String, dynamic>{
      'deleteDeviceApiToken': instance.deleteDeviceApiToken.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$DeleteDeviceApiToken$deleteDeviceApiToken
    _$Mutation$DeleteDeviceApiToken$deleteDeviceApiTokenFromJson(
            Map<String, dynamic> json) =>
        Mutation$DeleteDeviceApiToken$deleteDeviceApiToken(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Mutation$DeleteDeviceApiToken$deleteDeviceApiTokenToJson(
        Mutation$DeleteDeviceApiToken$deleteDeviceApiToken instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Mutation$GetNewDeviceApiKey _$Mutation$GetNewDeviceApiKeyFromJson(
        Map<String, dynamic> json) =>
    Mutation$GetNewDeviceApiKey(
      getNewDeviceApiKey:
          Mutation$GetNewDeviceApiKey$getNewDeviceApiKey.fromJson(
              json['getNewDeviceApiKey'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$GetNewDeviceApiKeyToJson(
        Mutation$GetNewDeviceApiKey instance) =>
    <String, dynamic>{
      'getNewDeviceApiKey': instance.getNewDeviceApiKey.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$GetNewDeviceApiKey$getNewDeviceApiKey
    _$Mutation$GetNewDeviceApiKey$getNewDeviceApiKeyFromJson(
            Map<String, dynamic> json) =>
        Mutation$GetNewDeviceApiKey$getNewDeviceApiKey(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
          key: json['key'] as String?,
        );

Map<String, dynamic> _$Mutation$GetNewDeviceApiKey$getNewDeviceApiKeyToJson(
        Mutation$GetNewDeviceApiKey$getNewDeviceApiKey instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
      'key': instance.key,
    };

Mutation$InvalidateNewDeviceApiKey _$Mutation$InvalidateNewDeviceApiKeyFromJson(
        Map<String, dynamic> json) =>
    Mutation$InvalidateNewDeviceApiKey(
      invalidateNewDeviceApiKey:
          Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey.fromJson(
              json['invalidateNewDeviceApiKey'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$InvalidateNewDeviceApiKeyToJson(
        Mutation$InvalidateNewDeviceApiKey instance) =>
    <String, dynamic>{
      'invalidateNewDeviceApiKey': instance.invalidateNewDeviceApiKey.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey
    _$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKeyFromJson(
            Map<String, dynamic> json) =>
        Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic>
    _$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKeyToJson(
            Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey
                instance) =>
        <String, dynamic>{
          'code': instance.code,
          'message': instance.message,
          'success': instance.success,
          '__typename': instance.$__typename,
        };

Variables$Mutation$AuthorizeWithNewDeviceApiKey
    _$Variables$Mutation$AuthorizeWithNewDeviceApiKeyFromJson(
            Map<String, dynamic> json) =>
        Variables$Mutation$AuthorizeWithNewDeviceApiKey(
          input: Input$UseNewDeviceKeyInput.fromJson(
              json['input'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$Variables$Mutation$AuthorizeWithNewDeviceApiKeyToJson(
        Variables$Mutation$AuthorizeWithNewDeviceApiKey instance) =>
    <String, dynamic>{
      'input': instance.input.toJson(),
    };

Mutation$AuthorizeWithNewDeviceApiKey
    _$Mutation$AuthorizeWithNewDeviceApiKeyFromJson(
            Map<String, dynamic> json) =>
        Mutation$AuthorizeWithNewDeviceApiKey(
          authorizeWithNewDeviceApiKey:
              Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey
                  .fromJson(json['authorizeWithNewDeviceApiKey']
                      as Map<String, dynamic>),
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Mutation$AuthorizeWithNewDeviceApiKeyToJson(
        Mutation$AuthorizeWithNewDeviceApiKey instance) =>
    <String, dynamic>{
      'authorizeWithNewDeviceApiKey':
          instance.authorizeWithNewDeviceApiKey.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey
    _$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKeyFromJson(
            Map<String, dynamic> json) =>
        Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
          token: json['token'] as String?,
        );

Map<String, dynamic>
    _$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKeyToJson(
            Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey
                instance) =>
        <String, dynamic>{
          'code': instance.code,
          'message': instance.message,
          'success': instance.success,
          '__typename': instance.$__typename,
          'token': instance.token,
        };
