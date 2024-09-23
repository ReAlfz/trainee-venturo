import 'dart:developer';

import 'package:trainee/modules/features/catalog/modules/sub_catalog_model.dart';
import 'package:trainee/modules/features/home/modules/menu_item_model.dart';

class CatalogModel {
  final MenuItemsModel menu;
  final List<SubCatalogModel> topping;
  final List<SubCatalogModel> level;

  CatalogModel({
    required this.menu,
    required this.level,
    required this.topping,
  });

  factory CatalogModel.fromJson(Map<String, dynamic> json) {
    try {
      return CatalogModel(
        menu: MenuItemsModel.fromJson(json['menu']),
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