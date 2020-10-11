import 'package:fieldfreshmobile/feature/home/bloc/home_state.dart';
import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_state.dart';

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  CurrentIndexChanged(this.currentIndex): super([currentIndex]);

  @override
  String toString() => 'CurrentIndexChanged';
}

class PageLoading extends BottomNavigationState {

  @override
  String toString() => 'PageLoading';
}

class HomePageLoaded extends BottomNavigationState {

  @override
  String toString() => 'HomePageLoaded';
}