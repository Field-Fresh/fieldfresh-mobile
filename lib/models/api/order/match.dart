
import 'package:fieldfreshmobile/models/api/product/product.dart';

import '../field_fresh_model.dart';

class Match extends FieldFreshModel {
  final double quantity;
  final int unitPriceCents;
  final String sellProductId;
  final String buyProductId;
  final int round;
  final Product product;
  final double originalSellQuantity;
  final double originalBuyQuantity;

  Match(
      {this.quantity,
      this.unitPriceCents,
      this.sellProductId,
      this.buyProductId,
      this.originalSellQuantity,
      this.originalBuyQuantity,
      this.product,
      this.round});

  static Match fromJson(Map<String, dynamic> json) {
    return Match(
      quantity: json["quantity"],
      unitPriceCents: json["unitPriceCents"],
      sellProductId: json["sellProductId"],
      buyProductId: json["buyProductId"],
      round: json["round"],
      product: Product.fromJson(json["product"]),
      originalSellQuantity: json["originalSellQuantity"],
      originalBuyQuantity: json["originalBuyQuantity"],
    );
  }
}
