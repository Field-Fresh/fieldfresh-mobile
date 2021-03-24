import 'dart:async';
import 'dart:core';

import 'package:fieldfreshmobile/feature/orders/matched_orders/list/bloc/states.dart';
import 'package:fieldfreshmobile/feature/orders/matched_orders/list/ui/matched_order_view.dart';
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

  Map<String, List<MatchedOrderItemData>> _buyMatchesByOrder = {};
  Map<String, List<MatchedOrderItemData>> _sellMatchesByOrder = {};

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
    if (_buyMatchesByOrder?.isNotEmpty ?? false) {
      emit(Loaded(Side.BUY, _buyMatchesByOrder));
    }

    try {
      (await _orderRepository.getMatches(proxyId, Side.BUY))?.forEach((e) {
        var match = MatchedOrderItemData(e.id, e.product, e.quantity,
            e.product.units, e.unitPriceCents / 100, Side.BUY, (e.quantity / e.originalBuyQuantity));
        if (_buyMatchesByOrder.containsKey(e.buyProduct.id)) {
          _buyMatchesByOrder[e.buyProduct.id].add(match);
        } else {
          _buyMatchesByOrder[e.buyProduct.id] = [match];
        }
      });
      emit(Loaded(Side.BUY, _buyMatchesByOrder));
    } catch (e) {
      emit(Error(Side.BUY));
    }
  }

  Future<void> _loadSellMatches(String proxyId) async {
    if (_sellMatchesByOrder?.isNotEmpty ?? false) {
      emit(Loaded(Side.SELL, _sellMatchesByOrder));
    }

    try {
      (await _orderRepository.getMatches(proxyId, Side.SELL))?.forEach((e) {
        var match = MatchedOrderItemData(
            e.id,
            e.product,
            e.quantity,
            e.product.units,
            e.unitPriceCents / 100,
            Side.SELL,
            e.quantity / e.originalSellQuantity);
        if (_sellMatchesByOrder.containsKey(e.sellProduct.id)) {
          _sellMatchesByOrder[e.sellProduct.id].add(match);
        } else {
          _sellMatchesByOrder[e.sellProduct.id] = [match];
        }
      });
      emit(Loaded(Side.SELL, _sellMatchesByOrder));
    } catch (e) {
      emit(Error(Side.SELL));
    }
  }

  Future<void> switchSide() async {
    switch (_side) {
      case Side.SELL:
        _side = Side.BUY;
        if (_buyMatchesByOrder.isEmpty) {
          emit(Empty(_side));
        } else {
          emit(Loaded(_side, _buyMatchesByOrder));
        }
        break;
      case Side.BUY:
        _side = Side.SELL;
        if (_sellMatchesByOrder.isEmpty) {
          emit(Empty(_side));
        } else {
          emit(Loaded(_side, _sellMatchesByOrder));
        }
        break;
    }
  }
}
