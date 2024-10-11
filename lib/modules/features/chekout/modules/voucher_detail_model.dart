import 'dart:developer';

class VoucherDetailModel {
  int idVoucher;
  int idPromo;
  String nama;
  int idUser;
  int nominal;
  String infoVoucher;
  int periodeMulai;
  int periodeSelesai;
  int type;
  int status;
  String catatan;

  VoucherDetailModel({
    required this.idVoucher,
    required this.idPromo,
    required this.nama,
    required this.idUser,
    required this.nominal,
    required this.infoVoucher,
    required this.periodeMulai,
    required this.periodeSelesai,
    required this.type,
    required this.status,
    required this.catatan,
  });

  factory VoucherDetailModel.fromJson(Map<String, dynamic> json) {
    try {
      return VoucherDetailModel(
        idVoucher: json["id_voucher"],
        idPromo: json["id_promo"],
        nama: json["nama"],
        idUser: json["id_user"],
        nominal: json["nominal"],
        infoVoucher: json["info_voucher"],
        periodeMulai: json["periode_mulai"],
        periodeSelesai: json["periode_selesai"],
        type: json["type"],
        status: json["status"],
        catatan: json["catatan"],
      );
    } catch (e, stacktrace) {
      log('Error parsing voucherDetail from JSON: $e', name: 'PARSING JSON');
      log('Stack Promo trace: $stacktrace', name: 'PARSING JSON');
      rethrow;
    }
  }
}
