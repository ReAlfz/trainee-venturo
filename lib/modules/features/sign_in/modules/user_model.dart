import 'dart:developer';
import 'package:trainee/modules/features/sign_in/modules/akses_model.dart';

class UserModel {
  int idUser;
  String email;
  String nama;
  String pin;
  String foto;
  int mRolesId;
  int isGoogle;
  int isCustomer;
  String roles;
  Akses akses;

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
    required this.akses,
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
        akses: Akses.fromJson(json["akses"]),
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
    "akses": akses.toJson(),
  };
}