import 'package:enum_to_string/enum_to_string.dart';
import 'package:fieldfreshmobile/models/api/order/order.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/order/status_type.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';

import '../field_fresh_model.dart';

class BuyOrder extends Order {

  List<BuyProduct> buyProducts;

  BuyOrder(this.buyProducts, proxyId, {id, isActive,})
      : super(id: id, isActive: isActive, side: Side.SELL, proxyId: proxyId);

  static BuyOrder fromJson(Map<String, dynamic> json) {
    return BuyOrder([], "");
  }
}

class BuyProduct extends FieldFreshModel {
  final Status status;
  final DateTime earliestDate;
  final DateTime latestDate;
  final int maxPriceCents;
  final double serviceRadius;
  final double volume;
  final Product product;

  BuyProduct({this.status, this.earliestDate, this.latestDate,
      this.maxPriceCents, this.volume, this.product, this.serviceRadius});

  static BuyProduct fromJson(Map<String, dynamic> json) {
    return BuyProduct(
      status: EnumToString.fromString(Status.values, json["status"]),
      maxPriceCents: json["maxPriceCents"],
      volume: json["volume"],
      product: Product.fromJson(json["product"]),
    );
  }
}
