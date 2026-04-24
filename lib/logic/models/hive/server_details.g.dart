// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServerHostingDetailsAdapter extends TypeAdapter<ServerHostingDetails> {
  @override
  final typeId = 2;

  @override
  ServerHostingDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServerHostingDetails(
      ip4: fields[0] as String,
      id: (fields[1] as num).toInt(),
      createTime: fields[3] as DateTime?,
      volume: fields[4] as ServerProviderVolume,
      apiToken: fields[5] as String,
      provider:
          fields[6] == null
              ? ServerProviderType.hetzner
              : fields[6] as ServerProviderType,
      serverLocation: fields[7] as String?,
      serverType: fields[8] as String?,
      startTime: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ServerHostingDetails obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.ip4)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.createTime)
      ..writeByte(4)
      ..write(obj.volume)
      ..writeByte(5)
      ..write(obj.apiToken)
      ..writeByte(6)
      ..write(obj.provider)
      ..writeByte(7)
      ..write(obj.serverLocation)
      ..writeByte(8)
      ..write(obj.serverType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerHostingDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ServerProviderVolumeAdapter extends TypeAdapter<ServerProviderVolume> {
  @override
  final typeId = 5;

  @override
  ServerProviderVolume read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServerProviderVolume(
      id: (fields[1] as num).toInt(),
      name: fields[2] as String,
      sizeByte: fields[3] == null ? 10737418240 : (fields[3] as num).toInt(),
      serverId: (fields[4] as num?)?.toInt(),
      linuxDevice: fields[5] as String?,
      uuid: fields[6] as String?,
      location: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ServerProviderVolume obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.sizeByte)
      ..writeByte(4)
      ..write(obj.serverId)
      ..writeByte(5)
      ..write(obj.linuxDevice)
      ..writeByte(6)
      ..write(obj.uuid)
      ..writeByte(7)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerProviderVolumeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ServerProviderTypeAdapter extends TypeAdapter<ServerProviderType> {
  @override
  final typeId = 101;

  @override
  ServerProviderType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ServerProviderType.unknown;
      case 1:
        return ServerProviderType.hetzner;
      case 2:
        return ServerProviderType.digitalOcean;
      default:
        return ServerProviderType.unknown;
    }
  }

  @override
  void write(BinaryWriter writer, ServerProviderType obj) {
    switch (obj) {
      case ServerProviderType.unknown:
        writer.writeByte(0);
      case ServerProviderType.hetzner:
        writer.writeByte(1);
      case ServerProviderType.digitalOcean:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerProviderTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
