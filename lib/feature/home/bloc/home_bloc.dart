import 'package:fieldfreshmobile/feature/home/event/events.dart';
import 'package:fieldfreshmobile/feature/home/state/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

// This is technically a state reducer for the signup page
class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  int currentIndex = 0;

  @override
  BottomNavigationState get initialState => PageLoading();

  @override
  Stream<BottomNavigationState> mapEventToState(BottomNavigationEvent event) async* {
    if (event is Started) {
      add(PageTapped(index: this.currentIndex));
    }
    if (event is PageTapped) {
      this.currentIndex = event.index;
      yield CurrentIndexChanged(this.currentIndex);
      yield PageLoading();

      if (this.currentIndex == 0) {
        yield HomePageLoaded();
      }
    }
  }
}