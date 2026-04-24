part of 'client_jobs_cubit.dart';

sealed class JobsState extends Equatable {
  String? get rebuildJobUid => null;

  JobsState addJob(final ClientJob job);

  @override
  List<Object?> get props => [];
}

class JobsStateEmpty extends JobsState {
  @override
  JobsStateWithJobs addJob(final ClientJob job) {
    getIt<NavigationService>().showSnackBar('jobs.job_added'.tr());
    return JobsStateWithJobs([job]);
  }

  @override
  List<Object?> get props => [];
}

class JobsStateWithJobs extends JobsState {
  JobsStateWithJobs(this.clientJobList);
  final List<ClientJob> clientJobList;

  bool get rebuildRequired =>
      clientJobList.any((final job) => job.requiresRebuild);

  bool get dnsUpdateRequired =>
      clientJobList.any((final job) => job.requiresDnsUpdate);

  JobsState removeById(final String id) {
    final List<ClientJob> newJobsList =
        clientJobList.where((final element) => element.id != id).toList();
    if (newJobsList.isEmpty) {
      return JobsStateEmpty();
    }
    return JobsStateWithJobs(newJobsList);
  }

  @override
  List<Object?> get props => [clientJobList];

  @override
  JobsState addJob(final ClientJob job) {
    if (job is ReplaceableJob) {
      final List<ClientJob> newJobsList =
          clientJobList
              .where(
                (final element) =>
                    job.shouldReplaceOnlyIfSameId
                        ? element.runtimeType != job.runtimeType ||
                            element.id != job.id
                        : element.runtimeType != job.runtimeType,
              )
              .toList();
      if (job.shouldRemoveInsteadOfAdd(clientJobList)) {
        getIt<NavigationService>().showSnackBar('jobs.job_removed'.tr());
      } else {
        newJobsList.add(job);
        getIt<NavigationService>().showSnackBar('jobs.job_added'.tr());
      }
      if (newJobsList.isEmpty) {
        return JobsStateEmpty();
      }
      return JobsStateWithJobs(newJobsList);
    }
    if (job.canAddTo(clientJobList)) {
      final List<ClientJob> newJobsList = [...clientJobList, job];
      getIt<NavigationService>().showSnackBar('jobs.job_added'.tr());
      return JobsStateWithJobs(newJobsList);
    }
    return this;
  }
}

class JobsStateLoading extends JobsState {
  JobsStateLoading(this.clientJobList, this.rebuildJobUid, this.postponedJobs);
  final List<ClientJob> clientJobList;
  @override
  final String? rebuildJobUid;

  bool get rebuildRequired =>
      clientJobList.any((final job) => job.requiresRebuild);

  bool get dnsUpdateRequired =>
      clientJobList.any((final job) => job.requiresDnsUpdate);

  final List<ClientJob> postponedJobs;

  JobsStateLoading updateJobStatus(
    final String id,
    final JobStatusEnum status, {
    final String? message,
  }) {
    final List<ClientJob> newJobsList =
        clientJobList.map((final job) {
          if (job.id == id) {
            return job.copyWithNewStatus(status: status, message: message);
          }
          return job;
        }).toList();
    return JobsStateLoading(newJobsList, rebuildJobUid, postponedJobs);
  }

  JobsStateLoading copyWith({
    final List<ClientJob>? clientJobList,
    final String? rebuildJobUid,
    final List<ClientJob>? postponedJobs,
  }) => JobsStateLoading(
    clientJobList ?? this.clientJobList,
    rebuildJobUid ?? this.rebuildJobUid,
    postponedJobs ?? this.postponedJobs,
  );

  JobsStateFinished finished() =>
      JobsStateFinished(clientJobList, rebuildJobUid, postponedJobs);

  @override
  List<Object?> get props => [clientJobList, rebuildJobUid, postponedJobs];

  @override
  JobsState addJob(final ClientJob job) {
    if (job is ReplaceableJob) {
      final List<ClientJob> newPostponedJobs =
          postponedJobs
              .where((final element) => element.runtimeType != job.runtimeType)
              .toList();
      if (job.shouldRemoveInsteadOfAdd(postponedJobs)) {
        getIt<NavigationService>().showSnackBar('jobs.job_removed'.tr());
      } else {
        newPostponedJobs.add(job);
        getIt<NavigationService>().showSnackBar('jobs.job_postponed'.tr());
      }
      return JobsStateLoading(clientJobList, rebuildJobUid, newPostponedJobs);
    }
    if (job.canAddTo(postponedJobs)) {
      final List<ClientJob> newPostponedJobs = [...postponedJobs, job];
      getIt<NavigationService>().showSnackBar('jobs.job_postponed'.tr());
      return JobsStateLoading(clientJobList, rebuildJobUid, newPostponedJobs);
    }
    return this;
  }
}

class JobsStateFinished extends JobsState {
  JobsStateFinished(this.clientJobList, this.rebuildJobUid, this.postponedJobs);
  final List<ClientJob> clientJobList;
  @override
  final String? rebuildJobUid;

  bool get rebuildRequired =>
      clientJobList.any((final job) => job.requiresRebuild);

  bool get dnsUpdateRequired =>
      clientJobList.any((final job) => job.requiresDnsUpdate);

  final List<ClientJob> postponedJobs;

  @override
  List<Object?> get props => [clientJobList, rebuildJobUid, postponedJobs];

  @override
  JobsState addJob(final ClientJob job) {
    if (job is ReplaceableJob) {
      final List<ClientJob> newPostponedJobs =
          postponedJobs
              .where((final element) => element.runtimeType != job.runtimeType)
              .toList();
      if (job.shouldRemoveInsteadOfAdd(postponedJobs)) {
        getIt<NavigationService>().showSnackBar('jobs.job_removed'.tr());
      } else {
        newPostponedJobs.add(job);
        getIt<NavigationService>().showSnackBar('jobs.job_added'.tr());
      }
      if (newPostponedJobs.isEmpty) {
        return JobsStateEmpty();
      }
      return JobsStateWithJobs(newPostponedJobs);
    }
    if (job.canAddTo(postponedJobs)) {
      final List<ClientJob> newPostponedJobs = [...postponedJobs, job];
      getIt<NavigationService>().showSnackBar('jobs.job_added'.tr());
      return JobsStateWithJobs(newPostponedJobs);
    }
    return this;
  }
}
