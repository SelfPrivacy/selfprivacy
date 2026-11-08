part of 'server_metadata_bloc.dart';

sealed class ServerMetadataState extends Equatable {
  ServerMetadataState({final List<ServerMetadataEntity> metadata = const []})
    : metadata = List.unmodifiable(metadata);

  final List<ServerMetadataEntity> metadata;

  @override
  List<Object?> get props => [metadata];
}

final class ServerMetadataLoading extends ServerMetadataState {
  ServerMetadataLoading({super.metadata});
}

final class ServerMetadataLoaded extends ServerMetadataState {
  ServerMetadataLoaded({required super.metadata});
}

final class ServerMetadataFailed extends ServerMetadataState {
  ServerMetadataFailed({super.metadata});
}

final class ServerMetadataDetached extends ServerMetadataState {
  ServerMetadataDetached();
}
