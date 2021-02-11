import 'package:equatable/equatable.dart';

abstract class OrderCountState extends Equatable {
  OrderCountState([List props = const []]) : super(props);
}

class OrderCountStateEmpty extends OrderCountState {
  @override
  String toString() => 'OrderCountStateEmpty';
}

class Loading extends OrderCountState {
  @override
  String toString() => 'Loading';
}

class Loaded extends OrderCountState {
  final int orderCount;

  Loaded(this.orderCount);

  @override
  String toString() => 'Loaded';
}

class Error extends OrderCountState {
  final String errorMessage;

  Error(this.errorMessage);

  @override
  String toString() => 'Error';
}