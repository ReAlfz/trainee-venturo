class MenuCartModel {
  int idMenu;
  String kategori;
  String topping;
  String nama;
  String foto;
  int jumlah;
  String harga;
  int total;
  String catatan;

  MenuCartModel({
    required this.idMenu,
    required this.kategori,
    required this.topping,
    required this.nama,
    required this.foto,
    required this.jumlah,
    required this.harga,
    required this.total,
    required this.catatan,
  });

  factory MenuCartModel.fromJson(Map<String, dynamic> json) =>
      MenuCartModel(
        idMenu: json["id_menu"],
        kategori: json["kategori"],
        topping: json["topping"],
        nama: json["nama"],
        foto: json["foto"],
        jumlah: json["jumlah"],
        harga: json["harga"],
        total: json["total"],
        catatan: json["catatan"],
      );
}