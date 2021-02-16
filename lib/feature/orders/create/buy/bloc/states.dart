import 'package:equatable/equatable.dart';

abstract class BuyOrderCreationState extends Equatable {
  BuyOrderCreationState([List props = const []]) : super(props);
}

class BuyOrderCreationStep extends BuyOrderCreationState {
  final int step;

  BuyOrderCreationStep(this.step): super([step]);
  @override
  String toString() => 'BuyOrderCreationStep';
}