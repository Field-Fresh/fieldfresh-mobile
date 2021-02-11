import 'package:fieldfreshmobile/models/api/product/product.dart';

class PendingProduct {
  Product product;
  String units;
  double volume;

  PendingProduct({this.product, this.units, this.volume});

  static PendingProduct fromJson(Map<String, dynamic> json) {
    return PendingProduct(
      product: Product.fromJson(json['product']),
      units: json['unit'],
      volume: json['totalVolume'],
    );
  }
}
