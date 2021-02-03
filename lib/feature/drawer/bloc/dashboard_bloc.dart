import 'package:fieldfreshmobile/feature/drawer/event/events.dart';
import 'package:fieldfreshmobile/feature/drawer/state/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_event.dart';
import 'dashboard_state.dart';

class NavDrawerBloc extends Bloc<NavDrawerEvent, NavDrawerState> {
  @override
  NavDrawerState get initialState => NavDrawerSelectedState(NavItem.home);

  @override
  Stream<NavDrawerState> mapEventToState(NavDrawerEvent event) async* {
    if (event is NavigateTo) {
        yield NavDrawerSelectedState(event.destination);
    }
  }
}