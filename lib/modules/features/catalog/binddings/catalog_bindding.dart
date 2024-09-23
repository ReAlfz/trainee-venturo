import 'package:get/get.dart';
import 'package:trainee/modules/features/catalog/controllers/catalog_controller.dart';

class CatalogBindding extends Bindings {
  @override
  void dependencies() {
    Get.put(CatalogController());
  }
}