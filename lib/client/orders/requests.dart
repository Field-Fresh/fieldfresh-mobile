import 'package:fieldfreshmobile/models/api/order/status_type.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';

class OrdersGetRequest {
  final Side side;
  final Status status;

  OrdersGetRequest(this.side, this.status);
}