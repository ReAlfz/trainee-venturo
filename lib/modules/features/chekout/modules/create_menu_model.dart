class CreateMenuModel {
  int idMenu;
  int harga;
  int level;
  List<int> topping;
  int jumlah;

  CreateMenuModel({
    required this.idMenu,
    required this.harga,
    required this.level,
    required this.topping,
    required this.jumlah,
  });

  factory CreateMenuModel.fromJson(Map<String, dynamic> json) => CreateMenuModel(
    idMenu: json["id_menu"],
    harga: json["harga"],
    level: json["level"],
    topping: List<int>.from(json["topping"].map((x) => x)),
    jumlah: json["jumlah"],
  );

  Map<String, dynamic> toJson() => {
    "id_menu": idMenu,
    "harga": harga,
    "level": level,
    "topping": List<dynamic>.from(topping.map((x) => x)),
    "jumlah": jumlah,
  };
}