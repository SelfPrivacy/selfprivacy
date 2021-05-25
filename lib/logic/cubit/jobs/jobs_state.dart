part of 'jobs_cubit.dart';

class JobsState extends Equatable {
  const JobsState(this.jobList);

  final List<Job> jobList;

  static JobsState emtpy() => JobsState([]);

  bool get isEmpty => jobList.isEmpty;

  JobsState addJob(Job job) {
    var newJobsList = [...jobList];
    newJobsList.add(job);
    return JobsState(newJobsList);
  }

  JobsState removeById(String id) {
    var newJobsList = jobList.where((element) => element.id != id).toList();
    return JobsState(newJobsList);
  }

  @override
  List<Object> get props => jobList;
}
