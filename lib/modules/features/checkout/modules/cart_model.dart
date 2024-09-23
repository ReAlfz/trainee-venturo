import 'dart:developer';

import 'package:trainee/modules/features/checkout/modules/cart_menu_model.dart';

class CartModel {
  int idOrder;
  String noStruk;
  String nama;
  int totalBayar;
  DateTime tanggal;
  int status;
  List<MenuCartModel> menu;

  CartModel({
    required this.idOrder,
    required this.noStruk,
    required this.nama,
    required this.totalBayar,
    required this.tanggal,
    required this.status,
    required this.menu,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    try {
      return CartModel(
        idOrder: json["id_order"],
        noStruk: json["no_struk"],
        nama: json["nama"],
        totalBayar: json["total_bayar"],
        tanggal: DateTime.parse(json["tanggal"]),
        status: json["status"],
        menu: List<MenuCartModel>.from(json["menu"].map((x) => MenuCartModel.fromJson(x))),
      );
    } catch (e, stacktrace) {
      log('Error parsing checkout from JSON: $e', name: 'PARSING JSON');
      log('Stack checkout trace: $stacktrace', name: 'PARSING JSON');
      rethrow;
    }
  }
}