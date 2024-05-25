import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

export 'package:provider/provider.dart';

part 'client_jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit() : super(JobsStateEmpty()) {
    final apiConnectionRepository = getIt<ApiConnectionRepository>();
    _apiDataSubscription = apiConnectionRepository.dataStream.listen(
      (final ApiData apiData) {
        if (apiData.serverJobs.data != null &&
            apiData.serverJobs.data!.isNotEmpty) {
          _handleServerJobs(apiData.serverJobs.data!);
        }
      },
    );
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

  void addJob(final ClientJob job) async {
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
      emit(JobsStateLoading(jobs, null, const []));

      await Future<void>.delayed(Duration.zero);

      final rebuildRequired = jobs.any((final job) => job.requiresRebuild);

      for (final ClientJob job in jobs) {
        emit(
          (state as JobsStateLoading)
              .updateJobStatus(job.id, JobStatusEnum.running),
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
            (state as JobsStateLoading)
                .updateJobStatus(job.id, JobStatusEnum.error, message: message),
          );
        }
      }

      if (!rebuildRequired) {
        emit((state as JobsStateLoading).finished());
        return;
      }
      final rebuildResult = await getIt<ApiConnectionRepository>().api.apply();
      if (rebuildResult.success) {
        if (rebuildResult.data != null) {
          emit(
            (state as JobsStateLoading)
                .copyWith(rebuildJobUid: rebuildResult.data!.uid),
          );
        } else {
          emit((state as JobsStateLoading).finished());
        }
      } else {
        emit((state as JobsStateLoading).finished());
      }
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
  Future<void> close() {
    _apiDataSubscription?.cancel();
    return super.close();
  }
}
