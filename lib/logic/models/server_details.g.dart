// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HetznerServerDetailsAdapter extends TypeAdapter<HetznerServerDetails> {
  @override
  final int typeId = 2;

  @override
  HetznerServerDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HetznerServerDetails(
      ip4: fields[0] as String?,
      id: fields[1] as int?,
      createTime: fields[3] as DateTime?,
      startTime: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, HetznerServerDetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.ip4)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.createTime)
      ..writeByte(2)
      ..write(obj.startTime);
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
