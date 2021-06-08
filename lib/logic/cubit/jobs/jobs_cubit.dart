import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/models/jobs/job.dart';
import 'package:equatable/equatable.dart';
export 'package:provider/provider.dart';

part 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit() : super(JobsState.emtpy());

  final api = ServerApi();

  void addJob(Job job) {
    final newState = state.addJob(job);
    emit(newState);
  }

  void removeJob(String id) {
    final newState = state.removeById(id);
    emit(newState);
  }

  Future<void> applyAll() async {
    for (var job in state.jobList) {
      if (job is CreateUserJob) {
        await api.createUser(job.user);
      }
    }
    emit(JobsState.emtpy());
  }
}
