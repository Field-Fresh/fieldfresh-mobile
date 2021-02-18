import 'package:equatable/equatable.dart';
import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';

abstract class BuyOrderCreationState extends Equatable {
  BuyOrderCreationState([List props = const []]) : super(props);
}

class BuyOrderCreationStep extends BuyOrderCreationState {
  final int step;

  final Product product;

  BuyOrderCreationStep(this.step, {this.product}): super([step, product]);
  @override
  String toString() => 'BuyOrderCreationStep';
}

class BuyOrderCreating extends BuyOrderCreationState {
  final BuyOrder _buyOrder;

  BuyOrderCreating(this._buyOrder): super([_buyOrder]);

  @override
  String toString() => 'BuyOrderCreating';
}

class BuyOrderCreated extends BuyOrderCreationState {
  final BuyOrder _buyOrder;

  BuyOrderCreated(this._buyOrder): super([_buyOrder]);

  @override
  String toString() => 'BuyOrderCreated';
}