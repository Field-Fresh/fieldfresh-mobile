import 'package:fieldfreshmobile/feature/drawer/bloc/dashboard_bloc.dart';
import 'package:fieldfreshmobile/feature/drawer/bloc/dashboard_state.dart';
import 'package:fieldfreshmobile/feature/drawer/state/states.dart';
import 'package:fieldfreshmobile/feature/drawer/ui/nav_drawer.dart';
import 'package:fieldfreshmobile/feature/home/ui/home_page.dart';
import 'package:fieldfreshmobile/feature/orders/pending_orders/ui/order_page.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/models/api/user/user.dart';
import 'package:fieldfreshmobile/util/user_singleton.dart';
import 'package:fieldfreshmobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) => BlocProvider<NavDrawerBloc>(
        create: (BuildContext context) => sl<NavDrawerBloc>(),
        child: BlocBuilder<NavDrawerBloc, NavDrawerState>(
            builder: (BuildContext context, NavDrawerState state) {
          User user = UserSingleton().getUser();
          return Scaffold(
            drawer: NavDrawerWidget(),
            appBar: FieldFreshAppBar(),
            body: SafeArea(
              child: _bodyForState(state, user),
            ),
          );
        }),
      );

  Widget _bodyForState(NavDrawerState state, User user) {
    if (state is NavDrawerSelectedState) {
      return _bodyForNavState(state, user);
    }
    return Text(state.toString());
  }

  Widget _bodyForNavState(NavDrawerSelectedState state, User user) {
    NavItem item = state.selectedItem;
    if (item == NavItem.home) {
      return HomeScreen();
    } else if (item == NavItem.profile) {
      return Container();
    } else if (item == NavItem.active_orders) {
      return OrderPage();
    } else {
      return Container();
    }
  }
}
