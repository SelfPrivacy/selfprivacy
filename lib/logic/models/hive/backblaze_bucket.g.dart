// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backblaze_bucket.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BackblazeBucketAdapter extends TypeAdapter<BackblazeBucket> {
  @override
  final typeId = 6;

  @override
  BackblazeBucket read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BackblazeBucket(
      bucketId: fields[0] as String,
      bucketName: fields[3] as String,
      applicationKeyId: fields[1] as String,
      applicationKey: fields[2] as String,
      encryptionKey: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BackblazeBucket obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.bucketId)
      ..writeByte(1)
      ..write(obj.applicationKeyId)
      ..writeByte(2)
      ..write(obj.applicationKey)
      ..writeByte(3)
      ..write(obj.bucketName)
      ..writeByte(4)
      ..write(obj.encryptionKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BackblazeBucketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
