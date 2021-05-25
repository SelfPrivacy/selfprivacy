import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:equatable/equatable.dart';
export 'package:provider/provider.dart';

part 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit() : super(JobsState.emtpy());

  List<Job> jobsList = [];

  void addJob(Job job) {
    final newState = state.addJob(job);
    emit(newState);
  }

  void removeJob(String id) {
    final newState = state.removeById(id);
    emit(newState);
  }

  void applyAll() {
    print(state.jobList);
    emit(JobsState.emtpy());
  }
}
