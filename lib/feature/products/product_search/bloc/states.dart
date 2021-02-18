import 'package:equatable/equatable.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';

abstract class ProductSearchState extends Equatable {
  ProductSearchState([List props = const []]) : super(props);
}

class Empty extends ProductSearchState {
  @override
  String toString() => 'Empty';
}

class Loading extends ProductSearchState {
  final String searchText;
  final List<Product> currentProducts;

  Loading(this.searchText, this.currentProducts)
      : super([searchText, currentProducts]);

  @override
  String toString() => 'Loading';
}

class Loaded extends ProductSearchState {
  final String searchText;
  final List<Product> products;

  Loaded(this.searchText, this.products) : super([searchText]);

  @override
  String toString() => 'Loaded';
}

class Error extends ProductSearchState {
  final String searchText;

  Error(this.searchText);

  @override
  String toString() => 'Error';
}
