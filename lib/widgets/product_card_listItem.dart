import 'package:fieldfreshmobile/models/api/product/pending_product.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/product_class_stamp.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class ProductCardListItem extends StatelessWidget {
  final PendingProduct _pendingProduct;

  const ProductCardListItem(
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
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Image.network(
                product.imgUrl,
                width: 180,
                height: 100,
                fit: BoxFit.cover,
              ),
              Container(
                child: ProductClassStamp(product.classType),
                margin: EdgeInsets.all(4),
              )
            ],
          ),
          Text(
            product.family + " | (" + product.type + ")",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(_pendingProduct.volume.toString() + " " + _pendingProduct.units,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w200))
        ],
      ),
    );
  }
}
