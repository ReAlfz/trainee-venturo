// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      idUser: fields[0] as int,
      email: fields[1] as String,
      nama: fields[2] as String,
      pin: fields[3] as String,
      foto: fields[4] as String,
      mRolesId: fields[5] as int,
      isGoogle: fields[6] as int,
      isCustomer: fields[7] as int,
      roles: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.idUser)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.nama)
      ..writeByte(3)
      ..write(obj.pin)
      ..writeByte(4)
      ..write(obj.foto)
      ..writeByte(5)
      ..write(obj.mRolesId)
      ..writeByte(6)
      ..write(obj.isGoogle)
      ..writeByte(7)
      ..write(obj.isCustomer)
      ..writeByte(8)
      ..write(obj.roles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
