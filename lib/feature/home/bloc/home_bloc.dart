
import 'package:fieldfreshmobile/feature/home/bloc/home_event.dart';
import 'package:fieldfreshmobile/feature/home/bloc/home_state.dart';
import 'package:fieldfreshmobile/feature/home/state/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavDrawerBloc extends Bloc<HomePageEvent, HomePageState> {
  @override
  HomePageState get initialState => HomePageStateEmpty();

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {

  }
}