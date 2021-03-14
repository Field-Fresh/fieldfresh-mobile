import 'package:enum_to_string/enum_to_string.dart';
import 'package:fieldfreshmobile/models/api/order/order.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/order/status_type.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';

import '../field_fresh_model.dart';

class SellOrder extends Order {

  List<SellProduct> sellProducts;

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
  final int minPriceCents;
  final double serviceRadius;
  final double volume;
  final Product product;
  final bool isCancelable;

  SellProduct(
      {id, this.isCancelable, this.status, this.earliestDate, this.latestDate, this.minPriceCents, this.volume, this.product, this.serviceRadius})
      : super(id: id);

  static SellProduct fromJson(Map<String, dynamic> json) {
    return SellProduct(
      id: json["id"],
      status: EnumToString.fromString(Status.values, json["status"]),
      minPriceCents: json["minPriceCents"],
      volume: json["volume"],
      serviceRadius: json["serviceRadius"],
      earliestDate: DateTime.parse(json['earliestDate']).toLocal(),
      latestDate: DateTime.parse(json['latestDate']).toLocal(),
      isCancelable: json["isCancellable"],
      product: Product.fromJson(json["product"]),
    );
  }
}
