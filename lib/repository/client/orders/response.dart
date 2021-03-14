import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/order/match.dart';
import 'package:fieldfreshmobile/models/api/order/order.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';

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

class SellOrderDetailsResponse {
  final SellProduct sellOrder;
  final List<Match> matches;

  SellOrderDetailsResponse({this.sellOrder, this.matches});

  static SellOrderDetailsResponse fromJson(Map<String, dynamic> json) {
    return SellOrderDetailsResponse(
        sellOrder: SellProduct.fromJson(json['order']),
        matches:
            (json['matches'] as List).map((e) => Match.fromJson(e)).toList());
  }
}

class BuyOrderDetailsResponse {
  final BuyProduct buyProduct;
  final List<Match> matches;

  BuyOrderDetailsResponse({this.buyProduct, this.matches});

  static BuyOrderDetailsResponse fromJson(Map<String, dynamic> json) {
    return BuyOrderDetailsResponse(
        buyProduct: BuyProduct.fromJson(json['order']),
        matches:
        (json['matches'] as List).map((e) => Match.fromJson(e)).toList());
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
