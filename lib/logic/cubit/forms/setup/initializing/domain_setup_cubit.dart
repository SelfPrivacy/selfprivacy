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
    final GenericResult<List<ServerDomain>> result =
        await ProvidersController.currentDnsProvider!.domainList();
    if (!result.success || result.data.isEmpty) {
      emit(Empty());
    } else if (result.data.length == 1) {
      emit(Loaded(result.data.first.domainName));
    } else {
      emit(
        MoreThenOne(
          result.data.map<String>((final d) => d.domainName).toList(),
        ),
      );
    }
  }

  Future<void> saveDomain(final String domainName) async {
    emit(Loading(LoadingTypes.saving));

    final dnsProvider = ProvidersController.currentDnsProvider!;

    final ServerDomain domain = ServerDomain(
      domainName: domainName,
      provider: dnsProvider.type,
    );

    await serverInstallationCubit.setDomain(domain);
    emit(DomainSet());
  }
}

abstract class DomainSetupState {}

class Initial extends DomainSetupState {}

class Empty extends DomainSetupState {}

class MoreThenOne extends DomainSetupState {
  MoreThenOne(this.domains);
  final List<String> domains;
}

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
