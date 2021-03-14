import 'package:fieldfreshmobile/feature/orders/matched_orders/bloc/matched_orders_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/matched_orders/bloc/states.dart';
import 'package:fieldfreshmobile/feature/orders/matched_orders/ui/matched_order_view.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchedOrders extends StatefulWidget {
  @override
  _MatchedOrdersState createState() => _MatchedOrdersState();
}

class _MatchedOrdersState extends State<MatchedOrders> {
  MatchedOrdersCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = sl<MatchedOrdersCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _cubit,
      builder: (BuildContext context, MatchedOrdersState state) {
        if (state is Empty) {
          _cubit.loadData();
        }
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Buy",
                        style: TextStyle(
                            color: state.side == Side.BUY ? AppTheme.colors.light.primary : AppTheme.colors.white,
                            fontSize: state.side == Side.BUY ? 20 : 16,
                            fontWeight: FontWeight.bold)),
                    Switch(
                      inactiveThumbColor: AppTheme.colors.white,
                      value: state.side == Side.SELL,
                      onChanged: (_) => _cubit.switchSide(),
                    ),
                    Text(
                      "Sell",
                      style: TextStyle(
                          color: state.side == Side.SELL ? AppTheme.colors.light.primary : AppTheme.colors.white,
                          fontSize: state.side == Side.SELL ? 20 : 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Divider(height: 2, color: AppTheme.colors.white.withOpacity(0.3), thickness: 2,),
            ),
            Expanded(child: _getDisplayContent(state))
          ],
        );
      },
    );
  }

  Widget _getDisplayContent(MatchedOrdersState state) {
    if (state is Loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is Loaded) {
      return state.items.isNotEmpty
          ? ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) =>
                  MatchedOrderItemView(state.items[index]))
          : Center(
              child: Text(
                "No matched orders.",
                style: TextStyle(color: AppTheme.colors.white, fontSize: 14),
              ),
            );
    }

    return Container();
  }
}
