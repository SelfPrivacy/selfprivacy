// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_credentials.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BearerTokenCredentialAdapter extends TypeAdapter<BearerTokenCredential> {
  @override
  final typeId = 11;

  @override
  BearerTokenCredential read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BearerTokenCredential(token: fields[0] as String);
  }

  @override
  void write(BinaryWriter writer, BearerTokenCredential obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BearerTokenCredentialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
