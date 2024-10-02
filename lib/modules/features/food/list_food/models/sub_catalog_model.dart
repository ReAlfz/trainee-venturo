class SubCatalogModel {
  int idDetail;
  int idMenu;
  String keterangan;
  String type;
  int harga;

  SubCatalogModel({
    required this.idDetail,
    required this.idMenu,
    required this.keterangan,
    required this.type,
    required this.harga,
  });

  factory SubCatalogModel.fromJson(Map<String, dynamic> json) => SubCatalogModel(
    idDetail: json["id_detail"],
    idMenu: json["id_menu"],
    keterangan: json["keterangan"],
    type: json["type"],
    harga: json["harga"],
  );
}