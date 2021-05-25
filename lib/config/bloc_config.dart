import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/jobs/jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/providers/providers_cubit.dart';
import 'package:selfprivacy/logic/cubit/users/users_cubit.dart';

class BlocAndProviderConfig extends StatelessWidget {
  const BlocAndProviderConfig({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // var platformBrightness =
    //     SchedulerBinding.instance.window.platformBrightness;
    // var isDark = platformBrightness == Brightness.dark;
    var isDark = false;

    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => AppSettingsCubit(
            isDarkModeOn: isDark,
            isOnbordingShowing: true,
          )..load(),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => AppConfigCubit()..load(),
        ),
        BlocProvider(create: (_) => ProvidersCubit()),
        BlocProvider(create: (_) => UsersCubit()),
        BlocProvider(create: (_) => JobsCubit()),
      ],
      child: child,
    );
  }
}
