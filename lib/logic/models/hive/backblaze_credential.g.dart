// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backblaze_credential.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BackblazeCredentialAdapter extends TypeAdapter<BackblazeCredential> {
  @override
  final int typeId = 4;

  @override
  BackblazeCredential read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BackblazeCredential(
      keyId: fields[0] as String,
      applicationKey: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BackblazeCredential obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.keyId)
      ..writeByte(1)
      ..write(obj.applicationKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BackblazeCredentialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
