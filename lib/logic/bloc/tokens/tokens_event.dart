part of 'tokens_bloc.dart';

sealed class TokensEvent extends Equatable {
  const TokensEvent();
}

class RevalidateTokens extends TokensEvent {
  const RevalidateTokens();

  @override
  List<Object> get props => [];
}

class AddServerProviderToken extends TokensEvent {
  const AddServerProviderToken(this.serverProviderCredential);

  final ServerProviderCredential serverProviderCredential;

  @override
  List<Object> get props => [serverProviderCredential];
}

class AddBackupsProviderCredential extends TokensEvent {
  const AddBackupsProviderCredential(this.credential);

  final BackupsCredential credential;

  @override
  List<Object> get props => [credential];
}

class RemoveBackupsProviderCredential extends TokensEvent {
  const RemoveBackupsProviderCredential(this.credential);

  final BackupsCredential credential;

  @override
  List<Object> get props => [credential];
}

class ServerSelectedForProviderToken extends TokensEvent {
  const ServerSelectedForProviderToken(
    this.providerServer,
    this.server,
    this.serverProviderCredential,
  );

  final ServerBasicInfoWithValidators providerServer;
  final Server server;
  final ServerProviderCredential serverProviderCredential;

  @override
  List<Object> get props => [providerServer, server, serverProviderCredential];
}

class RefreshServerApiTokenEvent extends TokensEvent {
  const RefreshServerApiTokenEvent();

  @override
  List<Object> get props => [];
}
