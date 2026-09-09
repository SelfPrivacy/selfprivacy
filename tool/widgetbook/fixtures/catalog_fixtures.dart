import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/bloc/devices/devices_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/tokens/tokens_bloc.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_readiness/app_readiness_cubit.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/service.dart';

import 'constants.dart';
import 'metrics.dart';
import 'mocks.dart';
import 'models.dart';

class CatalogFixtures {
  CatalogFixtures(this.variant, this.record) {
    final servicesState = DemoServicesState();
    final serviceList = variant == 'Empty' ? <Service>[] : [demoService()];
    when(() => servicesState.services).thenReturn(serviceList);
    when(() => servicesState.servicesThatCanBeBackedUp).thenReturn(serviceList);
    when(() => servicesState.getServiceById(any())).thenAnswer(
      (final invocation) =>
          invocation.positionalArguments.first == 'nextcloud' &&
              variant != 'Missing service'
          ? demoService()
          : null,
    );
    when(() => servicesState.lockedServices).thenReturn([]);
    final backupsState = DemoBackupsState();
    when(
      () => backupsState.autobackupPeriod,
    ).thenReturn(variant == 'Disabled' ? null : const Duration(days: 1));
    when(() => backupsState.autobackupQuotas).thenReturn(
      AutobackupQuotas(
        last: variant == 'Unlimited' ? -1 : 5,
        daily: 7,
        weekly: 4,
        monthly: 12,
        yearly: 3,
      ),
    );
    when(
      () => backupsState.encryptionKey,
    ).thenReturn(variant == 'Missing key' ? null : demoBackupKey);
    final serverJobsState = DemoServerJobsState();
    when(
      () => serverJobsState.busyServices,
    ).thenReturn(variant == 'Busy' ? ['nextcloud'] : []);
    when(
      () => serverJobsState.serverJobList,
    ).thenReturn(variant == 'Empty' ? [] : [demoJob(JobStatusEnum.running)]);
    when(
      () => serverJobsState.hasJobsBlockingRebuild,
    ).thenReturn(variant == 'Blocked');
    when(
      () => serverJobsState.hasRemovableJobs,
    ).thenReturn(variant == 'Finished' || variant == 'Failed');
    final loaded = DemoLoadedDetails();
    final ssh = DemoSshSettings();
    when(() => ssh.enable).thenReturn(variant != 'SSH disabled');
    when(() => loaded.sshSettings).thenReturn(ssh);
    when(() => loaded.metadata).thenReturn([
      ServerMetadataEntity(
        trId: 'server.server',
        value: 'SelfPrivacy — example.org',
      ),
    ]);
    bind(
      readiness,
      variant == 'Not configured' ? NoServer() : ServerConfigured(demoServer()),
    );
    bind(services, servicesState);
    bind(backups, backupsState);
    bind(serverJobs, serverJobsState);
    bind(
      volumes,
      VolumesLoaded(serverVolumesHashCode: 0, diskStatus: demoDisks()),
    );
    bind(
      details,
      variant == 'Loading'
          ? const ServerDetailsLoading()
          : variant == 'Not ready'
          ? const ServerDetailsNotReady()
          : loaded,
    );
    bind(
      metrics,
      variant == 'Unsupported'
          ? const MetricsUnsupported(Period.hour)
          : variant == 'Loading'
          ? const MetricsLoading(Period.hour)
          : demoMetrics(legacy: variant == 'Legacy'),
    );
    bind(support, const SupportSystemState('how_backblaze'));
    final clientJob = UpgradeServerJob(
      id: 'catalog-upgrade',
      status: variant == 'Finished'
          ? JobStatusEnum.finished
          : variant == 'Failed'
          ? JobStatusEnum.error
          : JobStatusEnum.created,
      message: variant == 'Failed' ? 'Upgrade could not be completed' : null,
    );
    final pendingJob = UpdateDnsRecordsJob();
    bind(jobs, switch (variant) {
      'Loading' => JobsStateLoading([clientJob], null, const []),
      'Finished' || 'Failed' => JobsStateFinished([clientJob], null, const []),
      'Queued' || 'Blocked' => JobsStateWithJobs([clientJob]),
      'Postponed' => JobsStateLoading([clientJob], 'catalog-job', [pendingJob]),
      _ => JobsStateEmpty(),
    });
    devices.record = record;
    tokens.record = record;
    when(
      () => resources.statusStream,
    ).thenAnswer((_) => const Stream<ResourcesModelEvent>.empty());
    when(() => resources.servers).thenReturn(
      variant == 'No token'
          ? []
          : [
              demoServer(
                rotatedAt: variant == 'Due now'
                    ? null
                    : referenceTime.subtract(
                        Duration(days: variant == 'Overdue' ? 40 : 10),
                      ),
              ),
            ],
    );
  }
  final String variant;
  final void Function(String) record;
  final readiness = DemoReadiness();
  final jobs = DemoJobs();
  final services = DemoServices();
  final backups = DemoBackups();
  final serverJobs = DemoServerJobs();
  final volumes = DemoVolumes();
  final details = DemoDetails();
  final metrics = DemoMetrics();
  final support = DemoSupport();
  final devices = DemoDevices();
  final tokens = DemoTokens();
  final resources = DemoResources();
  final List<StreamController<dynamic>> _streams = [];
  void bind<S>(final StateStreamable<S> mock, final S state) {
    final stream = StreamController<S>.broadcast();
    _streams.add(stream);
    when(() => mock.state).thenReturn(state);
    when(() => mock.stream).thenAnswer((_) => stream.stream);
    (mock as ActionMock).record = record;
  }

  Widget wrap(final Widget child) => MultiBlocProvider(
    providers: [
      BlocProvider<AppReadinessCubit>.value(value: readiness),
      BlocProvider<JobsCubit>.value(value: jobs),
      BlocProvider<ServicesBloc>.value(value: services),
      BlocProvider<BackupsBloc>.value(value: backups),
      BlocProvider<ServerJobsBloc>.value(value: serverJobs),
      BlocProvider<VolumesBloc>.value(value: volumes),
      BlocProvider<ServerDetailsCubit>.value(value: details),
      BlocProvider<MetricsCubit>.value(value: metrics),
      BlocProvider<SupportSystemCubit>.value(value: support),
      BlocProvider<DevicesBloc>.value(value: devices),
      BlocProvider<TokensBloc>.value(value: tokens),
    ],
    child: child,
  );
  void dispose() {
    for (final stream in _streams) {
      unawaited(stream.close());
    }
  }
}
