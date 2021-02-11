import 'package:fieldfreshmobile/feature/home/bloc/side_type.dart';
import 'package:fieldfreshmobile/feature/orders/summary/order_count/bloc/states.dart';
import 'package:fieldfreshmobile/models/api/order/status_type.dart';
import 'package:fieldfreshmobile/repository/client/orders/requests.dart';
import 'package:fieldfreshmobile/repository/client/orders/response.dart';
import 'package:fieldfreshmobile/repository/orders_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCountCubit extends Cubit<OrderCountState> {

  final OrderRepository repository;
  OrderCountCubit(this.repository) : super(OrderCountStateEmpty());

  Future<void> loadData(Side side, Status status) async {
    emit(Loading());
    try {
      OrdersGetRequest request = OrdersGetRequest(side, status);
      OrdersGetResponse response = await repository.getOrders(request);
      if (response != null) {
        emit(Loaded(response.count));
      }
    } catch (e) {
      emit(Error("Error"));
    }
  }
}