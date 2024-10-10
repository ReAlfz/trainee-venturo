import 'dart:developer';

class DetailPromoModel {
  final int idPromo;
  final String nama;
  final String type;
  dynamic diskon;
  final int nominal;
  final int kadaluarsa;
  final String syaratKetentuan;
  String foto;
  final int createdAt;
  final int createdBy;
  final int isDeleted;

  DetailPromoModel({
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

  factory DetailPromoModel.fromJson(Map<String, dynamic> json) {
    try {
      return DetailPromoModel(
        idPromo: json["id_promo"],
        nama: json["nama"] ?? '',
        type: json["type"] ?? '',
        diskon: json["diskon"],
        nominal: json["nominal"] ?? 0,
        kadaluarsa: json["kadaluarsa"] ?? 0,
        syaratKetentuan: json["syarat_ketentuan"] ?? '',
        foto: json["foto"] ?? '',
        createdAt: json["created_at"] ?? 0,
        createdBy: json["created_by"] ?? 0,
        isDeleted: json["is_deleted"] ?? 0,
      );
    } catch (e, stacktrace) {
      log('Error parsing MenuItems from JSON: $e', name: 'PARSING JSON');
      log('Stack MenuItems trace: $stacktrace', name: 'PARSING JSON');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        "id_promo": idPromo,
        "nama": nama,
        "type": type,
        "diskon": diskon,
        "nominal": nominal,
        "kadaluarsa": kadaluarsa,
        "syarat_ketentuan": syaratKetentuan,
        "foto": foto,
        "created_at": createdAt,
        "created_by": createdBy,
        "is_deleted": isDeleted,
      };
}
