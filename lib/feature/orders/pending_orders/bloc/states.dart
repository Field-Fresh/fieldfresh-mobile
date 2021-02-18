import 'package:equatable/equatable.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';

abstract class PendingOrdersState extends Equatable {
  PendingOrdersState([List props = const []]) : super(props);
}

class Empty extends PendingOrdersState {
  @override
  String toString() {
    return "Empty";
  }
}

class Loading extends PendingOrdersState {
  final Side side;
  final String proxyId;

  Loading(this.side, this.proxyId) : super([side, proxyId]);

  @override
  String toString() {
    return "Loading";
  }
}

class Loaded extends PendingOrdersState {
  final Side side;
  final String proxyId;
  final List<PendingOrderItemData> pendingOrders;

  Loaded(this.side, this.proxyId, this.pendingOrders)
      : super([side, proxyId, pendingOrders]);

  @override
  String toString() {
    return "Loaded";
  }
}

class PendingOrderItemData {
  final Product product;
  final double volume;
  final String units;
  final double unitPrice;
  final Side side;

  PendingOrderItemData(
      this.product, this.volume, this.units, this.unitPrice, this.side);
}
