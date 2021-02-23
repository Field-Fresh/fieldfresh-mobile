import 'dart:math';

import 'package:fieldfreshmobile/feature/orders/create/bloc/states.dart';
import 'package:fieldfreshmobile/feature/orders/create/steps/product_information/product_information_step.dart';
import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/repository/orders_repository.dart';
import 'package:fieldfreshmobile/util/constants.dart';
import 'package:fieldfreshmobile/util/preference.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class OrderCreationCubit extends Cubit<OrderCreationState>{

  final OrderRepository _orderRepository;

  OrderCreationCubit(this._orderRepository) : super(OrderCreationStep(0));

  int _currentStep = 0;
  int _maxSteps = 1;

  Product _selectedProduct;

  OrderProductInfo _info;

  Future<void> back() async {
    _currentStep = max(_currentStep - 1, 0);
    emit(OrderCreationStep(_currentStep));
  }

  Future<void> nextWithInfo(OrderProductInfo info) async {
    if(info is BuyOrderProductInfo) {
      _info = info;
      BuyOrder buyOrder = BuyOrder([
        BuyProduct(
            earliestDate: info.matchingPeriodStart,
            latestDate: info.matchingPeriodEnd,
            maxPriceCents: (info.unitMaxPrice * 100).toInt(),
            volume: info.volume,
            serviceRadius: info.serviceRadius,
            product: _selectedProduct)
      ], await PreferenceUtil.get(DEFAULT_PROXY));
      _orderRepository
          .createBuyOrder(buyOrder)
          .then((buyOrder) => this.emit(OrderCreated(buyOrder)));
      emit(OrderCreating(buyOrder));
    }else if (info is SellOrderProductInfo){
      SellOrder sellOrder = SellOrder(
          [
            SellProduct(
                earliestDate: info.matchingPeriodStart,
                latestDate: info.matchingPeriodEnd,
                minPriceCents: (info.unitMinPrice*100).toInt(),
                volume: info.volume,
                serviceRadius: info.serviceRadius,
                product: _selectedProduct
            )
          ],
          await PreferenceUtil.get(DEFAULT_PROXY)
      );
      _orderRepository.createSellOrder(sellOrder)
          .then((sellOrder) => this.emit(OrderCreated(sellOrder)));
      emit(OrderCreating(sellOrder));
    }
  }

  Future<void> nextWithProduct(Product product) async {
    _selectedProduct = product;
    _currentStep = min(_currentStep + 1, _maxSteps);
    emit(OrderCreationStep(_currentStep, product: _selectedProduct));
  }

  int getCurrentStep() => _currentStep;
}