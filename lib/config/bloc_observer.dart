import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:selfprivacy/config/get_it_config.dart';

class SimpleBlocObserver extends BlocObserver {
  SimpleBlocObserver();

  @override
  void onError(
    final BlocBase<dynamic> bloc,
    final Object error,
    final StackTrace stackTrace,
  ) {

    getIt<NavigationService>().showSnackBar(
      'Bloc error: ${error.toString()}',
    );
    super.onError(bloc, error, stackTrace);
  }
}
