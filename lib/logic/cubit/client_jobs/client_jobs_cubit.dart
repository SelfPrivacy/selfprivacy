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
    final List<ClientJob> newJobsList = [];
    if (state is JobsStateWithJobs) {
      final JobsStateWithJobs jobsState = state as JobsStateWithJobs;
      newJobsList.addAll(jobsState.clientJobList);
    }
    newJobsList.add(job);
    getIt<NavigationService>().showSnackBar('jobs.jobAdded'.tr());
    emit(JobsStateWithJobs(newJobsList));
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
        .any((final el) => el is ServiceToggleJob && el.type == job.type);
    if (needToRemoveJob) {
      final ClientJob removingJob = newJobsList.firstWhere(
        (final el) => el is ServiceToggleJob && el.type == job.type,
      );
      removeJob(removingJob.id);
    } else {
      newJobsList.add(job);
      getIt<NavigationService>().showSnackBar('jobs.jobAdded'.tr());
      emit(JobsStateWithJobs(newJobsList));
    }
  }

  void createShhJobIfNotExist(final CreateSSHKeyJob job) {
    final List<ClientJob> newJobsList = <ClientJob>[];
    if (state is JobsStateWithJobs) {
      newJobsList.addAll((state as JobsStateWithJobs).clientJobList);
    }
    final bool isExistInJobList =
        newJobsList.any((final el) => el is CreateSSHKeyJob);
    if (!isExistInJobList) {
      newJobsList.add(job);
      getIt<NavigationService>().showSnackBar('jobs.jobAdded'.tr());
      emit(JobsStateWithJobs(newJobsList));
    }
  }

  Future<void> rebootServer() async {
    emit(JobsStateLoading());
    final bool isSuccessful = await api.reboot();
    if (isSuccessful) {
      getIt<NavigationService>().showSnackBar('jobs.rebootSuccess'.tr());
    } else {
      getIt<NavigationService>().showSnackBar('jobs.rebootFailed'.tr());
    }
    emit(JobsStateEmpty());
  }

  Future<void> upgradeServer() async {
    emit(JobsStateLoading());
    final bool isPullSuccessful = await api.pullConfigurationUpdate();
    final bool isSuccessful = await api.upgrade();
    if (isSuccessful) {
      if (!isPullSuccessful) {
        getIt<NavigationService>().showSnackBar('jobs.configPullFailed'.tr());
      } else {
        getIt<NavigationService>().showSnackBar('jobs.upgradeSuccess'.tr());
      }
    } else {
      getIt<NavigationService>().showSnackBar('jobs.upgradeFailed'.tr());
    }
    emit(JobsStateEmpty());
  }

  Future<void> applyAll() async {
    if (state is JobsStateWithJobs) {
      final List<ClientJob> jobs = (state as JobsStateWithJobs).clientJobList;
      emit(JobsStateLoading());
      bool hasServiceJobs = false;
      for (final ClientJob job in jobs) {
        // TODO: Rewrite to polymorphism
        if (job is CreateUserJob) {
          await usersCubit.createUser(job.user);
        }
        if (job is DeleteUserJob) {
          await usersCubit.deleteUser(job.user);
        }
        if (job is ServiceToggleJob) {
          hasServiceJobs = true;
          await api.switchService(job.type.name, job.needToTurnOn);
        }
        if (job is CreateSSHKeyJob) {
          await usersCubit.addSshKey(job.user, job.publicKey);
        }
        if (job is DeleteSSHKeyJob) {
          await usersCubit.deleteSshKey(job.user, job.publicKey);
        }
        if (job is ResetUserPasswordJob) {
          await usersCubit.changeUserPassword(job.user, job.user.password!);
        }
        if (job is RebuildServerJob) {
          await upgradeServer();
        }
      }

      await api.pullConfigurationUpdate();
      await api.apply();

      if (hasServiceJobs) {
        await servicesCubit.load();
      }

      emit(JobsStateEmpty());
    }
  }
}
