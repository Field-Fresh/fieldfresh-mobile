import 'package:fieldfreshmobile/feature/home/bloc/side_type.dart';
import 'package:fieldfreshmobile/repository/client/orders/order_client.dart';
import 'package:fieldfreshmobile/repository/client/orders/requests.dart';
import 'package:fieldfreshmobile/repository/client/orders/response.dart';
import 'package:fieldfreshmobile/repository/client/product/product_client.dart';
import 'package:fieldfreshmobile/repository/client/product/response.dart';

class OrderRepository {
  final OrderClient _orderClient;

  OrderRepository(this._orderClient);

  Future<OrdersGetResponse> getOrders(OrdersGetRequest request) {
    return _orderClient.getOrders(request);
  }
}
