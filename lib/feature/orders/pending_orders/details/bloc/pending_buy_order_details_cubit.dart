import 'package:fieldfreshmobile/feature/orders/pending_orders/details/bloc/states.dart';
import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/order/match.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
import 'package:fieldfreshmobile/repository/orders_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingBuyOrderDetailsCubit extends Cubit<PendingOrderDetailsState> {
  final OrderRepository _orderRepository;

  PendingBuyOrderDetailsCubit(this._orderRepository) : super(Empty());

  List<Match> _matches;
  BuyProduct _buyProduct;

  Future<void> loadOrder(String id) async {
    emit(Loading());

    if ((_matches?.isNotEmpty ?? false) && _buyProduct != null) {
      emit(BuyOrderLoaded(_buyProduct, _matches));
    }

    try {
      var response = await _orderRepository.getBuyOrder(id);
      _matches = response?.matches;
      _buyProduct = response?.buyProduct;
      emit(BuyOrderLoaded(_buyProduct, _matches));
    } catch (e) {
      emit(Error());
    }
  }

  Future<void> cancelOrder(String id) async {
    emit(BuyOrderCancelling(_buyProduct, _matches));

    try {
      await _orderRepository.cancelBuyOrder(id);
      emit(BuyOrderCancelled(_buyProduct, _matches));
    } catch (e) {
      emit(BuyOrderCancelFailed(_buyProduct, _matches));
    }
  }
}
