


import 'package:fieldfreshmobile/feature/drawer/bloc/dashboard_state.dart';

class NavDrawerSelectedState extends NavDrawerState {
  final NavItem selectedItem;

  NavDrawerSelectedState(this.selectedItem): super([selectedItem]);

  @override
  String toString() => 'NavDrawerSelectedState';
}

enum NavItem {
  profile,
  home
}