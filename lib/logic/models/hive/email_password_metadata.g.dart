// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_password_metadata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmailPasswordMetadataAdapter extends TypeAdapter<EmailPasswordMetadata> {
  @override
  final typeId = 10;

  @override
  EmailPasswordMetadata read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmailPasswordMetadata(
      uuid: fields[0] as String,
      displayName: fields[1] as String,
      createdAt: fields[2] as DateTime?,
      expiresAt: fields[3] as DateTime?,
      lastUsed: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, EmailPasswordMetadata obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.displayName)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.expiresAt)
      ..writeByte(4)
      ..write(obj.lastUsed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailPasswordMetadataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
