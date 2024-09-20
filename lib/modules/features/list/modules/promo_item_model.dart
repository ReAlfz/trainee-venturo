class Promo {
  int idPromo;
  String nama;
  String type;
  int diskon;
  int nominal;
  dynamic kadaluarsa;
  String syaratKetentuan;
  dynamic foto;
  int createdAt;
  int createdBy;
  int isDeleted;

  Promo({
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

  factory Promo.fromJson(Map<String, dynamic> json) =>
      Promo(
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
}