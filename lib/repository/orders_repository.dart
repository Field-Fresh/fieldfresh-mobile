import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
<<<<<<< Updated upstream
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/order/status_type.dart';
=======
>>>>>>> Stashed changes
import 'package:fieldfreshmobile/repository/client/orders/order_client.dart';
import 'package:fieldfreshmobile/repository/client/orders/requests.dart';
import 'package:fieldfreshmobile/repository/client/orders/response.dart';

class OrderRepository {
  final OrderClient _orderClient;

  OrderRepository(this._orderClient);

  Future<OrdersGetResponse> getOrders(OrdersGetRequest request) {
    return _orderClient.getOrders(request);
  }

  Future<List<BuyProduct>> getBuyOrdersFor(Status status, String proxyId) {
    return _orderClient.getBuyProducts(status, proxyId);
  }

  Future<List<SellProduct>> getSellOrdersFor(Status status, String proxyId) {
    return _orderClient.getSellProducts(status, proxyId);
  }

  Future<BuyOrder> createBuyOrder(BuyOrder buyOrder) {
    return _orderClient.createBuyOrder(buyOrder);
  }
<<<<<<< Updated upstream
=======

  Future<SellOrder> createSellOrder(SellOrder sellOrder) {
    return _orderClient.createSellOrder(sellOrder);
  }

>>>>>>> Stashed changes
}
