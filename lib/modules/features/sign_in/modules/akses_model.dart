class Akses {
  bool authUser;
  bool authAkses;
  bool settingMenu;
  bool settingCustomer;
  bool settingPromo;
  bool settingDiskon;
  bool settingVoucher;
  bool laporanMenu;
  bool laporanCustomer;

  Akses({
    required this.authUser,
    required this.authAkses,
    required this.settingMenu,
    required this.settingCustomer,
    required this.settingPromo,
    required this.settingDiskon,
    required this.settingVoucher,
    required this.laporanMenu,
    required this.laporanCustomer,
  });

  factory Akses.fromJson(Map<String, dynamic> json) => Akses(
    authUser: json["auth_user"],
    authAkses: json["auth_akses"],
    settingMenu: json["setting_menu"],
    settingCustomer: json["setting_customer"],
    settingPromo: json["setting_promo"],
    settingDiskon: json["setting_diskon"],
    settingVoucher: json["setting_voucher"],
    laporanMenu: json["laporan_menu"],
    laporanCustomer: json["laporan_customer"],
  );

  Map<String, dynamic> toJson() => {
    "auth_user": authUser,
    "auth_akses": authAkses,
    "setting_menu": settingMenu,
    "setting_customer": settingCustomer,
    "setting_promo": settingPromo,
    "setting_diskon": settingDiskon,
    "setting_voucher": settingVoucher,
    "laporan_menu": laporanMenu,
    "laporan_customer": laporanCustomer,
  };
}