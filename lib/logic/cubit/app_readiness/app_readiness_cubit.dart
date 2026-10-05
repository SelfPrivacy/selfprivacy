import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';

part 'app_readiness_state.dart';

class AppReadinessCubit extends Cubit<AppReadinessState> {
  AppReadinessCubit() : super(NoServer()) {
    _subscription = _hub.changes.listen((_) => _update());
    _update();
  }

  void _update() {
    final serverId = _hub.active?.serverId;
    final server = _resources.servers.firstWhereOrNull(
      (final server) => server.uuid == serverId,
    );
    emit(server == null ? NoServer() : ServerConfigured(server));
  }

  final _hub = getIt<ServerConnectionHub>();
  final _resources = getIt<ResourcesModel>();
  late final StreamSubscription<void> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
