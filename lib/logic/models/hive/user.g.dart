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
      type: fields[5] == null ? UserType.normal : fields[5] as UserType,
      password: fields[1] as String?,
      sshKeys: fields[2] == null ? [] : (fields[2] as List).cast<String>(),
      isFoundOnServer: fields[3] == null ? true : fields[3] as bool,
      note: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.login)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.sshKeys)
      ..writeByte(3)
      ..write(obj.isFoundOnServer)
      ..writeByte(4)
      ..write(obj.note)
      ..writeByte(5)
      ..write(obj.type);
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

class UserTypeAdapter extends TypeAdapter<UserType> {
  @override
  final int typeId = 102;

  @override
  UserType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserType.root;
      case 1:
        return UserType.primary;
      case 2:
        return UserType.normal;
      default:
        return UserType.root;
    }
  }

  @override
  void write(BinaryWriter writer, UserType obj) {
    switch (obj) {
      case UserType.root:
        writer.writeByte(0);
        break;
      case UserType.primary:
        writer.writeByte(1);
        break;
      case UserType.normal:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
