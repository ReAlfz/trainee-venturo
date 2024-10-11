import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trainee/modules/features/chekout/repositories/voucher_detail_repository.dart';

import '../modules/voucher_detail_model.dart';

class VoucherDetailController extends GetxController {
  static VoucherDetailController get to => Get.find();

  RxString voucherState = 'loading'.obs;
  RxString foto = ''.obs;
  Rxn<VoucherDetailModel> voucherData = Rxn<VoucherDetailModel>();
  RxString date = ''.obs;
  late VoucherDetailRepository repository;

  @override
  void onInit() async {
    int idVoucher = Get.arguments;
    repository = VoucherDetailRepository();
    voucherData(await repository.fetchDataFromApi(idVoucher: idVoucher));
    foto(voucherData.value!.infoVoucher);
    date(parseIntDate(
      start: voucherData.value!.periodeMulai,
      end: voucherData.value!.periodeSelesai,
    ));
    voucherState('success');
    super.onInit();
  }

  String parseIntDate({required int start, required int end}) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime startDate = DateTime.fromMillisecondsSinceEpoch(start * 1000);
    DateTime endDate = DateTime.fromMillisecondsSinceEpoch(end * 1000);
    return '${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}';
  }
}
