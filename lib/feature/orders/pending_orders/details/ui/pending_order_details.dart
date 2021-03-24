import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fieldfreshmobile/feature/orders/pending_orders/details/args.dart';
import 'package:fieldfreshmobile/feature/orders/pending_orders/details/bloc/pending_buy_order_details_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/pending_orders/details/bloc/pending_sell_order_details_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/pending_orders/details/bloc/states.dart';
import 'package:fieldfreshmobile/feature/orders/pending_orders/details/ui/features/date_range_feature.dart';
import 'package:fieldfreshmobile/feature/orders/pending_orders/details/ui/features/service_range_feature.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/app_bar.dart';
import 'package:fieldfreshmobile/widgets/order_details/primary_details_feature.dart';
import 'package:fieldfreshmobile/widgets/order_details/product_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingOrderDetails extends StatefulWidget {
  final Side _side;
  final String _id;

  const PendingOrderDetails(this._side, this._id, {Key key}) : super(key: key);

  @override
  _PendingOrderDetailsState createState() {
    switch (_side) {
      case Side.BUY:
        return _BuyPendingOrderDetailsState(_id);
        break;
      case Side.SELL:
        return _SellPendingOrderDetailsState(_id);
        break;
      default:
        return null;
        break;
    }
  }
}

class _BuyPendingOrderDetailsState extends _PendingOrderDetailsState {
  PendingBuyOrderDetailsCubit _cubit;

  _BuyPendingOrderDetailsState(_id) : super(_id);

  @override
  void initState() {
    super.initState();
    _cubit = sl<PendingBuyOrderDetailsCubit>();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
        cubit: _cubit,
        builder: (context, state) {
          if (state is Empty || state is Loading) {
            _cubit.loadOrder(_id);
          }

          if (state is BuyOrderCancelling) {
            return showContent(state.buyProduct, disableCancel: true);
          }

          if (state is BuyOrderCancelled) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.SUCCES,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Order cancelled!',
                desc: "Your order has been cancelled and will not be matched.",
                btnOkOnPress: () { },
              ).show();
            });
            return showContent(state.buyProduct);
          }

          if (state is BuyOrderCancelFailed) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Failed to cancel order!',
                desc: 'Failed to cancel your order. Contact support.',
                btnOkOnPress: () {  },
              ).show();
            });
            return showContent(state.buyProduct);
          }

          if (state is BuyOrderLoaded) {
            return showContent(state.buyProduct);
          }

          return getLoading();
        },
      );

  Widget showContent(BuyProduct buyProduct, {bool disableCancel}) =>
      buildContent(
          Text("Buying",
              style: TextStyle(
                  color: AppTheme.colors.light.primary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          buyProduct.product,
          buyProduct.volume,
          buyProduct.maxPriceCents / 100,
          disableCancel == null ? buyProduct.isCancelable : !disableCancel,
          [
            DateRangeFeature(buyProduct.earliestDate,
                buyProduct.latestDate),
          ]);

  @override
  void cancelOrder(String id) => _cubit.cancelOrder(id);
}

class _SellPendingOrderDetailsState extends _PendingOrderDetailsState {
  PendingSellOrderDetailsCubit _cubit;

  _SellPendingOrderDetailsState(_id) : super(_id);

  @override
  void initState() {
    super.initState();
    _cubit = sl<PendingSellOrderDetailsCubit>();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
        cubit: _cubit,
        builder: (context, state) {
          if (state is Empty) {
            _cubit.loadOrder(_id);
            return getLoading();
          }

          if (state is SellOrderCancelling) {
            return showContent(state.sellProduct, disableCancel: true);
          }

          if (state is SellOrderCancelled) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.SUCCES,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Order cancelled!',
                desc: "Your order has been cancelled and will not be matched.",
                btnOkOnPress: () { },
              )..show();
            });
            return showContent(state.sellProduct);
          }

          if (state is SellOrderCancelFailed) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Failed to cancel order!',
                desc: 'Failed to cancel your order. Contact support.',
                btnOkOnPress: () { },
              ).show();
            });
            return showContent(state.sellProduct);
          }

          if (state is SellOrderLoaded) {
            return showContent(state.sellProduct);
          }

          return getLoading();
        },
      );

  Widget showContent(SellProduct sellProduct, {bool disableCancel}) =>
      buildContent(
          Text("Selling",
              style: TextStyle(
                  color: AppTheme.colors.light.primary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          sellProduct.product,
          sellProduct.volume,
          sellProduct.minPriceCents / 100,
          disableCancel == null ? sellProduct.isCancelable : !disableCancel,
          [
            DateRangeFeature(sellProduct.earliestDate,
                sellProduct.latestDate),
            if (sellProduct.serviceRadius != null)
              ServiceRangeFeature(sellProduct.serviceRadius)
          ]);

  @override
  void cancelOrder(String id) => _cubit.cancelOrder(id);
}

abstract class _PendingOrderDetailsState extends State<PendingOrderDetails> {
  final String _id;

  void cancelOrder(String id);

  _PendingOrderDetailsState(this._id);

  Widget getLoading() => Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      );

  Widget buildContent(Text title, Product product, int quantity,
          double price, isCancellable, List<Widget> additionalFeatures) =>
      Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                if (title != null)
                  Container(margin: EdgeInsets.only(top: 18), child: title),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Column(
                    children: [
                      ProductHeaderFeature(product),
                      PrimaryDetailsFeature(price, quantity, product.units),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppTheme.colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        )),
                    child: ListView(
                      children: additionalFeatures,
                    ),
                  ),
                ),
              ],
            ),
            FlatButton.icon(
              color: AppTheme.colors.light.primary,
              onPressed:
                  (isCancellable ?? true) ? () => cancelOrder(_id) : null,
              icon: Icon(Icons.cancel),
              label: Text("Cancel"),
              disabledColor: AppTheme.colors.white.withOpacity(0.2),
            ),
          ],
        ),
      );
}

class PendingOrderDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PendingOrderDetailsArguments args =
        ModalRoute.of(context).settings.arguments;
    var _side = args.side;
    var _id = args.orderId;
    return Scaffold(
      appBar: FieldFreshAppBar(),
      body: PendingOrderDetails(_side, _id),
    );
  }
}
