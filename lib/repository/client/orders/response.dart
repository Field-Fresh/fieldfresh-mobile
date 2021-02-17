import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/order/order.dart';

class OrdersGetResponse {
  final List<Order> orders;
  final int count;

  OrdersGetResponse({this.orders, this.count});

  static OrdersGetResponse fromJson(Map<String, dynamic> json) {
    return OrdersGetResponse(
        orders: (json['orders'] as List).map((e) => Order.fromJson(e)).toList(),
        count: json['count']);
  }
}


class BuyOrderCreatedResponse {
  final BuyOrder buyOrder;

  BuyOrderCreatedResponse({this.buyOrder});

  static OrdersGetResponse fromJson(Map<String, dynamic> json) {
    return OrdersGetResponse(
        orders: (json['orders'] as List).map((e) => Order.fromJson(e)).toList(),
        count: json['count']);
  }
}
