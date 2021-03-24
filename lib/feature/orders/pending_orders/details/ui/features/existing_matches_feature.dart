import 'package:fieldfreshmobile/feature/orders/matched_orders/list/ui/matched_order_view.dart';
import 'package:fieldfreshmobile/models/api/order/match.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MatchesFeature extends StatelessWidget {
  final List<Match> matches;
  final Side side;

  const MatchesFeature(this.matches, this.side, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Matches",
            style: TextStyle(
                color: AppTheme.colors.light.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          ListView.builder(itemBuilder: (context, index) {
            var match = matches[index];
            return MatchedOrderItemView(MatchedOrderItemData(
                match.id,
                match.product,
                match.quantity,
                match.product.units,
                match.unitPriceCents / 100,
                side,
                match.quantity / match.originalSellQuantity));
          })
        ],
      ),
    );
  }
}
