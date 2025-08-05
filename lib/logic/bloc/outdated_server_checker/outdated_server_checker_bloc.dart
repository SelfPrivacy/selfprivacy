import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';

part 'outdated_server_checker_event.dart';
part 'outdated_server_checker_state.dart';

const String requiredServerVersion = '>=3.6.0';

class OutdatedServerCheckerBloc
    extends Bloc<OutdatedServerCheckerEvent, OutdatedServerCheckerState> {
  OutdatedServerCheckerBloc() : super(OutdatedServerCheckerInitial()) {
    on<ServerApiVersionChanged>((final event, final emit) {
      if (event.newVersion == null) {
        emit(OutdatedServerCheckerInitial());
        return;
      }
      final requiredVersion = VersionConstraint.parse(requiredServerVersion);
      final currentVersion = Version.parse(event.newVersion!);
      if (requiredVersion.allows(currentVersion)) {
        emit(OutdatedServerCheckerUpToDate(currentVersion));
      } else {
        emit(OutdatedServerCheckerOutdated(currentVersion));
      }
    });

    _apiDataSubscription = getIt<ApiConnectionRepository>().dataStream.listen((
      final ApiData apiData,
    ) {
      add(ServerApiVersionChanged(apiData.apiVersion.data));
    });
  }

  @override
  Future<void> close() async {
    await _apiDataSubscription.cancel();
    return super.close();
  }

  @override
  void onChange(final Change<OutdatedServerCheckerState> change) {
    super.onChange(change);
  }

  late StreamSubscription _apiDataSubscription;
}
