// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      login: fields[0] as String,
      password: fields[1] as String?,
      sshKeys: fields[2] == null ? [] : (fields[2] as List).cast<String>(),
      isFoundOnServer: fields[3] == null ? true : fields[3] as bool,
      note: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.login)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.sshKeys)
      ..writeByte(3)
      ..write(obj.isFoundOnServer)
      ..writeByte(4)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
