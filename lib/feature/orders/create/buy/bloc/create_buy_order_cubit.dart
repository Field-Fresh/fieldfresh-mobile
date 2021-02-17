import 'dart:math';

import 'package:fieldfreshmobile/feature/orders/create/buy/bloc/states.dart';
import 'package:fieldfreshmobile/feature/orders/create/steps/product_information/product_information_step.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/repository/orders_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyOrderCreationCubit extends Cubit<BuyOrderCreationState> {

  final OrderRepository _orderRepository;

  BuyOrderCreationCubit(this._orderRepository) : super(BuyOrderCreationStep(0));

  int _currentStep = 0;
  int _maxSteps = 2;

  Product _selectedProduct;

  BuyOrderProductInfo _info;

  Future<void> back() async {
    _currentStep = max(_currentStep - 1, 0);
    emit(BuyOrderCreationStep(_currentStep));
  }

  Future<void> nextWithInfo(BuyOrderProductInfo info) async {
    _info = info;
    _currentStep = min(_currentStep + 1, _maxSteps);
    emit(BuyOrderCreationStep(_currentStep));
  }

  Future<void> nextWithProduct(Product product) async {
    _selectedProduct = product;
    _currentStep = min(_currentStep + 1, _maxSteps);
    emit(BuyOrderCreationStep(_currentStep, product: _selectedProduct));
  }

  int getCurrentStep() => _currentStep;
}