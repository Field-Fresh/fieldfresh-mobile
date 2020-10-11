

import 'package:fieldfreshmobile/feature/home/bloc/home_event.dart';
import 'package:flutter/foundation.dart';

class PageTapped extends BottomNavigationEvent {
  final int index;

  PageTapped({@required this.index}) : super([index]);

  @override
  String toString() => 'PageTapped: $index';
}

class Started extends BottomNavigationEvent {
  @override
  String toString() => 'Started';
}