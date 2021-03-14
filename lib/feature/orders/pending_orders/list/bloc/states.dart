import 'package:equatable/equatable.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';

abstract class PendingOrdersState extends Equatable {
  final Side side;

  PendingOrdersState(this.side, [List props = const []]) : super(props);
}

class Empty extends PendingOrdersState {
  Empty() : super(null);

  @override
  String toString() {
    return "Empty";
  }
}

class Loading extends PendingOrdersState {
  Loading(side) : super(side, [side]);

  @override
  String toString() {
    return "Loading";
  }
}

class Loaded extends PendingOrdersState {
  final String proxyId;
  final List<PendingOrderItemData> pendingOrders;

  Loaded(side, this.proxyId, this.pendingOrders)
      : super(side, [side, proxyId, pendingOrders]);

  @override
  String toString() {
    return "Loaded";
  }
}

class Error extends PendingOrdersState {
  final String proxyId;

  Error(side, this.proxyId) : super(side, [side, proxyId]);

  @override
  String toString() {
    return "Error";
  }
}

class PendingOrderItemData {
  final Product product;
  final double volume;
  final String units;
  final double unitPrice;
  final Side side;
  final String id;

  PendingOrderItemData(this.product, this.volume, this.units, this.unitPrice,
      this.side, this.id);
}
