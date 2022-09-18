import 'dart:async';

import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

export 'package:provider/provider.dart';

part 'server_jobs_state.dart';

class ServerJobsCubit
    extends ServerInstallationDependendCubit<ServerJobsState> {
  ServerJobsCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(
          serverInstallationCubit,
          ServerJobsState(),
        );

  Timer? timer;
  final ServerApi api = ServerApi();

  @override
  void clear() async {
    emit(
      ServerJobsState(),
    );
    if (timer != null && timer!.isActive) {
      timer!.cancel();
      timer = null;
    }
  }

  @override
  void load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      final List<ServerJob> jobs = await api.getServerJobs();
      emit(
        ServerJobsState(
          serverJobList: jobs,
        ),
      );
      timer = Timer(const Duration(seconds: 5), () => reload(useTimer: true));
    }
  }

  Future<void> migrateToBinds(final Map<String, String> serviceToDisk) async {
    final result = await api.migrateToBinds(serviceToDisk);
    if (!result.success || result.jobUid == null) {
      getIt<NavigationService>().showSnackBar(result.message!);
      return;
    }

    emit(
      ServerJobsState(
        migrationJobUid: result.jobUid,
      ),
    );
  }

  ServerJob? getServerJobByUid(final String uid) {
    ServerJob? job;

    try {
      job = state.serverJobList.firstWhere(
        (final ServerJob job) => job.uid == uid,
      );
    } catch (e) {
      print(e);
    }

    return job;
  }

  /// Get the job object and change its isHidden to true.
  /// Emit the new state.
  /// Call the api to remove the job.
  /// If the api call fails, change the isHidden to false and emit the new state.
  /// If the api call succeeds, remove the job from the list and emit the new state.
  Future<void> removeServerJob(final String uid) async {
    final ServerJob? job = getServerJobByUid(uid);
    if (job == null) {
      return;
    }

    job.isHidden = true;
    emit(
      ServerJobsState(
        serverJobList: state.serverJobList,
      ),
    );

    final result = await api.removeApiJob(uid);
    if (!result.success) {
      job.isHidden = false;
      emit(
        ServerJobsState(
          serverJobList: state.serverJobList,
        ),
      );
      getIt<NavigationService>().showSnackBar(result.message!);
      return;
    }

    state.serverJobList.remove(job);
    emit(
      ServerJobsState(
        serverJobList: state.serverJobList,
      ),
    );
  }

  Future<void> reload({final bool useTimer = false}) async {
    final List<ServerJob> jobs = await api.getServerJobs();
    emit(
      ServerJobsState(
        serverJobList: jobs,
      ),
    );
    if (useTimer) {
      timer = Timer(const Duration(seconds: 5), () => reload(useTimer: true));
    }
  }
}
