import 'package:fieldfreshmobile/models/api/product/pending_product.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/product/product_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class PendingProductCardListItem extends StatelessWidget {
  final PendingProduct _pendingProduct;

  const PendingProductCardListItem(
    this._pendingProduct, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = _pendingProduct.product;
    return Container(
      color: AppTheme.colors.white.withOpacity(0.3),
      margin: EdgeInsets.only(left: 8, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImage(product),
          Text.rich(TextSpan(
              text: product.family,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              children: <InlineSpan>[
                if (product.type != null)
                  TextSpan(
                    text: " ${product.type}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
              ])),
          Text(
              _pendingProduct.volume.toInt().toString() +
                  " " +
                  _pendingProduct.units,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w200))
        ],
      ),
    );
  }
}
