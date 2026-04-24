import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';

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

  void _handleServerJobs(final List<ServerJob> jobs) {
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
    if (rebuildJob == null ||
        rebuildJob.status == JobStatusEnum.error ||
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
    if (state is JobsStateEmpty) {
      emit(
        JobsStateLoading(
          [RebootServerJob(status: JobStatusEnum.running)],
          null,
          const [],
        ),
      );
      final rebootResult = await getIt<ApiConnectionRepository>().api.reboot();
      if (rebootResult.success && rebootResult.data != null) {
        emit(
          JobsStateFinished(
            [
              RebootServerJob(
                status: JobStatusEnum.finished,
                message: rebootResult.message,
              ),
            ],
            null,
            const [],
          ),
        );
      } else {
        emit(
          JobsStateFinished(
            [RebootServerJob(status: JobStatusEnum.error)],
            null,
            const [],
          ),
        );
      }
    }
  }

  Future<void> upgradeServer() async {
    if (state is JobsStateEmpty) {
      emit(
        JobsStateLoading(
          [UpgradeServerJob(status: JobStatusEnum.running)],
          null,
          const [],
        ),
      );
      final result = await getIt<ApiConnectionRepository>().api.upgrade();
      if (result.success && result.data != null) {
        emit(
          JobsStateLoading(
            [UpgradeServerJob(status: JobStatusEnum.finished)],
            result.data!.uid,
            const [],
          ),
        );
      } else if (result.success) {
        emit(
          JobsStateFinished(
            [UpgradeServerJob(status: JobStatusEnum.finished)],
            null,
            const [],
          ),
        );
      } else {
        emit(
          JobsStateFinished(
            [UpgradeServerJob(status: JobStatusEnum.error)],
            null,
            const [],
          ),
        );
      }
    }
  }

  Future<void> applyAll() async {
    if (state is JobsStateWithJobs) {
      final List<ClientJob> jobs = (state as JobsStateWithJobs).clientJobList;

      final rebuildRequired = jobs.any((final job) => job.requiresRebuild);
      final dnsUpdateRequired = jobs.any((final job) => job.requiresDnsUpdate);

      if (dnsUpdateRequired) {
        jobs.add(UpdateDnsRecordsJob(status: JobStatusEnum.created));
      }

      emit(JobsStateLoading(jobs, null, const []));

      await Future<void>.delayed(Duration.zero);

      final List<DnsRecord> oldDnsRecords =
          await getIt<ApiConnectionRepository>().api.getDnsRecords();

      for (final ClientJob job in jobs) {
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

      // If all jobs failed, do not try to change DNS records or rebuild the server
      if ((state as JobsStateLoading).clientJobList.every(
        (final job) =>
            (job.status == JobStatusEnum.error) || (job is UpdateDnsRecordsJob),
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
        await updateDnsRecords(oldDnsRecords);
      }

      if (!rebuildRequired) {
        emit((state as JobsStateLoading).finished());
        return;
      }
      final rebuildResult = await getIt<ApiConnectionRepository>().api.apply();
      if (rebuildResult.success) {
        if (rebuildResult.data != null) {
          emit(
            (state as JobsStateLoading).copyWith(
              rebuildJobUid: rebuildResult.data!.uid,
            ),
          );
        } else {
          emit((state as JobsStateLoading).finished());
        }
      } else {
        emit((state as JobsStateLoading).finished());
      }
    }
  }

  Future<void> updateDnsRecords(final List<DnsRecord> oldDnsRecords) async {
    emit(
      (state as JobsStateLoading).updateJobStatus(
        UpdateDnsRecordsJob.jobId,
        JobStatusEnum.running,
      ),
    );
    final List<DnsRecord> newDnsRecords =
        await getIt<ApiConnectionRepository>().api.getDnsRecords();

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
            newRecords:
                newDnsRecords.where((final r) => r.content != null).toList(),
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
    if (state is JobsStateEmpty) {
      emit(
        JobsStateLoading(
          [CollectNixGarbageJob(status: JobStatusEnum.running)],
          null,
          const [],
        ),
      );
      final result =
          await getIt<ApiConnectionRepository>().api.collectNixGarbage();
      if (result.success && result.data != null) {
        emit(
          JobsStateLoading(
            [CollectNixGarbageJob(status: JobStatusEnum.finished)],
            result.data!.uid,
            const [],
          ),
        );
      } else if (result.success) {
        emit(
          JobsStateFinished(
            [CollectNixGarbageJob(status: JobStatusEnum.finished)],
            null,
            const [],
          ),
        );
      } else {
        emit(
          JobsStateFinished(
            [CollectNixGarbageJob(status: JobStatusEnum.error)],
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
      await getIt<ApiConnectionRepository>().removeServerJob(rebuildJobUid);
    }
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
