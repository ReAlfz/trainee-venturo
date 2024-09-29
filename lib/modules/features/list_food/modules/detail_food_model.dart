import 'dart:developer';

import 'package:trainee/modules/features/list_food/modules/detail_menu_model.dart';
import 'package:trainee/modules/features/list_food/modules/sub_catalog_model.dart';

class DetailFoodModel {
  final DetailMenuModel menu;
  final List<SubCatalogModel> topping;
  final List<SubCatalogModel> level;

  DetailFoodModel({
    required this.menu,
    required this.level,
    required this.topping,
  });

  factory DetailFoodModel.fromJson(Map<String, dynamic> json) {
    try {
      return DetailFoodModel(
        menu: DetailMenuModel.fromJson(json['menu']),
        level: List<SubCatalogModel>.from(json['level'].map((x) => SubCatalogModel.fromJson(x))),
        topping: List<SubCatalogModel>.from(json['topping'].map((x) => SubCatalogModel.fromJson(x))),
      );

    } catch (e, stacktrace) {
      log('Error parsing Catalog from JSON: $e', name: 'PARSING JSON');
      log('Stack Catalog trace: $stacktrace', name: 'PARSING JSON');
      rethrow;
    }
  }
}