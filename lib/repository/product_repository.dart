import 'package:fieldfreshmobile/client/product/product_client.dart';
import 'package:fieldfreshmobile/client/product/response.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';

class ProductRepository {
  final ProductClient _productClient;

  ProductRepository(this._productClient);

  Future<PendingProductsResponse> getPendingProducts(Side side) {
    return _productClient.getPendingProducts(side);
  }

  Future<List<Product>> searchProducts(String searchText, int limit) {
    return _productClient.searchProducts(searchText, limit);
  }
}
