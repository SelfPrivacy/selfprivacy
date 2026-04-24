// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_provider_credential.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServerProviderCredentialAdapter
    extends TypeAdapter<ServerProviderCredential> {
  @override
  final typeId = 7;

  @override
  ServerProviderCredential read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServerProviderCredential(
      tokenId: fields[0] as String?,
      token: fields[1] as String,
      provider: fields[2] as ServerProviderType,
      associatedServerIds: (fields[3] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, ServerProviderCredential obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.tokenId)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.provider)
      ..writeByte(3)
      ..write(obj.associatedServerIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerProviderCredentialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
