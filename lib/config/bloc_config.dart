import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/logic/cubit/backups/backups_cubit.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/logic/cubit/jobs/jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/providers/providers_cubit.dart';
import 'package:selfprivacy/logic/cubit/services/services_cubit.dart';
import 'package:selfprivacy/logic/cubit/users/users_cubit.dart';

class BlocAndProviderConfig extends StatelessWidget {
  const BlocAndProviderConfig({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    var isDark = false;
    var usersCubit = UsersCubit();
    var appConfigCubit = AppConfigCubit()..load();
    var servicesCubit = ServicesCubit(appConfigCubit);
    var backupsCubit = BackupsCubit(appConfigCubit);
    var dnsRecordsCubit = DnsRecordsCubit(appConfigCubit);
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => AppSettingsCubit(
            isDarkModeOn: isDark,
            isOnbordingShowing: true,
          )..load(),
        ),
        BlocProvider(create: (_) => appConfigCubit, lazy: false),
        BlocProvider(create: (_) => ProvidersCubit()),
        BlocProvider(create: (_) => usersCubit..load(), lazy: false),
        BlocProvider(create: (_) => servicesCubit..load(), lazy: false),
        BlocProvider(create: (_) => backupsCubit..load(), lazy: false),
        BlocProvider(create: (_) => dnsRecordsCubit..load()),
        BlocProvider(
          create: (_) =>
              JobsCubit(usersCubit: usersCubit, servicesCubit: servicesCubit),
        ),
      ],
      child: child,
    );
  }
}
