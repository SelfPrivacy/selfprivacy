// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HetznerServerDetailsAdapter extends TypeAdapter<ServerHostingDetails> {
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
      dataBase: fields[4] as ServerVolume,
      apiToken: fields[5] as String,
      startTime: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ServerHostingDetails obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.ip4)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.createTime)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(4)
      ..write(obj.dataBase)
      ..writeByte(5)
      ..write(obj.apiToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HetznerServerDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HetznerDataBaseAdapter extends TypeAdapter<ServerVolume> {
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
    );
  }

  @override
  void write(BinaryWriter writer, ServerVolume obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HetznerDataBaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
