import 'package:fieldfreshmobile/feature/orders/pending_orders/bloc/states.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/repository/orders_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingOrdersCubit extends Cubit<PendingOrdersState> {

  final OrderRepository _orderRepository;

  PendingOrdersCubit(this._orderRepository) : super(Empty());

  Future<void> loadOrders({@required Side side, @required String proxyId}) async {
    emit(Loading(side, proxyId));



  }
}