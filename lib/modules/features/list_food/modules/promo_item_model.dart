import 'dart:developer';

class PromoModel {
  int idPromo;
  String nama;
  String type;
  int? diskon;
  int nominal;
  int? kadaluarsa;
  String syaratKetentuan;
  String foto;
  int createdAt;
  int createdBy;
  int isDeleted;

  PromoModel({
    required this.idPromo,
    required this.nama,
    required this.type,
    required this.diskon,
    required this.nominal,
    required this.kadaluarsa,
    required this.syaratKetentuan,
    required this.foto,
    required this.createdAt,
    required this.createdBy,
    required this.isDeleted,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) {
    try {
      return PromoModel(
        idPromo: json["id_promo"],
        nama: json["nama"],
        type: json["type"],
        diskon: json["diskon"],
        nominal: json["nominal"],
        kadaluarsa: json["kadaluarsa"],
        syaratKetentuan: json["syarat_ketentuan"],
        foto: json["foto"] ?? 'https://javacode.landa.id/img/promo/gambar_62661b52223ff.png',
        createdAt: json["created_at"],
        createdBy: json["created_by"],
        isDeleted: json["is_deleted"],
      );
    } catch (e, stacktrace) {
      log('Error parsing Promo from JSON: $e', name: 'PARSING JSON');
      log('Stack Promo trace: $stacktrace', name: 'PARSING JSON');
      rethrow;
    }
  }
}