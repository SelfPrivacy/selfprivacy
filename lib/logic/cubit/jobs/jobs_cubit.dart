import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/cubit/services/services_cubit.dart';
import 'package:selfprivacy/logic/cubit/users/users_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/models/user.dart';
export 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

part 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit({
    required this.usersCubit,
    required this.servicesCubit,
  }) : super(JobsStateEmpty());

  final api = ServerApi();
  final UsersCubit usersCubit;
  final ServicesCubit servicesCubit;

  void addJob(Job job) {
    var newJobsList = <Job>[];
    if (state is JobsStateWithJobs) {
      newJobsList.addAll((state as JobsStateWithJobs).jobList);
    }
    newJobsList.add(job);
    getIt<NavigationService>().showSnackBar(SnackBar(
      content: Text('jobs.jobAdded'.tr()),
      duration: const Duration(seconds: 2),
    ));
    emit(JobsStateWithJobs(newJobsList));
  }

  void removeJob(String id) {
    final newState = (state as JobsStateWithJobs).removeById(id);
    emit(newState);
  }

  void createOrRemove(ServiceToggleJob job) {
    var newJobsList = <Job>[];
    if (state is JobsStateWithJobs) {
      newJobsList.addAll((state as JobsStateWithJobs).jobList);
    }
    var needToRemoveJob =
        newJobsList.any((el) => el is ServiceToggleJob && el.type == job.type);
    if (needToRemoveJob) {
      var removingJob = newJobsList
          .firstWhere(((el) => el is ServiceToggleJob && el.type == job.type));
      removeJob(removingJob.id);
    } else {
      newJobsList.add(job);
      emit(JobsStateWithJobs(newJobsList));
    }
  }

  Future<void> applyAll() async {
    if (state is JobsStateWithJobs) {
      var jobs = (state as JobsStateWithJobs).jobList;
      emit(JobsStateLoading());

      var newUsers = <User>[];
      for (var job in jobs) {
        if (job is CreateUserJob) {
          newUsers.add(job.user);
          await api.createUser(job.user);
        } else if (job is ServiceToggleJob) {
          await api.switchService(job.type, job.needToTurnOn);
          if (job.needToTurnOn) {
            servicesCubit.turnOnist([job.type]);
          } else {
            servicesCubit.turnOffList([job.type]);
          }
        }
      }

      usersCubit.addUsers(newUsers);
      await api.apply();

      emit(JobsStateEmpty());

      getIt<NavigationService>().navigator!.pop();
    }
  }
}
