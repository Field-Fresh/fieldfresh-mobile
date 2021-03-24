import 'package:fieldfreshmobile/client/orders/order_client.dart';
import 'package:fieldfreshmobile/client/orders/requests.dart';
import 'package:fieldfreshmobile/client/orders/response.dart';
import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/order/match.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/order/status_type.dart';

class OrderRepository {
  final OrderClient _orderClient;

  OrderRepository(this._orderClient);

  Future<OrdersGetResponse> getOrders(OrdersGetRequest request) {
    return _orderClient.getOrders(request);
  }

  Future<SellOrderDetailsResponse> getSellOrder(String id) {
    return _orderClient.getSellOrder(id);
  }

  Future<BuyOrderDetailsResponse> getBuyOrder(String id) {
    return _orderClient.getBuyOrder(id);
  }

  Future<List<Match>> getMatches(String proxyId, Side side) {
    return _orderClient.getMatches(proxyId, side);
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

  Future<SellOrder> createSellOrder(SellOrder sellOrder) {
    return _orderClient.createSellOrder(sellOrder);
  }

  Future<void> cancelSellOrder(String id) {
    return _orderClient.cancelSellOrder(id);
  }

  Future<void> cancelBuyOrder(String id) {
    return _orderClient.cancelBuyOrder(id);
  }

  Future<MatchOrderDetailsResponse> getMatchDetails(String id, String proxyId) {
    return _orderClient.getMatchDetails(id, proxyId);
  }

}
