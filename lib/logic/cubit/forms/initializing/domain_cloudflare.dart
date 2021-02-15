import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/api_maps/cloudflare.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/models/cloudflare_domain.dart';

class DomainSetupCubit extends Cubit<DomainSetupState> {
  DomainSetupCubit(this.initializingCubit) : super(Initial()) {
    var token = (initializingCubit.state.cloudFlareKey);

    assert(token != null, 'no cloudflare token');

    api = CloudflareApi(token);
  }

  AppConfigCubit initializingCubit;
  CloudflareApi api;

  Future<void> load() async {
    emit(Loading(LoadingTypes.loadingDomain));
    var list = await api.domainList();
    if (list.isEmpty) {
      emit(Empty());
    } else if (list.length == 1) {
      emit(Loaded(list.first));
    } else {
      emit(MoreThenOne());
    }
  }

  @override
  Future<void> close() {
    api.close();
    return super.close();
  }

  Future<void> saveDomain() async {
    assert(state is Loaded, 'wrong state');
    var domainName = (state as Loaded).domain;

    emit(Loading(LoadingTypes.saving));

    var zoneId = await api.getZoneId(
      initializingCubit.state.cloudFlareKey,
      domainName,
    );

    var domain = CloudFlareDomain(
      domainName: domainName,
      zoneId: zoneId,
    );

    initializingCubit.setDomain(domain);
    emit(DomainSetted());
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
  final String domain;

  Loaded(this.domain);
}

class DomainSetted extends DomainSetupState {}
