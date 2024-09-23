import 'package:trainee/modules/features/home/modules/menu_item_model.dart';

class PaginatedData<T> {
  final List<MenuItemsModel> data;
  final bool? next;
  final bool? previous;

  PaginatedData({
    required this.data,
    this.next,
    this.previous
  });
}