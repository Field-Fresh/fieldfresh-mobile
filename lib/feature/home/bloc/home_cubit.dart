
import 'package:fieldfreshmobile/feature/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(Empty(false));

  bool loadBit = false;

  Future<void> reload() async {
    loadBit = !loadBit;
    emit(Empty(loadBit));
  }
}