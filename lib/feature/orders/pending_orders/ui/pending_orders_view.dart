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
  const PendingOrders({Key key}) : super(key: key);

  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  PendingOrdersCubit _pendingOrdersCubit;

  _PendingOrdersState();

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
        buildWhen: (prev, cur) => (cur.side == side || cur is Empty),
        builder: (BuildContext context, state) {
          Widget content = CircularProgressIndicator();
          if (state is Loaded) {
            content = state.pendingOrders.isNotEmpty
                ? Expanded(
                  child: ListView.builder(
                      itemCount: state.pendingOrders.length,
                      itemBuilder: (context, index) =>
                          PendingOrderItemView(state.pendingOrders[index])),
                )
                : Text(
                    "No Orders found",
                    style: TextStyle(
                        color: AppTheme.colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  );
          } else if (state is Error) {
            content = Text(
              "Error loading orders",
              style: TextStyle(
                  color: AppTheme.colors.light.errorRed,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            );
          } else {
            _pendingOrdersCubit.loadOrders(side: side);
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
                    children: [content],
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
