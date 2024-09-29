import 'dart:developer';

class MenuModel {
  final int idMenu;
  final String nama;
  final String kategori;
  final int harga;
  final String foto;

  final int status;
  final String deskripsi;
  List<int> topping;
  int level;
  int jumlah;
  int total;
  String catatan;

  MenuModel({
    required this.idMenu,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.foto,

    required this.status,
    required this.deskripsi,
    required this.topping,
    required this.level,
    required this.jumlah,
    required this.total,
    required this.catatan,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    try {
      return MenuModel(
        idMenu: json['id_menu'] ?? 0,
        nama: json['nama'] ?? '',
        kategori: json['kategori'] ?? '',
        harga: json['harga'] is String ? int.parse(json['harga']) : json['harga'],
        foto: json['foto'] ?? '',
        status: json['status'] ?? 1,
        deskripsi: json['deskripsi'] ?? '',
        topping: json['topping'] ?? [],
        level: json['level'] ?? 1,
        jumlah: json['jumlah'] ?? 0,
        total: json['total'] ?? 0,
        catatan: json['catatan'] ?? '',
      );
    } catch (e, stacktrace) {
      log('Error parsing MenuItems from JSON: $e', name: 'PARSING JSON');
      log('Stack MenuItems trace: $stacktrace', name: 'PARSING JSON');
      rethrow;
    }
  }
}