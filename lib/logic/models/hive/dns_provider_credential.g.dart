// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dns_provider_credential.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DnsProviderCredentialAdapter extends TypeAdapter<DnsProviderCredential> {
  @override
  final typeId = 8;

  @override
  DnsProviderCredential read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DnsProviderCredential(
      token: fields[1] as String,
      provider: fields[2] as DnsProviderType,
      associatedDomainNames: (fields[3] as List).cast<String>(),
      tokenId: fields[0] as String?,
      url: fields[4] as String?,
      tenant: fields[5] as String?,
      secondaryToken: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DnsProviderCredential obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.tokenId)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.provider)
      ..writeByte(3)
      ..write(obj.associatedDomainNames)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.tenant)
      ..writeByte(6)
      ..write(obj.secondaryToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DnsProviderCredentialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
