import 'package:equatable/equatable.dart';
import 'package:fieldfreshmobile/feature/orders/matched_orders/ui/matched_order_view.dart';
import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/order/match.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';

abstract class MatchedOrdersState extends Equatable {
  final Side side;

  MatchedOrdersState(this.side, [List props = const []]) : super(props);
}

class Empty extends MatchedOrdersState {
  final Side side;

  Empty(this.side) : super(side);

  @override
  String toString() {
    return "Empty";
  }
}

class Loading extends MatchedOrdersState {
  final Side side;

  Loading(this.side) : super(side);

  @override
  String toString() {
    return "Loading";
  }
}

class Loaded extends MatchedOrdersState {
  final Side side;
  final List<MatchedOrderItemData> items;

  Loaded(this.side, this.items) : super(side, items);

  @override
  String toString() {
    return "Loaded";
  }
}

class Error extends MatchedOrdersState {
  final Side side;

  Error(this.side) : super(side);

  @override
  String toString() {
    return "Error";
  }
}
