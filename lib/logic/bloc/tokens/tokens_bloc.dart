import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/providers/backups_providers/backups_provider_factory.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider_factory.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider_factory.dart';

part 'tokens_event.dart';
part 'tokens_state.dart';

class TokensBloc extends Bloc<TokensEvent, TokensState> {
  TokensBloc() : super(const TokensInitial()) {
    on<RevalidateTokens>(validateTokens, transformer: droppable());
    on<AddServerProviderToken>(addServerProviderCredential);
    on<ServerSelectedForProviderToken>(connectServerToProviderToken);
    on<RefreshServerApiTokenEvent>(
      refreshServerApiToken,
      transformer: droppable(),
    );

    add(const RevalidateTokens());

    _resourcesModelSubscription = getIt<ResourcesModel>().statusStream.listen((
      final _,
    ) {
      add(const RevalidateTokens());
    });
  }

  Future<void> validateTokens(
    final RevalidateTokens event,
    final Emitter<TokensState> emit,
  ) async {
    emit(const TokensInitial());
    final List<ServerProviderCredential> serverProviderCredentials =
        getIt<ResourcesModel>().serverProviderCredentials;
    final List<DnsProviderCredential> dnsProviderCredentials =
        getIt<ResourcesModel>().dnsProviderCredentials;
    final List<BackupsCredential> backupsCredentials =
        getIt<ResourcesModel>().backupsCredentials;

    final List<TokenStatusWrapper<ServerProviderCredential>>
    validatedServerProviderCredentials = [];
    final List<TokenStatusWrapper<DnsProviderCredential>>
    validatedDnsProviderCredentials = [];
    final List<TokenStatusWrapper<BackupsCredential>>
    validatedBackupsCredentials = [];

    for (final credential in serverProviderCredentials) {
      final TokenStatus status = await _validateServerProviderToken(credential);
      validatedServerProviderCredentials.add(
        TokenStatusWrapper(data: credential, status: status),
      );
    }

    for (final credential in dnsProviderCredentials) {
      final TokenStatus status = await _validateDnsProviderToken(credential);
      validatedDnsProviderCredentials.add(
        TokenStatusWrapper(data: credential, status: status),
      );
    }

    for (final credential in backupsCredentials) {
      final TokenStatus status = await _validateBackupsToken(credential);
      validatedBackupsCredentials.add(
        TokenStatusWrapper(data: credential, status: status),
      );
    }

    emit(
      TokensChecked(
        serverProviderCredentials: validatedServerProviderCredentials,
        dnsProviderCredentials: validatedDnsProviderCredentials,
        backupsCredentials: validatedBackupsCredentials,
      ),
    );
  }

  Future<TokenStatus> _validateServerProviderToken(
    final ServerProviderCredential credential,
  ) async {
    final ServerProviderSettings settings = ServerProviderSettings(
      provider: credential.provider,
      token: credential.token,
      isAuthorized: true,
    );
    final serverProvider = ServerProviderFactory.createServerProviderInterface(
      settings,
    );
    // First, we check if the token works at all
    final basicInitCheckResult = await serverProvider.tryInitApiByToken(
      credential.token,
    );
    if (!basicInitCheckResult.data) {
      return TokenStatus.invalid;
    }
    // Now, if there are associated servers, check if we have access to them
    if (credential.associatedServerIds.isNotEmpty) {
      final servers = (await serverProvider.getServers()).data;
      for (final serverId in credential.associatedServerIds) {
        if (!servers.any((final server) => server.id == serverId)) {
          return TokenStatus.noAccess;
        }
      }
    }
    return TokenStatus.valid;
  }

  Future<TokenStatus> _validateDnsProviderToken(
    final DnsProviderCredential credential,
  ) async {
    final DnsProviderSettings settings = DnsProviderSettings(
      provider: credential.provider,
      token: credential.token,
      isAuthorized: true,
    );
    final dnsProvider = DnsProviderFactory.createDnsProviderInterface(settings);
    final basicInitCheckResult = await dnsProvider.tryInitApiByToken(
      credential.token,
    );
    if (!basicInitCheckResult.data) {
      return TokenStatus.invalid;
    }
    if (credential.associatedDomainNames.isNotEmpty) {
      final domains = (await dnsProvider.domainList()).data;
      for (final domainName in credential.associatedDomainNames) {
        if (!domains.any((final domain) => domain.domainName == domainName)) {
          return TokenStatus.noAccess;
        }
      }
    }
    return TokenStatus.valid;
  }

  Future<TokenStatus> _validateBackupsToken(
    final BackupsCredential credential,
  ) async {
    final BackupsProviderSettings settings = BackupsProviderSettings(
      provider: credential.provider,
      token: credential.applicationKey,
      tokenId: credential.keyId,
      isAuthorized: true,
    );
    final backupsProvider =
        BackupsProviderFactory.createBackupsProviderInterface(settings);
    final basicInitCheckResult = await backupsProvider.tryInitApiByToken(
      encodedBackblazeKey(credential.keyId, credential.applicationKey),
    );
    if (!basicInitCheckResult.data) {
      return TokenStatus.invalid;
    }
    return TokenStatus.valid;
  }

  Future<void> addServerProviderCredential(
    final AddServerProviderToken event,
    final Emitter<TokensState> emit,
  ) async {
    await getIt<ResourcesModel>().addServerProviderToken(
      event.serverProviderCredential,
    );

    final ServerProviderSettings settings = ServerProviderSettings(
      provider: event.serverProviderCredential.provider,
      token: event.serverProviderCredential.token,
      isAuthorized: true,
    );
    ProvidersController.initServerProvider(settings);
  }

  Future<void> connectServerToProviderToken(
    final ServerSelectedForProviderToken event,
    final Emitter<TokensState> emit,
  ) async {
    await getIt<ResourcesModel>().associateServerWithToken(
      event.providerServer.id,
      event.serverProviderCredential.token,
    );
    final Server newServerData = Server(
      domain: event.server.domain,
      hostingDetails: ServerHostingDetails(
        ip4: event.providerServer.ip,
        id: event.providerServer.id,
        createTime: event.providerServer.created,
        volume: ServerProviderVolume(
          id: 0,
          name: 'recovered_volume',
          sizeByte: 0,
          serverId: event.providerServer.id,
          linuxDevice: '',
        ),
        apiToken: event.server.hostingDetails.apiToken,
        provider: event.serverProviderCredential.provider,
        serverLocation: event.providerServer.location,
        serverType: event.server.hostingDetails.serverType,
      ),
    );
    await getIt<ResourcesModel>().updateServerByDomain(newServerData);
  }

  Future<void> refreshServerApiToken(
    final RefreshServerApiTokenEvent event,
    final Emitter<TokensState> emit,
  ) async {
    final (success, newToken) =
        await getIt<ApiConnectionRepository>().refreshDeviceToken();
    if (!success) {
      getIt<NavigationService>().showSnackBar(
        'devices.refresh_token_alert.failed_to_refresh_token'.tr(),
      );
      return;
    }
    final Server serverDetails = state.servers.first;
    final hostingDetails = serverDetails.hostingDetails.copyWith(
      apiToken: newToken,
    );
    await getIt<ResourcesModel>().updateServerByDomain(
      Server(hostingDetails: hostingDetails, domain: serverDetails.domain),
    );
    getIt<NavigationService>().showSnackBar(
      'devices.refresh_token_alert.success_refresh_token'.tr(),
    );
  }

  @override
  Future<void> close() async {
    await _resourcesModelSubscription.cancel();
    return super.close();
  }

  late StreamSubscription _resourcesModelSubscription;
}
