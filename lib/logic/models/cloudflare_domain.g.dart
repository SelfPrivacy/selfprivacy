// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloudflare_domain.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CloudFlareDomainAdapter extends TypeAdapter<CloudFlareDomain> {
  @override
  final int typeId = 3;

  @override
  CloudFlareDomain read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CloudFlareDomain(
      domainName: fields[0] as String?,
      zoneId: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CloudFlareDomain obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.domainName)
      ..writeByte(1)
      ..write(obj.zoneId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CloudFlareDomainAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
