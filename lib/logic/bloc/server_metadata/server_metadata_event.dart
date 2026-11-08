part of 'server_metadata_bloc.dart';

sealed class ServerMetadataEvent {
  const ServerMetadataEvent();
}

class ServerMetadataRequested extends ServerMetadataEvent {
  const ServerMetadataRequested();
}

class _MetadataDetached extends ServerMetadataEvent {
  const _MetadataDetached();
}
