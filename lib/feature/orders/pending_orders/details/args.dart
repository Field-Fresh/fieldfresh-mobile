
import 'package:fieldfreshmobile/models/api/order/side_type.dart';

class PendingOrderDetailsArguments {
  final String orderId;
  final Side side;

  PendingOrderDetailsArguments(this.orderId, this.side);
}