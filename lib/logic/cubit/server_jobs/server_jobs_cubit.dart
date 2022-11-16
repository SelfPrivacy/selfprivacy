import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
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
    if (result.data == null) {
      getIt<NavigationService>().showSnackBar(result.message!);
      return;
    }

    emit(
      ServerJobsState(
        migrationJobUid: result.data,
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

  Future<void> removeServerJob(final String uid) async {
    final result = await api.removeApiJob(uid);
    if (!result.success) {
      getIt<NavigationService>().showSnackBar('jobs.generic_error'.tr());
      return;
    }

    if (!result.data) {
      getIt<NavigationService>()
          .showSnackBar(result.message ?? 'jobs.generic_error'.tr());
      return;
    }

    emit(
      ServerJobsState(
        serverJobList: [
          for (final ServerJob job in state.serverJobList)
            if (job.uid != uid) job
        ],
      ),
    );
  }

  Future<void> removeAllFinishedJobs() async {
    final List<ServerJob> finishedJobs = state.serverJobList
        .where(
          (final ServerJob job) =>
              job.status == JobStatusEnum.finished ||
              job.status == JobStatusEnum.error,
        )
        .toList();
    for (final ServerJob job in finishedJobs) {
      await removeServerJob(job.uid);
    }
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
