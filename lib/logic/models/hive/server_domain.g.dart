// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_domain.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServerDomainAdapter extends TypeAdapter<ServerDomain> {
  @override
  final typeId = 3;

  @override
  ServerDomain read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServerDomain(
      domainName: fields[0] as String,
      provider:
          fields[2] == null
              ? DnsProviderType.cloudflare
              : fields[2] as DnsProviderType,
    );
  }

  @override
  void write(BinaryWriter writer, ServerDomain obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.domainName)
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

class DnsProviderTypeAdapter extends TypeAdapter<DnsProviderType> {
  @override
  final typeId = 100;

  @override
  DnsProviderType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DnsProviderType.unknown;
      case 1:
        return DnsProviderType.cloudflare;
      case 2:
        return DnsProviderType.desec;
      case 3:
        return DnsProviderType.digitalOcean;
      default:
        return DnsProviderType.unknown;
    }
  }

  @override
  void write(BinaryWriter writer, DnsProviderType obj) {
    switch (obj) {
      case DnsProviderType.unknown:
        writer.writeByte(0);
      case DnsProviderType.cloudflare:
        writer.writeByte(1);
      case DnsProviderType.desec:
        writer.writeByte(2);
      case DnsProviderType.digitalOcean:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DnsProviderTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
