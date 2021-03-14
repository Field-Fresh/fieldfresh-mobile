import 'package:equatable/equatable.dart';

abstract class HomePageState extends Equatable {
  final bool reload;

  HomePageState(this.reload, [List props = const []]) : super(props);
}

class Empty extends HomePageState {

  Empty(reload): super(reload, [reload]);

  @override
  String toString() {
    return "Empty";
  }
}