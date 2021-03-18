import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/ui/components/error/error.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

import './get_it_config.dart';

class SimpleBlocObserver extends BlocObserver {
  SimpleBlocObserver();

  @override
  void onError(BlocBase cubit, Object error, StackTrace stackTrace) {
    final navigator = getIt.get<NavigationService>().navigator!;

    navigator.push(
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
