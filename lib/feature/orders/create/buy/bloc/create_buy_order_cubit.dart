import 'dart:math';

import 'package:fieldfreshmobile/feature/orders/create/buy/bloc/states.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/repository/orders_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyOrderCreationCubit extends Cubit<BuyOrderCreationState> {

  final OrderRepository _orderRepository;

  BuyOrderCreationCubit(this._orderRepository) : super(BuyOrderCreationStep(0));

  int _currentStep = 0;
  int _maxSteps = 1;

  Future<void> back() async {
    _currentStep = max(_currentStep - 1, 0);
    emit(BuyOrderCreationStep(_currentStep));
  }

  Future<void> next() async {
    _currentStep = min(_currentStep + 1, _maxSteps);
    emit(BuyOrderCreationStep(_currentStep));
  }

  Future<void> nextWithInfo() async {
    _currentStep = min(_currentStep + 1, _maxSteps);
    emit(BuyOrderCreationStep(_currentStep));
  }

  Future<void> nextWithProduct(Product product) async {
    _currentStep = min(_currentStep + 1, _maxSteps);
    emit(BuyOrderCreationStep(_currentStep));
  }

  int getCurrentStep() => _currentStep;
}