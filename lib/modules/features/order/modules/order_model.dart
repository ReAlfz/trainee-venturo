import 'dart:developer';

import 'package:trainee/modules/global_models/menu_model.dart';

class OrderModel {
  int idOrder;
  String noStruk;
  String nama;
  int totalBayar;
  DateTime tanggal;
  int status;
  List<MenuModel> menu;

  OrderModel({
    required this.idOrder,
    required this.noStruk,
    required this.nama,
    required this.totalBayar,
    required this.tanggal,
    required this.status,
    required this.menu,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    try {
      return OrderModel(
        idOrder: json["id_order"],
        noStruk: json["no_struk"],
        nama: json["nama"],
        totalBayar: json["total_bayar"],
        tanggal: DateTime.parse(json["tanggal"]),
        status: json["status"],
        menu: List<MenuModel>.from(json["menu"].map((x) => MenuModel.fromJson(x))),
      );
    } catch (e, stacktrace) {
      log('Error parsing checkout from JSON: $e', name: 'PARSING JSON');
      log('Stack checkout trace: $stacktrace', name: 'PARSING JSON');
      rethrow;
    }
  }
}