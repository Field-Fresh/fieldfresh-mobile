import 'package:fieldfreshmobile/models/api/product/pending_product.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'file:///C:/src/fieldfresh-mobile/lib/widgets/product/product_class_stamp.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class ProductCardListItem extends StatelessWidget {
  final Product _product;

  const ProductCardListItem(
    this._product, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = _product;
    return Container(
      margin: EdgeInsets.only(bottom: 12, left: 8, right: 8),
      color: AppTheme.colors.light.secondaryLight.withOpacity(0.3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Image.network(product.imgUrl,
                  width: 80, height: 80, fit: BoxFit.cover),
              Container(
                child: ProductClassStamp(product.classType),
                margin: EdgeInsets.all(4),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product.family}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),
                ),
                Text(
                  product.type,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
