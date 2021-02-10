
import 'package:fieldfreshmobile/feature/home/bloc/home_event.dart';
import 'package:fieldfreshmobile/feature/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavDrawerBloc extends Bloc<HomePageEvent, HomePageState> {
  NavDrawerBloc(HomePageState initialState) : super(initialState);

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {

  }
}