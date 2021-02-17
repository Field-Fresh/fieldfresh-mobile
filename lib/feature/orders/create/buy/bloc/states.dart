import 'package:equatable/equatable.dart';
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