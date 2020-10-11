import 'package:fieldfreshmobile/feature/home/bloc/home_bloc.dart';
import 'package:fieldfreshmobile/feature/home/bloc/home_state.dart';
import 'package:fieldfreshmobile/feature/home/event/events.dart';
import 'package:fieldfreshmobile/feature/home/state/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';

class HomeScreen extends StatelessWidget {
  final BottomNavigationBloc bottomNavigationBloc = sl<BottomNavigationBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        bloc: bottomNavigationBloc,
        builder: (BuildContext context, BottomNavigationState state) {
          if (state is PageLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is HomePageLoaded) {
          }

          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
          bloc: bottomNavigationBloc,
          builder: (BuildContext context, BottomNavigationState state) {
            return BottomNavigationBar(
              currentIndex: bottomNavigationBloc.currentIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.black),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.attach_money, color: Colors.black),
                  title: Text('Buy'),
                ),
              ],
              onTap: (index) => bottomNavigationBloc.add(PageTapped(index: index)),
            );
          }
      ),
    );
  }
}
