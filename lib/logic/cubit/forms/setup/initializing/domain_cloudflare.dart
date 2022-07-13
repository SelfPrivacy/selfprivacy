import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/cloudflare.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

class DomainSetupCubit extends Cubit<DomainSetupState> {
  DomainSetupCubit(this.serverInstallationCubit) : super(Initial());

  final ServerInstallationCubit serverInstallationCubit;

  Future<void> load() async {
    emit(Loading(LoadingTypes.loadingDomain));
    final CloudflareApi api = CloudflareApi();

    final List<String> list = await api.domainList();
    if (list.isEmpty) {
      emit(Empty());
    } else if (list.length == 1) {
      emit(Loaded(list.first));
    } else {
      emit(MoreThenOne());
    }
  }

  @override
  Future<void> close() => super.close();

  Future<void> saveDomain() async {
    assert(state is Loaded, 'wrong state');
    final String domainName = (state as Loaded).domain;
    final CloudflareApi api = CloudflareApi();

    emit(Loading(LoadingTypes.saving));

    final String zoneId = await api.getZoneId(domainName);

    final ServerDomain domain = ServerDomain(
      domainName: domainName,
      zoneId: zoneId,
      provider: DnsProvider.cloudflare,
    );

    serverInstallationCubit.setDomain(domain);
    emit(DomainSet());
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
