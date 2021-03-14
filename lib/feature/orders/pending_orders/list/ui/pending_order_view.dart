import 'package:fieldfreshmobile/feature/orders/pending_orders/list/bloc/states.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/product/product_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class PendingOrderItemView extends StatelessWidget {
  final PendingOrderItemData _data;

  const PendingOrderItemView(this._data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = _data.product;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Material(
        elevation: 4,
        color: AppTheme.colors.white.withOpacity(0.3),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProductImage(product, width: 130),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 12),
                      child: _getProductDesc(product)),
                  Container(
                      margin: EdgeInsets.only(left: 12),
                      child: _getOrderInfoPills())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _getProductDesc(Product product) => Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  product.family,
                  style: TextStyle(
                      color: AppTheme.colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              if (product.type != null)
                Text(
                  product.type,
                  style: TextStyle(color: AppTheme.colors.white, fontSize: 14),
                ),
            ],
          ),
        ),
      );

  Container _getOrderInfoPills() => Container(
        margin: EdgeInsets.only(top: 8),
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(height: 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _getPillWithText("${_data.volume} ${_data.units}"),
              _getPillWithText(
                  "\$ ${_data.unitPrice / 100}/${_data.units}"),
            ],
          ),
        ),
      );

  Container _getPillWithText(String text) => Container(
        margin: EdgeInsets.only(right: 8),
        width: 80,
        height: 40,
        decoration: BoxDecoration(
            color: AppTheme.colors.light.primary,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            )),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: AppTheme.colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
}
