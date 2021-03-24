import 'package:equatable/equatable.dart';
import 'package:fieldfreshmobile/models/api/order/match.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';

abstract class ProxyPageState extends Equatable {
  ProxyPageState([List props = const []]) : super(props);
}

class Empty extends ProxyPageState {
  @override
  String toString() {
    return "Empty";
  }
}

class Loading extends ProxyPageState {
  @override
  String toString() {
    return "Loading";
  }
}

class Loaded extends ProxyPageState {
  final Proxy defaultProxy;
  final List<Proxy> proxies;

  Loaded(this.defaultProxy, this.proxies): super([defaultProxy, proxies]);

  @override
  String toString() {
    return "Loaded";
  }
}

class Error extends ProxyPageState {
  @override
  String toString() {
    return "Error";
  }
}
