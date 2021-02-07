import 'package:fieldfreshmobile/feature/home/bloc/side_type.dart';
import 'package:fieldfreshmobile/repository/client/product/product_client.dart';
import 'package:fieldfreshmobile/repository/client/product/response.dart';

class ProductRepository {
  final ProductClient _productClient;

  ProductRepository(this._productClient);

  Future<PendingProductsResponse> getPendingProducts(Side side) {
    return _productClient.getPendingProducts(side);
  }
}
