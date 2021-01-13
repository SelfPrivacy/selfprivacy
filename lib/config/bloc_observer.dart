import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/ui/components/error/error.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class SimpleBlocObserver extends BlocObserver {
  final GlobalKey<NavigatorState> navigatorKey;

  SimpleBlocObserver({this.navigatorKey});

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    navigatorKey.currentState.push(
      materialRoute(
        BrandError(
          error: error,
          stackTrace: stackTrace,
        ),
      ),
    );
    super.onError(cubit, error, stackTrace);
  }
}
