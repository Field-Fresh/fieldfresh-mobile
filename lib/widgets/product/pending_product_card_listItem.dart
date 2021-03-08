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
          Text(
            product.family,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          if (product.type != null)
            Text(
              product.type,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          Text(_pendingProduct.volume.toInt().toString() + " " + _pendingProduct.units,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w200))
        ],
      ),
    );
  }
}
