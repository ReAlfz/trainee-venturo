import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/chekout/modules/voucher_model.dart';
import 'package:trainee/modules/features/chekout/repositories/voucher_repository.dart';

class VoucherController extends GetxController {
  static VoucherController get to => Get.find();

  late VoucherRepository repository;
  RxList<VoucherModel> list = RxList<VoucherModel>([]);
  Rxn<int> selectedIndex = Rxn<int>();

  @override
  void onInit() async {
    repository = VoucherRepository();
    list(await repository.fetchVoucherFromApi());
    super.onInit();
  }

  void onBack() {
    if (selectedIndex.value != null) Get.back(result: list[selectedIndex.value!]);
  }

  void pushDetail({required VoucherModel voucher}) {
    int idVoucher = voucher.idVoucher;
    Get.toNamed(MainRoute.voucherDetail, arguments: idVoucher);
  }
}