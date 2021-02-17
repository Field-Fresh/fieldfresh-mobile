import 'package:equatable/equatable.dart';

abstract class HomePageState extends Equatable {
  HomePageState([List props = const []]) : super(props);
}

class Empty extends HomePageState {
  @override
  String toString() {
    return "Empty";
  }
}

class Loading extends HomePageState {
  @override
  String toString() {
    return "Loading";
  }
}