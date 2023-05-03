import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';

class DomainSetupCubit extends Cubit<DomainSetupState> {
  DomainSetupCubit(this.serverInstallationCubit) : super(Initial());

  final ServerInstallationCubit serverInstallationCubit;

  Future<void> load() async {
    emit(Loading(LoadingTypes.loadingDomain));
    final List<String> list =
        await ProvidersController.currentDnsProvider!.domainList();
    if (list.isEmpty) {
      emit(Empty());
    } else if (list.length == 1) {
      emit(Loaded(list.first));
    } else {
      emit(MoreThenOne());
    }
  }

  Future<void> saveDomain() async {
    assert(state is Loaded, 'wrong state');
    final String domainName = (state as Loaded).domain;

    emit(Loading(LoadingTypes.saving));

    final String? zoneId =
        await ProvidersController.currentDnsProvider!.getZoneId(domainName);

    if (zoneId != null) {
      final ServerDomain domain = ServerDomain(
        domainName: domainName,
        zoneId: zoneId,
        provider: DnsProviderType.cloudflare,
      );

      serverInstallationCubit.setDomain(domain);
      emit(DomainSet());
    }
  }
}

abstract class DomainSetupState {}

class Initial extends DomainSetupState {}

class Empty extends DomainSetupState {}

class MoreThenOne extends DomainSetupState {}

class Loading extends DomainSetupState {
  Loading(this.type);
  final LoadingTypes type;
}

enum LoadingTypes { loadingDomain, saving }

class Loaded extends DomainSetupState {
  Loaded(this.domain);
  final String domain;
}

class DomainSet extends DomainSetupState {}
