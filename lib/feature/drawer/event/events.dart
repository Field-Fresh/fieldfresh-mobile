


import 'package:fieldfreshmobile/feature/drawer/bloc/dashboard_event.dart';
import 'package:fieldfreshmobile/feature/drawer/state/states.dart';

class NavigateTo extends NavDrawerEvent {
  final NavItem destination;

  NavigateTo(this.destination) : super([destination]);

  @override
  String toString() => 'NavigateTo: $destination';
}