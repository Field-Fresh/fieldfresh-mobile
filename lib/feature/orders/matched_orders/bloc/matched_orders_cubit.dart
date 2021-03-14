import 'dart:async';
import 'dart:core';

import 'package:fieldfreshmobile/feature/orders/matched_orders/bloc/states.dart';
import 'package:fieldfreshmobile/feature/orders/matched_orders/ui/matched_order_view.dart';
import 'package:fieldfreshmobile/models/api/order/match.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/repository/orders_repository.dart';
import 'package:fieldfreshmobile/util/constants.dart';
import 'package:fieldfreshmobile/util/preference.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchedOrdersCubit extends Cubit<MatchedOrdersState> {
  final OrderRepository _orderRepository;

  String proxyId;

  MatchedOrdersCubit(this._orderRepository) : super(Empty(Side.SELL));

  Side _side = Side.SELL;

  List<MatchedOrderItemData> _buyMatches = [];
  List<MatchedOrderItemData> _sellMatches = [];

  Future<void> loadData() async {
    emit(Loading(_side));
    if (proxyId == null) {
      proxyId = await PreferenceUtil.get(DEFAULT_PROXY);
    }
    switch (_side) {
      case Side.SELL:
        _loadSellMatches(proxyId);
        break;
      case Side.BUY:
        _loadBuyMatches(proxyId);
        break;
    }
  }

  Future<void> _loadBuyMatches(String proxyId) async {
    if (_buyMatches?.isNotEmpty ?? false) {
      emit(Loaded(Side.BUY, _buyMatches));
    }

    try {
      _buyMatches = (await _orderRepository.getMatches(proxyId, Side.BUY))?.map(
          (e) => MatchedOrderItemData(
              e.product,
              e.quantity,
              e.product.units,
              e.unitPriceCents / 100,
              Side.BUY,
              e.quantity / e.originalBuyQuantity))?.toList();
      emit(Loaded(Side.BUY, _buyMatches));
    } catch (e) {
      emit(Error(Side.BUY));
    }
  }

  Future<void> _loadSellMatches(String proxyId) async {
    if (_sellMatches?.isNotEmpty ?? false) {
      emit(Loaded(Side.SELL, _sellMatches));
    }

    try {
      _sellMatches = (await _orderRepository.getMatches(proxyId, Side.SELL))?.map(
              (e) => MatchedOrderItemData(
              e.product,
              e.quantity,
              e.product.units,
              e.unitPriceCents / 100,
              Side.BUY,
              e.quantity / e.originalSellQuantity))?.toList();
      emit(Loaded(Side.SELL, _sellMatches));
    } catch (e) {
      emit(Error(Side.SELL));
    }
  }

  Future<void> switchSide() {
    switch (_side) {
      case Side.SELL:
        _side = Side.BUY;
        if (_buyMatches.isEmpty) {
          emit(Empty(_side));
        } else {
          emit(Loaded(_side, _buyMatches));
        }
        break;
      case Side.BUY:
        _side = Side.SELL;
        if (_sellMatches.isEmpty) {
          emit(Empty(_side));
        } else {
          emit(Loaded(_side, _sellMatches));
        }
        break;
    }
  }
}
