import 'dart:developer';

import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  int idUser;

  @HiveField(1)
  String email;

  @HiveField(2)
  String nama;

  @HiveField(3)
  String pin;

  @HiveField(4)
  String foto;

  @HiveField(5)
  int mRolesId;

  @HiveField(6)
  int isGoogle;

  @HiveField(7)
  int isCustomer;

  @HiveField(8)
  String roles;

  UserModel({
    required this.idUser,
    required this.email,
    required this.nama,
    required this.pin,
    required this.foto,
    required this.mRolesId,
    required this.isGoogle,
    required this.isCustomer,
    required this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      return UserModel(
        idUser: json["id_user"],
        email: json["email"],
        nama: json["nama"],
        pin: json["pin"],
        foto: json["foto"],
        mRolesId: json["m_roles_id"],
        isGoogle: json["is_google"],
        isCustomer: json["is_customer"],
        roles: json["roles"],
      );
    } catch (e, stacktrace) {
      log('Error parsing user from JSON: $e', name: 'PARSING JSON');
      log('Stack user trace: $stacktrace', name: 'PARSING JSON');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "email": email,
    "nama": nama,
    "pin": pin,
    "foto": foto,
    "m_roles_id": mRolesId,
    "is_google": isGoogle,
    "is_customer": isCustomer,
    "roles": roles,
  };
}