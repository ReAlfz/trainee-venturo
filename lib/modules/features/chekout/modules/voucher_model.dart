class VoucherModel {
  int idVoucher;
  String nama;
  int idUser;
  String namaUser;
  int nominal;
  String infoVoucher;
  DateTime periodeMulai;
  DateTime periodeSelesai;
  int type;
  int status;
  String catatan;

  VoucherModel({
    required this.idVoucher,
    required this.nama,
    required this.idUser,
    required this.namaUser,
    required this.nominal,
    required this.infoVoucher,
    required this.periodeMulai,
    required this.periodeSelesai,
    required this.type,
    required this.status,
    required this.catatan,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) => VoucherModel(
        idVoucher: json["id_voucher"],
        nama: json["nama"],
        idUser: json["id_user"],
        namaUser: json["nama_user"],
        nominal: json["nominal"],
        infoVoucher: json["info_voucher"],
        periodeMulai: DateTime.parse(json["periode_mulai"]),
        periodeSelesai: DateTime.parse(json["periode_selesai"]),
        type: json["type"],
        status: json["status"],
        catatan: json["catatan"],
      );
}
