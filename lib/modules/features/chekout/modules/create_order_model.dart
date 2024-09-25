class CreateOrderModel {
  int idUser;
  int idVoucher;
  int potongan;
  int totalBayar;

  CreateOrderModel({
    required this.idUser,
    required this.idVoucher,
    required this.potongan,
    required this.totalBayar,
  });

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) => CreateOrderModel(
    idUser: json["id_user"],
    idVoucher: json["id_voucher"],
    potongan: json["potongan"],
    totalBayar: json["total_bayar"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "id_voucher": idVoucher,
    "potongan": potongan,
    "total_bayar": totalBayar,
  };
}