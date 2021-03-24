import 'package:fieldfreshmobile/feature/orders/matched_orders/details/args.dart';
import 'package:fieldfreshmobile/feature/orders/matched_orders/details/bloc/matched_order_details_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/matched_orders/details/bloc/states.dart';
import 'package:fieldfreshmobile/feature/orders/matched_orders/details/ui/features/proxy_details_feature.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/widgets/app_bar.dart';
import 'package:fieldfreshmobile/widgets/order_details/primary_details_feature.dart';
import 'package:fieldfreshmobile/widgets/order_details/product_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchDetails extends StatefulWidget {
  final String _id;

  const MatchDetails(this._id, {Key key}) : super(key: key);

  @override
  _MatchDetailsState createState() => _MatchDetailsState(_id);
}

class _MatchDetailsState extends State<MatchDetails> {

  final String _id;
  MatchDetailsCubit _cubit;

  _MatchDetailsState(this._id);

  @override
  void initState() {
    super.initState();
    _cubit = sl<MatchDetailsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _cubit,
      builder: (context, state) {
        if (state is Loaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: ProductHeaderFeature(state.match.product)),
              PrimaryDetailsFeature(
                  state.match.unitPriceCents / 100, state.match.quantity,
                  state.match.product.units),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProxyDetailsFeature(proxy: state.proxy, side: state.side,)
                  ],
                ),
              )
            ],
          );
        }

        if (state is Empty) {
          _cubit.loadMatch(_id);
        }

        return Column(
          children: [
            Expanded(child: Center(child: CircularProgressIndicator()))
          ],
        );
      },
    );
  }
}

class MatchDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MatchedOrderDetailsArguments args =
        ModalRoute
            .of(context)
            .settings
            .arguments;
    var _id = args.matchId;
    return Scaffold(
      appBar: FieldFreshAppBar(),
      body: MatchDetails(_id),
    );
  }
}
