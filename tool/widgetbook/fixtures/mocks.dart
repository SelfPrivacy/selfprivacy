import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/bloc/devices/devices_bloc.dart';
import 'package:selfprivacy/logic/bloc/groups/groups_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/tokens/tokens_bloc.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/cubit/app_readiness/app_readiness_cubit.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/ssh_settings.dart';

class ActionMock extends Mock {
  void Function(String)? record;
  @override
  dynamic noSuchMethod(final Invocation invocation) {
    final name = invocation.memberName.toString();
    if (record != null &&
        invocation.isMethod &&
        [
          'add',
          'addJob',
          'removeJob',
          'applyAll',
          'rebootServer',
          'upgradeServer',
          'acknowledgeFinished',
          'changePeriod',
        ].any((final method) => name == 'Symbol("$method")')) {
      record!(
        '$name ${invocation.positionalArguments.map((final a) => a.runtimeType).join(', ')}',
      );
      if ([
        'applyAll',
        'rebootServer',
        'upgradeServer',
        'acknowledgeFinished',
        'changePeriod',
      ].any((final method) => name == 'Symbol("$method")')) {
        return Future<void>.value();
      }
      return null;
    }
    return super.noSuchMethod(invocation);
  }
}

class DemoReadiness extends ActionMock implements AppReadinessCubit {}

class DemoJobs extends ActionMock implements JobsCubit {}

class DemoServices extends ActionMock implements ServicesBloc {}

class DemoBackups extends ActionMock implements BackupsBloc {}

class DemoServerJobs extends ActionMock implements ServerJobsBloc {}

class DemoVolumes extends ActionMock implements VolumesBloc {}

class DemoDetails extends ActionMock implements ServerDetailsCubit {}

class DemoMetrics extends ActionMock implements MetricsCubit {}

class DemoSupport extends ActionMock implements SupportSystemCubit {}

class DemoDevices extends ActionMock implements DevicesBloc {}

class DemoTokens extends ActionMock implements TokensBloc {}

// These state views bypass repository-backed getters in catalog fixtures.
// ignore: avoid_implementing_value_types
class DemoServicesState extends Mock implements ServicesLoaded {}

// ignore: avoid_implementing_value_types
class DemoBackupsState extends Mock implements BackupsInitialized {}

// ignore: avoid_implementing_value_types
class DemoServerJobsState extends Mock implements ServerJobsListWithJobsState {}

// ignore: avoid_implementing_value_types
class DemoLoadedDetails extends Mock implements Loaded {}

class DemoSshSettings extends Mock implements SshSettings {}

class DemoResources extends Mock implements ResourcesModel {}

class DemoGroups extends ActionMock implements GroupsBloc {}

class DemoGroupsState extends GroupsLoaded {
  DemoGroupsState()
    : super(groups: const ['sp.full_users', 'sp.admins', 'sp.nextcloud.user']);

  @override
  List<String> get groups => const [
    'sp.full_users',
    'sp.admins',
    'sp.nextcloud.user',
  ];
}
