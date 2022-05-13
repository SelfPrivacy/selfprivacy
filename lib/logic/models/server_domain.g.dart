// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_domain.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServerDomainAdapter extends TypeAdapter<ServerDomain> {
  @override
  final int typeId = 3;

  @override
  ServerDomain read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServerDomain(
      domainName: fields[0] as String,
      zoneId: fields[1] as String,
      provider:
          fields[2] == null ? DnsProvider.Cloudflare : fields[2] as DnsProvider,
    );
  }

  @override
  void write(BinaryWriter writer, ServerDomain obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.domainName)
      ..writeByte(1)
      ..write(obj.zoneId)
      ..writeByte(2)
      ..write(obj.provider);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerDomainAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
