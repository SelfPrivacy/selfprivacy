// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/ui/components/error/error.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

import 'package:selfprivacy/config/get_it_config.dart';

class SimpleBlocObserver extends BlocObserver {
  SimpleBlocObserver();

  @override
  void onError(final BlocBase bloc, final Object error, final StackTrace stackTrace) {
    final NavigatorState navigator = getIt.get<NavigationService>().navigator!;

    navigator.push(
      materialRoute(
        BrandError(
          error: error,
          stackTrace: stackTrace,
        ),
      ),
    );
    super.onError(bloc, error, stackTrace);
  }
}
