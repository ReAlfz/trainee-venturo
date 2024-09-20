import 'package:trainee/modules/features/list/modules/menu_item.dart';

class PaginatedData<T> {
  final List<MenuItems> data;
  final bool? next;
  final bool? previous;

  PaginatedData({
    required this.data,
    this.next,
    this.previous
  });
}