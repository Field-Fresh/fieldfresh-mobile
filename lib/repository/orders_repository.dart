import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/repository/client/orders/order_client.dart';
import 'package:fieldfreshmobile/repository/client/orders/requests.dart';
import 'package:fieldfreshmobile/repository/client/orders/response.dart';


class OrderRepository {
  final OrderClient _orderClient;

  OrderRepository(this._orderClient);

  Future<OrdersGetResponse> getOrders(OrdersGetRequest request) {
    return _orderClient.getOrders(request);
  }

  Future<List<BuyOrder>> getBuyOrdersFor(Side side, String proxyId) async {
    return [];
  }

  Future<List<SellOrder>> getSellOrdersFor(Side side, String proxyId) async {
    return [];
  }

  Future<BuyOrder> createBuyOrder(BuyOrder buyOrder) {
    return _orderClient.createBuyOrder(buyOrder);
  }



}
