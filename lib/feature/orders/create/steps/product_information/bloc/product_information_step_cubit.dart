import 'package:fieldfreshmobile/feature/orders/create/steps/product_selection/bloc/states.dart';
import 'package:fieldfreshmobile/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSelectionStepCubit extends Cubit<ProductSelectionState> {

  final ProductRepository repository;
  ProductSelectionStepCubit(this.repository) : super(ProductSelectionStateEmpty());

  Future<void> loadProductCategories() async {

  }
}