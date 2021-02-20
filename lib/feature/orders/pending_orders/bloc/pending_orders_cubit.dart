import 'package:fieldfreshmobile/feature/orders/pending_orders/bloc/states.dart';
import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/order/status_type.dart';
import 'package:fieldfreshmobile/repository/orders_repository.dart';
import 'package:fieldfreshmobile/util/constants.dart';
import 'package:fieldfreshmobile/util/preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingOrdersCubit extends Cubit<PendingOrdersState> {
  final OrderRepository _orderRepository;

  String proxyId;

  PendingOrdersCubit(this._orderRepository) : super(Empty());

  List<PendingOrderItemData> _buyProductItemData;
  List<PendingOrderItemData> _sellProductsItemData;

  Future<void> loadOrders({@required Side side}) async {
    emit(Loading(side));
    if (proxyId == null) {
      proxyId = await PreferenceUtil.get(DEFAULT_PROXY);
    }
    switch (side) {
      case Side.SELL:
        _loadSellOrders(proxyId);
        break;
      case Side.BUY:
        _loadBuyOrders(proxyId);
        break;
    }
  }

  Future<void> _loadBuyOrders(String proxyId) async {
    if (_buyProductItemData?.isNotEmpty ?? false) {
      emit(Loaded(Side.BUY, proxyId, _buyProductItemData));
    }

    try {
      final List<BuyProduct> buyProducts =
          await _orderRepository.getBuyOrdersFor(Status.PENDING, proxyId);
      _buyProductItemData = buyProducts.map((bp) => PendingOrderItemData(
          bp.product,
          bp.volume,
          bp.product.units,
          bp.maxPriceCents?.toDouble(),
          Side.BUY)).toList();
      emit(Loaded(Side.BUY, proxyId, _buyProductItemData));
    } catch (e) {
      emit(Error(Side.BUY, proxyId));
    }
  }

  Future<void> _loadSellOrders(String proxyId) async {
    if (_sellProductsItemData?.isNotEmpty ?? false) {
      emit(Loaded(Side.SELL, proxyId, _sellProductsItemData));
    }

    try {
      final List<SellProduct> sellProducts =
          await _orderRepository.getSellOrdersFor(Status.PENDING, proxyId);
      _sellProductsItemData = sellProducts.map((bp) => PendingOrderItemData(
          bp.product,
          bp.volume,
          bp.product.units,
          bp.minPriceCents?.toDouble(),
          Side.SELL)).toList();
      emit(Loaded(Side.SELL, proxyId, _sellProductsItemData));
    } catch (e) {
      emit(Error(Side.SELL, proxyId));
    }
  }
}
