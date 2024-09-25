import 'package:trainee/modules/global_models/menu_model.dart';

class PaginatedData<T> {
  final List<MenuModel> data;
  final bool? next;
  final bool? previous;

  PaginatedData({
    required this.data,
    this.next,
    this.previous
  });
}