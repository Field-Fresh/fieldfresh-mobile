import 'dart:math';

import 'package:fieldfreshmobile/feature/orders/create/sell/bloc/states.dart';
import 'package:fieldfreshmobile/feature/orders/create/steps/product_information/product_information_step.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/repository/orders_repository.dart';
import 'package:fieldfreshmobile/util/constants.dart';
import 'package:fieldfreshmobile/util/preference.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellOrderCreationCubit extends Cubit<SellOrderCreationState> {

  final OrderRepository _orderRepository;

  SellOrderCreationCubit(this._orderRepository) : super(SellOrderCreationStep(0));

  int _currentStep = 0;
  int _maxSteps = 1;

  Product _selectedProduct;

  SellOrderProductInfo _info;

  Future<void> back() async {
    _currentStep = max(_currentStep - 1, 0);
    emit(SellOrderCreationStep(_currentStep));
  }

  Future<void> nextWithInfo(SellOrderProductInfo info) async {
    _info = info;
    SellOrder sellOrder = SellOrder(
        [
          SellProduct(
              earliestDate: _info.matchingPeriodStart,
              latestDate: _info.matchingPeriodEnd,
              maxPriceCents: (_info.unitMaxPrice*100).toInt(),
              volume: _info.volume,
              serviceRadius: _info.serviceRadius,
              product: _selectedProduct
          )
        ],
        await PreferenceUtil.get(DEFAULT_PROXY)
    );
    _orderRepository.createSellOrder(sellOrder)
        .then((buyOrder) => this.emit(SellOrderCreated(buyOrder)));
    emit(SellOrderCreating(sellOrder));
  }

  Future<void> nextWithProduct(Product product) async {
    _selectedProduct = product;
    _currentStep = min(_currentStep + 1, _maxSteps);
    emit(SellOrderCreationStep(_currentStep, product: _selectedProduct));
  }

  int getCurrentStep() => _currentStep;
}