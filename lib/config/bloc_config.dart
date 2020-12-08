import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/logic/cubit/services/services_cubit.dart';
import 'package:selfprivacy/logic/cubit/users/users_cubit.dart';

class BlocAndProviderConfig extends StatelessWidget {
  const BlocAndProviderConfig({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var platformBrightness =
        SchedulerBinding.instance.window.platformBrightness;
    // var platformBrightness = Brightness.dark;
    return MultiProvider(
      providers: [
        BlocProvider<AppSettingsCubit>(
          create: (BuildContext context) => AppSettingsCubit(
              isDarkModeOn: platformBrightness == Brightness.dark),
        ),
        BlocProvider<ServicesCubit>(
          create: (BuildContext context) => ServicesCubit(),
        ),
        BlocProvider<UsersCubit>(
          create: (BuildContext context) => UsersCubit(),
        ),
      ],
      child: child,
    );
  }
}
