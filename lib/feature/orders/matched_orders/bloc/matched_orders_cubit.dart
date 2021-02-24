import 'dart:async';
import 'dart:async';
import 'dart:core';

import 'package:fieldfreshmobile/feature/orders/matched_orders/bloc/states.dart';
import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/order/status_type.dart';
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
      final List<BuyProduct> buyProducts =
          await _orderRepository.getBuyOrdersFor(Status.MATCHED, proxyId);
      _buyMatches = buyProducts
          .map((bp) => MatchedOrderItemData(bp.product, bp.volume,
              bp.product.units, bp.maxPriceCents?.toDouble(), Side.BUY, 1))
          .toList();
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
      final List<SellProduct> sellProducts =
          await _orderRepository.getSellOrdersFor(Status.MATCHED, proxyId);
      _sellMatches = sellProducts
          .map((bp) => MatchedOrderItemData(bp.product, bp.volume,
              bp.product.units, bp.minPriceCents?.toDouble(), Side.SELL, 0))
          .toList();
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
