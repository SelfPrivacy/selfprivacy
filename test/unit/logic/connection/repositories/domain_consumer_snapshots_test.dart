import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/models/service.dart';

import '../../../../helpers/fixtures/domain_mutation_fixtures.dart';

void main() {
  test('jobs state retains an immutable constructor snapshot', () {
    final job = aServiceMoveJob();
    final input = [job];
    final state = ServerJobsListWithJobsState(serverJobList: input);
    input.clear();
    expect(state.serverJobList, [job]);
    expect(state.serverJobList.clear, throwsUnsupportedError);
  });

  test('services state retains an immutable constructor snapshot', () {
    final input = <Service>[Service.empty];
    final state = ServicesLoaded(services: input, lockedServices: const []);
    input.clear();
    expect(state.services, [Service.empty]);
    expect(state.services.clear, throwsUnsupportedError);
  });
}
