import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';

class DomainSetupCubit extends Cubit<DomainSetupState> {
  DomainSetupCubit(this.serverInstallationCubit) : super(Initial());

  final ServerInstallationCubit serverInstallationCubit;

  Future<void> load() async {
    emit(Loading(LoadingTypes.loadingDomain));
    final GenericResult<List<String>> result =
        await ProvidersController.currentDnsProvider!.domainList();
    if (!result.success || result.data.isEmpty) {
      emit(Empty());
    } else if (result.data.length == 1) {
      emit(Loaded(result.data.first));
    } else {
      emit(MoreThenOne());
    }
  }

  Future<void> saveDomain() async {
    assert(state is Loaded, 'wrong state');
    final String domainName = (state as Loaded).domain;

    emit(Loading(LoadingTypes.saving));

    final GenericResult<String?> zoneIdResult =
        await ProvidersController.currentDnsProvider!.getZoneId(domainName);

    if (zoneIdResult.success || zoneIdResult.data != null) {
      final ServerDomain domain = ServerDomain(
        domainName: domainName,
        zoneId: zoneIdResult.data!,
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
