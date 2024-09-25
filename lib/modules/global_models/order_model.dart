class Order {
  int idVoucher;
  int potongan;
  int totalBayar;

  Order({
    required this.idVoucher,
    required this.potongan,
    required this.totalBayar,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    idVoucher: json["id_voucher"],
    potongan: json["potongan"],
    totalBayar: json["total_bayar"],
  );

  Map<String, dynamic> toJson() => {
    "id_voucher": idVoucher,
    "potongan": potongan,
    "total_bayar": totalBayar,
  };
}