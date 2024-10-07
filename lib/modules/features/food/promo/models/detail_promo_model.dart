class DetailPromoModel {
  final int idPromo;
  final String nama;
  final String type;
  dynamic diskon;
  final int nominal;
  final int kadaluarsa;
  final String syaratKetentuan;
  final String foto;
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

  factory DetailPromoModel.fromJson(Map<String, dynamic> json) => DetailPromoModel(
        idPromo: json["id_promo"],
        nama: json["nama"],
        type: json["type"],
        diskon: json["diskon"],
        nominal: json["nominal"],
        kadaluarsa: json["kadaluarsa"],
        syaratKetentuan: json["syarat_ketentuan"],
        foto: json["foto"],
        createdAt: json["created_at"],
        createdBy: json["created_by"],
        isDeleted: json["is_deleted"],
      );

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
