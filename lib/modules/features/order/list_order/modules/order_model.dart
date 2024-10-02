import 'dart:developer';

import 'package:trainee/modules/global_models/menu_model.dart';

class OrderModel {
  int idOrder;
  String noStruk;

  String nama;
  int totalBayar;
  String tanggal;
  int status;

  int idVocher;
  String namaVocher;
  int diskon;
  int potongan;


  List<MenuModel> menu;

  OrderModel({
    required this.idOrder,
    required this.noStruk,
    required this.nama,
    required this.totalBayar,
    required this.tanggal,
    required this.status,
    required this.menu,
    required this.diskon,
    required this.idVocher,
    required this.namaVocher,
    required this.potongan,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    try {
      return OrderModel(
        idOrder: json["id_order"],
        noStruk: json["no_struk"],
        nama: json["nama"],
        totalBayar: json["total_bayar"],
        tanggal: json["tanggal"],
        status: json["status"],
        menu: List<MenuModel>.from(json["menu"].map((x) => MenuModel.fromJson(x))),

        diskon: json['diskon'] ?? 0,
        idVocher: json['id_voucher'] ?? 0,
        namaVocher: json['nama_voucher'] ?? '',
        potongan: json['potongan'] ?? 0,
      );
    } catch (e, stacktrace) {
      log('Error parsing checkout from JSON: $e', name: 'PARSING JSON');
      log('Stack checkout trace: $stacktrace', name: 'PARSING JSON');
      rethrow;
    }
  }

  factory OrderModel.customJson(Map<String, dynamic> json, List<MenuModel> list) {
    return OrderModel(
      idOrder: json["id_order"],
      noStruk: json["no_struk"],
      nama: json["nama"],
      totalBayar: json["total_bayar"],
      tanggal: json["tanggal"],
      status: json["status"],
      menu: list,

      diskon: json['diskon'] ?? 0,
      idVocher: json['id_voucher'] ?? 0,
      namaVocher: json['nama_voucher'] ?? '',
      potongan: json['potongan'] ?? 0,
    );
  }
}