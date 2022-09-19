import 'dart:async';

import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/service.dart';

part 'services_state.dart';

class ServicesCubit extends ServerInstallationDependendCubit<ServicesState> {
  ServicesCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(serverInstallationCubit, const ServicesState.empty());
  final ServerApi api = ServerApi();
  Timer? timer;
  @override
  Future<void> load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      final List<Service> services = await api.getAllServices();
      emit(
        ServicesState(
          services: services,
          lockedServices: const [],
        ),
      );
      timer = Timer(const Duration(seconds: 10), () => reload(useTimer: true));
    }
  }

  Future<void> reload({final bool useTimer = false}) async {
    final List<Service> services = await api.getAllServices();
    emit(
      state.copyWith(
        services: services,
      ),
    );
    if (useTimer) {
      timer = Timer(const Duration(seconds: 60), () => reload(useTimer: true));
    }
  }

  Future<void> restart(final String serviceId) async {
    emit(state.copyWith(lockedServices: [...state.lockedServices, serviceId]));
    await api.restartService(serviceId);
    await Future.delayed(const Duration(seconds: 2));
    reload();
    await Future.delayed(const Duration(seconds: 10));
    emit(
      state.copyWith(
        lockedServices: state.lockedServices
            .where((final element) => element != serviceId)
            .toList(),
      ),
    );
    reload();
  }

  Future<void> moveService(
    final String serviceId,
    final String destination,
  ) async {
    await api.moveService(serviceId, destination);
  }

  @override
  void clear() async {
    emit(const ServicesState.empty());
    if (timer != null && timer!.isActive) {
      timer!.cancel();
      timer = null;
    }
  }
}
