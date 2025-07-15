// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backups_credential.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BackupsCredentialAdapter extends TypeAdapter<BackupsCredential> {
  @override
  final typeId = 4;

  @override
  BackupsCredential read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BackupsCredential(
      keyId: fields[0] as String,
      applicationKey: fields[1] as String,
      provider:
          fields[2] == null
              ? BackupsProviderType.backblaze
              : fields[2] as BackupsProviderType,
    );
  }

  @override
  void write(BinaryWriter writer, BackupsCredential obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.keyId)
      ..writeByte(1)
      ..write(obj.applicationKey)
      ..writeByte(2)
      ..write(obj.provider);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BackupsCredentialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BackupsProviderTypeAdapter extends TypeAdapter<BackupsProviderType> {
  @override
  final typeId = 103;

  @override
  BackupsProviderType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BackupsProviderType.none;
      case 1:
        return BackupsProviderType.memory;
      case 2:
        return BackupsProviderType.file;
      case 3:
        return BackupsProviderType.backblaze;
      default:
        return BackupsProviderType.none;
    }
  }

  @override
  void write(BinaryWriter writer, BackupsProviderType obj) {
    switch (obj) {
      case BackupsProviderType.none:
        writer.writeByte(0);
      case BackupsProviderType.memory:
        writer.writeByte(1);
      case BackupsProviderType.file:
        writer.writeByte(2);
      case BackupsProviderType.backblaze:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BackupsProviderTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
