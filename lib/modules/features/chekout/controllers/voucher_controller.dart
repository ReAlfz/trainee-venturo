import 'package:get/get.dart';
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
}