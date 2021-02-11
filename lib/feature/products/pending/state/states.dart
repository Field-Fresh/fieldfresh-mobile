import 'package:fieldfreshmobile/feature/products/pending/bloc/pending_product_state.dart';
import 'package:fieldfreshmobile/models/api/product/pending_product.dart';

class PendingProductStateEmpty extends PendingProductState {
  @override
  String toString() => 'PendingProductStateEmpty';
}

class Loading extends PendingProductState {
  @override
  String toString() => 'Loading';
}

class Loaded extends PendingProductState {
  final List<PendingProduct> pendingProducts;

  Loaded(this.pendingProducts);

  @override
  String toString() => 'Loaded';
}


class Error extends PendingProductState {
  final String errorMessage;

  Error(this.errorMessage);

  @override
  String toString() => 'Error';
}

class ViewAllSelected extends PendingProductState {
  @override
  String toString() => 'ViewAllSelected';
}