import 'dart:developer';

class MenuItems {
  final int idMenu;
  final String nama;
  final String kategori;
  final int harga;
  final String deskripsi;
  final String foto;
  final int status;

  MenuItems({
    required this.idMenu,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.foto,
    required this.status,
  });

  factory MenuItems.fromJson(Map<String, dynamic> json) {
    try {
      return MenuItems(
        idMenu: json['id_menu'] ?? '',
        nama: json['nama'] ?? '',
        kategori: json['kategori'] ?? '',
        harga: json['harga'] ?? '',
        deskripsi: json['deskripsi'] ?? '',
        foto: json['foto'] ?? 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
        status: json['status'] ?? '',
      );
    } catch (e) {
      log('Error parsing MenuItems from JSON: $e', name: 'PARSING JSON');
      rethrow;
    }
  }
}