import 'package:trainee/modules/features/order/modules/order_model.dart';
import 'package:trainee/modules/global_models/menu_model.dart';

class PaginatedMenu<T> {
  final List<MenuModel> data;
  final bool? next;
  final bool? previous;

  PaginatedMenu({
    required this.data,
    this.next,
    this.previous
  });
}

class PaginatedOrder<T> {
  final List<OrderModel> data;
  final bool? next;
  final bool? previous;

  PaginatedOrder({
    required this.data,
    this.next,
    this.previous,
  });
}