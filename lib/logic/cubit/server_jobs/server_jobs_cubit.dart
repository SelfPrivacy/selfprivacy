import 'dart:async';

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
          const ServerJobsState(
            serverJobList: [],
          ),
        );

  Timer? timer;
  final ServerApi api = ServerApi();

  @override
  void clear() async {
    emit(
      const ServerJobsState(
        serverJobList: [],
      ),
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
      timer = Timer(const Duration(seconds: 10), () => reload(useTimer: true));
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
      timer = Timer(const Duration(seconds: 10), () => reload(useTimer: true));
    }
  }
}
