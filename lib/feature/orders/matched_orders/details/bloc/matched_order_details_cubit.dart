import 'package:fieldfreshmobile/feature/orders/matched_orders/details/bloc/states.dart';
import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/order/match.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';
import 'package:fieldfreshmobile/repository/orders_repository.dart';
import 'package:fieldfreshmobile/util/constants.dart';
import 'package:fieldfreshmobile/util/preference.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MatchDetailsCubit extends Cubit<MatchDetailsState> {
  final OrderRepository _orderRepository;

  MatchDetailsCubit(this._orderRepository) : super(Empty());

  Match _match;
  BuyProduct _buyProduct;
  SellProduct _sellProduct;
  Proxy _matchedProxy;
  Side _orderSide;

  String _viewerProxyId;

  Future<void> loadMatch(String id) async {
    emit(Loading());

    if (_viewerProxyId == null) {
      _viewerProxyId = await PreferenceUtil.get(DEFAULT_PROXY);
    }

    if (_match != null) {
      emit(Loaded(_match, _matchedProxy, _orderSide));
    }

    try {
      var response = await _orderRepository.getMatchDetails(id, _viewerProxyId);
      _match = response?.match;
      _buyProduct = response?.buyProduct;
      _sellProduct = response?.sellProduct;
      _matchedProxy = response?.matchedProxy;
      _orderSide = response?.side;
      emit(Loaded(_match, _matchedProxy, _orderSide));
    } catch (e) {
      emit(Error());
    }
  }
}
