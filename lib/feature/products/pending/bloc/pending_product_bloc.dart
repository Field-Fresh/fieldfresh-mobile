
import 'package:fieldfreshmobile/feature/products/pending/bloc/pending_product_event.dart';
import 'package:fieldfreshmobile/feature/products/pending/bloc/pending_product_state.dart';
import 'package:fieldfreshmobile/feature/products/pending/event/events.dart';
import 'package:fieldfreshmobile/feature/products/pending/state/states.dart';
import 'package:fieldfreshmobile/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingProductsBloc extends Bloc<PendingProductEvent, PendingProductState> {
  final ProductRepository _productRepository;

  PendingProductsBloc(this._productRepository) : super(PendingProductStateEmpty());

  @override
  Stream<PendingProductState> mapEventToState(PendingProductEvent event) async* {
    if (event is LoadPendingProducts) {
      yield* loadProducts(event);
    }
  }

  Stream<PendingProductState> loadProducts(LoadPendingProducts event) async* {
    try {
      final pendingProducts = await _productRepository.getPendingProducts(event.side);
      if (pendingProducts != null) {
        yield Loaded(pendingProducts.productList);
      } else {
        yield Error("Failed to load products");
      }
    } catch (e) {
      yield Error("");
    }
  }
}