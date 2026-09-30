import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

export 'package:provider/provider.dart';

part 'client_jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit() : super(JobsStateEmpty()) {
    final apiConnectionRepository = getIt<ApiConnectionRepository>();
    _apiDataSubscription = apiConnectionRepository.dataStream.listen((
      final ApiData apiData,
    ) {
      if (apiData.serverJobs.data != null &&
          apiData.serverJobs.data!.isNotEmpty) {
        _handleServerJobs(apiData.serverJobs.data!);
      }
    });
  }

  StreamSubscription? _apiDataSubscription;
  ServerConnection? _jobConnection;

  void _handleServerJobs(final List<ServerJob> jobs) {
    if (_jobConnection?.isAttached != true) {
      return;
    }
    if (state is! JobsStateLoading) {
      return;
    }
    if (state.rebuildJobUid == null) {
      return;
    }
    // Find a job with the uid of the rebuild job
    final ServerJob? rebuildJob = jobs.firstWhereOrNull(
      (final job) => job.uid == state.rebuildJobUid,
    );
    if (rebuildJob == null) {
      return;
    }
    if (rebuildJob.status == JobStatusEnum.error ||
        rebuildJob.status == JobStatusEnum.finished) {
      emit((state as JobsStateLoading).finished());
    }
  }

  void addJob(final ClientJob job) {
    emit(state.addJob(job));
  }

  void removeJob(final String id) {
    final JobsState newState = (state as JobsStateWithJobs).removeById(id);
    emit(newState);
  }

  Future<void> rebootServer() async {
    final connection = getIt<ApiConnectionRepository>().connection;
    if (connection == null) {
      return;
    }
    if (state is JobsStateEmpty) {
      emit(
        JobsStateLoading(
          [RebootServerJob(status: JobStatusEnum.running)],
          null,
          const [],
        ),
      );
      final rebootResult = await connection.volumes.reboot();
      if (rebootResult.outcome == ServerMutationOutcome.confirmed) {
        emit(
          JobsStateFinished(
            [
              RebootServerJob(
                status: JobStatusEnum.finished,
                message: serverMutationMessage(rebootResult),
              ),
            ],
            null,
            const [],
          ),
        );
      } else {
        emit(
          JobsStateFinished(
            [
              RebootServerJob(
                status: JobStatusEnum.error,
                message: serverMutationMessage(rebootResult),
              ),
            ],
            null,
            const [],
          ),
        );
      }
    }
  }

  Future<void> upgradeServer() async {
    final connection = getIt<ApiConnectionRepository>().connection;
    if (connection == null) {
      return;
    }
    if (state is JobsStateEmpty) {
      _jobConnection = connection;
      emit(
        JobsStateLoading(
          [UpgradeServerJob(status: JobStatusEnum.running)],
          null,
          const [],
        ),
      );
      final result = await connection.jobs.upgrade();
      if (result.outcome == ServerMutationOutcome.confirmed &&
          result.payload.value != null) {
        emit(
          JobsStateLoading(
            [
              UpgradeServerJob(
                status: JobStatusEnum.finished,
                message: serverMutationMessage(result),
              ),
            ],
            result.payload.value!.uid,
            const [],
          ),
        );
      } else if (result.outcome == ServerMutationOutcome.confirmed) {
        emit(
          JobsStateFinished(
            [
              UpgradeServerJob(
                status: JobStatusEnum.finished,
                message: serverMutationMessage(result),
              ),
            ],
            null,
            const [],
          ),
        );
      } else {
        emit(
          JobsStateFinished(
            [
              UpgradeServerJob(
                status: JobStatusEnum.error,
                message: serverMutationMessage(result),
              ),
            ],
            null,
            const [],
          ),
        );
      }
    }
  }

  Future<void> applyAll() async {
    final connection = getIt<ApiConnectionRepository>().connection;
    if (connection == null) {
      return;
    }
    if (state is JobsStateWithJobs) {
      _jobConnection = connection;
      final jobs = [...(state as JobsStateWithJobs).clientJobList];

      final rebuildRequired = jobs.any((final job) => job.requiresRebuild);
      final dnsUpdateRequired = jobs.any((final job) => job.requiresDnsUpdate);

      if (dnsUpdateRequired) {
        jobs.add(UpdateDnsRecordsJob(status: JobStatusEnum.created));
      }

      emit(JobsStateLoading(jobs, null, const []));

      await Future<void>.delayed(Duration.zero);

      final List<DnsRecord> oldDnsRecords =
          await connection.api.getDnsRecords() ?? [];

      for (final ClientJob job in jobs) {
        if (!connection.isAttached) {
          emit((state as JobsStateLoading).finished());
          return;
        }
        if (job is UpdateDnsRecordsJob) {
          continue;
        }

        emit(
          (state as JobsStateLoading).updateJobStatus(
            job.id,
            JobStatusEnum.running,
          ),
        );
        final (result, message) = await job.execute();
        if (result) {
          emit(
            (state as JobsStateLoading).updateJobStatus(
              job.id,
              JobStatusEnum.finished,
              message: message,
            ),
          );
        } else {
          emit(
            (state as JobsStateLoading).updateJobStatus(
              job.id,
              JobStatusEnum.error,
              message: message,
            ),
          );
        }
      }

      await Future<void>.delayed(Duration.zero);

      if ((state as JobsStateLoading).clientJobList.any(
        (final job) => job.status == JobStatusEnum.error,
      )) {
        if (dnsUpdateRequired) {
          emit(
            (state as JobsStateLoading).updateJobStatus(
              UpdateDnsRecordsJob.jobId,
              JobStatusEnum.error,
              message: 'jobs.ignored_due_to_failures'.tr(),
            ),
          );
          await Future.delayed(Duration.zero);
        }
        emit((state as JobsStateLoading).finished());
        return;
      }

      if (dnsUpdateRequired) {
        if (!connection.isAttached) {
          emit((state as JobsStateLoading).finished());
          return;
        }
        await updateDnsRecords(oldDnsRecords, connection: connection);
      }

      if (!rebuildRequired) {
        emit((state as JobsStateLoading).finished());
        return;
      }
      final rebuildResult = await connection.jobs.apply();
      if (rebuildResult.outcome == ServerMutationOutcome.confirmed) {
        if (rebuildResult.payload.value != null) {
          emit(
            (state as JobsStateLoading).copyWith(
              rebuildJobUid: rebuildResult.payload.value!.uid,
            ),
          );
        } else {
          if (rebuildResult.payload.status !=
              ServerMutationPayloadStatus.notExpected) {
            getIt<NavigationService>().showSnackBar(
              serverMutationMessage(rebuildResult),
            );
          }
          emit((state as JobsStateLoading).finished());
        }
      } else {
        getIt<NavigationService>().showSnackBar(
          serverMutationMessage(rebuildResult),
        );
        emit((state as JobsStateLoading).finished());
      }
    }
  }

  Future<void> updateDnsRecords(
    final List<DnsRecord> oldDnsRecords, {
    final ServerConnection? connection,
  }) async {
    final binding = connection ?? getIt<ApiConnectionRepository>().connection;
    if (binding == null || !binding.isAttached) {
      return;
    }
    emit(
      (state as JobsStateLoading).updateJobStatus(
        UpdateDnsRecordsJob.jobId,
        JobStatusEnum.running,
      ),
    );
    final List<DnsRecord> newDnsRecords =
        await binding.api.getDnsRecords() ?? [];
    if (!binding.isAttached) {
      return;
    }

    // If any of the records have a null content, we don't want to update
    // the DNS records
    if (newDnsRecords.isEmpty || oldDnsRecords.isEmpty) {
      emit(
        (state as JobsStateLoading).updateJobStatus(
          UpdateDnsRecordsJob.jobId,
          JobStatusEnum.error,
          message: 'jobs.failed_to_load_dns_records'.tr(),
        ),
      );
      return;
    }

    if (const UnorderedIterableEquality().equals(
      oldDnsRecords,
      newDnsRecords,
    )) {
      emit(
        (state as JobsStateLoading).updateJobStatus(
          UpdateDnsRecordsJob.jobId,
          JobStatusEnum.finished,
          message: 'jobs.dns_records_did_not_change'.tr(),
        ),
      );
    } else {
      final ServerDomain? domain =
          getIt<ApiConnectionRepository>().serverDomain;

      final dnsCreateResult = await ProvidersController.currentDnsProvider!
          .updateDnsRecords(
            newRecords: newDnsRecords
                .where((final r) => r.content != null)
                .toList(),
            oldRecords: oldDnsRecords,
            domain: domain!,
          );

      emit(
        (state as JobsStateLoading).updateJobStatus(
          UpdateDnsRecordsJob.jobId,
          dnsCreateResult.success
              ? JobStatusEnum.finished
              : JobStatusEnum.error,
          message: dnsCreateResult.message ?? 'jobs.dns_records_changed'.tr(),
        ),
      );
    }
  }

  Future<void> collectNixGarbage() async {
    final connection = getIt<ApiConnectionRepository>().connection;
    if (connection == null) {
      return;
    }
    if (state is JobsStateEmpty) {
      _jobConnection = connection;
      emit(
        JobsStateLoading(
          [CollectNixGarbageJob(status: JobStatusEnum.running)],
          null,
          const [],
        ),
      );
      final result = await connection.jobs.collectNixGarbage();
      if (result.outcome == ServerMutationOutcome.confirmed &&
          result.payload.value != null) {
        emit(
          JobsStateLoading(
            [
              CollectNixGarbageJob(
                status: JobStatusEnum.finished,
                message: serverMutationMessage(result),
              ),
            ],
            result.payload.value!.uid,
            const [],
          ),
        );
      } else if (result.outcome == ServerMutationOutcome.confirmed) {
        emit(
          JobsStateFinished(
            [
              CollectNixGarbageJob(
                status: JobStatusEnum.finished,
                message: serverMutationMessage(result),
              ),
            ],
            null,
            const [],
          ),
        );
      } else {
        emit(
          JobsStateFinished(
            [
              CollectNixGarbageJob(
                status: JobStatusEnum.error,
                message: serverMutationMessage(result),
              ),
            ],
            null,
            const [],
          ),
        );
      }
    }
  }

  Future<void> acknowledgeFinished() async {
    if (state is! JobsStateFinished) {
      return;
    }
    final rebuildJobUid = state.rebuildJobUid;
    if ((state as JobsStateFinished).postponedJobs.isNotEmpty) {
      emit(JobsStateWithJobs((state as JobsStateFinished).postponedJobs));
    } else {
      emit(JobsStateEmpty());
    }
    if (rebuildJobUid != null) {
      await _jobConnection?.jobs.removeJob(rebuildJobUid);
    }
    _jobConnection = null;
  }

  @override
  void onChange(final Change<JobsState> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() async {
    await _apiDataSubscription?.cancel();
    return super.close();
  }
}
