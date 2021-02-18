import 'package:fieldfreshmobile/feature/products/pending/bloc/pending_product_event.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';

class ProductSelected extends PendingProductEvent {
  final String productId;
  final Side side;

  ProductSelected(this.productId, this.side) : super([productId, side]);

  @override
  String toString() => 'ProductSelected';
}

class LoadPendingProducts extends PendingProductEvent {
  final Side side;

  LoadPendingProducts(this.side) : super([]);

  @override
  String toString() => 'LoadPendingProducts';
}

class ViewAllPendingProducts extends PendingProductEvent {
  final Side side;

  ViewAllPendingProducts(this.side) : super([side]);

  @override
  String toString() => 'ViewAllPendingProducts';
}