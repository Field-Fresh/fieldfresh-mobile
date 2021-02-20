import 'package:enum_to_string/enum_to_string.dart';
import 'package:fieldfreshmobile/models/api/order/order.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/order/status_type.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';

import '../field_fresh_model.dart';

class SellOrder extends Order {

  List<SellProduct> sellProducts;

  // SellOrder(id, {isActive,})
  //     : super(id: id, isActive: isActive, side: Side.SELL);
  //
  // static SellOrder fromJson(Map<String, dynamic> json) {
  //   return SellOrder("");

    SellOrder(this.sellProducts, proxyId, {id, isActive,})
    : super(id: id, isActive: isActive, side: Side.SELL, proxyId: proxyId);

    static SellOrder fromJson(Map<String, dynamic> json) {
    return SellOrder([], "");
  }
}

class SellProduct extends FieldFreshModel {
  final Status status;
  final DateTime earliestDate;
  final DateTime latestDate;
  final int maxPriceCents;
  final double serviceRadius;
  final double volume;
  final Product product;

  SellProduct({this.status, this.earliestDate, this.latestDate,
<<<<<<< Updated upstream
      this.minPriceCents, this.volume, this.product});

  static SellProduct fromJson(Map<String, dynamic> json) {
    return SellProduct(
      status: EnumToString.fromString(Status.values, json["status"]),
      minPriceCents: json["minPriceCents"],
      volume: json["volume"],
      product: Product.fromJson(json["product"]),
    );
=======
    this.maxPriceCents, this.volume, this.product, this.serviceRadius});

  static SellProduct fromJson(Map<String, dynamic> json) {
    return SellProduct();
>>>>>>> Stashed changes
  }
}
