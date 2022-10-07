import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server.dart';
import 'package:selfprivacy/logic/cubit/services/services_cubit.dart';
import 'package:selfprivacy/logic/cubit/users/users_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';

export 'package:provider/provider.dart';

part 'client_jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit({
    required this.usersCubit,
    required this.servicesCubit,
  }) : super(JobsStateEmpty());

  final ServerApi api = ServerApi();
  final UsersCubit usersCubit;
  final ServicesCubit servicesCubit;

  void addJob(final ClientJob job) {
    _updateJobsState([
      ...currentJobList,
      ...[job]
    ]);
  }

  void removeJob(final String id) {
    final JobsState newState = (state as JobsStateWithJobs).removeById(id);
    emit(newState);
  }

  void createOrRemoveServiceToggleJob(final ToggleJob job) {
    final List<ClientJob> newJobsList = <ClientJob>[];
    if (state is JobsStateWithJobs) {
      newJobsList.addAll((state as JobsStateWithJobs).clientJobList);
    }
    final bool needToRemoveJob = newJobsList
        .any((final el) => el is ServiceToggleJob && el.id == job.id);
    if (needToRemoveJob) {
      final ClientJob removingJob = newJobsList.firstWhere(
        (final el) => el is ServiceToggleJob && el.id == job.id,
      );
      removeJob(removingJob.id);
    } else {
      newJobsList.add(job);
      getIt<NavigationService>().showSnackBar('jobs.job_added'.tr());
      emit(JobsStateWithJobs(newJobsList));
    }
  }

  List<ClientJob> get currentJobList {
    final List<ClientJob> jobs = <ClientJob>[];
    if (state is JobsStateWithJobs) {
      jobs.addAll((state as JobsStateWithJobs).clientJobList);
    }

    return jobs;
  }

  void _updateJobsState(final List<ClientJob> newJobs) {
    getIt<NavigationService>().showSnackBar('jobs.job_added'.tr());
    emit(JobsStateWithJobs(newJobs));
  }

  void addUniqueJob<J extends ClientJob>(final J job) {
    final List<ClientJob> jobs = currentJobList;
    final bool exists = jobs.any((final el) => el is J);
    if (!exists) {
      _updateJobsState([
        ...jobs,
        ...[job]
      ]);
    }
  }

  Future<void> rebootServer() async {
    emit(JobsStateLoading());
    final bool isSuccessful = await api.reboot();
    if (isSuccessful) {
      getIt<NavigationService>().showSnackBar('jobs.reboot_success'.tr());
    } else {
      getIt<NavigationService>().showSnackBar('jobs.reboot_failed'.tr());
    }
    emit(JobsStateEmpty());
  }

  Future<void> upgradeServer() async {
    emit(JobsStateLoading());
    final bool isPullSuccessful = await api.pullConfigurationUpdate();
    final bool isSuccessful = await api.upgrade();
    if (isSuccessful) {
      if (!isPullSuccessful) {
        getIt<NavigationService>().showSnackBar('jobs.config_pull_failed'.tr());
      } else {
        getIt<NavigationService>().showSnackBar('jobs.upgrade_success'.tr());
      }
    } else {
      getIt<NavigationService>().showSnackBar('jobs.upgrade_failed'.tr());
    }
    emit(JobsStateEmpty());
  }

  Future<void> applyAll() async {
    if (state is JobsStateWithJobs) {
      final List<ClientJob> jobs = (state as JobsStateWithJobs).clientJobList;
      emit(JobsStateLoading());

      for (final ClientJob job in jobs) {
        job.execute(this);
      }

      await api.pullConfigurationUpdate();
      await api.apply();
      await servicesCubit.load();

      emit(JobsStateEmpty());
    }
  }
}
