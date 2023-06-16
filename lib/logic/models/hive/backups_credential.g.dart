// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backups_credential.dart';

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

class BackupsProviderAdapter extends TypeAdapter<BackupsProvider> {
  @override
  final int typeId = 103;

  @override
  BackupsProvider read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BackupsProvider.none;
      case 1:
        return BackupsProvider.memory;
      case 2:
        return BackupsProvider.file;
      case 3:
        return BackupsProvider.backblaze;
      default:
        return BackupsProvider.none;
    }
  }

  @override
  void write(BinaryWriter writer, BackupsProvider obj) {
    switch (obj) {
      case BackupsProvider.none:
        writer.writeByte(0);
        break;
      case BackupsProvider.memory:
        writer.writeByte(1);
        break;
      case BackupsProvider.file:
        writer.writeByte(2);
        break;
      case BackupsProvider.backblaze:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BackupsProviderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
