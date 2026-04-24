part of 'tokens_bloc.dart';

enum TokenStatus { loading, valid, invalid, noAccess }

class TokenStatusWrapper<T> {
  TokenStatusWrapper({required this.data, required this.status});

  final T data;
  final TokenStatus status;
}

sealed class TokensState extends Equatable {
  const TokensState();

  List<TokenStatusWrapper<ServerProviderCredential>>
  get serverProviderCredentials;
  List<TokenStatusWrapper<DnsProviderCredential>> get dnsProviderCredentials;
  List<TokenStatusWrapper<BackupsCredential>> get backupsCredentials;
  List<Server> get servers => _servers;

  List<Server> get serversWithoutProviderCredentials =>
      servers
          .where(
            (final Server server) =>
                server.hostingDetails.provider != ServerProviderType.unknown &&
                serverProviderCredentials.every(
                  (
                    final TokenStatusWrapper<ServerProviderCredential>
                    serverProviderCredential,
                  ) =>
                      !serverProviderCredential.data.associatedServerIds
                          .contains(server.hostingDetails.id),
                ),
          )
          .toList();

  Server getServerById(final int serverId) => servers.firstWhere(
    (final Server server) => server.hostingDetails.id == serverId,
  );

  List<ServerProviderCredential> get _serverProviderCredentials =>
      getIt<ResourcesModel>().serverProviderCredentials;
  List<DnsProviderCredential> get _dnsProviderCredentials =>
      getIt<ResourcesModel>().dnsProviderCredentials;
  List<BackupsCredential> get _backupsCredentials =>
      getIt<ResourcesModel>().backupsCredentials;
  List<Server> get _servers => getIt<ResourcesModel>().servers;
}

final class TokensInitial extends TokensState {
  const TokensInitial();

  @override
  List<TokenStatusWrapper<ServerProviderCredential>>
  get serverProviderCredentials =>
      _serverProviderCredentials
          .map(
            (final ServerProviderCredential serverProviderCredential) =>
                TokenStatusWrapper<ServerProviderCredential>(
                  data: serverProviderCredential,
                  status: TokenStatus.loading,
                ),
          )
          .toList();

  @override
  List<TokenStatusWrapper<DnsProviderCredential>> get dnsProviderCredentials =>
      _dnsProviderCredentials
          .map(
            (final DnsProviderCredential dnsProviderCredential) =>
                TokenStatusWrapper<DnsProviderCredential>(
                  data: dnsProviderCredential,
                  status: TokenStatus.loading,
                ),
          )
          .toList();

  @override
  List<TokenStatusWrapper<BackupsCredential>> get backupsCredentials =>
      _backupsCredentials
          .map(
            (final BackupsCredential backupsCredential) =>
                TokenStatusWrapper<BackupsCredential>(
                  data: backupsCredential,
                  status: TokenStatus.loading,
                ),
          )
          .toList();

  @override
  List<Server> get servers => _servers;

  @override
  List<Object> get props => [];
}

final class TokensChecked extends TokensState {
  const TokensChecked({
    required this.serverProviderCredentials,
    required this.dnsProviderCredentials,
    required this.backupsCredentials,
  });

  @override
  final List<TokenStatusWrapper<ServerProviderCredential>>
  serverProviderCredentials;
  @override
  final List<TokenStatusWrapper<DnsProviderCredential>> dnsProviderCredentials;
  @override
  final List<TokenStatusWrapper<BackupsCredential>> backupsCredentials;

  @override
  List<Object> get props => [
    serverProviderCredentials,
    dnsProviderCredentials,
    backupsCredentials,
    servers,
  ];
}
