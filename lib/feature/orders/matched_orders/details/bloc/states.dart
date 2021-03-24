import 'package:equatable/equatable.dart';
import 'package:fieldfreshmobile/models/api/order/match.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';

abstract class MatchDetailsState extends Equatable {
  MatchDetailsState([List props = const []]) : super(props);
}

class Empty extends MatchDetailsState {
  @override
  String toString() {
    return "Empty";
  }
}

class Loading extends MatchDetailsState {
  @override
  String toString() {
    return "Loading";
  }
}

class Loaded extends MatchDetailsState {
  final Match match;
  final Proxy proxy;
  final Side side;

  Loaded(this.match, this.proxy, this.side): super([match, proxy, side]);

  @override
  String toString() {
    return "Loaded";
  }
}

class Error extends MatchDetailsState {
  @override
  String toString() {
    return "Error";
  }
}
