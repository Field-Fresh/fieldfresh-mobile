import 'package:fieldfreshmobile/models/api/product/pending_product.dart';

class PendingProductsResponse {
  final List<PendingProduct> productList;

  PendingProductsResponse({this.productList});

  static PendingProductsResponse fromJson(Map<String, dynamic> json) {
    return PendingProductsResponse(
      productList: (json['pendingProducts'] as List)
          .map((e) => PendingProduct.fromJson(e))
          .toList(),
    );
  }
}
