import 'package:equatable/equatable.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';

abstract class SellOrderCreationState extends Equatable {
  SellOrderCreationState([List props = const []]) : super(props);
}

class SellOrderCreationStep extends SellOrderCreationState {
  final int step;

  final Product product;

  SellOrderCreationStep(this.step, {this.product}): super([step, product]);
  @override
  String toString() => 'SellOrderCreationStep';
}

class SellOrderCreating extends SellOrderCreationState {
  final SellOrder _SellOrder;

  SellOrderCreating(this._SellOrder): super([_SellOrder]);

  @override
  String toString() => 'SellOrderCreating';
}

class SellOrderCreated extends SellOrderCreationState {
  final SellOrder _SellOrder;

  SellOrderCreated(this._SellOrder): super([_SellOrder]);

  @override
  String toString() => 'SellOrderCreated';
}