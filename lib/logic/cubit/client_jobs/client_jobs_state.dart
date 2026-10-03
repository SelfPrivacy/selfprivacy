part of 'client_jobs_cubit.dart';

sealed class JobsState extends Equatable {
  String? get rebuildJobUid => null;

  JobsState addJob(final ClientJob job, {final SystemSettings? settings});

  @override
  List<Object?> get props => [];
}

class JobsStateEmpty extends JobsState {
  @override
  JobsStateWithJobs addJob(
    final ClientJob job, {
    final SystemSettings? settings,
  }) => JobsStateWithJobs([job]);

  @override
  List<Object?> get props => [];
}

class JobsStateWithJobs extends JobsState {
  JobsStateWithJobs(final List<ClientJob> clientJobList)
    : clientJobList = List.unmodifiable(clientJobList);
  final List<ClientJob> clientJobList;

  bool get rebuildRequired =>
      clientJobList.any((final job) => job.requiresRebuild);

  bool get dnsUpdateRequired =>
      clientJobList.any((final job) => job.requiresDnsUpdate);

  JobsState removeById(final String id) {
    final List<ClientJob> newJobsList = clientJobList
        .where((final element) => element.id != id)
        .toList();
    if (newJobsList.isEmpty) {
      return JobsStateEmpty();
    }
    return JobsStateWithJobs(newJobsList);
  }

  @override
  List<Object?> get props => [clientJobList];

  @override
  JobsState addJob(final ClientJob job, {final SystemSettings? settings}) {
    if (job is ReplaceableJob) {
      final List<ClientJob> newJobsList = clientJobList
          .where(
            (final element) => job.shouldReplaceOnlyIfSameId
                ? element.runtimeType != job.runtimeType || element.id != job.id
                : element.runtimeType != job.runtimeType,
          )
          .toList();
      if (!job.matchesSettings(settings)) {
        newJobsList.add(job);
      }
      if (newJobsList.isEmpty) {
        return JobsStateEmpty();
      }
      return JobsStateWithJobs(newJobsList);
    }
    if (job.canAddTo(clientJobList)) {
      final List<ClientJob> newJobsList = [...clientJobList, job];
      return JobsStateWithJobs(newJobsList);
    }
    return this;
  }
}

class JobsStateLoading extends JobsState {
  JobsStateLoading(
    final List<ClientJob> clientJobList,
    this.rebuildJobUid,
    final List<ClientJob> postponedJobs,
  ) : clientJobList = List.unmodifiable(clientJobList),
      postponedJobs = List.unmodifiable(postponedJobs);
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
    final List<ClientJob> newJobsList = clientJobList.map((final job) {
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
  JobsState addJob(final ClientJob job, {final SystemSettings? settings}) {
    if (job is ReplaceableJob) {
      final List<ClientJob> newPostponedJobs = postponedJobs
          .where((final element) => element.runtimeType != job.runtimeType)
          .toList();
      if (!job.matchesSettings(settings)) {
        newPostponedJobs.add(job);
      }
      return JobsStateLoading(clientJobList, rebuildJobUid, newPostponedJobs);
    }
    if (job.canAddTo(postponedJobs)) {
      final List<ClientJob> newPostponedJobs = [...postponedJobs, job];
      return JobsStateLoading(clientJobList, rebuildJobUid, newPostponedJobs);
    }
    return this;
  }
}

class JobsStateFinished extends JobsState {
  JobsStateFinished(
    final List<ClientJob> clientJobList,
    this.rebuildJobUid,
    final List<ClientJob> postponedJobs,
  ) : clientJobList = List.unmodifiable(clientJobList),
      postponedJobs = List.unmodifiable(postponedJobs);
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
  JobsState addJob(final ClientJob job, {final SystemSettings? settings}) {
    if (job is ReplaceableJob) {
      final List<ClientJob> newPostponedJobs = postponedJobs
          .where((final element) => element.runtimeType != job.runtimeType)
          .toList();
      if (!job.matchesSettings(settings)) {
        newPostponedJobs.add(job);
      }
      if (newPostponedJobs.isEmpty) {
        return JobsStateEmpty();
      }
      return JobsStateWithJobs(newPostponedJobs);
    }
    if (job.canAddTo(postponedJobs)) {
      final List<ClientJob> newPostponedJobs = [...postponedJobs, job];
      return JobsStateWithJobs(newPostponedJobs);
    }
    return this;
  }
}
