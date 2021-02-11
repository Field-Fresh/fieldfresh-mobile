import 'package:fieldfreshmobile/feature/home/bloc/side_type.dart';
import 'package:fieldfreshmobile/models/api/order/status_type.dart';

class OrdersGetRequest {
  final Side side;
  final Status status;

  OrdersGetRequest(this.side, this.status);
}