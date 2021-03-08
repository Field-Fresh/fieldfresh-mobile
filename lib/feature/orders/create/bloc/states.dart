import 'package:equatable/equatable.dart';
import 'package:fieldfreshmobile/feature/orders/create/steps/product_information/product_information_step.dart';
import 'package:fieldfreshmobile/models/api/order/order.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';

abstract class OrderCreationState extends Equatable {
  OrderCreationState([List props = const []]) : super(props);
}

class OrderCreationStep extends OrderCreationState {
  final int step;

  final Product product;

  OrderCreationStep(this.step, {this.product}): super([step, product]);
  @override
  String toString() => 'BuyOrderCreationStep';
}

class OrderCreating extends OrderCreationState {
  final Order _buyOrder;

  OrderCreating(this._buyOrder): super([_buyOrder]);

  @override
  String toString() => 'BuyOrderCreating';
}

class OrderCreated extends OrderCreationState {
  final Order _buyOrder;

  OrderCreated(this._buyOrder): super([_buyOrder]);

  @override
  String toString() => 'BuyOrderCreated';
}

class Error extends OrderCreationState {
  final BuyOrderProductInfo _buyOrderInfo;
  final dynamic error;

  Error(this._buyOrderInfo, this.error): super([_buyOrderInfo]);

  @override
  String toString() => 'Error';
}