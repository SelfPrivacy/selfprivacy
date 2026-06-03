import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';

part 'app_readiness_state.dart';

class AppReadinessCubit extends Cubit<AppReadinessState> {
  AppReadinessCubit() : super(NoServer()) {
    _resources = getIt<ResourcesModel>();

    _resourcesSubscription = _resources?.statusStream.listen(
      (_) => emit(getAppReadinessState(_resources)),
    );

    emit(getAppReadinessState(_resources!));
  }

  static AppReadinessState getAppReadinessState(
    final ResourcesModel resources,
  ) {
    if (resources.servers.isNotEmpty) {
      final Server server = resources.servers.first;
      return ServerConfigured(server);
    }
    return NoServer();
  }

  late final ResourcesModel? _resources;
  StreamSubscription? _resourcesSubscription;

  @override
  Future<void> close() async {
    await _resourcesSubscription?.cancel();
    return super.close();
  }
}
