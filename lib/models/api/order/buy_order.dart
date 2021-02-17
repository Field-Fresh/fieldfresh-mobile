import 'package:enum_to_string/enum_to_string.dart';
import 'package:fieldfreshmobile/feature/home/bloc/side_type.dart';
import 'package:fieldfreshmobile/models/api/order/order.dart';
import 'package:fieldfreshmobile/models/api/order/status_type.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';

import '../field_fresh_model.dart';

class BuyOrder extends Order {

  List<BuyProduct> sellProducts;

  BuyOrder(id, {isActive,})
      : super(id: id, isActive: isActive, side: Side.SELL);

  static BuyOrder fromJson(Map<String, dynamic> json) {
    return BuyOrder("");
  }
}

class BuyProduct extends FieldFreshModel {
  final Status status;
  final String earliestDate;
  final String latestDate;
  final int minPriceCents;
  final double volume;
  final Product product;

  BuyProduct(this.status, this.earliestDate, this.latestDate,
      this.minPriceCents, this.volume, this.product);

}
