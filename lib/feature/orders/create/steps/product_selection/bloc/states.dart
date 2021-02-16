import 'package:equatable/equatable.dart';

abstract class ProductSelectionState extends Equatable {
  ProductSelectionState([List props = const []]) : super(props);
}

class ProductSelectionStateEmpty extends ProductSelectionState {
  @override
  String toString() => 'ProductSelectionStateEmpty';
}