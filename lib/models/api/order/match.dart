import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';

import '../field_fresh_model.dart';

class Match extends FieldFreshModel {
  final int quantity;
  final int unitPriceCents;
  final SellProduct sellProduct;
  final BuyProduct buyProduct;
  final int round;
  final Product product;
  final int originalSellQuantity;
  final int originalBuyQuantity;

  Match(
      {id,
      this.quantity,
      this.unitPriceCents,
      this.sellProduct,
      this.buyProduct,
      this.originalSellQuantity,
      this.originalBuyQuantity,
      this.product,
      this.round}) : super(id: id);

  static Match fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      quantity: json["quantity"],
      unitPriceCents: json["unitPriceCents"],
      sellProduct: SellProduct.fromJson(json["sellProduct"]),
      buyProduct: BuyProduct.fromJson(json["buyProduct"]),
      round: json["round"],
      product: Product.fromJson(json["product"]),
      originalSellQuantity: json["originalSellQuantity"],
      originalBuyQuantity: json["originalBuyQuantity"],
    );
  }
}
