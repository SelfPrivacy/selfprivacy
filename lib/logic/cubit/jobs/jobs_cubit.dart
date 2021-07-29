import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/cubit/users/users_cubit.dart';
import 'package:selfprivacy/logic/models/jobs/job.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/models/user.dart';
export 'package:provider/provider.dart';

part 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit(this.usersCubit) : super(JobsStateEmpty());

  final api = ServerApi();
  final UsersCubit usersCubit;

  void addJob(Job job) {
    var newJobsList = <Job>[];
    if (state is JobsStateWithJobs) {
      newJobsList.addAll((state as JobsStateWithJobs).jobList);
    }
    newJobsList.add(job);
    emit(JobsStateWithJobs(newJobsList));
  }

  void removeJob(String id) {
    final newState = (state as JobsStateWithJobs).removeById(id);
    emit(newState);
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
        }
      }

      usersCubit.addUsers(newUsers);
      await api.apply();

      emit(JobsStateEmpty());

      getIt<NavigationService>().navigator!.pop();
    }
  }
}
