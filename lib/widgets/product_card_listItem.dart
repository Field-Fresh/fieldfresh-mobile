import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/product_class_stamp.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class ProductCardListItem extends StatelessWidget {
  final Product product;

  const ProductCardListItem(
    this.product, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            product.family + " | " + product.type,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(product.value.toString() + " " + product.units,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w200))
        ],
      ),
    );
  }
}
