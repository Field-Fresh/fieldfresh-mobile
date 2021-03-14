import 'package:fieldfreshmobile/feature/orders/pending_orders/details/bloc/states.dart';
import 'package:fieldfreshmobile/models/api/order/match.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
import 'package:fieldfreshmobile/repository/orders_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingSellOrderDetailsCubit extends Cubit<PendingOrderDetailsState> {
  final OrderRepository _orderRepository;

  PendingSellOrderDetailsCubit(this._orderRepository) : super(Empty());

  List<Match> _matches;
  SellProduct _sellOrder;

  Future<void> loadOrder(String id) async {
    emit(Loading());

    if ((_matches?.isNotEmpty ?? false) && _sellOrder != null) {
      emit(SellOrderLoaded(_sellOrder, _matches));
    }

    try {
      var response = await _orderRepository.getSellOrder(id);
      _matches = response?.matches;
      _sellOrder = response?.sellOrder;
      emit(SellOrderLoaded(_sellOrder, _matches));
    } catch (e) {
      emit(Error());
    }
  }

  Future<void> cancelOrder(String id) async {
    emit(SellOrderCancelling(_sellOrder, _matches));

    try {
      await _orderRepository.cancelSellOrder(id);
      emit(SellOrderCancelled(_sellOrder, _matches));
    } catch (e) {
      emit(SellOrderCancelFailed(_sellOrder, _matches));
    }
  }
}
