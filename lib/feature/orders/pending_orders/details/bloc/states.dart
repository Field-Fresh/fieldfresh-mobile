import 'package:equatable/equatable.dart';
import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/order/match.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';

abstract class PendingOrderDetailsState extends Equatable {
  PendingOrderDetailsState([List props = const []]) : super(props);
}

class Empty extends PendingOrderDetailsState {
  Empty() : super(null);

  @override
  String toString() {
    return "Empty";
  }
}

class Loading extends PendingOrderDetailsState {
  @override
  String toString() {
    return "Loading";
  }
}

class SellOrderCancelling extends PendingOrderDetailsState {
  final SellProduct sellProduct;
  final List<Match> matches;

  SellOrderCancelling(this.sellProduct, this.matches);
  @override
  String toString() {
    return "SellOrderCancelling";
  }
}

class SellOrderLoaded extends PendingOrderDetailsState {
  final SellProduct sellProduct;
  final List<Match> matches;

  SellOrderLoaded(this.sellProduct, this.matches)
      : super([sellProduct, matches]);

  @override
  String toString() {
    return "SellOrderLoaded";
  }
}

class SellOrderCancelled extends PendingOrderDetailsState {
  final SellProduct sellProduct;
  final List<Match> matches;

  SellOrderCancelled(this.sellProduct, this.matches);
  @override
  String toString() {
    return "SellOrderCancelled";
  }
}

class SellOrderCancelFailed extends PendingOrderDetailsState {
  final SellProduct sellProduct;
  final List<Match> matches;

  SellOrderCancelFailed(this.sellProduct, this.matches);
  @override
  String toString() {
    return "SellOrderCancelFailed";
  }
}

class BuyOrderLoaded extends PendingOrderDetailsState {
  final BuyProduct buyProduct;
  final List<Match> matches;

  BuyOrderLoaded(this.buyProduct, this.matches)
      : super([buyProduct, matches]);

  @override
  String toString() {
    return "BuyOrderLoaded";
  }
}

class BuyOrderCancelling extends PendingOrderDetailsState {
  final BuyProduct buyProduct;
  final List<Match> matches;

  BuyOrderCancelling(this.buyProduct, this.matches);
  @override
  String toString() {
    return "BuyOrderCancelling";
  }
}

class BuyOrderCancelled extends PendingOrderDetailsState {
  final BuyProduct buyProduct;
  final List<Match> matches;

  BuyOrderCancelled(this.buyProduct, this.matches);
  @override
  String toString() {
    return "BuyOrderCancelled";
  }
}

class BuyOrderCancelFailed extends PendingOrderDetailsState {
  final BuyProduct buyProduct;
  final List<Match> matches;

  BuyOrderCancelFailed(this.buyProduct, this.matches);
  @override
  String toString() {
    return "BuyOrderCancelFailed";
  }
}

class Error extends PendingOrderDetailsState {

  @override
  String toString() {
    return "Error";
  }
}
