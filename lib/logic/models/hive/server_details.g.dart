// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServerHostingDetailsAdapter extends TypeAdapter<ServerHostingDetails> {
  @override
  final int typeId = 2;

  @override
  ServerHostingDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServerHostingDetails(
      ip4: fields[0] as String,
      id: fields[1] as int,
      createTime: fields[3] as DateTime?,
      volume: fields[4] as ServerVolume,
      apiToken: fields[5] as String,
      provider: fields[6] == null
          ? ServerProvider.hetzner
          : fields[6] as ServerProvider,
      startTime: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ServerHostingDetails obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.ip4)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.createTime)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(4)
      ..write(obj.volume)
      ..writeByte(5)
      ..write(obj.apiToken)
      ..writeByte(6)
      ..write(obj.provider);
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

class ServerVolumeAdapter extends TypeAdapter<ServerVolume> {
  @override
  final int typeId = 5;

  @override
  ServerVolume read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServerVolume(
      id: fields[1] as int,
      name: fields[2] as String,
      sizeByte: fields[3] == null ? 10737418240 : fields[3] as int,
      serverId: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ServerVolume obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.sizeByte)
      ..writeByte(4)
      ..write(obj.serverId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerVolumeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ServerProviderAdapter extends TypeAdapter<ServerProvider> {
  @override
  final int typeId = 101;

  @override
  ServerProvider read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ServerProvider.unknown;
      case 1:
        return ServerProvider.hetzner;
      default:
        return ServerProvider.unknown;
    }
  }

  @override
  void write(BinaryWriter writer, ServerProvider obj) {
    switch (obj) {
      case ServerProvider.unknown:
        writer.writeByte(0);
        break;
      case ServerProvider.hetzner:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerProviderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
