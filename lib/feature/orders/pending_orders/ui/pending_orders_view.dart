import 'package:enum_to_string/enum_to_string.dart';
import 'package:fieldfreshmobile/feature/home/ui/home_page.dart';
import 'package:fieldfreshmobile/feature/orders/pending_orders/bloc/pending_orders_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/pending_orders/bloc/states.dart';
import 'package:fieldfreshmobile/feature/orders/pending_orders/ui/pending_order_view.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/no_glow_single_child_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingOrders extends StatefulWidget {
  final String proxyId;

  const PendingOrders({Key key, this.proxyId}) : super(key: key);

  @override
  _PendingOrdersState createState() => _PendingOrdersState(proxyId: proxyId);
}

class _PendingOrdersState extends State<PendingOrders> {
  final String proxyId;

  PendingOrdersCubit _pendingOrdersCubit;

  _PendingOrdersState({this.proxyId});

  @override
  void initState() {
    super.initState();
    _pendingOrdersCubit = sl<PendingOrdersCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(child: _getListBody(Side.SELL)),
          Flexible(child: _getListBody(Side.BUY)),
        ],
      ),
    );
  }

  BlocBuilder _getListBody(Side side) => BlocBuilder(
        cubit: _pendingOrdersCubit,
        builder: (BuildContext context, state) {
          Widget content = CircularProgressIndicator();
          if (state is Loaded &&
              state.side == side &&
              state.proxyId == proxyId) {
            content = ListView.builder(
                itemCount: state.pendingOrders.length,
                itemBuilder: (context, index) =>
                    PendingOrderItemView(state.pendingOrders[index]));
          } else {
            _pendingOrdersCubit.loadOrders(side: side, proxyId: proxyId);
          }

          return ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Text(
                        "Pending ${EnumToString.convertToString(side).toLowerCase()} orders ",
                        style: TextStyle(
                            color: AppTheme.colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      content
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
}

class PendingOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NoGlowSingleChildScrollView(child: PendingOrders()),
    );
  }
}
