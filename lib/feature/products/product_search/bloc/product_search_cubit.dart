import 'package:fieldfreshmobile/feature/products/product_search/bloc/states.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSearchCubit extends Cubit<ProductSearchState> {

  final ProductRepository repository;
  ProductSearchCubit(this.repository) : super(Empty());

  List<Product> _products = [];
  String _searchText;
  Future<void> searchTextUpdated(String searchText) async {
    if (_searchText == searchText || searchText.length < 3) {
      return;
    }
    _searchText = searchText;
    emit(Loading(searchText, _products));
    try {
      _products = await repository.searchProducts(searchText, 10);
      emit(Loaded(searchText, _products));
    } catch (e) {
      emit(Error(searchText));
    }
  }
}