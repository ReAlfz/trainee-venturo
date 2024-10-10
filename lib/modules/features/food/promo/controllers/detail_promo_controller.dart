import 'package:get/get.dart';
import 'package:trainee/modules/features/food/promo/models/detail_promo_model.dart';
import 'package:trainee/modules/features/food/promo/repositories/promo_repository.dart';
import 'package:trainee/modules/features/home/controllers/home_controller.dart';

class DetailPromoController extends GetxController {
  static DetailPromoController get to => Get.find();

  late PromoRepository repository;
  RxString promoState = 'loading'.obs;
  Rxn<DetailPromoModel> promo = Rxn<DetailPromoModel>();
  RxString foto = ''.obs;

  void backPromo() => HomeController.to.foodKey!.currentState!.pop();

  @override
  void onInit() async {
    repository = PromoRepository();
    int idPromo = Get.arguments;
    promo(await repository.fetchPromoFromApi(idPromo));
    foto(promo.value!.foto);
    promoState('success');
    super.onInit();
  }
}