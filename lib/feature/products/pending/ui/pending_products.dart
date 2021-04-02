import 'package:fieldfreshmobile/feature/products/pending/bloc/pending_product_bloc.dart';
import 'package:fieldfreshmobile/feature/products/pending/event/events.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/feature/products/pending/state/states.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/product/pending_product_card_listItem.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingProductList extends StatefulWidget {
  final Side side;

  const PendingProductList({Key key, this.side}) : super(key: key);

  @override
  _PendingProductListState createState() => _PendingProductListState(side);
}

class _PendingProductListState extends State<PendingProductList> {
  final Side side;
  final Text title;
  PendingProductsBloc _bloc;

  _PendingProductListState(this.side, {title})
      : this.title = title ??
            Text(
              side == Side.BUY
                  ? "What is the market buying?"
                  : "What is the market selling?",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            );

  @override
  void initState() {
    super.initState();
    _bloc = sl<PendingProductsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _bloc,
      builder: (BuildContext context, state) {
        if (state is Loaded) {
          return getLoadedState(state);
        }

        if (state is PendingProductStateEmpty) {
          _bloc.add(LoadPendingProducts(side));
        }

        return getLoadingState();
      },
    );
  }

  Container createHorizontalList(Widget content) => Container(
        child: Card(
            color: AppTheme.colors.light.secondaryDark,
            elevation: 8,
            margin: EdgeInsets.only(top: 8, left: 6, right: 6),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 6),
                          child: title,
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 160,
                      child: content,
                    ),
                  ],
                ),
              ),
            )),
      );

  Container getLoadingState() => createHorizontalList(
        Center(
          child: CircularProgressIndicator(),
        ),
      );

  Container getLoadedState(Loaded state) => state.pendingProducts.isNotEmpty
      ? createHorizontalList(ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.pendingProducts.length,
          itemBuilder: (context, index) {
            return PendingProductCardListItem(state.pendingProducts[index]);
          }))
      : createHorizontalList(Center(
          child: Text(
            "No products found",
            style:
                TextStyle(color: AppTheme.colors.light.primary.withOpacity(.5)),
          ),
        ));
}
